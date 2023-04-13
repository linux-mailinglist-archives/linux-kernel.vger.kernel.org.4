Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A266E093D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDMIsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDMIsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:48:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373047DA5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Du9y7fpdltbvnmKX4UNaupPxJrJ0sG0KNOQFpMVQLA=; b=BLnoB8VToCB5QszFQZNxxQiJzj
        ZFOlptGnsOkVKGhwgEpiJwneq6MsPA9pWCxjWLYemNX1FCf8kmVsEwnceui9Tsl2+W1S9hczl3LGU
        FtoFNOsUSP09ewXfzkV3mf/KRCO+0AbqRJbRWPRqEMIsWS/yR2QggeAUkwnmt4+qMMwzyFjb355e+
        +/tRXmlPcuGbEb04Y8UIXeabUuXPRXAgLQabQO03csh9lezlC5zEIpU1cRWDcSxA/VFAeyv1wQBZr
        KFaQUr2Xqul6btTNkSwLn8FGoXtIZi/+pVAMKBv67Mp1KeD/jSDXYxE42TiUov9/bilhSigHmhhV5
        MRlfc0pQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmscc-007eIU-L3; Thu, 13 Apr 2023 08:48:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9123D3001E5;
        Thu, 13 Apr 2023 10:48:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 707AF20D0CF59; Thu, 13 Apr 2023 10:48:01 +0200 (CEST)
Date:   Thu, 13 Apr 2023 10:48:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 8/9] objtool: Detect missing __noreturn annotations
Message-ID: <20230413084801.GI4253@hirez.programming.kicks-ass.net>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <0f630a0eb4585ab4114e4eecaa6f166a1fd81d49.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f630a0eb4585ab4114e4eecaa6f166a1fd81d49.1681325924.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:03:23PM -0700, Josh Poimboeuf wrote:
> Most "unreachable instruction" warnings these days seem to actually be
> the result of a missing __noreturn annotation.  Add an explicit check
> for that.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/Documentation/objtool.txt |  6 ++++++
>  tools/objtool/check.c                   | 14 +++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
> index 5a69c207a10e..2cd1fa16ed08 100644
> --- a/tools/objtool/Documentation/objtool.txt
> +++ b/tools/objtool/Documentation/objtool.txt
> @@ -303,6 +303,12 @@ the objtool maintainers.
>     If it's not actually in a callable function (e.g. kernel entry code),
>     change ENDPROC to END.
>  
> +3. file.o: warning: objtool: foo+0x48c: bar() is missing a __noreturn annotation
> +
> +   The call from foo() to bar() doesn't return, but bar() is missing the
> +   __noreturn annotation.  NOTE: In addition to adding the __noreturn
> +   annotation, the function name also needs to be added to
> +   'global_noreturns' in tools/objtool/check.c.

Do we want something like the below (except perhaps less horrible) ?

---
 tools/objtool/Makefile     |  1 +
 tools/objtool/check.c      | 27 +--------------------------
 tools/objtool/noreturns    | 26 ++++++++++++++++++++++++++
 tools/objtool/noreturns.sh |  7 +++++++
 4 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 83b100c1e7f6..50b6cd241571 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -63,6 +63,7 @@ include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep $(LIBSUBCMD) FORCE
 	$(Q)$(CONFIG_SHELL) ./sync-check.sh
+	$(Q)$(CONFIG_SHELL) ./noreturns.sh
 	$(Q)$(MAKE) $(build)=objtool $(HOST_OVERRIDES) CFLAGS="$(OBJTOOL_CFLAGS)" \
 		LDFLAGS="$(OBJTOOL_LDFLAGS)"
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f937be1afe65..f558730c27b6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -197,32 +197,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 * attribute isn't provided in ELF data. Keep 'em sorted.
 	 */
 	static const char * const global_noreturns[] = {
-		"__invalid_creds",
-		"__module_put_and_kthread_exit",
-		"__reiserfs_panic",
-		"__stack_chk_fail",
-		"__ubsan_handle_builtin_unreachable",
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
 
 	if (!func)
diff --git a/tools/objtool/noreturns b/tools/objtool/noreturns
new file mode 100644
index 000000000000..75f35fbb34d1
--- /dev/null
+++ b/tools/objtool/noreturns
@@ -0,0 +1,26 @@
+__invalid_creds
+__module_put_and_kthread_exit
+__reiserfs_panic
+__stack_chk_fail
+__ubsan_handle_builtin_unreachable
+cpu_bringup_and_idle
+cpu_startup_entry
+do_exit
+do_group_exit
+do_task_dead
+ex_handler_msr_mce
+fortify_panic
+kthread_complete_and_exit
+kthread_exit
+kunit_try_catch_throw
+lbug_with_loc
+machine_real_restart
+make_task_dead
+panic
+rewind_stack_and_make_dead
+sev_es_terminate
+snp_abort
+stop_this_cpu
+usercopy_abort
+xen_cpu_bringup_again
+xen_start_kernel
diff --git a/tools/objtool/noreturns.sh b/tools/objtool/noreturns.sh
new file mode 100755
index 000000000000..f728cb61e665
--- /dev/null
+++ b/tools/objtool/noreturns.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+cat noreturns | while read func
+do
+	echo \"${func}\",
+done > noreturns.h
