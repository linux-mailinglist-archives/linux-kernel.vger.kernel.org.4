Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A46D5FC42E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJLLMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJLLLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:11:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B95C1DAF;
        Wed, 12 Oct 2022 04:11:38 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MnVGY6nKyz1P73k;
        Wed, 12 Oct 2022 19:07:01 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 19:11:36 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 12 Oct
 2022 19:11:35 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Conor Dooley <conor@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v3 2/2] riscv: Enable HAVE_ARCH_HUGE_VMALLOC for 64BIT
Date:   Wed, 12 Oct 2022 20:00:38 +0800
Message-ID: <20221012120038.1034354-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012120038.1034354-1-liushixin2@huawei.com>
References: <20221012120038.1034354-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we support HAVE_ARCH_HUGE_VMAP, we can now enable HAVE_ARCH_HUGE_VMALLOC
too. This feature has been used in kvmalloc and alloc_large_system_hash
for now. This feature can be disabled by kernel parameters "nohugevmalloc".

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Tested-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a4d597203bd9..fded181c9e50 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -70,6 +70,7 @@ config RISCV
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT && !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
-- 
2.25.1

