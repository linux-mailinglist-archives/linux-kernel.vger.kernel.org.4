Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4DB6BD1D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCPOKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjCPOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896EA39CD2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678975772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCtPtzpuFMR8qAF/d/etYJgL7eXxb5y6E1pj/qDFqRA=;
        b=fr/sxjR8g9krcztrY1GBHPiz7wscYkx+JaJOQ4V8ITGKpFcMKxlthRdKCFir/wyLm+NsTy
        FxjsQHH+fEcn1vIFM60LRk593BU49TzadOHf5fohqqzcplOR0/Oi3SAevdzvx5uoYxD17L
        UV6tVtqgGS8UlOLY91qIwRBmDhlHzdE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-qAMHYbxdOieUAFWWDX3POg-1; Thu, 16 Mar 2023 10:09:27 -0400
X-MC-Unique: qAMHYbxdOieUAFWWDX3POg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E5CE3814590;
        Thu, 16 Mar 2023 14:09:27 +0000 (UTC)
Received: from desnesn.remote.csb (ovpn-116-3.gru2.redhat.com [10.97.116.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C188F40C6E67;
        Thu, 16 Mar 2023 14:09:24 +0000 (UTC)
From:   Desnes Nunes <desnesn@redhat.com>
To:     iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, linux-kernel@vger.kernel.org
Cc:     hch@lst.de, martin.petersen@oracle.com, don.brace@microchip.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, jejb@linux.ibm.com,
        jsnitsel@redhat.com, Desnes Nunes <desnesn@redhat.com>
Subject: [PATCH v2 2/3] dma-debug: add cacheline to user/kernel space dump messages
Date:   Thu, 16 Mar 2023 11:09:11 -0300
Message-Id: <20230316140912.1038404-3-desnesn@redhat.com>
In-Reply-To: <20230316140912.1038404-1-desnesn@redhat.com>
References: <20230316140912.1038404-1-desnesn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the cacheline also printed on the debug_dma_dump_mappings() and
dump_show() is useful for debugging. Furthermore, this also standardizes
the messages shown on both dump functions.

Signed-off-by: Desnes Nunes <desnesn@redhat.com>
---
 kernel/dma/debug.c | 122 ++++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 58 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index e0ad8db1ec25..19cc59829ffd 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -396,37 +396,6 @@ static unsigned long long phys_addr(struct dma_debug_entry *entry)
 	return page_to_phys(pfn_to_page(entry->pfn)) + entry->offset;
 }
 
-/*
- * Dump mapping entries for debugging purposes
- */
-void debug_dma_dump_mappings(struct device *dev)
-{
-	int idx;
-
-	for (idx = 0; idx < HASH_SIZE; idx++) {
-		struct hash_bucket *bucket = &dma_entry_hash[idx];
-		struct dma_debug_entry *entry;
-		unsigned long flags;
-
-		spin_lock_irqsave(&bucket->lock, flags);
-
-		list_for_each_entry(entry, &bucket->list, list) {
-			if (!dev || dev == entry->dev) {
-				dev_info(entry->dev,
-					 "%s idx %d P=%Lx N=%lx D=%Lx L=%Lx %s %s\n",
-					 type2name[entry->type], idx,
-					 phys_addr(entry), entry->pfn,
-					 entry->dev_addr, entry->size,
-					 dir2name[entry->direction],
-					 maperr2str[entry->map_err_type]);
-			}
-		}
-
-		spin_unlock_irqrestore(&bucket->lock, flags);
-		cond_resched();
-	}
-}
-
 /*
  * For each mapping (initial cacheline in the case of
  * dma_alloc_coherent/dma_map_page, initial cacheline in each page of a
@@ -547,6 +516,70 @@ static void active_cacheline_remove(struct dma_debug_entry *entry)
 	spin_unlock_irqrestore(&radix_lock, flags);
 }
 
+/*
+ * Dump mappings entries on kernel space for debugging purposes
+ */
+void debug_dma_dump_mappings(struct device *dev)
+{
+	int idx;
+	phys_addr_t cln;
+
+	for (idx = 0; idx < HASH_SIZE; idx++) {
+		struct hash_bucket *bucket = &dma_entry_hash[idx];
+		struct dma_debug_entry *entry;
+		unsigned long flags;
+
+		spin_lock_irqsave(&bucket->lock, flags);
+		list_for_each_entry(entry, &bucket->list, list) {
+			if (!dev || dev == entry->dev) {
+				cln = to_cacheline_number(entry);
+				dev_info(entry->dev,
+					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
+					 type2name[entry->type], idx,
+					 phys_addr(entry), entry->pfn,
+					 entry->dev_addr, entry->size,
+					 cln, dir2name[entry->direction],
+					 maperr2str[entry->map_err_type]);
+			}
+		}
+		spin_unlock_irqrestore(&bucket->lock, flags);
+
+		cond_resched();
+	}
+}
+
+/*
+ * Dump mappings entries on user space via debugfs
+ */
+static int dump_show(struct seq_file *seq, void *v)
+{
+	int idx;
+	phys_addr_t cln;
+
+	for (idx = 0; idx < HASH_SIZE; idx++) {
+		struct hash_bucket *bucket = &dma_entry_hash[idx];
+		struct dma_debug_entry *entry;
+		unsigned long flags;
+
+		spin_lock_irqsave(&bucket->lock, flags);
+		list_for_each_entry(entry, &bucket->list, list) {
+			cln = to_cacheline_number(entry);
+			seq_printf(seq,
+				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
+				   dev_driver_string(entry->dev),
+				   dev_name(entry->dev),
+				   type2name[entry->type], idx,
+				   phys_addr(entry), entry->pfn,
+				   entry->dev_addr, entry->size,
+				   cln, dir2name[entry->direction],
+				   maperr2str[entry->map_err_type]);
+		}
+		spin_unlock_irqrestore(&bucket->lock, flags);
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(dump);
+
 /*
  * Wrapper function for adding an entry to the hash.
  * This function takes care of locking itself.
@@ -765,33 +798,6 @@ static const struct file_operations filter_fops = {
 	.llseek = default_llseek,
 };
 
-static int dump_show(struct seq_file *seq, void *v)
-{
-	int idx;
-
-	for (idx = 0; idx < HASH_SIZE; idx++) {
-		struct hash_bucket *bucket = &dma_entry_hash[idx];
-		struct dma_debug_entry *entry;
-		unsigned long flags;
-
-		spin_lock_irqsave(&bucket->lock, flags);
-		list_for_each_entry(entry, &bucket->list, list) {
-			seq_printf(seq,
-				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx %s %s\n",
-				   dev_name(entry->dev),
-				   dev_driver_string(entry->dev),
-				   type2name[entry->type], idx,
-				   phys_addr(entry), entry->pfn,
-				   entry->dev_addr, entry->size,
-				   dir2name[entry->direction],
-				   maperr2str[entry->map_err_type]);
-		}
-		spin_unlock_irqrestore(&bucket->lock, flags);
-	}
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(dump);
-
 static int __init dma_debug_fs_init(void)
 {
 	struct dentry *dentry = debugfs_create_dir("dma-api", NULL);
-- 
2.39.1

