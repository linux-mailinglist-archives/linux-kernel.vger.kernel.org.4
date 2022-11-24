Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD663706F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiKXC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKXC3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:29:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548C2ED75
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:29:01 -0800 (PST)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHhkM07kXzmW0w;
        Thu, 24 Nov 2022 10:28:26 +0800 (CST)
Received: from huawei.com (10.67.175.34) by kwepemi500022.china.huawei.com
 (7.221.188.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 24 Nov
 2022 10:28:59 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yusongping@huawei.com>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH v2] arm64: armv8_deprecated: fix unused-function error
Date:   Thu, 24 Nov 2022 02:24:29 +0000
Message-ID: <20221124022429.19024-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

To fix this warning, modify aarch32_check_condition() with __maybe_unused.

Fixes: 0c5f416219da ("arm64: armv8_deprecated: move aarch32 helper earlier")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
Changes in v2:
- modify aarch32_check_condition() with __maybe_unused.

 arch/arm64/kernel/armv8_deprecated.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index ed0788cf6bbb..8a9052cf3013 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -64,7 +64,7 @@ struct insn_emulation {
 
 #define	ARM_OPCODE_CONDITION_UNCOND	0xf
 
-static unsigned int aarch32_check_condition(u32 opcode, u32 psr)
+static unsigned int __maybe_unused aarch32_check_condition(u32 opcode, u32 psr)
 {
 	u32 cc_bits  = opcode >> 28;
 
-- 
2.17.1

