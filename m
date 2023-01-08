Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A149B66174D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjAHRVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjAHRUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:20:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292C6BC16
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:20:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B872960D2E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54966C433D2;
        Sun,  8 Jan 2023 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673198451;
        bh=iG2c7SwaVS+AHAGobcySGLg5gpp4yB/hNLo6VR8KQ70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzPennYDMOaD04CrkSiu/4ll2jZV3oMZfyc34DaMlOABjb6fusConprR0iHOmSw29
         bDa4frDqHySiL/hgwB2TDH5IaQIezsQjS0y8xfkBYf7so/+nmoSPoTDQYmncGEPcYi
         wMipj8NyVtFqDnr9MatTydrSCvKSXHPdLLjhOO5N3cjxqbiRWoSzOJZDgzJGW4oGO9
         M6hFTXiuA0KNVYQVpTh0/AGV+LQEjgQMgYUMV2n6OW92eVkvSpmKyy/+y9yEq/qeJb
         O9TIpGrWkCGGsUTzLf0WrXl+425C2gBsR6USuIUQLYyApPv00PirT3tVJ+fSylAwYw
         bdzZh34sbtINw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 5/7] habanalabs: trace LBW reads/writes
Date:   Sun,  8 Jan 2023 19:20:38 +0200
Message-Id: <20230108172040.3991204-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230108172040.3991204-1-ogabbay@kernel.org>
References: <20230108172040.3991204-1-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

Add traces to LBW reads/writes.
This may be handy when debugging configuration failure or events when
tracking configuration flow.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c  | 10 +++++++++-
 drivers/accel/habanalabs/common/pci/pci.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 6a05ab3fda23..722a5beb0974 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2401,7 +2401,12 @@ void hl_device_fini(struct hl_device *hdev)
  */
 inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 {
-	return readl(hdev->rmmio + reg);
+	u32 val = readl(hdev->rmmio + reg);
+
+	if (unlikely(trace_habanalabs_rreg32_enabled()))
+		trace_habanalabs_rreg32(hdev->dev, reg, val);
+
+	return val;
 }
 
 /*
@@ -2416,6 +2421,9 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
  */
 inline void hl_wreg(struct hl_device *hdev, u32 reg, u32 val)
 {
+	if (unlikely(trace_habanalabs_wreg32_enabled()))
+		trace_habanalabs_wreg32(hdev->dev, reg, val);
+
 	writel(val, hdev->rmmio + reg);
 }
 
diff --git a/drivers/accel/habanalabs/common/pci/pci.c b/drivers/accel/habanalabs/common/pci/pci.c
index 5fe3da5fba30..d1f4c695baf2 100644
--- a/drivers/accel/habanalabs/common/pci/pci.c
+++ b/drivers/accel/habanalabs/common/pci/pci.c
@@ -10,6 +10,8 @@
 
 #include <linux/pci.h>
 
+#include <trace/events/habanalabs.h>
+
 #define HL_PLDM_PCI_ELBI_TIMEOUT_MSEC	(HL_PCI_ELBI_TIMEOUT_MSEC * 100)
 
 #define IATU_REGION_CTRL_REGION_EN_MASK		BIT(31)
@@ -120,6 +122,9 @@ int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data)
 	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE) {
 		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
 
+		if (unlikely(trace_habanalabs_elbi_read_enabled()))
+			trace_habanalabs_elbi_read(hdev->dev, (u32) addr, val);
+
 		return 0;
 	}
 
@@ -179,8 +184,11 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 		usleep_range(300, 500);
 	}
 
-	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE)
+	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE) {
+		if (unlikely(trace_habanalabs_elbi_write_enabled()))
+			trace_habanalabs_elbi_write(hdev->dev, (u32) addr, val);
 		return 0;
+	}
 
 	if (val & PCI_CONFIG_ELBI_STS_ERR)
 		return -EIO;
-- 
2.25.1

