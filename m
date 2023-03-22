Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1F6C53FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCVSqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjCVSqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4563064B31
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3B0462278
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9170CC433D2;
        Wed, 22 Mar 2023 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679510721;
        bh=khs4WyDC4bsNM7Qsr87hszfKJX33A8kySjsYmIbzpXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9XS7Qx3zeZfbNZaT5WGwlM40Nj0P9NYG6/733ExbmB/MS4s+3NqHG3zxQNtSGZWM
         SVIzSNUx1JY3TMrTnuSPZ1HUsba2yl/4lCBN2ePGX66NBzG4DMBWHJM4ZnzIqY1Y4/
         4BPx1C10Anj5BXuhobKb0xRuZ7ZU0Y7Be2x1bhILDULUtkVZnglz9Cw4VGIf0KCIj5
         2b5dAIqg+pf0T3t/RLLZFqR8m0YJDp8EG1m+gifKIGsz2XZtdQLSf4pl2bzY1W+6Ti
         TLeqB5nzueurRfctBX+aaWRmGu87yJuzUBLe+r1m94t1XQOTKmD1O4cwME69FDo72B
         ZAkG5Epf0lldQ==
Date:   Wed, 22 Mar 2023 11:45:18 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/11] static_call: Remove DEFINE_STATIC_CALL_RET0()
Message-ID: <20230322184518.wjgfp7dyxvg5la5p@treble>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <8aab02492c2bf512c7ffe458e41acc1b930ed2dc.1679456900.git.jpoimboe@kernel.org>
 <20230322151532.GG2357380@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322151532.GG2357380@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 04:15:32PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 21, 2023 at 09:00:17PM -0700, Josh Poimboeuf wrote:
> > NULL and RET0 static calls are both slightly different ways of nopping a
> > static call.  A not-insignificant amount of code and complexity is spent
> > maintaining them separately.  It's also somewhat tricky for the user who
> > has to try to remember to use the correct one for the given function
> > type.
> 
> Well, I have very little sympathy for that argument. The return type
> should be a big frigging clue.
> 
> > Simplify things all around by just combining them, such that NULL static
> > calls always return 0.
> > 
> > While it doesn't necessarily make sense for void-return functions to
> > return 0, it's pretty much harmless.  The return value register is
> > already callee-clobbered, and an extra "xor %eax, %eax" shouldn't affect
> > performance (knock on wood).
> 
> Urgh.. OTOH I do like the lines removes.

So this patch is more of an RFC than the others.  I'm not fully
convinced myself, but I very much liked the removed lines and simpler
interface.

> > This "do nothing return 0" default should work for the vast majority of
> > NULL cases.  Otherwise it can be easily overridden with a user-specified
> > function which panics or returns 0xdeadbeef or does whatever one wants.
> > 
> > This simplifies the static call code and also tends to help simplify
> > users' code as well.
> 
> Can we at least keep the DEFINE_STATIC_CALL_RET0() and
> __static_call_return0 as aliases? It reads really daft to use _NULL or
> __static_call_nop for non-void functions.

I disagree, to me NULL means "nop the function (including any return
value)".  Nice and easy.

Keeping those other ret0 defines around would negate some of the cool
deletions.

-- 
Josh
