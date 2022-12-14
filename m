Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D663464CBB9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiLNOAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbiLNN75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:59:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF620188
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:59:56 -0800 (PST)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXH203gzDzqT81;
        Wed, 14 Dec 2022 21:55:36 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 14 Dec 2022 21:59:53 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <oleg@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <broonie@kernel.org>, <wanghaibin.wang@huawei.com>,
        <zhouquan65@huawei.com>, <sundongxu3@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] arm64: ptrace: Use ARM64_SME to guard the SME register enumerations
Date:   Wed, 14 Dec 2022 21:59:43 +0800
Message-ID: <20221214135943.379-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently guard REGSET_{SSVE, ZA} using ARM64_SVE for no good reason.
Both enumerations would be pointless without ARM64_SME and create two empty
entries in aarch64_regsets[] which would then become part of a process's
native regset view (they should be ignored though).

Switch to use ARM64_SME instead.

Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 2686ab157601..0c321ad23cd3 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1357,7 +1357,7 @@ enum aarch64_regset {
 #ifdef CONFIG_ARM64_SVE
 	REGSET_SVE,
 #endif
-#ifdef CONFIG_ARM64_SVE
+#ifdef CONFIG_ARM64_SME
 	REGSET_SSVE,
 	REGSET_ZA,
 #endif
-- 
2.33.0

