Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211F169B7B7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 03:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBRCTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 21:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBRCTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 21:19:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1759F4AFDF;
        Fri, 17 Feb 2023 18:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676686744; x=1708222744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eOxsSCkly6OfS9ejgcE60ZcxhTGEoXdmme+lQaoewg0=;
  b=U6RxYLnZVPVc+BHMOQ4DLrfMEyj+1VGeQbJ0t8w1muLxU2HzjSXRbFxG
   AB8fWv7KWeNE2yJ1YZzJq/aoN1ygyXg/h8rGdCdQPaP8MlIXQ2vN+nZZC
   5eV+l5UCaC+jx/IvaX01N8Sld9ReTQHqVtnwDV46NVk+exp4h88aO0k3Y
   376lycN2PyNDkrpkS4eLpb6azh090aHp6j63v6VSUiZDsc6LP1AzKUZqK
   wY6g/kAP15Er6vj56yQGE/SQ9enZVZgYjfYNyGCSpdC2qJ5Q+2HR3ZVjo
   0Uh4e2JslsUqeE71wImgyHAq5dAaIRWmN0cy0uOKG+uir1JRjB32M0MZp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="320244217"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="320244217"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 18:19:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="672787892"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="672787892"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.133.15])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 18:19:02 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/6] cxl/region: Provide region info to the cxl_poison trace event
Date:   Fri, 17 Feb 2023 18:18:52 -0800
Message-Id: <62d24b380514c8c39b651aca79c81a424f0b5b37.1676685180.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1676685180.git.alison.schofield@intel.com>
References: <cover.1676685180.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/cxl/core/core.h   |  5 +++
 drivers/cxl/core/memdev.c | 14 +++++-
 drivers/cxl/core/region.c | 89 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

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
index ea996057815e..c11b7bc253b4 100644
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
index f29028148806..a055f8e36ef1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2213,6 +2213,95 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
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
+		rc = cxl_mem_get_poison(cxlmd, 0, cxled->skip, NULL);
+		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
+			rc = 0;
+		if (rc)
+			goto out;
+	}
+	length = cxled->dpa_res->end - cxled->dpa_res->start + 1;
+	rc = cxl_mem_get_poison(cxlmd, cxled->dpa_res->start, length,
+				cxled->cxld.region);
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

