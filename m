Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D889F6333E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiKVDYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiKVDYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:24:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD5223E96
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:24:33 -0800 (PST)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGV3Q0F06zmWNQ;
        Tue, 22 Nov 2022 11:24:02 +0800 (CST)
Received: from huawei.com (10.67.175.34) by kwepemi500022.china.huawei.com
 (7.221.188.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 11:24:31 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <yusongping@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH] arm64: armv8_deprecated: fix unused-function error
Date:   Tue, 22 Nov 2022 03:20:10 +0000
Message-ID: <20221122032010.202956-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500022.china.huawei.com (7.221.188.64)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SWP_EMULATION is not set and
CONFIG_CP15_BARRIER_EMULATION is not set,
aarch64-linux-gnu complained about unused-function :

arch/arm64/kernel/armv8_deprecated.c:67:21: error: ‘aarch32_check_condition’ defined but not used [-Werror=unused-function]
 static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
                     ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

To fix this error, warp the definition of
aarch32_check_condition() by defined(CONFIG_SWP_EMULATION) ||
defined(CONFIG_CP15_BARRIER_EMULATION)

Fixes: 0c5f416219da ("arm64: armv8_deprecated: move aarch32 helper earlier")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index ed0788cf6bbb..3f29ceb6653a 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -64,6 +64,7 @@ struct insn_emulation {
 
 #define	ARM_OPCODE_CONDITION_UNCOND	0xf
 
+#if defined(CONFIG_SWP_EMULATION) || defined(CONFIG_CP15_BARRIER_EMULATION)
 static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
 {
 	u32 cc_bits  = opcode >> 28;
@@ -76,6 +77,7 @@ static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
 	}
 	return ARM_OPCODE_CONDTEST_UNCOND;
 }
+#endif
 
 #ifdef CONFIG_SWP_EMULATION
 /*
-- 
2.17.1

