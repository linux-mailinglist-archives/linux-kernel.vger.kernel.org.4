Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778636BD1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjCPOKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCPOKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A420128865
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678975770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tS52zKBxg1UC4SRr3mUX7J3cjhaqnRbdGJlfsu7ZFVk=;
        b=KVKOz29yaWYMiOmMusXXWNte7W78zKsmEtk6pA+tbMFUYM8v4oMelCvWL/ECw0qd8Iw28b
        rIUFJNx4Xm7Y1coR+qnT9ZxpBVGfSMsl6tqfDf+4DbUD94UldVMcK/F6UAL746lItlFGvU
        j4gNhxkdtw6O+8h5+KCNbOZXt7+wMw8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-f60fcco_OVaKhz9Y4YZ7Dg-1; Thu, 16 Mar 2023 10:09:25 -0400
X-MC-Unique: f60fcco_OVaKhz9Y4YZ7Dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FA0D10146ED;
        Thu, 16 Mar 2023 14:09:24 +0000 (UTC)
Received: from desnesn.remote.csb (ovpn-116-3.gru2.redhat.com [10.97.116.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE55040C6E67;
        Thu, 16 Mar 2023 14:09:21 +0000 (UTC)
From:   Desnes Nunes <desnesn@redhat.com>
To:     iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, linux-kernel@vger.kernel.org
Cc:     hch@lst.de, martin.petersen@oracle.com, don.brace@microchip.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, jejb@linux.ibm.com,
        jsnitsel@redhat.com, Desnes Nunes <desnesn@redhat.com>
Subject: [PATCH v2 1/3] dma-debug: small dma_debug_entry's comment and variable name updates
Date:   Thu, 16 Mar 2023 11:09:10 -0300
Message-Id: <20230316140912.1038404-2-desnesn@redhat.com>
In-Reply-To: <20230316140912.1038404-1-desnesn@redhat.com>
References: <20230316140912.1038404-1-desnesn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small update on dma_debug_entry's struct commentary and also standardize
the usage of 'dma_addr' variable name from debug_dma_map_page() on
debug_dma_unmap_page(), and similarly on debug_dma_free_coherent()

Signed-off-by: Desnes Nunes <desnesn@redhat.com>
---
V1 -> V2: Updated comment properly

 kernel/dma/debug.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 18c93c2276ca..9aa5100d0d7e 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -53,6 +53,7 @@ enum map_err_types {
  * struct dma_debug_entry - track a dma_map* or dma_alloc_coherent mapping
  * @list: node on pre-allocated free_entries list
  * @dev: 'dev' argument to dma_map_{page|single|sg} or dma_alloc_coherent
+ * @dev_addr: dma address
  * @size: length of the mapping
  * @type: single, page, sg, coherent
  * @direction: enum dma_data_direction
@@ -1262,13 +1263,13 @@ void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 }
 EXPORT_SYMBOL(debug_dma_mapping_error);
 
-void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
+void debug_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 			  size_t size, int direction)
 {
 	struct dma_debug_entry ref = {
 		.type           = dma_debug_single,
 		.dev            = dev,
-		.dev_addr       = addr,
+		.dev_addr       = dma_addr,
 		.size           = size,
 		.direction      = direction,
 	};
@@ -1403,13 +1404,13 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 void debug_dma_free_coherent(struct device *dev, size_t size,
-			 void *virt, dma_addr_t addr)
+			 void *virt, dma_addr_t dma_addr)
 {
 	struct dma_debug_entry ref = {
 		.type           = dma_debug_coherent,
 		.dev            = dev,
 		.offset		= offset_in_page(virt),
-		.dev_addr       = addr,
+		.dev_addr       = dma_addr,
 		.size           = size,
 		.direction      = DMA_BIDIRECTIONAL,
 	};
-- 
2.39.1

