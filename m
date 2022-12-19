Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D37F651388
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiLST4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiLST4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:56:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21062DEE7;
        Mon, 19 Dec 2022 11:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=klZAlP1kOUp7wpdZeL5YEyJd1NOcY1vneGW37Msxzjw=; b=zEEU2qspZ4u/6ELaYbnpp78VmU
        GLEoJRvumw95axpcRtNDMP/P+JPKcvMQZ1gycML+Hjhd+SH5I7pv1c/brFef8Ava5AUAq2d4j9Vic
        G+f+Kthek418tixMVMw67hbN0yLX1+m7RFNzuOZBTDOq/uf6/y78uQ4T+pNlm8TH1HQv6L+94Mh72
        iC2J0WvTJqmpiSv9GM3oHlLl/IC92+ZPj5rR/ATydJ/yOq3aM0nFYuYUxC2caNQ+n1aQGagHK84G8
        kO0PWwOApi0omv+yHFytr2/yAMeEK7o2T4PAl++2WkBEJ/Mn5CkG/Je1NZ9ix7twkuPCZzh4F745E
        6CRIjONg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7MFJ-001TSF-BY; Mon, 19 Dec 2022 19:56:25 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     dave@stgolabs.net, a.manzanares@samsung.com, mcgrof@kernel.org,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl_test: remove nvdimm requirement
Date:   Mon, 19 Dec 2022 11:56:20 -0800
Message-Id: <20221219195620.351544-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for NVDIMM to test CXL, so remove this
requirement.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/cxl/config_check.c | 2 --
 tools/testing/cxl/test/mock.c    | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/config_check.c b/tools/testing/cxl/config_check.c
index 99b56b5f6edf..cef5f1159ba7 100644
--- a/tools/testing/cxl/config_check.c
+++ b/tools/testing/cxl/config_check.c
@@ -10,7 +10,5 @@ void check(void)
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_64BIT));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_BUS));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_ACPI));
-	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_PMEM));
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST));
-	BUILD_BUG_ON(!IS_ENABLED(CONFIG_NVDIMM_SECURITY_TEST));
 }
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 5dface08e0de..7c71826f1aac 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -116,6 +116,7 @@ struct acpi_pci_root *__wrap_acpi_pci_find_root(acpi_handle handle)
 }
 EXPORT_SYMBOL_GPL(__wrap_acpi_pci_find_root);
 
+#ifdef CONFIG_CXL_PMEM
 struct nvdimm_bus *
 __wrap_nvdimm_bus_register(struct device *dev,
 			   struct nvdimm_bus_descriptor *nd_desc)
@@ -130,6 +131,7 @@ __wrap_nvdimm_bus_register(struct device *dev,
 	return nvdimm_bus_register(dev, nd_desc);
 }
 EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
+#endif
 
 struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port)
 {
-- 
2.35.1

