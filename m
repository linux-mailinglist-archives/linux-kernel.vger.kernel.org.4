Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B868B60BA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiJXU20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiJXU10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:27:26 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F6F13C1FA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:40:16 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id ACDD81C0008;
        Mon, 24 Oct 2022 18:38:16 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 24 Oct 2022 11:38:16 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
In-Reply-To: <CABCJKuc8eu0t08E0e1si-Sm2m0QqB1mrzofZy9cJ3G-tHBUZRg@mail.gmail.com>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <20221021230859.gysp5v3yzfqz4xgb@treble>
 <Y1QGUXSc43rInacJ@hirez.programming.kicks-ass.net>
 <CABCJKuc8eu0t08E0e1si-Sm2m0QqB1mrzofZy9cJ3G-tHBUZRg@mail.gmail.com>
Message-ID: <dffbc3cc5babe4f7ed2e5d41edad7dec@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, the compiler patch is already in, but if the cfi/kcfi confusion
> is a big concern, it's still possible to rename the symbol before
> Clang 16 is released. However, I thought we picked the __cfi prefix
> earlier to make things less confusing with FineIBT? Joao, are you
> still planning on adding FineIBT to Clang as well?

Not only with FineIBT, but also with CFG, ClangCFI and any other scheme 
that does CFI. IIRC, my concern was regarding some functions/structures 
that could be easily re-used in both (or many) schemes (such as setting 
the hashes for a specific call or something) being named to one 
specifically. But yeah, I didn't think at the time that there would be a 
different collision with Dwarf stuff. I still think that having a 
generic prefix is better, but I agree that the collision with dwarf is 
bad. Maybe we use something generic enough that doesn't collide, Idk, 
"cflow" or something like that (naming is hard).

As for FineIBT within clang, that is still undecided. I'm waiting for 
peterz's patches to get in first, so then I can raise the discussion if 
it is worthy compiling the kernel directly with FineIBT. Also, on the 
user-space side, I'm waiting for IBT support to get in to then get back 
there and see if I can make it feasible. So the answer right now is 
really that it depends.

Tks,
Joao
