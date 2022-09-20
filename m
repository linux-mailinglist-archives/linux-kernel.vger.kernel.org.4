Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84795BDF68
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiITIL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiITILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:11:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD3E6612D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:07:21 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWvDf0ZJfzlVmh;
        Tue, 20 Sep 2022 16:03:14 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 16:07:19 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <jpoimboe@kernel.org>, <peterz@infradead.org>, <mbenes@suse.cz>
CC:     <linux-kernel@vger.kernel.org>, <zengheng4@huawei.com>,
        <liwei391@huawei.com>
Subject: [PATCH -next 2/3] tools: objtool: fix unused-parameter warning in check.c
Date:   Tue, 20 Sep 2022 16:14:15 +0800
Message-ID: <20220920081416.3570803-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920081416.3570803-1-zengheng4@huawei.com>
References: <20220920081416.3570803-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused parameters of internal functions.

There is no logic changes.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/objtool/check.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7f2a867f8f85..cee5436b3bf9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -268,8 +268,7 @@ static void init_cfi_state(struct cfi_state *cfi)
 	cfi->drap_offset = -1;
 }
 
-static void init_insn_state(struct objtool_file *file, struct insn_state *state,
-			    struct section *sec)
+static void init_insn_state(struct insn_state *state, struct section *sec)
 {
 	memset(state, 0, sizeof(*state));
 	init_cfi_state(&state->cfi);
@@ -2446,7 +2445,7 @@ static bool is_fentry_call(struct instruction *insn)
 	return false;
 }
 
-static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
+static bool has_modified_stack_frame(struct insn_state *state)
 {
 	struct cfi_state *cfi = &state->cfi;
 	int i;
@@ -2491,9 +2490,8 @@ static bool has_valid_stack_frame(struct insn_state *state)
 	return false;
 }
 
-static int update_cfi_state_regs(struct instruction *insn,
-				  struct cfi_state *cfi,
-				  struct stack_op *op)
+static int update_cfi_state_regs(struct cfi_state *cfi,
+				 struct stack_op *op)
 {
 	struct cfi_reg *cfa = &cfi->cfa;
 
@@ -2602,7 +2600,7 @@ static int update_cfi_state(struct instruction *insn,
 
 	if (cfi->type == UNWIND_HINT_TYPE_REGS ||
 	    cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL)
-		return update_cfi_state_regs(insn, cfi, op);
+		return update_cfi_state_regs(cfi, op);
 
 	switch (op->dest.type) {
 
@@ -3015,7 +3013,7 @@ static int update_cfi_state(struct instruction *insn,
  * and replacement) into a single shared CFI array which can be used to detect
  * conflicts and nicely feed a linear array of ORC entries to the unwinder.
  */
-static int propagate_alt_cfi(struct objtool_file *file, struct instruction *insn)
+static int propagate_alt_cfi(struct instruction *insn)
 {
 	struct cfi_state **alt_cfi;
 	int group_off;
@@ -3249,7 +3247,7 @@ static int validate_sibling_call(struct objtool_file *file,
 				 struct instruction *insn,
 				 struct insn_state *state)
 {
-	if (has_modified_stack_frame(insn, state)) {
+	if (has_modified_stack_frame(state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
 				insn->sec, insn->offset);
 		return 1;
@@ -3284,7 +3282,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 		return 1;
 	}
 
-	if (func && has_modified_stack_frame(insn, state)) {
+	if (func && has_modified_stack_frame(state)) {
 		WARN_FUNC("return with modified stack frame",
 			  insn->sec, insn->offset);
 		return 1;
@@ -3405,7 +3403,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		insn->visited |= visited;
 
-		if (propagate_alt_cfi(file, insn))
+		if (propagate_alt_cfi(insn))
 			return 1;
 
 		if (!insn->ignore_alts && !list_empty(&insn->alts)) {
@@ -3567,7 +3565,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	if (!file->hints)
 		return 0;
 
-	init_insn_state(file, &state, sec);
+	init_insn_state(&state, sec);
 
 	if (sec) {
 		insn = find_insn(file, sec, 0);
@@ -3930,7 +3928,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 		if (func->type != STT_FUNC)
 			continue;
 
-		init_insn_state(file, &state, sec);
+		init_insn_state(&state, sec);
 		set_func_state(&state.cfi);
 
 		warnings += validate_symbol(file, sec, func, &state);
-- 
2.25.1

