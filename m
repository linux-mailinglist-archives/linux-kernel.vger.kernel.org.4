Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36EA6B80AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjCMScA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCMSbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:31:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95D8314B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA88FB811EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC29C433D2;
        Mon, 13 Mar 2023 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732230;
        bh=g4E1wcKH/Q2KGgYcTLAN52CLQs15rnqXo1TtKmLx46o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R61D2i5/fk67iJoda+wbgLOGSt9ImnLcOdLA4W24Yt1HFIVMotg2ZcGOSj9uk6Q6M
         YnGH0wG9ML2NWLHj1eimhg9xLWxAeY+ENtd9TOZk7HviDXvI1PS6vWR82vwHV/rpqo
         fPBlRktYODsEc2jf435Dcn1/ZL32WuRNl4OBPNkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: [PATCH 34/36] iommu: make the pointer to struct bus_type constant
Date:   Mon, 13 Mar 2023 19:29:16 +0100
Message-Id: <20230313182918.1312597-34-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5053; i=gregkh@linuxfoundation.org; h=from:subject; bh=g4E1wcKH/Q2KGgYcTLAN52CLQs15rnqXo1TtKmLx46o=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82TWL3ReXsm1/p/3H/ayG66UMRdHDNjF3rXSbyooqP my+6KzUEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABNZeIdhruBJw+nfCrtmTCvs df7p2VYjwxhjzTDPaLpDcDlXZca1N/d8RY+qp67qK5kAAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of iommu functions take a struct bus_type * and never modify
the data passed in, so make them all const * as that is what the driver
core is expecting to have passed into as well.

This is a step toward making all struct bus_type pointers constant in
the kernel.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 drivers/iommu/iommu.c | 14 +++++++-------
 include/linux/iommu.h | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10db680acaed..0b5e181998c9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -89,7 +89,7 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
-static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
+static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
@@ -1631,7 +1631,7 @@ static int iommu_get_def_domain_type(struct device *dev)
 	return 0;
 }
 
-static int iommu_group_alloc_default_domain(struct bus_type *bus,
+static int iommu_group_alloc_default_domain(const struct bus_type *bus,
 					    struct iommu_group *group,
 					    unsigned int type)
 {
@@ -1777,7 +1777,7 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
 	return 0;
 }
 
-static void probe_alloc_default_domain(struct bus_type *bus,
+static void probe_alloc_default_domain(const struct bus_type *bus,
 				       struct iommu_group *group)
 {
 	struct __group_domain_type gtype;
@@ -1832,7 +1832,7 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group)
 					  iommu_do_create_direct_mappings);
 }
 
-int bus_iommu_probe(struct bus_type *bus)
+int bus_iommu_probe(const struct bus_type *bus)
 {
 	struct iommu_group *group, *next;
 	LIST_HEAD(group_list);
@@ -1876,7 +1876,7 @@ int bus_iommu_probe(struct bus_type *bus)
 	return ret;
 }
 
-bool iommu_present(struct bus_type *bus)
+bool iommu_present(const struct bus_type *bus)
 {
 	return bus->iommu_ops != NULL;
 }
@@ -1951,7 +1951,7 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
-static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
+static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
 						 unsigned type)
 {
 	struct iommu_domain *domain;
@@ -1976,7 +1976,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	return domain;
 }
 
-struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
+struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 {
 	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6595454d4f48..0fd4e6734d5b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -455,11 +455,11 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
-extern int bus_iommu_probe(struct bus_type *bus);
-extern bool iommu_present(struct bus_type *bus);
+extern int bus_iommu_probe(const struct bus_type *bus);
+extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
-extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
+extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
 extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
@@ -732,7 +732,7 @@ struct iommu_device {};
 struct iommu_fault_param {};
 struct iommu_iotlb_gather {};
 
-static inline bool iommu_present(struct bus_type *bus)
+static inline bool iommu_present(const struct bus_type *bus)
 {
 	return false;
 }
@@ -742,7 +742,7 @@ static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 	return false;
 }
 
-static inline struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
+static inline struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 {
 	return NULL;
 }
-- 
2.39.2

