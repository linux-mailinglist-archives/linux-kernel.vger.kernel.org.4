Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5451B707106
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjEQSoS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEQSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:44:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D741BC;
        Wed, 17 May 2023 11:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5121263E63;
        Wed, 17 May 2023 18:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F848C433D2;
        Wed, 17 May 2023 18:44:11 +0000 (UTC)
Date:   Wed, 17 May 2023 14:44:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: make ftrace_likely_update() declaration
 visible
Message-ID: <20230517144409.3f790524@gandalf.local.home>
In-Reply-To: <CAHk-=wh+129KAcegJqvo2PKPUK3yw5qQwF0LcHofdT0bPbs8iQ@mail.gmail.com>
References: <20230517124721.929540-1-arnd@kernel.org>
        <CAHk-=wh+129KAcegJqvo2PKPUK3yw5qQwF0LcHofdT0bPbs8iQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 09:39:41 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, May 17, 2023 at 5:47 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > This function is only used when CONFIG_TRACE_BRANCH_PROFILING is
> > set, and the declaration is hidden behind this Kconfig symbol,
> > which causes a warning if disabled:  
> 
> That explanation is not very clear.
> 
> The problem is that the tracing code itself is built with
> DISABLE_BRANCH_PROFILING, in order to not recurse. And that hides the
> declaration when the definition is compiled, leading to the problem.
> 
> CONFIG_TRACE_BRANCH_PROFILING isn't the problem in itself - *that*
> part of the test is consistent (not used, not declared, and not
> compiled if it is off).
> 
> The problem is that DISABLE_BRANCH_PROFILING case, where it is used
> elsewhere, but not declared when it is itself compiled.
> 
> I applied the patch, but I tried to reword the explanation to be more
> clear. I may have failed.
> 

That's pretty much it. The DISABLE_BRANCH_PROFILING is to disable it in
various places where it will crash if used (vdso is one of them). It is
also used to prevent the code that declares it from recursing on itself (as
you stated).

Thus, the issue is simply that the declaration is hidden by the recursion
protection where the function is actually defined.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
