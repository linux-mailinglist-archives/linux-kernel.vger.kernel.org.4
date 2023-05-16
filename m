Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB8705853
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjEPUGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjEPUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED56582
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD8D4618C9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AD3C433D2;
        Tue, 16 May 2023 20:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684267560;
        bh=7dX4GIh606KqYGe9dKO1nnlkYackAgVvqWFkxj3MV3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9D4f8rCdLfFdDw7qINtml7i1SoNHf4q3RadsfMLORAPy7fjCpDtEOLXrddBoM1hd
         YSgauh0A1hrL20xIDd8dWKSdcTKkfJ6SwFT9V9nWm2IuFzMa2RuqCQvzpR/HNIh3qq
         HN1eqL0zUFzObo4wk8Ck90RjbgZUN9LEFpCF6E/S3vNWpHVzxc1rIlmY43hyB3ZeKM
         r7CfpAAwhsWIDh5jCyrsg4t10D24wDWpUZsAzERYils/hQi+dsxSIvWPfzmCmrT3+H
         h3C6UBMzjtVaIKlO/ux/MIRZYLZnT4R7dEC6BuOolurl2NDQ5BnZ17OkTfrq8pinzx
         X5mkIqwUPx1Iw==
From:   Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <guohanjun@huawei.com>,
        Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] irqchip: gicv3: add a iort_pmsi_get_dev_id() prototype
Date:   Tue, 16 May 2023 22:05:08 +0200
Message-Id: <20230516200516.554663-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516200516.554663-1-arnd@kernel.org>
References: <20230516200516.554663-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

iort_pmsi_get_dev_id() has a __weak definition in the driver, and
an override in arm64 specific code, but the declaration is conditional
and not always seen when the copy in the driver gets built:

drivers/irqchip/irq-gic-v3-its-platform-msi.c:41:12: error: no previous prototype for 'iort_pmsi_get_dev_id' [-Werror=missing-prototypes]

Move the existing declaration out of the #ifdef block to ensure
it can be seen in all configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/acpi_iort.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index b43be0987b19..6b70d02bc5f9 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -26,13 +26,14 @@ int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
+
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
 u32 iort_msi_map_id(struct device *dev, u32 id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 					  enum irq_domain_bus_token bus_token);
 void acpi_configure_pmsi_domain(struct device *dev);
-int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
 void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
-- 
2.39.2

