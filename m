Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A372438C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbjFFND6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jun 2023 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjFFND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:03:56 -0400
X-Greylist: delayed 296 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 06:03:55 PDT
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D6EA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:03:55 -0700 (PDT)
Received: from w013.hihonor.com (unknown [10.68.26.19])
        by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Qb9HC5cTVzZFR27;
        Tue,  6 Jun 2023 20:47:35 +0800 (CST)
Received: from a005.hihonor.com (10.68.18.24) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 6 Jun
 2023 20:47:37 +0800
Received: from a007.hihonor.com (10.68.22.31) by a005.hihonor.com
 (10.68.18.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 6 Jun
 2023 20:47:37 +0800
Received: from a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7]) by
 a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7%10]) with mapi id 15.02.1118.021;
 Tue, 6 Jun 2023 20:47:37 +0800
From:   gaoxu <gaoxu2@hihonor.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>,
        "wangbintian(BintianWang)" <bintian.wang@hihonor.com>
Subject: [RESEND  PATCH] dma-remap: Use kvmalloc_array/kvfree for larger dma
 memory remap
Thread-Topic: [RESEND  PATCH] dma-remap: Use kvmalloc_array/kvfree for larger
 dma memory remap
Thread-Index: AdmYdFzrTjKG3Wk/TNCzbQyr42cDew==
Content-Class: 
Date:   Tue, 6 Jun 2023 12:47:37 +0000
Message-ID: <4cae21d9a89a4c4da47fb3ef6465b676@hihonor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.164.11.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dma_direct_alloc() alloc memory in size of 64MB, the inner function
dma_common_contiguous_remap() will allocate 128KB memory by invoking 
the function kmalloc_array(). and the kmalloc_array seems to fail to try to
allocate 128KB mem. 

Call trace:
[14977.928623] qcrosvm: page allocation failure: order:5, mode:0x40cc0
[14977.928638] dump_backtrace.cfi_jt+0x0/0x8
[14977.928647] dump_stack_lvl+0x80/0xb8
[14977.928652] warn_alloc+0x164/0x200
[14977.928657] __alloc_pages_slowpath+0x9f0/0xb4c
[14977.928660] __alloc_pages+0x21c/0x39c
[14977.928662] kmalloc_order+0x48/0x108
[14977.928666] kmalloc_order_trace+0x34/0x154
[14977.928668] __kmalloc+0x548/0x7e4
[14977.928673] dma_direct_alloc+0x11c/0x4f8
[14977.928678] dma_alloc_attrs+0xf4/0x138
[14977.928680] gh_vm_ioctl_set_fw_name+0x3c4/0x610 [gunyah]
[14977.928698] gh_vm_ioctl+0x90/0x14c [gunyah]
[14977.928705] __arm64_sys_ioctl+0x184/0x210

work around by doing kvmalloc_array instead.

Signed-off-by: Gao Xu <gaoxu2@hihonor.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/dma/remap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c index b45266680..27596f3b4 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -43,13 +43,13 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 	void *vaddr;
 	int i;
 
-	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
+	pages = kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return NULL;
 	for (i = 0; i < count; i++)
 		pages[i] = nth_page(page, i);
 	vaddr = vmap(pages, count, VM_DMA_COHERENT, prot);
-	kfree(pages);
+	kvfree(pages);
 
 	return vaddr;
 }
--
2.17.1

