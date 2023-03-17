Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412EF6BE99D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjCQMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCQMtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:49:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1059C6B303
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:49:50 -0700 (PDT)
Received: from dggpeml500004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PdP843qK5znVJf;
        Fri, 17 Mar 2023 20:48:52 +0800 (CST)
Received: from DESKTOP-EJM108K.china.huawei.com (10.174.186.25) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 20:49:48 +0800
From:   Dongxu Sun <sundongxu3@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Dongxu Sun <sundongxu3@huawei.com>
Subject: [PATCH 4/4] arm64/sme: Fix some comments of ARM SME
Date:   Fri, 17 Mar 2023 20:49:15 +0800
Message-ID: <20230317124915.1263-5-sundongxu3@huawei.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When TIF_SME is clear, fpsimd_restore_current_state will disable
SME trap during ret_to_user, then SME access trap is impossible
in userspace, not SVE.

Besides, fix typo: alocated->allocated.

Signed-off-by: Dongxu Sun <sundongxu3@huawei.com>
---
 arch/arm64/kernel/fpsimd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 692dfefbe0ed..41b8f2052689 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -299,7 +299,7 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
 /*
  * TIF_SME controls whether a task can use SME without trapping while
  * in userspace, when TIF_SME is set then we must have storage
- * alocated in sve_state and sme_state to store the contents of both ZA
+ * allocated in sve_state and sme_state to store the contents of both ZA
  * and the SVE registers for both streaming and non-streaming modes.
  *
  * If both SVCR.ZA and SVCR.SM are disabled then at any point we
@@ -1477,7 +1477,7 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
  *
  * TIF_SME should be clear on entry: otherwise, fpsimd_restore_current_state()
  * would have disabled the SME access trap for userspace during
- * ret_to_user, making an SVE access trap impossible in that case.
+ * ret_to_user, making an SME access trap impossible in that case.
  */
 void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 {
-- 
2.33.0

