Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CCB6BE99A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCQMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjCQMtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:49:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD7F18A8C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:49:42 -0700 (PDT)
Received: from dggpeml500004.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PdP8g5fndz9t6p;
        Fri, 17 Mar 2023 20:49:23 +0800 (CST)
Received: from DESKTOP-EJM108K.china.huawei.com (10.174.186.25) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 20:49:40 +0800
From:   Dongxu Sun <sundongxu3@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Dongxu Sun <sundongxu3@huawei.com>
Subject: [PATCH 1/4] arm64/signal: Use system_supports_tpidr2() to check TPIDR2
Date:   Fri, 17 Mar 2023 20:49:12 +0800
Message-ID: <20230317124915.1263-2-sundongxu3@huawei.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20230317124915.1263-1-sundongxu3@huawei.com>
References: <20230317124915.1263-1-sundongxu3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.186.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500004.china.huawei.com (7.185.36.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a9d6915859501("arm64/sme: Implement support
for TPIDR2"), We introduced system_supports_tpidr2() for
TPIDR2 handling. Let's use the specific check instead.

No functional changes.

Signed-off-by: Dongxu Sun <sundongxu3@huawei.com>
---
 arch/arm64/kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 06a02707f488..032e97f8cae0 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -651,7 +651,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			break;
 
 		case TPIDR2_MAGIC:
-			if (!system_supports_sme())
+			if (!system_supports_tpidr2())
 				goto invalid;
 
 			if (user->tpidr2)
@@ -802,7 +802,7 @@ static int restore_sigframe(struct pt_regs *regs,
 			err = restore_fpsimd_context(&user);
 	}
 
-	if (err == 0 && system_supports_sme() && user.tpidr2)
+	if (err == 0 && system_supports_tpidr2() && user.tpidr2)
 		err = restore_tpidr2_context(&user);
 
 	if (err == 0 && system_supports_sme() && user.za)
@@ -974,7 +974,7 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 	}
 
 	/* TPIDR2 if supported */
-	if (system_supports_sme() && err == 0) {
+	if (system_supports_tpidr2() && err == 0) {
 		struct tpidr2_context __user *tpidr2_ctx =
 			apply_user_offset(user, user->tpidr2_offset);
 		err |= preserve_tpidr2_context(tpidr2_ctx);
-- 
2.33.0

