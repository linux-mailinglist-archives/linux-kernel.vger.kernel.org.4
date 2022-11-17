Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3937162E585
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiKQT5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiKQT5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:57:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A408E1836A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49C78B821F1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB48C433C1;
        Thu, 17 Nov 2022 19:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668715042;
        bh=gCElGlWGA46iOYzp69MoHYuVOmSDZpYob11i+TmiOis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uT12eTDHxm2DRoHODbjDmitHklpMgERuLBYis+vjfbu+3AJ2dZRxUkqgTyk6UR7XM
         sB9kV8D654tedS0DcdyQ+abjJO3zV2ERvrceBSFxvwjnp9rZQ8VTgS4H/rbhimNH16
         ZV+5wzd1DHu9xyiyJpBYj1/aIk0I2VhLlfz46nd+rQIqXWwniTPY/OQULDF7QBdw3P
         xwg4rk2XVVCAa0xkf7nz9HMc8BxUov/RzlLetQkHs7hCTxnz5MbJfQBp9cwhs5aeLG
         KVBV88zba2xfZkmOhrA+oe4Rdv/0TSCptz7ZoQ3Zq40L2Mg9B3CAYzSbV5XtGQpxPo
         ZeIRt8dq+wa8A==
Date:   Thu, 17 Nov 2022 19:57:17 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] irqchip/sifive-plic: default to enabled
Message-ID: <Y3aSHUb8GHnso3Qb@spud>
References: <20221117185942.3896559-1-conor@kernel.org>
 <86y1s9nzja.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86y1s9nzja.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:36:57PM +0000, Marc Zyngier wrote:
> On Thu, 17 Nov 2022 18:59:43 +0000,
> Conor Dooley <conor@kernel.org> wrote:
> > 
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > The SiFive PLIC driver is used by all current implementations, including
> > those that do not have a SiFive PLIC. Default the driver to enabled,
> > with the intention of later removing the current "every SOC selects
> > this" situation in Kconfig.socs at the moment.
> > 
> > The speculative "potential others" in the description no longer makes
> > any sense, as the driver is always used. Update the Kconfig symbol's
> > description to reflect the driver's ubiquitous state.
> > 
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > Hey Marc,
> > 
> > I recall some discussion when this driver was extended to other PLICs a
> > few months ago:
> > https://lore.kernel.org/linux-riscv/20511a05f39408c8ffbcc98923c4abd2@kernel.org/
> > 
> > Perhaps I got the wrong impression, but it seemed to me that you intend
> > for future implementations to reuse this driver where possible?
> 
> Well, within reasons. People seem to have some very liberal
> interpretations of the architecture spec...

Yeah, I know.. something something "RISC-V is meant to be extensible"
something something. Even if that means doing some "standard" thing
your own way apparently.

> > I'd like to think, and surely will be proven wrong, that ~all future
> > plic implementations should be similar enough to fit that bill.
> > It's kinda on this basis that I figure switching this thing to default y
> > should be okay. It's already only buildable on RISC-V & every
> > implementation uses it, so no difference there.
> 
> If you expect this to be present at all times, why isn't this selected
> by the architecture Kconfig instead?

Everyone at the moment needs it, but that's not always going to be true.
The AIA APLIC that's currently out for review is the "next generation"
interrupt controller. When we will actually see one in the wild is
another question.

> I always find it pretty odd to
> have something that is 'default y' and yet constrained by a 'depend
> MYARCH'. A 'select PLIC' would make a lot more sense.
> 
> And then you can stop making this user selectable.

I was considering moving the select to arch level, but settled for this
as while I'd like to stop the individual SOCs doing `select PLIC`, I can
see why someone building for a (future) system with the new AIA stuff
may not care to build it.

Or maybe the overhead of this one driver is nothing to care about?

Thanks,
Conor.

