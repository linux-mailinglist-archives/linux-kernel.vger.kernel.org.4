Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BAF5BDDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiITHO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiITHOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:14:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DC65C36C;
        Tue, 20 Sep 2022 00:14:23 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWt3m0JFYzmVYx;
        Tue, 20 Sep 2022 15:10:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 15:14:21 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 15:14:21 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 7/8] livepatch: Improve the search performance of module_kallsyms_on_each_symbol()
Date:   Tue, 20 Sep 2022 15:13:16 +0800
Message-ID: <20220920071317.1787-8-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220920071317.1787-1-thunder.leizhen@huawei.com>
References: <20220920071317.1787-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we traverse all symbols of all modules to find the specified
function for the specified module. But in reality, we just need to find
the given module and then traverse all the symbols in it.

In order to achieve this purpose, split the call to hook 'fn' into two
phases:
1. Finds the given module. Pass pointer 'mod'. Hook 'fn' directly returns
   the comparison result of the module name without comparing the function
   name.
2. Finds the given function in that module. Pass pointer 'mod = NULL'.
   Hook 'fn' skip the comparison of module name and directly compare
   function names.

Phase1: mod1-->mod2..(subsequent modules do not need to be compared)
                |
Phase2:          -->f1-->f2-->f3

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/livepatch/core.c  |  7 ++-----
 kernel/module/kallsyms.c | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 31b57ccf908017e..98e23137e4133bc 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -130,15 +130,12 @@ static int klp_find_callback(void *data, const char *name,
 {
 	struct klp_find_arg *args = data;
 
-	if ((mod && !args->objname) || (!mod && args->objname))
-		return 0;
+	if (mod)
+		return strcmp(args->objname, mod->name);
 
 	if (strcmp(args->name, name))
 		return 0;
 
-	if (args->objname && strcmp(args->objname, mod->name))
-		return 0;
-
 	args->addr = addr;
 	args->count++;
 
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index f5c5c9175333df7..b033613e6c7e3bb 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -510,6 +510,11 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 
+		/* check mod->name first */
+		ret = fn(data, NULL, mod, 0);
+		if (ret)
+			continue;
+
 		/* Use rcu_dereference_sched() to remain compliant with the sparse tool */
 		preempt_disable();
 		kallsyms = rcu_dereference_sched(mod->kallsyms);
@@ -522,10 +527,16 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 				continue;
 
 			ret = fn(data, kallsyms_symbol_name(kallsyms, i),
-				 mod, kallsyms_symbol_value(sym));
+				 NULL, kallsyms_symbol_value(sym));
 			if (ret != 0)
 				goto out;
 		}
+
+		/*
+		 * The given module is found, the subsequent modules do not
+		 * need to be compared.
+		 */
+		break;
 	}
 out:
 	mutex_unlock(&module_mutex);
-- 
2.25.1

