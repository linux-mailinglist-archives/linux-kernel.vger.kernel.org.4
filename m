Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC50566C061
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjAPN5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjAPN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:56:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38182CFCB;
        Mon, 16 Jan 2023 05:53:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE905B80F3B;
        Mon, 16 Jan 2023 13:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C99C433D2;
        Mon, 16 Jan 2023 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877190;
        bh=/8FHND46nv69mmy17Nnbru1utyPLvPaIrYFKiLgjjl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2WM40DLGO1lztzykK7PIvVMi32p3yWdlWvFuxVYMX72ewFWHckK8V5MbnOp1PZjP
         4Z6F5UNO79Ssw1sAQ4YYqnY0fnf2tpYPpVwvEq/wz9HIw0JJojZ4kkiYo99Ao5wCUF
         jUKg3dMmyc76LcU7NW7TAlWq2JRoeNeLtOY2dTsppleNRyL5zO8LeXB312cFuthRGO
         jjZWC4ZZgIiHlAzFHJEg9emEGEh+l4SI4UBV2onvKa++v+b624tGOHTqDYTogK9D2l
         ih/2ZruyNUzfFSRYrVW7+HcLPEVh8GdNCT+Wd2DNMe/vgoaaok13vfzgX8R3rFOmqe
         PapyB2OhgVTHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pHPvV-00041g-Fz; Mon, 16 Jan 2023 14:53:29 +0100
Date:   Mon, 16 Jan 2023 14:53:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/19] irqdomain: fix mapping race and clean up locking
Message-ID: <Y8VW2XLQq0ttNzrL@hovoldconsulting.com>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <CAJMQK-ht8_dvdCOQXfUMGGa6ZcPJSXf_AjDd0OLi79WF43NYGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-ht8_dvdCOQXfUMGGa6ZcPJSXf_AjDd0OLi79WF43NYGA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:31:24PM +0800, Hsin-Yi Wang wrote:
> On Thu, Dec 15, 2022 at 5:22 PM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Parallel probing (e.g. due to asynchronous probing) of devices that
> > share interrupts can currently result in two mappings for the same
> > hardware interrupt to be created.
> >
> > This series fixes this mapping race and clean up the irqdomain locking
> > so that in the end the global irq_domain_mutex is only used for managing
> > the likewise global irq_domain_list, while domain operations (e.g.
> > IRQ allocations) use per-domain (hierarchy) locking.

> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> 
> The series solves a race issue when having non-populated 2nd source
> components that share the same irq on ARM devices:
> Previously we would see
> [    0.476357] irq: type mismatch, failed to map hwirq-11 for pinctrl@10005000!
> and the component failed to probe.

Thanks again for testing. I just sent a v4 adding a couple of clarifying
comments to the final patch.

Johan
