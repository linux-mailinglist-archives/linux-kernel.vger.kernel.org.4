Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6365E63AA76
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiK1OGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiK1OGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:06:20 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E12127C;
        Mon, 28 Nov 2022 06:06:17 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ASE6B2q109903;
        Mon, 28 Nov 2022 08:06:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669644371;
        bh=flzB7Wa6hAMqJiGA/2RH5eCO5QhcD1qsRfBay0L5uTc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sgMOVTnJHWvOyE9ZMBJX+tx/TohEOpBUJNp3+CQBK5YnqFI9L7yRh/VtMWTZaNovl
         YAy9TszD8Rd3Hu8n05BQDO49QwIOQJOLYviEJQLtAJ41jgBSvXQ10xdgRQbjlxVYTC
         CvLaVGZX3TLHnCMfH/mm2pX6pnC8TpfpVCJSOpSo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ASE6Bkb099220
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Nov 2022 08:06:11 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 28
 Nov 2022 08:06:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 28 Nov 2022 08:06:11 -0600
Received: from jti.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ASE5NQf125815;
        Mon, 28 Nov 2022 08:06:05 -0600
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH v5 6/6] firmware: ti_sci: Introduce prepare system suspend call
Date:   Mon, 28 Nov 2022 16:05:22 +0200
Message-ID: <20221128140522.49474-7-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128140522.49474-1-g-vlaev@ti.com>
References: <20221128140522.49474-1-g-vlaev@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Introduce a ti_sci_prepare_system_suspend call to be used in the driver
suspend handler to allow the system to identify the low power mode being
entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
about the mode is being entered and the address for allocated memory for
storing the context during Deep Sleep.

We're using "pm_suspend_target_state" to map the kernel's target suspend
state to SysFW low power mode. Make sure this is available only when
CONFIG_SUSPEND is enabled.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Tested-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/firmware/ti_sci.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 09bca1a15d74..681f2ebb3fe4 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3568,9 +3568,46 @@ static void ti_sci_set_is_suspending(struct ti_sci_info *info, bool is_suspendin
 	info->is_suspending = is_suspending;
 }
 
+static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
+{
+#if IS_ENABLED(CONFIG_SUSPEND)
+	u8 mode;
+
+	/* Map and validate the target Linux suspend state to TISCI LPM. */
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_MEM:
+		/* S2MEM is not supported by the firmware. */
+		if (!(info->fw_caps & MSG_FLAG_CAPS_LPM_DEEP_SLEEP))
+			return 0;
+		/* S2MEM can't continue if the LPM firmware is not loaded. */
+		if (!info->lpm_firmware_loaded)
+			return -EINVAL;
+		mode = TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP;
+		break;
+	default:
+		/*
+		 * Do not fail if we don't have action to take for a
+		 * specific suspend mode.
+		 */
+		return 0;
+	}
+
+	return ti_sci_cmd_prepare_sleep(&info->handle, mode,
+					(u32)(info->ctx_mem_addr & 0xffffffff),
+					(u32)((u64)info->ctx_mem_addr >> 32), 0);
+#else
+	return 0;
+#endif
+}
+
 static int ti_sci_suspend(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ti_sci_prepare_system_suspend(info);
+	if (ret)
+		return ret;
 	/*
 	 * We must switch operation to polled mode now as drivers and the genpd
 	 * layer may make late TI SCI calls to change clock and device states
-- 
2.30.2

