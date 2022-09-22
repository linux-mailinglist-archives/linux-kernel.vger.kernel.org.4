Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B825E6128
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiIVLdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIVLdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:33:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA36E21CE;
        Thu, 22 Sep 2022 04:33:19 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYChg332szMnbq;
        Thu, 22 Sep 2022 19:28:35 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:33:17 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <sumit.semwal@linaro.org>, <benjamin.gaignard@collabora.com>,
        <lmark@codeaurora.org>, <labbott@redhat.com>,
        <Brian.Starkey@arm.com>, <jstultz@google.com>,
        <christian.koenig@amd.com>
CC:     <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dma-buf: Add __init annotation to module init func
Date:   Thu, 22 Sep 2022 19:29:38 +0800
Message-ID: <20220922112938.147609-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __init annotation to module init func.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/dma-buf/heaps/cma_heap.c    | 2 +-
 drivers/dma-buf/heaps/system_heap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 28fb04eccdd0..62d0d0e8b10d 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -392,7 +392,7 @@ static int __add_cma_heap(struct cma *cma, void *data)
 	return 0;
 }
 
-static int add_default_cma_heap(void)
+static int __init add_default_cma_heap(void)
 {
 	struct cma *default_cma = dev_get_cma_area(NULL);
 	int ret = 0;
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index fcf836ba9c1f..cbe445bc5bab 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -422,7 +422,7 @@ static const struct dma_heap_ops system_heap_ops = {
 	.allocate = system_heap_allocate,
 };
 
-static int system_heap_create(void)
+static int __init system_heap_create(void)
 {
 	struct dma_heap_export_info exp_info;
 
-- 
2.17.1

