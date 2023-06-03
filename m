Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40496720D25
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 04:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbjFCCJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 22:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbjFCCJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:09:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657BE4D;
        Fri,  2 Jun 2023 19:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685758173; x=1717294173;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cuZ67ek2FPqXnrXVq3JWOFTKzohvfRqyJT4xFD/V2X8=;
  b=MuNXJEWaWSV8P5vCtckTBHJ+RBXmXGYaZ04kGI9d+rvTJW1ldxgN7pLZ
   atV/An42IQvDA3r4jESEory3Hg76kVRoJpjy1zyrT7ykFW+Se7LTJdh6R
   dztzbuCWpIZfAY4gTUReu3NaaSetRLU2uVMZPwSjCyg1HZxkD52Nls1YB
   0NACcnMBAuMXsBXWYqR7bDE3qP2FJKVVdQGuxuoqSuonnVdRgMM6KJ/NC
   +/hgMjz5y6R7IvEyHEHNY8l/FXgbhiq5x1+edsfws+2htu1LjV4qqbTJE
   FbzeBJMYWF/NQrneyvZYjzeyw8ECV49puJHMRtoMppk+qshcAetP4Q7Vo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="340649443"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="340649443"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852354415"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="852354415"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.97.230])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:09:31 -0700
From:   ira.weiny@intel.com
Date:   Fri, 02 Jun 2023 19:09:22 -0700
Subject: [PATCH RFC 2/4] dax/hmem: Fix refcount leak in dax_hmem_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-dax-region-put-v1-2-d8668f335d45@intel.com>
References: <20230602-dax-region-put-v1-0-d8668f335d45@intel.com>
In-Reply-To: <20230602-dax-region-put-v1-0-d8668f335d45@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Yongqiang Liu <liuyongqiang13@huawei.com>,
        Paul Cassella <cassella@hpe.com>, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685758165; l=1143;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=DCqwnNEGFbx08b+rkmwCRZ6p+PTcrb6DH1GrUdGBQJw=;
 b=73GEgZX9DU492Absc9d47SZD0IZXPG6TVtym9JbpPpRp8e8AKDyh40CCLSstWwAR9weXLPqDe
 K4ncPMKuN7SChr2G5H3jltokrfSfIaJsppaVjuzBFdzMU06Pf7YkWTb
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Liu <liuyongqiang13@huawei.com>

We should always call dax_region_put() whenever devm_create_dev_dax()
succeed or fail to avoid refcount leak of dax_region. Move the return
value check after dax_region_put().

Cc: nvdimm@lists.linux.dev
Fixes: c01044cc8191 ("ACPI: HMAT: refactor hmat_register_target_device to hmem_register_device")
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
 drivers/dax/hmem/hmem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index e5fe8b39fb94..b4831a3d3934 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -39,12 +39,10 @@ static int dax_hmem_probe(struct platform_device *pdev)
 		.size = region_idle ? 0 : range_len(&mri->range),
 	};
 	dev_dax = devm_create_dev_dax(&data);
-	if (IS_ERR(dev_dax))
-		return PTR_ERR(dev_dax);
 
 	/* child dev_dax instances now own the lifetime of the dax_region */
 	dax_region_put(dax_region);
-	return 0;
+	return IS_ERR(dev_dax) ? PTR_ERR(dev_dax) : 0;
 }
 
 static struct platform_driver dax_hmem_driver = {

-- 
2.40.0

