Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B1E72D470
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbjFLWct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjFLWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:32:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B69184;
        Mon, 12 Jun 2023 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686609164; x=1718145164;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2WO9NMOZ/PRhy9r+fAXNEYD2XSKH8nP/w1qhX5tdp9w=;
  b=jCJbP9mbPMsUSq65rjDxGvmf9ATWnCwt+EMRNJGoqvAhDpjvbuK2+FjU
   Tl9UFcmzymxUJhKQzrlqyMa9KflQsNc4hImTJuBEVsbxqpRfQtbM9JwAL
   CBrzba7t9RlO3gfh5A98kXWak1PfAELs3XUp0FBsBOu/CidNU0dtgLUVg
   vzNQMjvDakVsOTI04w/B41uYUqb35ZwuzmWFjYF9ZWKm5YCRm2D7FBnBz
   uyRxvT0okOcqka4wPjtR1OyzxXz0LzkGwFG3fyL4MxRGemjyJfOXRFY6t
   zMrxVqdoMORCQK8fBK8G+eKgzx1q+AaAvMOT6Y5DUbYAAffilxxJk1vSY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421767445"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="421767445"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 15:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="958190731"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="958190731"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.120.159])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 15:32:42 -0700
Subject: [PATCH v2] base/node / acpi: Change 'node_hmem_attrs' to
 'access_coordinates'
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        dan.j.williams@intel.com, jonathan.cameron@huawei.com
Date:   Mon, 12 Jun 2023 15:32:42 -0700
Message-ID: <168660916231.1965241.248859226126456131.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
to hardware topology characteristics. The observation is that seemed like
an excercise in having the application identify "where" it falls on a
spectrum of bandwidth and latency needs. For the tuple of read/write-latency
and read/write-bandwidth, "coordinates" is not a perfect fit. Sometimes it
is just conveying values in isolation and not a "location" relative to
other performance points, but in the end this data is used to identify the
performance operation point of a given memory-node. [2]

Link: http://lore.kernel.org/r/64471313421f7_1b66294d5@dwillia2-xfh.jf.intel.com.notmuch/
Link: https://lore.kernel.org/linux-cxl/645e6215ee0de_1e6f2945e@dwillia2-xfh.jf.intel.com.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---

Hi Greg and Rafael,
please consider ACK this patch and Dan can take it through the
CXL upstream tree. The remaining ACPI [1] and CXL [2] patches for enabling
CXL QoS class data have dependency on this patch. Thank you!

[1]: https://lore.kernel.org/linux-cxl/168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3/T/#t
[2]: https://lore.kernel.org/linux-cxl/168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3/T/#t

v2:
- Add additional descriptions from Dan on reasoning behind using
  access_coordinate. (Jonathan)
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


