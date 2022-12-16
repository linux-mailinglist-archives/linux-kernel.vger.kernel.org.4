Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C5164F0CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiLPSQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:16:09 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B90DE5D699
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:16:00 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2BGIAnf3023871;
        Fri, 16 Dec 2022 12:10:49 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 2BGIAmSn023870;
        Fri, 16 Dec 2022 12:10:48 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 16 Dec 2022 12:10:48 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2] powerpc: Pass correct CPU reference to assembler
Message-ID: <20221216181048.GC25951@gate.crashing.org>
References: <01fe73614988e2402a7526fb6b6e903bc3777bb5.1671179743.git.christophe.leroy@csgroup.eu> <20221216171821.GA25951@gate.crashing.org> <73fc1107-b540-bec3-7625-c6e6d0641bbb@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73fc1107-b540-bec3-7625-c6e6d0641bbb@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 05:57:46PM +0000, Christophe Leroy wrote:
> Le 16/12/2022 à 18:18, Segher Boessenkool a écrit :
> > On Fri, Dec 16, 2022 at 09:35:50AM +0100, Christophe Leroy wrote:
> >> Today we have CONFIG_TARGET_CPU which provides the identification of the
> >> expected CPU, it is used for GCC. Use it as well for the assembler.
> > 
> > Why do you use -Wa, at all for this?  The compiler should already pass
> > proper options always!
> 
> That's historical I guess. Comes from commit 14cf11af6cf6 ("powerpc: 
> Merge enough to start building in arch/powerpc.")

Ah.  The patch moves stuff around, I thought more of it is new than it
really is.  Sorry.

It would be good to get rid of all such things that do no good and can
easily cause problems, of course, but that does not belong to this patch
of course.

> >> +cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-many)
> > 
> > What is this for?  Using -many is a huge step back, it hides many
> > problems :-(
> 
> The only thing I did is removed the -Wa,-mpower4 from the line, leaving 
> the remaining part. Initialy it was:
> 
> cpu-as-$(CONFIG_PPC_BOOK3S_64) += $(call as-option,-Wa$(comma)-mpower4) 
> $(call as-option,-Wa$(comma)-many)
> 
> It was added in 2018 by commit 960e30029863 ("powerpc/Makefile: Fix 
> PPC_BOOK3S_64 ASFLAGS"). There is a long explanation it the commit.
> 
> Should we remove it ?

The commit says it is a workaround for clang problems, so it needs
testing there.  It also needs testing everywhere else, because as I said
it hides a lot of problems, so removing it will make a lot of sloppy
code that has crept in since 2018 scream bloody murder :-(


Segher
