Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6526F67EA7E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjA0QMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjA0QMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:12:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694B24C81
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:12:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA3161CC0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17E6C4339B;
        Fri, 27 Jan 2023 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674835925;
        bh=60klBDle3W3g6fhHaYY765QOsRAFvLHiUbtPU7k6p6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUtl714xuXAPOs+vQV/HqemQhf0rTDPtKQfdl2PdjKVaoeiVacrkiUUKxa3bZDc6d
         8H9goXb269HmTYiVFdzYUc5lYllODDd32xpvs5dSdzCxFSSkeidEUNfk7nySNe9E20
         G2kT/UYXmNRCpkDdzNnuuZg3VGaF+NLYc9kcHdkmdeIy8mkjby01Y3Fzlcu80PVrqO
         KvnNvB/MgxFYdNBW1R8LX9VeKcPjY2iPNRKGLcs5A/ywYL0xPQnducjJG6dZmNX8kt
         0dDpA12KipZF03E1tC8/heRoQ89Kc4Dvv+01ZKKIoMeOP9Hmtx2U1Pxj4/TpHbrPmA
         mhU2Qzn1Wx0BA==
Date:   Fri, 27 Jan 2023 08:12:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: suppress KMSAN reports in arch_within_stack_frames()
Message-ID: <Y9P301c/cQ/wLTMs@sol.localdomain>
References: <20221118172305.3321253-1-glider@google.com>
 <Y4bs2hoG3MANYgF7@sol.localdomain>
 <Y7+dXStDx9G0h2JE@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7+dXStDx9G0h2JE@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:40:47PM -0800, Eric Biggers wrote:
> On Tue, Nov 29, 2022 at 09:40:45PM -0800, Eric Biggers wrote:
> > On Fri, Nov 18, 2022 at 06:23:05PM +0100, Alexander Potapenko wrote:
> > > arch_within_stack_frames() performs stack walking and may confuse
> > > KMSAN by stepping on stale shadow values. To prevent false positive
> > > reports, disable KMSAN checks in this function.
> > > 
> > > This fixes KMSAN's interoperability with CONFIG_HARDENED_USERCOPY.
> > > 
> > > Link: https://github.com/google/kmsan/issues/89
> > > Link: https://lore.kernel.org/lkml/Y3b9AAEKp2Vr3e6O@sol.localdomain/
> > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > ---
> > >  arch/x86/include/asm/thread_info.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > 
> > Tested-by: Eric Biggers <ebiggers@google.com>
> > 
> 
> Can this patch be applied to the x86 tree, please?
> 
> - Eric

Ping.
