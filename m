Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA3863E67E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLAA1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiLAA1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:27:34 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431B310E;
        Wed, 30 Nov 2022 16:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669854453; x=1701390453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QN0FHISioResjhVj/Pv6zoPf18aJjWgu/WCgU6BoeF8=;
  b=VuK1lyfd5Oyi95mckUYMTyXVe0S1B13uOib6ISqUtlYlMfF0hlKa3Ptt
   zTXFYyJ78rhdWPry35qHicC+iual+biCa570CHXkB1wPUl+9IiuBeGEdj
   7c7nvJMx2AyLWWC+bPBVz2iDObQ58wo8dYDMPrai4qlzDLNeh3dii4uUm
   UKFpG5YhoSaFkv5hX/NtrlEDbapWPn2SP5NFHGTm0zLQBKHbzp2aDw7cK
   rFTTnztGW4y9Ed3CDAxFKIDQkfnHbiSi9XK+HP4+F47eFEgSCL7fVZWim
   p8odTSIggQkJXTifb/zSFr9IagdcTeamcibIukEmu/UA+1ZMdNUgdHsMm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="317400853"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="317400853"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622085225"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="622085225"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.251.1.240])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:29 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V2 04/11] cxl/mem: Clear events on driver load
Date:   Wed, 30 Nov 2022 16:27:12 -0800
Message-Id: <20221201002719.2596558-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221201002719.2596558-1-ira.weiny@intel.com>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
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

From: Ira Weiny <ira.weiny@intel.com>

The information contained in the events prior to the driver loading can
be queried at any time through other mailbox commands.

Ensure a clean slate of events by reading and clearing the events.  The
events are sent to the trace buffer but it is not anticipated to have
anyone listening to it at driver load time.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c            | 2 ++
 tools/testing/cxl/test/mem.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8f86f85d89c7..11e95a95195a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -521,6 +521,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	cxl_mem_get_event_records(cxlds);
+
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index aa2df3a15051..e2f5445d24ff 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -285,6 +285,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	cxl_mem_get_event_records(cxlds);
+
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(dev, cxlmd);
 
-- 
2.37.2

