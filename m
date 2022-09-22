Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5A65E633A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiIVNIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiIVNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:08:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E200EBBD5;
        Thu, 22 Sep 2022 06:08:36 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYFqG2G3lz14S3P;
        Thu, 22 Sep 2022 21:04:26 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:08:34 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:08:34 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
        <ardb@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <anshuman.khandual@arm.com>, <chenzhongjin@huawei.com>
Subject: [PATCH -next 1/3] arm64: efi-header: Mark efi header as data
Date:   Thu, 22 Sep 2022 21:04:50 +0800
Message-ID: <20220922130452.233323-2-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922130452.233323-1-chenzhongjin@huawei.com>
References: <20220922130452.233323-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file only contains a set of constants forming the efi header.

Make the constants part of data symbols by wrapping them with
SYM_DATA.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/efi-header.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
index 28d8a5dca5f1..3eacd27ab761 100644
--- a/arch/arm64/kernel/efi-header.S
+++ b/arch/arm64/kernel/efi-header.S
@@ -28,6 +28,7 @@
 	.macro	__EFI_PE_HEADER
 #ifdef CONFIG_EFI
 	.set	.Lpe_header_offset, . - .L_head
+SYM_DATA_START_LOCAL(arm64_efi_header)
 	.long	PE_MAGIC
 	.short	IMAGE_FILE_MACHINE_ARM64		// Machine
 	.short	.Lsection_count				// NumberOfSections
@@ -160,6 +161,7 @@
 
 	.balign	SEGMENT_ALIGN
 .Lefi_header_end:
+SYM_DATA_END_LABEL(arm64_efi_header, SYM_L_LOCAL, efi_header_end)
 #else
 	.set	.Lpe_header_offset, 0x0
 #endif
-- 
2.17.1

