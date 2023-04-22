Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2066EB6F5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 05:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjDVDJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 23:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjDVDJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 23:09:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1EF212D;
        Fri, 21 Apr 2023 20:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682132975; x=1713668975;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mIYimCHUd+xZlhl4PkrV2HFz2iF0o6KFaAlHPr3UxyY=;
  b=OZVE1nyxM0K+U0DzG5cHD/NMsOjOrk3floQBsdanzwwGjfeXLloQpjJA
   iLC2tS/0xEW07vGsUur5ed/9ucj0cK6jMwxhbNS/nQxMuLNPEqiYZTn5E
   nlnBJpB8LutRNXKOrgeZ6XAffdaNY1SihKChGOzkwMMq1OhhPD1h5vtzJ
   2uTS1jqC1uyg9nLoOYljBdHMTZzN0XroCqTyM6u7rReH4oYeTYI2CN0yB
   RS4OtDX062+oCJSQ+9TrbDRxR1VIseCdG7Qqq6nt3g+A3nbPU1DBY/nrR
   sfqbovld0GytlAo0/t9qx0Hl4ij6s9epbm1sapFzZBe7xFr18W3/xA73k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="343609056"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="343609056"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="757092264"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="757092264"
Received: from jwostman-mobl2.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.111.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:09:33 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Fri, 21 Apr 2023 21:09:25 -0600
Subject: [PATCH 1/4] cxl/pci: Allocate irq vectors earlier in pci probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-vv-fw_update-v1-1-22468747d72f@intel.com>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
In-Reply-To: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=0+Mnvz+/aDR8bX8YzKcpUzlkn/9vo8RpJOTXggnm6b4=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCnO/m89Vnn+2dY3f+Pn+n+HQmo37HjDMkM/iGnOY4fcx
 oeec7pPdJSyMIhxMciKKbL83fOR8Zjc9nyewARHmDmsTCBDGLg4BWAipdoM/+OiTjxlv/RjfdmV
 y/Hf3rGGLMn/tmRJeF1t49/SbNHMYycZGc7r/VO7csjp8tPM6U+dPqjkhyUy8DLceP1t9+VDaZ6
 dj1gA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

Move the cxl_alloc_irq_vectors() call further up in the probing
in order to allow for mailbox interrupt usage. No change in
semantics.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20230421092321.12741-2-dave@stgolabs.net
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/cxl/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 60b23624d167..39b829a29f6c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -757,6 +757,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	rc = cxl_alloc_irq_vectors(pdev);
+	if (rc)
+		return rc;
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
@@ -777,10 +781,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_alloc_irq_vectors(pdev);
-	if (rc)
-		return rc;
-
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);

-- 
2.40.0

