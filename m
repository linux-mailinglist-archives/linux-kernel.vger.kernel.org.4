Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D669790C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjBOJcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjBOJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:32:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C323431A;
        Wed, 15 Feb 2023 01:32:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl22EVBnpCrDz3rfyMvPsvRyyLiWU8cqXh8KVaeyycIBQJeVnI/7fQFId1cUAhFhEiVW4UEjIAFu5Weg12MTADRZP6ah9udfnyAqNvE3wxX9sLchclKOum7r1cIoI+KdNpUPkUnwkpMkxwOekkPyiqr6k5r56H+vEn30GI9Qos02z5iOzOeFvE8DmabsSuJwUzU6f9a6iI+jXA7NhhK3SSQIPCMiEt9CZEn42JpD1Vj0U6nHeP2MhgOR2SJ9twuonj0FSFD5P+6e/19W0FLvb4k/skQTjV6FoWNbkLiiubXLkm7qGRO4BYB7rCPjn2LO3w7Q6J31g5MhNUhxzB6+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1F91IPModui4TqOwqQiPatecT08phOw1I1FQ9sKsY4=;
 b=ck4nNmFae+bV6C3JlsD1Q/WK0mrdCkrehZmg6GaB6EmJWHhvMsfNyCJ9OjHY60weio6OpODTS9KiIojxHFEMIxBnavqp6UD8Ka+EqeWOVElzqDLnuAEGh5Faz0kiJhXEiGdCfja/dpO6lLne6b8ZVcD2pCFvoHvrcI3SclWkvaUZwRAYwgJ/k1HKbT/km/erslmBz5dDNGfgPK1x4TClfe/zpGWmLHNYd+5uJDWTaESRNLk7JxG6QXS9pSV19/V0HzODf6to3LHc8zWj2ym4PyYclu/RbNsaVzjw4CtNXM4Jn89vp3UkTiB0bPPlcvYXD12deJhCAbp+Tv5QT3iY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1F91IPModui4TqOwqQiPatecT08phOw1I1FQ9sKsY4=;
 b=Xlplid4tUzb9aEW2azyQ8KOaIMlCYmXHR+iu1nkNXpdmAtm9MzSSZxFn2h1mR9nEXixAeEfOqhcGfsfqiNO09QrOIrXkajZIfeztHMmzXR1QjOeyuedu+LASdPmp1/aBQEbKAKCyEeENVR65WbQJGhw1HyDAYP9zoPSLR+h5mfs=
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 CH0PR12MB5186.namprd12.prod.outlook.com (2603:10b6:610:b9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.24; Wed, 15 Feb 2023 09:32:32 +0000
Received: from DS1PEPF0000E63F.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::a2) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 09:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63F.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Wed, 15 Feb 2023 09:32:32 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 03:32:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 01:32:11 -0800
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 15 Feb 2023 03:32:08 -0600
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,ulpi-ext-vbus-drv quirk
Date:   Wed, 15 Feb 2023 15:01:45 +0530
Message-ID: <20230215093146.5812-2-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230215093146.5812-1-piyush.mehta@amd.com>
References: <20230215093146.5812-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63F:EE_|CH0PR12MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1def08-6361-4851-dbe9-08db0f379096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABI5sB1knQYdv6WSFGuivEz5awnnzYWEf4YSCS6lIJGlaouZ4zkjYwjOssBSrQi22omfe8FNIind/Hp19IK1/pXrpHJDiGY769/lPdA/La4VOIFTVtrsiVxoQBe8RLkYycMeHUn3osGbZyZOvpYshIxPB7bP61I3YXfqNw/oEU/mPyQvJ1yFAmFrY3xAhQunjn9PG7N6OpdQ6kIa/NSakDXLODPTk7jIWJ1zcgZz5ceFe6wbUw/XA91E2feuIjgimB19+/kg/ARFzo67/hy2FTryCLrKH1O3aLdaBqoCl3aIDZDjBF6AAE/DLOd23/iFVQdme8m7oBHnMeJPoWl+ddU9LXXcJ5W3D8XmoM0EqGc72A7DSqmneUWaAEQXcUTEDv16EgtzEpE0wvPctt3SpWpsrQtMkwYwYI2ONtEe+DgCcm9M1m1dDazRtlM1mxUIeUN3aTL2FyO5tPC+2EsE9hxTV8mh9FN6Jkys6u4NYU/4t+gWVQi07TarZn30TPXjQQtDcuoV660yjAGZDl23m77unQ1VvjZ33YxC3VbWO/6J6w9SWPQtn19iatUtEvaaBb26uRUBjo5NPe85kwomsmvuDaKJGpWMhH8VJvQEaO5FYrZ1ULERZ5PgDg1LJ7Qxn+7dwAaKIiTadRCrKyJyU9x+B+4w/oCX6kKOFFsd9w8ppuvroU352XXs02rJKr35WxibOVPLd7HcuQXKg8w/MWQ3ARth1dp9LrYyyynZVig=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(46966006)(40470700004)(36840700001)(44832011)(5660300002)(2906002)(336012)(86362001)(82310400005)(83380400001)(40460700003)(426003)(8936002)(316002)(4326008)(8676002)(70206006)(356005)(70586007)(2616005)(26005)(47076005)(41300700001)(82740400003)(81166007)(36756003)(54906003)(36860700001)(110136005)(40480700001)(6666004)(478600001)(1076003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 09:32:32.5699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1def08-6361-4851-dbe9-08db0f379096
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5186
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ULPI USB PHYs do not support an internal vBus supply, to drive the
CPEN pin properly, it requires configuration of the ULPI DRVVBUSEXTERNAL
bit of the USB ULPI PHY OTG_CTRL register.

Added 'snps,ulpi-ext-vbus-drv' DT property to configure the USB2 PHY to
drives VBUS with an external supply.

When the ULPIEXTVBUSDRV bit is set to '1' in the Global USB2 PHY
Configuration registers, PHY drive vBus with an external 5V supply source.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 6d78048c4613..4e4a2dfb77b1 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -246,6 +246,14 @@ properties:
       of resume. This option is to support certain legacy ULPI PHYs.
     type: boolean
 
+  snps,ulpi-ext-vbus-drv:
+    description:
+      Some ULPI USB PHY does not support internal VBUS supply, and driving
+      the CPEN pin, requires the configuration of the ulpi DRVVBUSEXTERNAL
+      bit. When set, the xhci host will configure the USB2 PHY drives VBUS
+      with an external supply.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.17.1

