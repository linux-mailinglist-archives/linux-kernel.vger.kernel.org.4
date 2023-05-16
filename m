Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB5A705876
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjEPUPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjEPUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD093EF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98CD863D84
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8BEC4339B;
        Tue, 16 May 2023 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268068;
        bh=PfWI5pbJLZYncl+Uo6KbeVi/opEdg9bkbTtIghw9SQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJhVpmF7i5EW9Rx91r0FCizTscPDtZJ2GimQp9BDPWVGJjWI9gn4hV+hANYa6uiBZ
         XJ/xGSFfu+9umO4u/v17A4PBEiZk3Rzw95MFryBG84s8n0UI5ZABt0LpwavqgTe7EN
         Kr6ssHGMwPwMDktHuTY29kS+mkjRJrLZFeT4DqqZFsTFWL/TvKObYA2XRWgo6jJSXk
         TAgey6/16PDmWVlaoAt60wVwdZQ0FV5Ui54FMKnbCJ3HJhNv3K0c7r0vn1rbhQTDp+
         doJWYBDzvX9B5mXV2oPW2v9hRn1rd8cSpkSJY41m3AzzZaoZMIcTNF0jU1e+ZD9aRH
         Fv+DPoZS8SoPw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] testing: nvdimm: add missing prototypes for wrapped functions
Date:   Tue, 16 May 2023 22:14:08 +0200
Message-Id: <20230516201415.556858-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516201415.556858-1-arnd@kernel.org>
References: <20230516201415.556858-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The nvdimm test wraps a number of API functions, but these functions
don't have a prototype in a header because they are all called
by a different name:

drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:74:15: error: no previous prototype for '__wrap_devm_ioremap' [-Werror=missing-prototypes]
   74 | void __iomem *__wrap_devm_ioremap(struct device *dev,
      |               ^~~~~~~~~~~~~~~~~~~
drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:86:7: error: no previous prototype for '__wrap_devm_memremap' [-Werror=missing-prototypes]
   86 | void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
      |       ^~~~~~~~~~~~~~~~~~~~
...

Add prototypes to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 tools/testing/nvdimm/test/nfit_test.h | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
index b5f7a996c4d0..b00583d1eace 100644
--- a/tools/testing/nvdimm/test/nfit_test.h
+++ b/tools/testing/nvdimm/test/nfit_test.h
@@ -207,7 +207,36 @@ typedef struct nfit_test_resource *(*nfit_test_lookup_fn)(resource_size_t);
 typedef union acpi_object *(*nfit_test_evaluate_dsm_fn)(acpi_handle handle,
 		 const guid_t *guid, u64 rev, u64 func,
 		 union acpi_object *argv4);
+void __iomem *__wrap_devm_ioremap(struct device *dev,
+		resource_size_t offset, unsigned long size);
+void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
+		size_t size, unsigned long flags);
+void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
+pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags);
+void *__wrap_memremap(resource_size_t offset, size_t size,
+		unsigned long flags);
+void __wrap_devm_memunmap(struct device *dev, void *addr);
+void __iomem *__wrap_ioremap(resource_size_t offset, unsigned long size);
+void __iomem *__wrap_ioremap_wc(resource_size_t offset, unsigned long size);
 void __wrap_iounmap(volatile void __iomem *addr);
+void __wrap_memunmap(void *addr);
+struct resource *__wrap___request_region(struct resource *parent,
+		resource_size_t start, resource_size_t n, const char *name,
+		int flags);
+int __wrap_insert_resource(struct resource *parent, struct resource *res);
+int __wrap_remove_resource(struct resource *res);
+struct resource *__wrap___devm_request_region(struct device *dev,
+		struct resource *parent, resource_size_t start,
+		resource_size_t n, const char *name);
+void __wrap___release_region(struct resource *parent, resource_size_t start,
+		resource_size_t n);
+void __wrap___devm_release_region(struct device *dev, struct resource *parent,
+		resource_size_t start, resource_size_t n);
+acpi_status __wrap_acpi_evaluate_object(acpi_handle handle, acpi_string path,
+		struct acpi_object_list *p, struct acpi_buffer *buf);
+union acpi_object * __wrap_acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
+		u64 rev, u64 func, union acpi_object *argv4);
+
 void nfit_test_setup(nfit_test_lookup_fn lookup,
 		nfit_test_evaluate_dsm_fn evaluate);
 void nfit_test_teardown(void);
-- 
2.39.2

