Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29CD62E16A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiKQQUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbiKQQUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6750078D7F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBA6062129
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF0BC433D6;
        Thu, 17 Nov 2022 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702005;
        bh=co5bVJK+UHoCCerLuzrGiotmPOsp9tgHPPc72sx6JtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9vJkdJh4MBviSr7nEUz3ktO0fHNiIPOQboCOMxpgu11pMqjbrZSQ+GkcjKSMXpax
         82gjYDlT0Xha2gOmLBZ9rQOk68Z3TLqotmlusRRjb6sk648UqWvOUh9XjwA1SfO/NF
         zRtg2jGbfiqdaT2zNVXsIPKomNGqtIlKaeyPBDLGjXCfMH1rZsQAGJAH0DbcVx9oSu
         MHZ6S9X3pOQE5h4TLzwMh1t/YVikFLgDN335zVr0dZZRwKl4+oPVrYIXhtHZ7wxZ5A
         2OMkFCXevtoCf31Mc8+QD03X4U4uVmQyy2OS8QoS5EHvEAs6TNo/Xr3TLgJPa2RzMj
         yxaLClgNaZU2g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 07/20] habanalabs: fix firmware descriptor copy operation
Date:   Thu, 17 Nov 2022 18:19:38 +0200
Message-Id: <20221117161951.845454-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117161951.845454-1-ogabbay@kernel.org>
References: <20221117161951.845454-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

This is needed to allow adding more data to the lkd_fw_comms_desc
structure.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 26 ++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index f18e53bbba6b..01c4ffba6e97 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -12,6 +12,7 @@
 #include <linux/crc32.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
+#include <linux/vmalloc.h>
 
 #define FW_FILE_MAX_SIZE		0x1400000 /* maximum size of 20MB */
 
@@ -1988,10 +1989,11 @@ static int hl_fw_dynamic_read_and_validate_descriptor(struct hl_device *hdev,
 						struct fw_load_mgr *fw_loader)
 {
 	struct lkd_fw_comms_desc *fw_desc;
+	void __iomem *src, *temp_fw_desc;
 	struct pci_mem_region *region;
 	struct fw_response *response;
+	u16 fw_data_size;
 	enum pci_region region_id;
-	void __iomem *src;
 	int rc;
 
 	fw_desc = &fw_loader->dynamic_loader.comm_desc;
@@ -2018,9 +2020,29 @@ static int hl_fw_dynamic_read_and_validate_descriptor(struct hl_device *hdev,
 	fw_loader->dynamic_loader.fw_desc_valid = false;
 	src = hdev->pcie_bar[region->bar_id] + region->offset_in_bar +
 							response->ram_offset;
+
+	/*
+	 * We do the copy of the fw descriptor in 2 phases:
+	 * 1. copy the header + data info according to our lkd_fw_comms_desc definition.
+	 *    then we're able to read the actual data size provided by fw.
+	 *    this is needed for cases where data in descriptor was changed(add/remove)
+	 *    in embedded specs header file before updating lkd copy of the header file
+	 * 2. copy descriptor to temporary buffer with aligned size and send it to validation
+	 */
 	memcpy_fromio(fw_desc, src, sizeof(struct lkd_fw_comms_desc));
+	fw_data_size = le16_to_cpu(fw_desc->header.size);
+
+	temp_fw_desc = vzalloc(sizeof(struct comms_desc_header) + fw_data_size);
+	if (!temp_fw_desc)
+		return -ENOMEM;
+
+	memcpy_fromio(temp_fw_desc, src, sizeof(struct comms_desc_header) + fw_data_size);
 
-	return hl_fw_dynamic_validate_descriptor(hdev, fw_loader, fw_desc);
+	rc = hl_fw_dynamic_validate_descriptor(hdev, fw_loader,
+					(struct lkd_fw_comms_desc *) temp_fw_desc);
+	vfree(temp_fw_desc);
+
+	return rc;
 }
 
 /**
-- 
2.25.1

