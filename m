Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67F721F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjFEHdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjFEHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:33:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C8CD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:33:18 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QZPtc5H8XztQWV;
        Mon,  5 Jun 2023 15:12:08 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 5 Jun
 2023 15:14:27 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <tglx@linutronix.de>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <x86@kernel.org>, <liwei391@huawei.com>
Subject: [PATCH] x86/microcode/AMD: shrink the size of amd_ucode_patch array
Date:   Mon, 5 Jun 2023 15:12:56 +0800
Message-ID: <20230605071256.1813504-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

About the commit <7ff6edf4fef3>, the amd_ucode_patch is expanded as
two-dimensional array. When CONFIG_MAXSMP is enabled or CONFIG_NODES_SHIFT
is set as 10, this array would occupy memory up to 12M.

Here we allocate amd_ucode_patch array dynamically in need instead of
static declaration.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f5fdeb1e3606..b6cd6ce9c016 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -57,7 +57,8 @@ struct cont_desc {
 static u32 ucode_new_rev;
 
 /* One blob per node. */
-static u8 amd_ucode_patch[MAX_NUMNODES][PATCH_MAX_SIZE];
+static u8 amd_ucode_patch_0[PATCH_MAX_SIZE];
+static u8 *amd_ucode_patch[MAX_NUMNODES] = { amd_ucode_patch_0 };
 
 /*
  * Microcode patch container file is prepended to the initrd in cpio
@@ -420,17 +421,17 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
 static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
 {
 	struct cont_desc desc = { 0 };
-	u8 (*patch)[PATCH_MAX_SIZE];
+	u8 *patch;
 	struct microcode_amd *mc;
 	u32 rev, dummy, *new_rev;
 	bool ret = false;
 
 #ifdef CONFIG_X86_32
 	new_rev = (u32 *)__pa_nodebug(&ucode_new_rev);
-	patch	= (u8 (*)[PATCH_MAX_SIZE])__pa_nodebug(&amd_ucode_patch);
+	patch	= (u8 *)__pa_nodebug(amd_ucode_patch_0);
 #else
 	new_rev = &ucode_new_rev;
-	patch	= &amd_ucode_patch[0];
+	patch	= amd_ucode_patch_0;
 #endif
 
 	desc.cpuid_1_eax = cpuid_1_eax;
@@ -881,8 +882,11 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 
 		ret = UCODE_NEW;
 
-		memset(&amd_ucode_patch[nid], 0, PATCH_MAX_SIZE);
-		memcpy(&amd_ucode_patch[nid], p->data, min_t(u32, p->size, PATCH_MAX_SIZE));
+		if (!amd_ucode_patch[nid])
+			amd_ucode_patch[nid] = kmalloc(PATCH_MAX_SIZE, GFP_KERNEL);
+
+		memset(amd_ucode_patch[nid], 0, PATCH_MAX_SIZE);
+		memcpy(amd_ucode_patch[nid], p->data, min_t(u32, p->size, PATCH_MAX_SIZE));
 	}
 
 	return ret;
-- 
2.25.1

