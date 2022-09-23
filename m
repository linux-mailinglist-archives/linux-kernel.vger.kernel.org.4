Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6060E5E85C1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIWWUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIWWUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:20:04 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FAAB9B841
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:19:56 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 28NMFiAQ005463;
        Fri, 23 Sep 2022 17:15:44 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 28NMFhVm005462;
        Fri, 23 Sep 2022 17:15:43 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 23 Sep 2022 17:15:43 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/irq: Modernise inline assembly in irq_soft_mask_{set,return}
Message-ID: <20220923221543.GN25951@gate.crashing.org>
References: <178f30ff62c0317061f019b3dbbc079073f104c3.1663656058.git.christophe.leroy@csgroup.eu> <CN3LB8F3D9LM.3W1RQRVS64UXU@bobo> <20220923121829.GL25951@gate.crashing.org> <CN3X6YN1FRQ3.1Z9BVD6WYQY3M@bobo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CN3X6YN1FRQ3.1Z9BVD6WYQY3M@bobo>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 02:26:52AM +1000, Nicholas Piggin wrote:
> I still don't see what clauses guarantees asm("%0" ::"r"(foo)) to give
> 13. It doesn't say access via inline assembly is special,

But it is.  It is for all register variables, local and global.  I agree
this isn't documented clearly.  For local register variables this is the
*only* thing guaranteed; for global register vars there is more (it
changes the ABI, there are safe/restore effects, that kind of thing).

Never it is guaranteed that all accesses through this variable will use
the register directly: this fundamentally cannot work on all archs, and
also not at -O0.  More in general it doesn't work if some basic
optimisations are not done, be it because of a compiler deficiency, or a
straight out bug, or maybe it is a conscious choice in some cases.

> I think if it was obviously guaranteed then this might be marginally
> better than explicit r13 in the asm
> 
>        asm volatile(
>                "stb %0,%2(%1)"
>                :
>                : "r" (mask),
> 	         "r" (local_paca),
>                  "i" (offsetof(struct paca_struct, irq_soft_mask))
>                : "memory");

(Please use "n" instead of "i".  Doesn't matter here, but it does in
many other places.)


Segher
