Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC0663D6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiK3NaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiK3N34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:29:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E656DCEA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EF25B81B4E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D017C433D6;
        Wed, 30 Nov 2022 13:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669814990;
        bh=sP2qxHqOzBLVqNoiwojKC0COyARR01VWRMLMQXAbFHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFNR8KlKCWZYPbBmoi9ggWRPIauHdC6kTOYCHlWXKGCFcubWTJFeOrCz7f0sNUWcU
         uA9nt20wyz4yEw+nVtrg8vxiBk8ZXzqtXPzH6LGdyWfeQH1IfkYMiU8937x5ct7vNk
         nHuyk49wEt6MKfD2pYrRdu6w9JtV2Puj/TIQ+a+dV55w5rLS96wqecsRRM9IWUBgoF
         5TvXXtLN7wf7NkMyTH2X6KAdJG3137NhhZx4mB2iqI9QycG+RNiaL2ySfHndq2M2Gs
         IIIutVLowic/XjbYGz97h2s+fl+piub14eI/FwicshDxWf0loN7QUk9xDgYR6hKXxB
         lsxNfS8FNI4qQ==
Date:   Wed, 30 Nov 2022 13:29:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Geoff Blake <blakgeof@amazon.com>, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] perf/arm-cmn: Add shutdown routine
Message-ID: <20221130132945.GA27624@willie-the-truck>
References: <20221125230153.49468-1-blakgeof@amazon.com>
 <166973320082.112522.10687339610259452670.b4-ty@kernel.org>
 <c7acc1af-b97e-f9f7-4891-64bc9380a12e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7acc1af-b97e-f9f7-4891-64bc9380a12e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:28:17PM +0000, Robin Murphy wrote:
> On 2022-11-29 19:52, Will Deacon wrote:
> > On Fri, 25 Nov 2022 17:01:53 -0600, Geoff Blake wrote:
> > > The CMN driver does not gracefully handle all
> > > restart cases, such as kexec.  On a kexec if the
> > > arm-cmn driver is in use it can be left in a state
> > > with still active  events that can cause spurious and/or
> > > unhandled interrupts that appear as non-fatal kernel errors
> > > like below, that can be confusing and misleading:
> > > 
> > > [...]
> > 
> > Applied to will (for-next/perf), thanks!
> > 
> > [1/1] perf/arm-cmn: Add shutdown routine
> >        https://git.kernel.org/will/c/316f862a787c
> 
> Oh, if I'd seen this I'd have said the same thing as when asked about it
> off-list, that it's needlessly overcomplicated and doesn't really solve the
> problem anyway. If there's a need to be robust against spurious interrupts
> then that needs to be done in the interrupt handler.
> 
> Even if we do think it's worth stopping the PMU on shutdown, as we do on
> remove, that still only needs a single register write (per the current
> remove implementation).

Sorry Robin, I didn't spot that you weren't on cc for this. I've dropped the
patch locally and I'll update the branches later on today.

Please can you help Geoff come up with something better?

Will
