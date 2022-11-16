Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7680562C75B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiKPSOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbiKPSOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:14:15 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099361BBE;
        Wed, 16 Nov 2022 10:14:12 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AGIE41s124855;
        Wed, 16 Nov 2022 12:14:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668622444;
        bh=4g1A+bdsai1k2SJIC++Cf1aVL+iDkzr21PM5Fp+vzzc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C6MyXsqJKiMO73KGOPXZD4hP34ZRVtJ2UuiN84XmulrDQkpvBk7dke0OpjQfcCB2s
         XDkKXJURWKSfzTlGqP7KVIKOYQbmXsKYQSDbKRnZaHT0A1aA7MWYE2pL+VzPekcElS
         +o+OXuhvcfek/eJMJy+dbaCEHEfkTBgH/EU4zuxo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AGIE4p9013903
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Nov 2022 12:14:04 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 16
 Nov 2022 12:14:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 16 Nov 2022 12:14:03 -0600
Received: from jti.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AGID8MJ026690;
        Wed, 16 Nov 2022 12:13:55 -0600
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
Subject: [PATCH v4 5/5] firmware: ti_sci: Introduce prepare system suspend call
Date:   Wed, 16 Nov 2022 20:13:07 +0200
Message-ID: <20221116181307.198209-6-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116181307.198209-1-g-vlaev@ti.com>
References: <20221116181307.198209-1-g-vlaev@ti.com>
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
Tested-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/firmware/ti_sci.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index fec4ef0ae4c3..3fad7209b722 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3510,9 +3510,39 @@ static void ti_sci_set_is_suspending(struct ti_sci_info *info, bool is_suspendin
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
+					(u32)((u64)info->ctx_mem_addr >> 32), 0);
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

