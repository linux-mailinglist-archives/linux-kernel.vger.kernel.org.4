Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2A56173AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiKCBUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKCBUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:20:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA05612745
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:20:30 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N2m8G2jT7zJnQL;
        Thu,  3 Nov 2022 09:17:34 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 09:20:28 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <linux@armlinux.org.uk>, <linus.walleij@linaro.org>,
        <ardb@kernel.org>, <liaochang1@huawei.com>, <nico@fluxnic.net>,
        <rmk+kernel@armlinux.org.uk>, <chenzhongjin@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: module: Reclaim the unwind list of module on kmalloc failed
Date:   Thu, 3 Nov 2022 09:17:13 +0800
Message-ID: <20221103011713.138974-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unwind table allocation failed, it needs to reclaim the unwind list
of module to avoid potential NULL pointer exception and memory leakage.

Fixes: b6f21d14f1ac ("ARM: 9204/2: module: Add all unwind tables when load module")
Signed-off-by: Liao Chang <liaochang1@huawei.com>
Cc: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index d59c36dc0494..cc637dcdcb10 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -485,6 +485,10 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 						s->sh_size,
 						txt_sec->sh_addr,
 						txt_sec->sh_size);
+			if (!table) {
+				module_arch_cleanup(mod);
+				return -ENOMEM;
+			}
 
 			list_add(&table->mod_list, unwind_list);
 
-- 
2.17.1

