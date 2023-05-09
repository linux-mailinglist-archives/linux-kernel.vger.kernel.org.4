Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FDB6FC4F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjEIL0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjEIL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:26:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E13DC1724
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:26:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B783DFEC;
        Tue,  9 May 2023 04:27:29 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.56.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EA063F67D;
        Tue,  9 May 2023 04:26:43 -0700 (PDT)
Date:   Tue, 9 May 2023 12:26:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM/arm64: Mark all accessor functions inline
Message-ID: <ZFot3325jfshzhIa@FVFF77S0Q05N>
References: <cover.1683561087.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683561087.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 06:05:17PM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series adds missing "inline" keywords to the few perf
> accessors that lack them.
> 
> BTW, I tried converting my local timing code to the new unified system.
> This works fine on arm64, but broke on arm32.  Is read_pmccntr()
> supposed to work on arm32? I get an undefined instruction exception on
> Cortex A15 and A9.

That's expected.

This code is for PMUv3 (which was added as part of ARMv8), and one of the
things changed in PMUv3 was that PMCCNTR was expanded to 64 bits accessible via
MRRC and MCRR.

Previously, PMCCNTR was only 32 bits, and that's what Cortex-A9 and Cortex-A15
implement.

Thanks,
Mark.

> Before, my custom code used "mrc p15, 0, %0, c9,
> c13, 0" (as is also used in arch/arm/kernel/perf_event_v7.c), for which
> there is no accessor yet.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (2):
>   ARM: perf: Mark all accessor functions inline
>   arm64: perf: Mark all accessor functions inline
> 
>  arch/arm/include/asm/arm_pmuv3.h   | 6 +++---
>  arch/arm64/include/asm/arm_pmuv3.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> -- 
> 2.34.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
