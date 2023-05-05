Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB2B6F8B19
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjEEVe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjEEVet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:34:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C05E42;
        Fri,  5 May 2023 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683322487; x=1714858487;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ygVybuXnWs/ny/MJljRlz4zC2fpHSEB8MFl5p8kH0BU=;
  b=VAYXOlQFHXIol5glezVdk68xfoxEl2s/Co8JYZnr9AZiHnPfyuiMhx7P
   9DBAYScszLjB2epWCjSm3kT+pZ+JBFlQCdMVFv7sv1XxeBOxyGuVhVsqt
   VN8I6YCIXQMPVRkIcg4p9bJuguAR6vq/7dyZW8SmFUygTe0yAKKx7HnzP
   LQ88MMFlmZSEKT8RsL91w/c6mB4CO0B22+7DDSwqjLPBa8Vmif0V2Pv/j
   Kl64yMutPnaMioortCT2ANnC+qeDow4EKglmBIZW00SrX/MO6kA62965/
   pcmLC1ACtbRQGRhclbcHW93FJtHIDhlX5aCMRuZV6+6CSlY5PzHnfOV8N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="329656185"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="329656185"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 14:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="767275699"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="767275699"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 14:34:47 -0700
Subject: [PATCH] base/node / acpi: Change 'node_hmem_attrs' to
 'access_coordinates'
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Date:   Fri, 05 May 2023 14:34:46 -0700
Message-ID: <168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams suggested changing the struct 'node_hmem_attrs' to
'access_coordinates' [1]. The struct is a container of r/w-latency and
r/w-bandwidth numbers. Moving forward, this container will also be used by
CXL to store the performance characteristics of each link hop in
the PCIE/CXL topology. So, where node_hmem_attrs is just the access
parameters of a memory-node, access_coordinates applies more broadly
to hardware topology characteristics.

[1]: http://lore.kernel.org/r/64471313421f7_1b66294d5@dwillia2-xfh.jf.intel.com.notmuch/

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |   20 ++++++++++----------
 drivers/base/node.c      |   12 ++++++------
 include/linux/node.h     |    8 ++++----
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index bba268ecd802..f9ff992038fa 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -62,7 +62,7 @@ struct memory_target {
 	unsigned int memory_pxm;
 	unsigned int processor_pxm;
 	struct resource memregions;
-	struct node_hmem_attrs hmem_attrs[2];
+	struct access_coordinate coord[2];
 	struct list_head caches;
 	struct node_cache_attrs cache_attrs;
 	bool registered;
@@ -227,24 +227,24 @@ static void hmat_update_target_access(struct memory_target *target,
 {
 	switch (type) {
 	case ACPI_HMAT_ACCESS_LATENCY:
-		target->hmem_attrs[access].read_latency = value;
-		target->hmem_attrs[access].write_latency = value;
+		target->coord[access].read_latency = value;
+		target->coord[access].write_latency = value;
 		break;
 	case ACPI_HMAT_READ_LATENCY:
-		target->hmem_attrs[access].read_latency = value;
+		target->coord[access].read_latency = value;
 		break;
 	case ACPI_HMAT_WRITE_LATENCY:
-		target->hmem_attrs[access].write_latency = value;
+		target->coord[access].write_latency = value;
 		break;
 	case ACPI_HMAT_ACCESS_BANDWIDTH:
-		target->hmem_attrs[access].read_bandwidth = value;
-		target->hmem_attrs[access].write_bandwidth = value;
+		target->coord[access].read_bandwidth = value;
+		target->coord[access].write_bandwidth = value;
 		break;
 	case ACPI_HMAT_READ_BANDWIDTH:
-		target->hmem_attrs[access].read_bandwidth = value;
+		target->coord[access].read_bandwidth = value;
 		break;
 	case ACPI_HMAT_WRITE_BANDWIDTH:
-		target->hmem_attrs[access].write_bandwidth = value;
+		target->coord[access].write_bandwidth = value;
 		break;
 	default:
 		break;
@@ -701,7 +701,7 @@ static void hmat_register_target_cache(struct memory_target *target)
 static void hmat_register_target_perf(struct memory_target *target, int access)
 {
 	unsigned mem_nid = pxm_to_node(target->memory_pxm);
-	node_set_perf_attrs(mem_nid, &target->hmem_attrs[access], access);
+	node_set_perf_attrs(mem_nid, &target->coord[access], access);
 }
 
 static void hmat_register_target_devices(struct memory_target *target)
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 2cada01c70da..fc0444b617d0 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -75,14 +75,14 @@ static BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
  * @dev:	Device for this memory access class
  * @list_node:	List element in the node's access list
  * @access:	The access class rank
- * @hmem_attrs: Heterogeneous memory performance attributes
+ * @coord:	Heterogeneous memory performance coordinates
  */
 struct node_access_nodes {
 	struct device		dev;
 	struct list_head	list_node;
 	unsigned int		access;
 #ifdef CONFIG_HMEM_REPORTING
-	struct node_hmem_attrs	hmem_attrs;
+	struct access_coordinate	coord;
 #endif
 };
 #define to_access_nodes(dev) container_of(dev, struct node_access_nodes, dev)
@@ -168,7 +168,7 @@ static ssize_t property##_show(struct device *dev,			\
 			   char *buf)					\
 {									\
 	return sysfs_emit(buf, "%u\n",					\
-			  to_access_nodes(dev)->hmem_attrs.property);	\
+			  to_access_nodes(dev)->coord.property);	\
 }									\
 static DEVICE_ATTR_RO(property)
 
@@ -188,10 +188,10 @@ static struct attribute *access_attrs[] = {
 /**
  * node_set_perf_attrs - Set the performance values for given access class
  * @nid: Node identifier to be set
- * @hmem_attrs: Heterogeneous memory performance attributes
+ * @coord: Heterogeneous memory performance coordinates
  * @access: The access class the for the given attributes
  */
-void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
+void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 			 unsigned int access)
 {
 	struct node_access_nodes *c;
@@ -206,7 +206,7 @@ void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
 	if (!c)
 		return;
 
-	c->hmem_attrs = *hmem_attrs;
+	c->coord = *coord;
 	for (i = 0; access_attrs[i] != NULL; i++) {
 		if (sysfs_add_file_to_group(&c->dev.kobj, access_attrs[i],
 					    "initiators")) {
diff --git a/include/linux/node.h b/include/linux/node.h
index 427a5975cf40..25b66d705ee2 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -20,14 +20,14 @@
 #include <linux/list.h>
 
 /**
- * struct node_hmem_attrs - heterogeneous memory performance attributes
+ * struct access_coordinate - generic performance coordinates container
  *
  * @read_bandwidth:	Read bandwidth in MB/s
  * @write_bandwidth:	Write bandwidth in MB/s
  * @read_latency:	Read latency in nanoseconds
  * @write_latency:	Write latency in nanoseconds
  */
-struct node_hmem_attrs {
+struct access_coordinate {
 	unsigned int read_bandwidth;
 	unsigned int write_bandwidth;
 	unsigned int read_latency;
@@ -65,7 +65,7 @@ struct node_cache_attrs {
 
 #ifdef CONFIG_HMEM_REPORTING
 void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs);
-void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
+void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 			 unsigned access);
 #else
 static inline void node_add_cache(unsigned int nid,
@@ -74,7 +74,7 @@ static inline void node_add_cache(unsigned int nid,
 }
 
 static inline void node_set_perf_attrs(unsigned int nid,
-				       struct node_hmem_attrs *hmem_attrs,
+				       struct access_coordinate *coord,
 				       unsigned access)
 {
 }


