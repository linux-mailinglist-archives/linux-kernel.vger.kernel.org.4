Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF696ACF39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCFUbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCFUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:31:50 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9085646082
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:31:48 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 326GphOg077387;
        Mon, 6 Mar 2023 10:51:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678121503;
        bh=ph7tv8RlCVDGBwJJVB5s/5P21YkzOhXtmfn1KwSVtY4=;
        h=From:To:CC:Subject:Date;
        b=PkXM7HPUnWgtDX8nGWWEu8j+wuUfFSA9U4DUTZTH6Re4QiSa3Q9bkGURdASBOLNzz
         JS8QLabNBx41vcf+pgpkx56JiHw8D0P34/lTAUilNOlHlP/zdaRdgt6NbTOR4sGt3T
         5Z0jtLNWOA23JREvcXqXQMYOngqQWLgHvngILfDk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 326GphnA127700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Mar 2023 10:51:43 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 6
 Mar 2023 10:51:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 6 Mar 2023 10:51:43 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 326GphfX013025;
        Mon, 6 Mar 2023 10:51:43 -0600
From:   Andrew Davis <afd@ti.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v3] dma-buf: cma_heap: Check for device max segment size when attaching
Date:   Mon, 6 Mar 2023 10:51:43 -0600
Message-ID: <20230306165143.1671-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although there is usually not such a limitation (and when there is it is
often only because the driver forgot to change the super small default),
it is still correct here to break scatterlist element into chunks of
dma_max_mapping_size().

This might cause some issues for users with misbehaving drivers. If
bisecting has landed you on this commit, make sure your drivers both set
dma_set_max_seg_size() and are checking for contiguousness correctly.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v2:
 - Rebase v6.3-rc1

Changes from v1:
 - Fixed mixed declarations and code warning

 drivers/dma-buf/heaps/cma_heap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 1131fb943992..579261a46fa3 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -53,16 +53,18 @@ static int cma_heap_attach(struct dma_buf *dmabuf,
 {
 	struct cma_heap_buffer *buffer = dmabuf->priv;
 	struct dma_heap_attachment *a;
+	size_t max_segment;
 	int ret;
 
 	a = kzalloc(sizeof(*a), GFP_KERNEL);
 	if (!a)
 		return -ENOMEM;
 
-	ret = sg_alloc_table_from_pages(&a->table, buffer->pages,
-					buffer->pagecount, 0,
-					buffer->pagecount << PAGE_SHIFT,
-					GFP_KERNEL);
+	max_segment = dma_get_max_seg_size(attachment->dev);
+	ret = sg_alloc_table_from_pages_segment(&a->table, buffer->pages,
+						buffer->pagecount, 0,
+						buffer->pagecount << PAGE_SHIFT,
+						max_segment, GFP_KERNEL);
 	if (ret) {
 		kfree(a);
 		return ret;
-- 
2.39.2

