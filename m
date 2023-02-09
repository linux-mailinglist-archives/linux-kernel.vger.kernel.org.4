Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3938691488
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBIXfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjBIXfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:35:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F8E6D8DE;
        Thu,  9 Feb 2023 15:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675985695; x=1707521695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cv6WybSbF9U1JSwkfFCNpheiIUUtR7LMTKLupRFUKQ8=;
  b=UxcwgfrZhniLHUgbJOfe6cMWhVd1y0yZnNl1yswMFdIg3YgMe/h30PLw
   1rpIJcBd8ai2+nvwCCVkLQGj4LONfDYGus+QES/R46WKw6lMbPi9Mumst
   TGcO2doeqOeyqKNQjFVFLM7Kt1zCOPuzHWUUNrfGb8nDDDFHT0Ei8Edjx
   WaCwVRG+6Wou1v7drRSGKp8jgtCds2nLKjV9HLSOcjPHpOfVYrOoZvtuJ
   pwjL8OfeKc0Mq9zUI4YHVYgpLRMcZHzuzxsFP/i/BBjrMar5bv5XVPRNA
   jb7YYUcy/Eza31WTP4+zNH4qiKU35GdJBckhhpyxe3jUBP5LdSxG2bNGJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416508730"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="416508730"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756592045"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="756592045"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.13.232])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:08 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/6] cxl/region: Provide region info to the cxl_poison trace event
Date:   Thu,  9 Feb 2023 15:32:57 -0800
Message-Id: <7862ef793a3b4fce49b0c8074b014b53b389ce12.1675983077.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1675983077.git.alison.schofield@intel.com>
References: <cover.1675983077.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
maps the memdev where poison is being read. The default method remains:
read the poison by memdev resource.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/core.h   |  5 +++
 drivers/cxl/core/memdev.c | 14 ++++++-
 drivers/cxl/core/region.c | 82 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 8c04672dca56..2f9bd8651eb1 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -22,7 +22,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 #define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
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
index 19b833c9cf35..8696d7b508b6 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -139,14 +139,26 @@ static ssize_t trigger_poison_list_store(struct device *dev,
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
+	if (port->commit_end == -1)
+		/* No regions mapped to this memdev */
+		rc = cxl_get_poison_by_memdev(cxlmd);
+	else
+		/* Regions mapped, collect poison by endpoint */
+		rc = device_for_each_child(&port->dev, port,
+					   cxl_get_poison_by_endpoint);
+
 	up_read(&cxl_dpa_rwsem);
 
 	return rc ? rc : len;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 67e83d961670..0ac08e9106af 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1826,6 +1826,88 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
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
+	 * Get the poison by decoder for mapped resources. This
+	 * separates pmem and ram poison list reads, as the spec
+	 * requires, and provides the region for the trace event.
+	 */
+	cxlmd = cxled_to_memdev(cxled);
+	length = cxled->dpa_res->end - cxled->dpa_res->start + 1;
+	rc = cxl_mem_get_poison(cxlmd, cxled->dpa_res->start, length,
+				cxled->cxld.region);
+	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
+		rc = 0;
+	if (rc)
+		goto out;
+
+	/* Get poison in a skip range */
+	if (cxled->skip) {
+		rc = cxl_mem_get_poison(cxlmd, 0, cxled->skip, NULL);
+		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
+			rc = 0;
+		if (rc)
+			goto out;
+	}
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
+		length = resource_size(&cxlds->pmem_res) - offset;
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

