Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93851619401
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiKDKAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiKDKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:00:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA6028725
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:00:15 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N3bhS6M9MzHvZ2;
        Fri,  4 Nov 2022 17:59:52 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 18:00:13 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 18:00:12 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <lizhengyu3@huawei.com>,
        <liaochang1@huawei.com>, <u.kleine-koenig@pengutronix.de>,
        <rdunlap@infradead.org>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kexec@lists.infradead.org>, <lihuafei1@huawei.com>
Subject: [PATCH 2/2] RISC-V: kexec: Fix memory leak of elf header buffer
Date:   Fri, 4 Nov 2022 17:56:58 +0800
Message-ID: <20221104095658.141222-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104095658.141222-1-lihuafei1@huawei.com>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is reported by kmemleak detector:

unreferenced object 0xff2000000403d000 (size 4096):
  comm "kexec", pid 146, jiffies 4294900633 (age 64.792s)
  hex dump (first 32 bytes):
    7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00  .ELF............
    04 00 f3 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000566ca97c>] kmemleak_vmalloc+0x3c/0xbe
    [<00000000979283d8>] __vmalloc_node_range+0x3ac/0x560
    [<00000000b4b3712a>] __vmalloc_node+0x56/0x62
    [<00000000854f75e2>] vzalloc+0x2c/0x34
    [<00000000e9a00db9>] crash_prepare_elf64_headers+0x80/0x30c
    [<0000000067e8bf48>] elf_kexec_load+0x3e8/0x4ec
    [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
    [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
    [<0000000040c62c03>] ret_from_syscall+0x0/0x2

In elf_kexec_load(), a buffer is allocated via vzalloc() to store elf
headers.  While it's not freed back to system when kdump kernel is
reloaded or unloaded, or when image->elf_header is successfully set and
then fails to load kdump kernel for some reason. Fix it by freeing the
buffer in arch_kimage_file_post_load_cleanup().

Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/riscv/kernel/elf_kexec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index ff30fcb43f47..5372b708fae2 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -26,6 +26,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	kvfree(image->arch.fdt);
 	image->arch.fdt = NULL;
 
+	vfree(image->elf_headers);
+	image->elf_headers = NULL;
+	image->elf_headers_sz = 0;
+
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-- 
2.17.1

