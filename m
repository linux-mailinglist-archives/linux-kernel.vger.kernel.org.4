Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C343A648668
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLIQQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLIQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:16:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1A380A2A;
        Fri,  9 Dec 2022 08:16:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEEA8B828AE;
        Fri,  9 Dec 2022 16:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD30C433D2;
        Fri,  9 Dec 2022 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670602583;
        bh=js1PfDhOGMctIh6NeImGt0mdI3KhpNxYU6DFWhYEELY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1Uamg1eXeQiknxY8yvLQM8IemgzDAluL8Xe6EQp9mId5ZgVqEKicouOj9+r69Uk3
         sbamGL1FXTkFWlONu9CEc5Dknyi/K5hSAcTgWtEEfI+S2sDvDY3wH+ihJs8X5p71cn
         5TOrwZzTTluW2MFi/Snpf30TdbwqR+2g2knChQLf4GG+HhPx5CCNrcmk7UaY5QUbLT
         CC2045Gw0aejJN5o++KGkcCm3CEoh+ScYHs70ToRUsn1+dtnQXNeOBxMs7++cFjiEJ
         UNina70DtzuQo+MA5JbEvbvKLaUWMeepNmEpDlgaCkORZVI3Rh/M4u/j9FTUI2rrHl
         0IUANkdRGIx6A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p3g3D-0002Gf-Re; Fri, 09 Dec 2022 17:16:40 +0100
Date:   Fri, 9 Dec 2022 17:16:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/19] irqdomain: fix mapping race and clean up locking
Message-ID: <Y5NfZ3bKTA15MWpu@hovoldconsulting.com>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <87o7scd197.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7scd197.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Dec 09, 2022 at 04:51:00PM +0100, Thomas Gleixner wrote:
> Johan!
> 
> On Fri, Dec 09 2022 at 15:01, Johan Hovold wrote:
> > Parallel probing (e.g. due to asynchronous probing) of devices that
> > share interrupts can currently result in two mappings for the same
> > hardware interrupt to be created.
> >
> > This series fixes this mapping race and clean up the irqdomain locking
> > so that in the end the global irq_domain_mutex is only used for managing
> > the likewise global irq_domain_list, while domain operations (e.g.
> > IRQ allocations) use per-domain (hierarchy) locking.
> 
> Can you please rebase that on top of:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core

The series is based on next-20221208 which should contain that branch in
its current state if I'm not mistaken.

I just tried applying it on top of irq/core and did not notice any
problems.

Johan
