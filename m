Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F6768DE0B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjBGQhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGQhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:37:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D251EA4;
        Tue,  7 Feb 2023 08:37:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DED60F4A;
        Tue,  7 Feb 2023 16:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E187C433EF;
        Tue,  7 Feb 2023 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675787859;
        bh=53K+tJd24PX6VrTjyzROobjqX3rQ8W3Mg2Iop6ThxQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dP2chd5jZgT66rivj0sunx1wshBqtC9KMKudxvChxShyThsxOoZyELd+7/mszhE1h
         Lk2dP3F7sUs5CIxEeIazH7H2mzVRYdYKOjpUQOw/iN3zDs05TxP6ZJQc7zXvgr5LQ1
         4TeEOFdzWCxuiO/IdxQpMC5QAbLvJ56R1RTAXfPwV6iDXD85Mi9Wcav/dhXf7fhw48
         IePU1jNVs6Pny1heH3/HsVCPvGOia3GIQ/orciNBvqgqLRHscHHTp60iv95C6EFgyT
         k7/9RA9+R1t7PzvQ5K+NWudthSyubN/1sXLD8bQ5TArkILwzUUPc/UAmfAjbQk1WwJ
         i6wipfpmnHR2A==
Date:   Tue, 7 Feb 2023 09:37:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, llvm@lists.linux.dev,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: x86/include/asm/arch_hweight.h:49:15: error: invalid input size
 for constraint 'D'
Message-ID: <Y+J+UQ1vAKr6RHuH@dev-arch.thelio-3990X>
References: <CA+G9fYuSWodh1teau4jGG_P15yT-ev1+bS7HAAmMu5D5J-d2vw@mail.gmail.com>
 <Y+J8SobyVojJWuFv@dev-arch.thelio-3990X>
 <Y+J8rtEBlSTsCBLa@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+J8rtEBlSTsCBLa@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 05:30:38PM +0100, Borislav Petkov wrote:
> On Tue, Feb 07, 2023 at 09:28:58AM -0700, Nathan Chancellor wrote:
> > Thanks a lot for the report as always! Looks like there is a fix pending
> > on the list:
> > 
> > https://lore.kernel.org/Y+IsCWQdXEr8d9Vy@linutronix.de/
> 
> Btw, while I have you, do you know why clang isn't DCOing this chunk
> like gcc does?

Clang does its semantic analysis before optimization, so it cannot dead
code eliminate that chunk before it checks the validity of the asm
constraints, that is just how the pipeline is structured as far as I
understand it. That is one of the biggest and longest standing
differences between clang and GCC that we know about, the upstream link
in the issue below has some more info.

https://github.com/ClangBuiltLinux/linux/issues/3

I am not super familiar with the internal details of LLVM and clang as
other folks are though so I could be wrong or missing something :)

Cheers,
Nathan
