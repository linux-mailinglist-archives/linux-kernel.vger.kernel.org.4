Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C11621F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKHWqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiKHWq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:46:29 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2C60691;
        Tue,  8 Nov 2022 14:46:28 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A8MkNt9123857;
        Tue, 8 Nov 2022 16:46:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667947583;
        bh=irLruPItPKZSOBhSNcqEgmj1Wp8qBzvia9j9Am2wPIk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fx0E8AavhyiUkG9lhmBvcw42Ap0HLQu8i1LOYt5Jkza/9r3nBBVUGNY+P/Oy/JlVm
         MxNEuUwctkK4aavk+ZoQJ9QZAq3KlxoQ+Joiqqz7dQmIH+B2uK8PlVG7qVTZwlxmXD
         7RDCSDp2BHb8DNZ6JwmXQl3oFGkt5rd4qqr+PHv8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A8MkN27119415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Nov 2022 16:46:23 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 8 Nov
 2022 16:46:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 8 Nov 2022 16:46:23 -0600
Received: from jti.ent.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A8MjSp1071038;
        Tue, 8 Nov 2022 16:46:15 -0600
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH v2 5/5] firmware: ti_sci: Introduce prepare system suspend call
Date:   Wed, 9 Nov 2022 00:45:27 +0200
Message-ID: <20221108224527.137179-6-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108224527.137179-1-g-vlaev@ti.com>
References: <20221108224527.137179-1-g-vlaev@ti.com>
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
entered and if necessary, send TI_SCI_MSG_BEGIN_SLEEP with information
about the mode is being entered and the address for allocated memory for
storing the context during Deep Sleep.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
---
 drivers/firmware/ti_sci.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 4986df1b8570..a6d982685aca 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3509,9 +3509,39 @@ static void ti_sci_set_is_suspending(struct ti_sci_info *info, bool is_suspendin
 	info->is_suspending = is_suspending;
 }
 
+static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
+{
+	int ret = 0;
+	int mode;
+
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_MEM:
+		mode = TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	/*
+	 * Do not fail if we don't have action to take for a
+	 * specific suspend mode.
+	 */
+	if (ret)
+		return 0;
+
+	return ti_sci_cmd_prepare_sleep(&info->handle, mode,
+					(u32)(info->ctx_mem_addr & 0xffffffff),
+					(u32)(info->ctx_mem_addr >> 32), 0);
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

