Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2B15E6338
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiIVNI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiIVNIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:08:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE89BEBBE4;
        Thu, 22 Sep 2022 06:08:42 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYFsf3kKJzHpvG;
        Thu, 22 Sep 2022 21:06:30 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:08:32 +0800
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
Subject: [PATCH -next 2/3] arm64: head: Mark constants as data
Date:   Thu, 22 Sep 2022 21:04:51 +0800
Message-ID: <20220922130452.233323-3-chenzhongjin@huawei.com>
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

Add data annotations to constants part of the image header.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/head.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 814b6587ccb7..f298e88e2d23 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -57,9 +57,10 @@
 	/*
 	 * DO NOT MODIFY. Image header expected by Linux boot-loaders.
 	 */
-	efi_signature_nop			// special NOP to identity as PE/COFF executable
+SYM_DATA_LOCAL(efi_nop, efi_signature_nop)	// special NOP to identity as PE/COFF executable
 	b	primary_entry			// branch to kernel start, magic
-	.quad	0				// Image load offset from start of RAM, little-endian
+SYM_DATA_LOCAL(_zero_reserved, .quad	0)	// Image load offset from start of RAM, little-endian
+SYM_DATA_START_LOCAL(_arm64_common_header)
 	le64sym	_kernel_size_le			// Effective size of kernel image, little-endian
 	le64sym	_kernel_flags_le		// Informative flags, little-endian
 	.quad	0				// reserved
@@ -67,6 +68,7 @@
 	.quad	0				// reserved
 	.ascii	ARM64_IMAGE_MAGIC		// Magic number
 	.long	.Lpe_header_offset		// Offset to the PE header.
+SYM_DATA_END(_arm64_common_header)
 
 	__EFI_PE_HEADER
 
-- 
2.17.1

