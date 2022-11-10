Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979AF624A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiKJTGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiKJTFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:05:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5B245EF5;
        Thu, 10 Nov 2022 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668107116; x=1699643116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JX6SVwcJaEAfjGLJHiyrrsbi4lffntQ1KMrxCo39Jzw=;
  b=cbYK3Jag9kjfqOHHscalysx0gmDcxcEL18OZAGrYXc0XpJ5ciCtNVhYz
   /xzxAFa2tjy9rOMZmi5D3jPAka/OHXkrSgWR3KQyQkgSB5Dh6ZjQ5tM8y
   6Lt5EzrhSy6H63qA6M9TfZsLjtJ4cNBEBYTumKj1Kbi3wzM35m+hjHW2S
   955bHs2+MPH2kAtIOdY3vximJD+pn/hMGoKhXuRc+EadAT0LZn2al9wq8
   55d2Ot98jgWSl2AhpuajuDacCvjZ5SLqN1fexy7+CuQOhddyx+VRJqaNR
   XBCJje+AMWaQUhVFILgGDpfe3s+TU1vNBGxr3J+i9Gyp6CWkSyrtwbYnS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375662085"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375662085"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882473419"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="882473419"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.6.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:07 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH 04/11] cxl/mem: Clear events on driver load
Date:   Thu, 10 Nov 2022 10:57:51 -0800
Message-Id: <20221110185758.879472-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221110185758.879472-1-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
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
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c            | 2 ++
 tools/testing/cxl/test/mem.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 62e560063e50..e0d511575b45 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -530,6 +530,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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

