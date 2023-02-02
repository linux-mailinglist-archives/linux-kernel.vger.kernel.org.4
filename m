Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1156F687422
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBBDs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjBBDst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:48:49 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9DF7BBE6;
        Wed,  1 Feb 2023 19:48:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VaiwXFi_1675309722;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VaiwXFi_1675309722)
          by smtp.aliyun-inc.com;
          Thu, 02 Feb 2023 11:48:45 +0800
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        jkchen@linux.alibaba.com, xueshuai@linux.alibaba.com,
        Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH] ACPICA: PCI: Undefined ACPI_ADR_SPACE_PCI_CONFIG when CONFIG_PCI is unset
Date:   Thu,  2 Feb 2023 11:48:21 +0800
Message-Id: <20230202034821.25123-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI core subsystem initialization will fail when Kernel disabled PCI but
ACPI tables still have PCI config address spaces.

Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces
only when ACPI_PCI_CONFIGURED is defined.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/acpi/acpica/evhandler.c | 2 ++
 include/acpi/acconfig.h         | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index be9a05498adc..86057e39df8c 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
 	ACPI_ADR_SPACE_SYSTEM_MEMORY,
 	ACPI_ADR_SPACE_SYSTEM_IO,
+#ifdef ACPI_PCI_CONFIGURED
 	ACPI_ADR_SPACE_PCI_CONFIG,
+#endif
 	ACPI_ADR_SPACE_DATA_TABLE
 };
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 151e40385673..28456120529f 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -162,7 +162,11 @@
 /* Maximum space_ids for Operation Regions */
 
 #define ACPI_MAX_ADDRESS_SPACE          255
+#ifdef ACPI_PCI_CONFIGURED
 #define ACPI_NUM_DEFAULT_SPACES         4
+#else
+#define ACPI_NUM_DEFAULT_SPACES         3
+#endif
 
 /* Array sizes.  Used for range checking also */
 
-- 
2.33.1

