Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9351E6C4F27
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjCVPPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCVPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:15:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938995FA7E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oo95ksNo438JOehySiTYm2xvtjpxki70aoJy1x654ic=; b=AmZ2yrsZzD4hIqyo5kv7jGnakK
        Xp5HymcULYHKiPmU0NelZiXniuv5bFpGR4XawrJ9sicQHGWK8yJCFBqUzgBSY/VQtud4N1DN87+KC
        c7pFK8A2II1Hy5hc2crVFOA5N7MCOp5rAIYa90s0SQ7AY8EXjL0hhDQc/gXoq9tiv/K9baikGBPuv
        tdWmywNXyOa5NgV+l9hSZzN+DLj+qPo6+FCxVGRHhNucOHc+/gY86qQAlEH8bmbuJkIW+4qve6g/o
        iIO3PraeOxVCPa+EqiGS2TzqFHBGsT2QddsWck3WlnOr5TUuy1ZDh5l3SATp28cz6IY8w6zsEqqEg
        VX7N1KXA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pf0Bb-0036gM-8p; Wed, 22 Mar 2023 15:15:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D005300379;
        Wed, 22 Mar 2023 16:15:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33289201FFA49; Wed, 22 Mar 2023 16:15:32 +0100 (CET)
Date:   Wed, 22 Mar 2023 16:15:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
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
Message-ID: <20230322151532.GG2357380@hirez.programming.kicks-ass.net>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <8aab02492c2bf512c7ffe458e41acc1b930ed2dc.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aab02492c2bf512c7ffe458e41acc1b930ed2dc.1679456900.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:00:17PM -0700, Josh Poimboeuf wrote:
> NULL and RET0 static calls are both slightly different ways of nopping a
> static call.  A not-insignificant amount of code and complexity is spent
> maintaining them separately.  It's also somewhat tricky for the user who
> has to try to remember to use the correct one for the given function
> type.

Well, I have very little sympathy for that argument. The return type
should be a big frigging clue.

> Simplify things all around by just combining them, such that NULL static
> calls always return 0.
> 
> While it doesn't necessarily make sense for void-return functions to
> return 0, it's pretty much harmless.  The return value register is
> already callee-clobbered, and an extra "xor %eax, %eax" shouldn't affect
> performance (knock on wood).

Urgh.. OTOH I do like the lines removes.

> This "do nothing return 0" default should work for the vast majority of
> NULL cases.  Otherwise it can be easily overridden with a user-specified
> function which panics or returns 0xdeadbeef or does whatever one wants.
> 
> This simplifies the static call code and also tends to help simplify
> users' code as well.

Can we at least keep the DEFINE_STATIC_CALL_RET0() and
__static_call_return0 as aliases? It reads really daft to use _NULL or
__static_call_nop for non-void functions.

