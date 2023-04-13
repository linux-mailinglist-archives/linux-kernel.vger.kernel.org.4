Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13806E10E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjDMPTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjDMPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E811A5FD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8683D63FA5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1858C433D2;
        Thu, 13 Apr 2023 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681399179;
        bh=D+Ns0pp9LAUq3M6VnP28UWoylcBTqXjdgm9D2DdpP24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWdqNzBAVVxkwsvUwz9LXic6zpm7MYWIzVrMec7Q5gMoFypD8C5xT5px3xbKaC/5O
         sDMqpmDY0rYMjOWjw2YWf0xnIa6d7tBHFg1sGLKM6/0iI8rHJ2XUqGzW3rYqa3SEws
         O1jx1OFXgRipmvBYRQ5oITQ1/bytb2I+Ka+p7RsfPdzy1ad6oI3CTQn8oFUPleyuwU
         V6Q3Rdv3qZFmEA1q2wcZAPwLED34B4FaV7zBIjKnXtYIb6oH2hMEPiEBY6xILeI7F1
         S4tXVOk44eATLhF/vnTbc2P62z4UlrsId/ljXlkRiLcFe2ZdbzAoNlYnH+HTklaa/h
         9hzdqvq/gtF2Q==
Date:   Thu, 13 Apr 2023 08:19:36 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 8/9] objtool: Detect missing __noreturn annotations
Message-ID: <20230413151936.7ineuo4heqwttugj@treble>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <0f630a0eb4585ab4114e4eecaa6f166a1fd81d49.1681325924.git.jpoimboe@kernel.org>
 <20230413084801.GI4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230413084801.GI4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:48:01AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 12, 2023 at 12:03:23PM -0700, Josh Poimboeuf wrote:
> > Most "unreachable instruction" warnings these days seem to actually be
> > the result of a missing __noreturn annotation.  Add an explicit check
> > for that.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  tools/objtool/Documentation/objtool.txt |  6 ++++++
> >  tools/objtool/check.c                   | 14 +++++++++++++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
> > index 5a69c207a10e..2cd1fa16ed08 100644
> > --- a/tools/objtool/Documentation/objtool.txt
> > +++ b/tools/objtool/Documentation/objtool.txt
> > @@ -303,6 +303,12 @@ the objtool maintainers.
> >     If it's not actually in a callable function (e.g. kernel entry code),
> >     change ENDPROC to END.
> >  
> > +3. file.o: warning: objtool: foo+0x48c: bar() is missing a __noreturn annotation
> > +
> > +   The call from foo() to bar() doesn't return, but bar() is missing the
> > +   __noreturn annotation.  NOTE: In addition to adding the __noreturn
> > +   annotation, the function name also needs to be added to
> > +   'global_noreturns' in tools/objtool/check.c.
> 
> Do we want something like the below (except perhaps less horrible) ?

Yeah, maybe.  Another possible way to do it:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cae6ac6ff246..a4e8ff9dabf1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -192,39 +192,16 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	struct instruction *insn;
 	bool empty = true;
 
+#define NORETURN(func) "\"" __stringify(func) "\"",
+
 	/*
 	 * Unfortunately these have to be hard coded because the noreturn
 	 * attribute isn't provided in ELF data. Keep 'em sorted.
 	 */
 	static const char * const global_noreturns[] = {
-		"__invalid_creds",
-		"__module_put_and_kthread_exit",
-		"__reiserfs_panic",
-		"__stack_chk_fail",
-		"__ubsan_handle_builtin_unreachable",
-		"arch_cpu_idle_dead",
-		"cpu_bringup_and_idle",
-		"cpu_startup_entry",
-		"do_exit",
-		"do_group_exit",
-		"do_task_dead",
-		"ex_handler_msr_mce",
-		"fortify_panic",
-		"kthread_complete_and_exit",
-		"kthread_exit",
-		"kunit_try_catch_throw",
-		"lbug_with_loc",
-		"machine_real_restart",
-		"make_task_dead",
-		"panic",
-		"rewind_stack_and_make_dead",
-		"sev_es_terminate",
-		"snp_abort",
-		"stop_this_cpu",
-		"usercopy_abort",
-		"xen_cpu_bringup_again",
-		"xen_start_kernel",
+#include "noreturns.h"
 	};
+#undef NORETURN
 
 	if (!func)
 		return false;
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
new file mode 100644
index 000000000000..0f5e53fd9e7a
--- /dev/null
+++ b/tools/objtool/noreturns.h
@@ -0,0 +1,27 @@
+NORETURN(__invalid_creds)
+NORETURN(__module_put_and_kthread_exit)
+NORETURN(__reiserfs_panic)
+NORETURN(__stack_chk_fail)
+NORETURN(__ubsan_handle_builtin_unreachable)
+NORETURN(arch_cpu_idle_dead)
+NORETURN(cpu_bringup_and_idle)
+NORETURN(cpu_startup_entry)
+NORETURN(do_exit)
+NORETURN(do_group_exit)
+NORETURN(do_task_dead)
+NORETURN(ex_handler_msr_mce)
+NORETURN(fortify_panic)
+NORETURN(kthread_complete_and_exit)
+NORETURN(kthread_exit)
+NORETURN(kunit_try_catch_throw)
+NORETURN(lbug_with_loc)
+NORETURN(machine_real_restart)
+NORETURN(make_task_dead)
+NORETURN(panic)
+NORETURN(rewind_stack_and_make_dead)
+NORETURN(sev_es_terminate)
+NORETURN(snp_abort)
+NORETURN(stop_this_cpu)
+NORETURN(usercopy_abort)
+NORETURN(xen_cpu_bringup_again)
+NORETURN(xen_start_kernel)
