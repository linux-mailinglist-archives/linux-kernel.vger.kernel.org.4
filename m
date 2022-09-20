Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63B5BDF63
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiITILp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiITILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:11:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE91467164
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:07:21 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWvDt1DCrzcn0p;
        Tue, 20 Sep 2022 16:03:26 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 16:07:19 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <jpoimboe@kernel.org>, <peterz@infradead.org>, <mbenes@suse.cz>
CC:     <linux-kernel@vger.kernel.org>, <zengheng4@huawei.com>,
        <liwei391@huawei.com>
Subject: [PATCH -next 3/3] tools: objtool: fix unused-parameter warning in special.c
Date:   Tue, 20 Sep 2022 16:14:16 +0800
Message-ID: <20220920081416.3570803-4-zengheng4@huawei.com>
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

Remove unused parameters of function
'arch_support_alt_relocation'.

There is no logic changes.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/objtool/arch/x86/special.c        | 3 +--
 tools/objtool/check.c                   | 2 +-
 tools/objtool/include/objtool/special.h | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 7c97b7391279..2524156f0f23 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -39,8 +39,7 @@ void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 }
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
-				 struct instruction *insn,
-				 struct reloc *reloc)
+				 struct instruction *insn)
 {
 	/*
 	 * The x86 alternatives code adjusts the offsets only when it
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cee5436b3bf9..1f755700c036 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1645,7 +1645,7 @@ static int handle_group_alt(struct objtool_file *file,
 		 */
 		alt_reloc = insn_reloc(file, insn);
 		if (alt_reloc &&
-		    !arch_support_alt_relocation(special_alt, insn, alt_reloc)) {
+		    !arch_support_alt_relocation(special_alt, insn)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
 				  insn->sec, insn->offset);
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index dc4721e19002..fc184be6cd9f 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -35,8 +35,7 @@ int special_get_alts(struct elf *elf, struct list_head *alts);
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
-				 struct instruction *insn,
-				 struct reloc *reloc);
+				 struct instruction *insn);
 struct reloc *arch_find_switch_table(struct objtool_file *file,
 				    struct instruction *insn);
 #endif /* _SPECIAL_H */
-- 
2.25.1

