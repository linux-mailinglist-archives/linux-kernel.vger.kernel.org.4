Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8945A6B4F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCJRzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjCJRyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:54:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D83132A97;
        Fri, 10 Mar 2023 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678470872; x=1710006872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fp/uJlm5YOGar/bSX/0Dj2KdUIw3LVsd3f0bJZXpAWc=;
  b=U4hjYqEGbPkg5o9nqHELer3buH7FfKVPiQMowpvNbZZnJV5HfLJGcz5f
   tQGeya9I9ev4MdAHyNgBkZCItlq9PX0G19wW4JGu9vaJWKTv9+YHcySMQ
   oSNel9u98bZ4FbOKWBJmHk0ravkg9n/v9ePxxYC7uXGqGtyKQBfYuOcOi
   7GjdNlR9q3Vmr6LUUjENaVC4w87ue9GSXIF2fCITqVaPsHsJtKT8bLlso
   6acvO2ivnH//UVjyym8hjRe4EyNzcOu5ZFpZgEOfooQkkOh9kmYZkI0St
   O5CaxOSYik8jcCx0MhxueuVGRVege911nAPKyMQEmh5rDhJT3TYkE305g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="339154074"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="339154074"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:54:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="680276585"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="680276585"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.255.228.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:54:29 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/6] cxl/region: Provide region info to the cxl_poison trace event
Date:   Fri, 10 Mar 2023 09:54:18 -0800
Message-Id: <b5ba1187b04a18f49be9ebb91b699cfa8573eef2.1678468593.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1678468593.git.alison.schofield@intel.com>
References: <cover.1678468593.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

User space may need to know which region, if any, maps the poison
address(es) logged in a cxl_poison trace event. Since the mapping
of DPAs (device physical addresses) to a region can change, the
kernel must provide this information at the time the poison list
is read. The event informs user space that at event <timestamp>
this <region> mapped to this <DPA>, which is poisoned.

The cxl_poison trace event is already wired up to log the region
name and uuid if it receives param 'struct cxl_region'.

In order to provide that cxl_region, add another method for gathering
poison - by committed endpoint decoder mappings. This method is only
available with CONFIG_CXL_REGION and is only used if a region actually
maps the memdev where poison is being read. After the poison list is
read for all the mapped resources, poison is read for the unmapped
resources, and those events are logged without the region info.

Mixed mode decoders are not currently supported in Linux. Add a debug
message to the poison request path. That will serve as an alert that
poison list retrieval needs to add support for mixed mode.

The default method remains: read the poison by memdev resource.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/core.h   |  5 ++
 drivers/cxl/core/memdev.c | 17 ++++++-
 drivers/cxl/core/region.c | 96 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index cde475e13216..4f507cb85926 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -25,7 +25,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
 int cxl_region_init(void);
 void cxl_region_exit(void);
+int cxl_get_poison_by_endpoint(struct device *dev, void *data);
 #else
+static inline int cxl_get_poison_by_endpoint(struct device *dev, void *data)
+{
+	return 0;
+}
 static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 }
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index ea996057815e..5e65818d2171 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -139,14 +139,29 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 					 const char *buf, size_t len)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_port *port;
 	bool trigger;
 	int rc;
 
 	if (kstrtobool(buf, &trigger) || !trigger)
 		return -EINVAL;
 
+	port = dev_get_drvdata(&cxlmd->dev);
+	if (!port || !is_cxl_endpoint(port))
+		return -EINVAL;
+
 	down_read(&cxl_dpa_rwsem);
-	rc = cxl_get_poison_by_memdev(cxlmd);
+	if (port->commit_end == -1) {
+		/* No regions mapped to this memdev */
+		rc = cxl_get_poison_by_memdev(cxlmd);
+	} else {
+		/* Regions mapped, collect poison by endpoint */
+		rc = device_for_each_child(&port->dev, port,
+					   cxl_get_poison_by_endpoint);
+		if (rc == 1)
+			rc = 0;
+	}
+
 	up_read(&cxl_dpa_rwsem);
 
 	return rc ? rc : len;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f29028148806..1a558adfe32d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2213,6 +2213,102 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
 
+int cxl_get_poison_by_endpoint(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port = data;
+	struct cxl_dev_state *cxlds;
+	struct cxl_memdev *cxlmd;
+	u64 offset, length;
+	int rc = 0;
+
+	down_read(&cxl_dpa_rwsem);
+
+	if (!is_endpoint_decoder(dev))
+		goto out;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+		goto out;
+
+	/*
+	 * Regions are only created with single mode decoders: pmem or ram.
+	 * Linux does not currently support mixed mode decoders. This means
+	 * that reading poison per endpoint decoder adheres to the spec
+	 * requirement that poison reads of pmem and ram must be separated.
+	 * CXL 3.0 Spec 8.2.9.8.4.1
+	 *
+	 * Watch for future support of mixed with a dev_dbg() msg.
+	 */
+	if (cxled->mode == CXL_DECODER_MIXED) {
+		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
+		goto out;
+	}
+
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->skip) {
+		offset = cxled->dpa_res->start - cxled->skip;
+		length = cxled->skip;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
+			rc = 0;
+		if (rc)
+			goto out;
+	}
+
+	offset = cxled->dpa_res->start;
+	length = cxled->dpa_res->end - offset + 1;
+	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
+	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
+		rc = 0;
+	if (rc)
+		goto out;
+
+	/* Iterate until commit_end is reached */
+	if (cxled->cxld.id < port->commit_end)
+		goto out;
+
+	/*
+	 * Reach here with the last committed decoder only.
+	 * Knowing that PMEM must always follow RAM, get poison
+	 * for unmapped ranges based on the last decoder's mode:
+	 *	ram: scan remains of ram range, then scan for pmem
+	 *	pmem: scan remains of pmem range
+	 */
+	cxlds = cxlmd->cxlds;
+
+	if (cxled->mode == CXL_DECODER_RAM) {
+		offset = cxled->dpa_res->end + 1;
+		length = resource_size(&cxlds->ram_res) - offset;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (rc == -EFAULT)
+			rc = 0;
+		if (rc)
+			goto out;
+	}
+	if (cxled->mode == CXL_DECODER_PMEM) {
+		offset = cxled->dpa_res->end + 1;
+		length = resource_size(&cxlds->dpa_res) - offset;
+		if (!length) {
+			rc = 1;
+			goto out;
+		}
+	} else if (resource_size(&cxlds->pmem_res)) {
+		offset = cxlds->pmem_res.start;
+		length = resource_size(&cxlds->pmem_res);
+	} else {
+		rc = 1;
+		goto out;
+	}
+	/* Final get poison call. Return rc or 1 to stop iteration. */
+	rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+	if (!rc)
+		rc = 1;
+out:
+	up_read(&cxl_dpa_rwsem);
+	return rc;
+}
+
 static struct lock_class_key cxl_pmem_region_key;
 
 static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
-- 
2.37.3

