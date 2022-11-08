Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A60D62088E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiKHEy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKHEyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:54:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D8F3FBB5;
        Mon,  7 Nov 2022 20:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdrDVH8qHJzmHHEebpVF3SMWchUZrLj9Q8qfVUAD3m9rSncIgYxqAJCrotsxgc2W4gznZ9Otk0dSklR0eOu6f9c2l7ze0CTbclJAO6Gdu1ktixn1vIIl+TT7h0SmoFF0nrzRumV1TzBCF3UYwTK28PLMYrJ7SS/xzANPC21pPmPqJRm42FBdJwFr6ox+ghZZpsxrtnm0AwvEXBF3Dt//lSSZXe/yYbEbi+hTNdLpVE3H9sODpTnPqXfloC1eeju/MQ7opelBmhbchztL85Wr4JDZHJJgIj+Vc0Ptr0FfLgW/HNuQhxZJqD0mEfnAkKIkuwLEI8n2iyVVu6mm4A9VvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4WTPtHENiXhh+7V0/5fr9n1s6BvVv17NHJYTZrwKIo=;
 b=E7Oo5f1nWuFKcq0qjif6EtXfBKlSzh0NVQC69uuYD/1dlODp8lKD7susUYBrRhdSTIlmL3orYoG4qfzJoNdJ6izZptxXgqyh3HGTRmhIy7/A4lTnow56x9rd6LUXj5dIvxx/hnwwYfp7FBZIY6+Gly7tjaB4a95pypAUzgFclwLlcJ0cfzbksE2dfP+GFKbiWHkOLoy6SOPrzu8Y8efi4JRIqzdSzlc39g/VfbG7FhsExQs78MEkgXOFk9G7GiBI+g3ODK2W7cFbHMMmX75Y6vZmcrahwU9qCh+qFF1D9Z+x6NNsiMHI33nXf1HofiemeBFYvIHED639jaT8+3bEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4WTPtHENiXhh+7V0/5fr9n1s6BvVv17NHJYTZrwKIo=;
 b=EqogoiB35Y4Og3MvmKjNLS4GfnPBQ5cjqTH4OCNuQgPCy7DfB4rb5otVL0n7zZUJQJQkyhdINkWWPbvUwskF5KLVxwzY25GKSpcHS8CriGgkgvkQP/Fu7QBPwry+kQR8orwg/HWr5A03cAnJanoH/f7rPJGtFJvnrfvQIjii8rjDqjJppwmMKo2tI9PQJLj0dHDOO6DTJH59CmjuvZkce/nugtQN0iRNk2j8kZmhdJH0h2b2ABKRP2w5XAZEkj+uJcn96F87N5vBDwUZAb0PbW1KGkPHginN0gK14Ds2SWr46hOpGNnqGyYp+jiD2FNwZ7j3MY5tgfH6lf4rB7zkyg==
Received: from DM6PR17CA0007.namprd17.prod.outlook.com (2603:10b6:5:1b3::20)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 04:52:57 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::b9) by DM6PR17CA0007.outlook.office365.com
 (2603:10b6:5:1b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Tue, 8 Nov 2022 04:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 04:52:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 20:52:49 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 20:52:48 -0800
Received: from nmalwade-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 20:52:46 -0800
From:   Ninad Malwade <nmalwade@nvidia.com>
To:     <nmalwade@nvidia.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <nicolinc@nvidia.com>, <rkasirajan@nvidia.com>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH] ina3221: add support for summation channel control
Date:   Tue, 8 Nov 2022 12:52:43 +0800
Message-ID: <20221108045243.24143-1-nmalwade@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: e19e3e68-640a-46e8-9cb4-08dac1451aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uacurVtkDiqvj3ocSziu5h9dRNl8y50SIKb4sy4wkci6Jl846ARa1SBkf3NuztPFnpaaaH1EX/Feas7rDNaeYFVKvcP9qNJisnYa5o7eI2bikxdAr9g3Qbu1O+8i9uYX4UIvhcIoJE4QD4d2y7qw9Sybp0+ounIYd7PlgTQa2E142vRw6lPEBQ5zGTa9/a+BVNLTGhFPNciR0Y1R4a+0oBUzPmdEd6qC0pR2KBJVDEhP5uCrm6y2ph94tZAxaEkEztFYnWb87b1poZN/vbgFkH+y7yGei4/QThF12aVuVCSXnRgS85uCi2V5wtZ5pw/giIDMC2fDXEXx4A55cFrVBcxE6g0ef8X9mSL7pkaFo6zDOUTbFFwapI6ZUJpl4v+VU50BBuWUvJcLq579Gm7FgZcROkqSevDVXO2P74PoYR7UuleG4tubhFy9Vlq3Ckrn+084qoFVakRpQei1GoDQrM6XhY6ygEyJyDJ3EkhJpc3fbz7hSbeNTn3B4D8+DI55QvJgRGs3RueftCjhRDEPOsoHDHQKEv/kQ9y9ZkB/De/0Yy2nRqPb/2VQW5E9g/MyrsnOg3nghJ2vdpvf35+HW2XquNboZi2JuJXq3/GVN5b3CxsMkQiYvRm/qaQveHUJEN/GBnJdruQOQdIPyS2J/sl/Uk9OEN+Gy6gUhH4c7flNZXP/sj5RfGYRJ5GocindFLFZfUH3DjZvtOguf1hH8oN83yTFsX5+nJsqJX9phXHs4H+PvOEF2C8Yd0C+r0cLPWKsM3VsjwUfZ2yaR2Raqw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(86362001)(82740400003)(356005)(7636003)(83380400001)(40480700001)(40460700003)(2906002)(186003)(336012)(26005)(6666004)(1076003)(47076005)(426003)(7696005)(36860700001)(8676002)(4326008)(2616005)(70206006)(6636002)(110136005)(316002)(82310400005)(54906003)(70586007)(8936002)(5660300002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 04:52:57.1174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19e3e68-640a-46e8-9cb4-08dac1451aca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to initialize summation channel control via kernel device
tree property "summation-bypass". The channel which has this property
is excluded from channel summation.

Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
---
 .../devicetree/bindings/hwmon/ina3221.txt          |  2 ++
 drivers/hwmon/ina3221.c                            | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
index fa63b6171407..c6e8e6aafcce 100644
--- a/Documentation/devicetree/bindings/hwmon/ina3221.txt
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -29,6 +29,7 @@ Texas Instruments INA3221 Device Tree Bindings
   Optional properties:
   - label: Name of the input source
   - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
+  - summation-bypass: exclude from channel summation.
 
 Example:
 
@@ -41,6 +42,7 @@ ina3221@40 {
 	input@0 {
 		reg = <0x0>;
 		status = "disabled";
+		summation-bypass;
 	};
 	input@1 {
 		reg = <0x1>;
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 2a57f4b60c29..ba0d6da06947 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -104,6 +104,7 @@ struct ina3221_input {
 	const char *label;
 	int shunt_resistor;
 	bool disconnected;
+	bool summation_bypass;
 };
 
 /**
@@ -125,6 +126,7 @@ struct ina3221_data {
 	struct mutex lock;
 	u32 reg_config;
 	int summation_shunt_resistor;
+	u32 summation_channel_control;
 
 	bool single_shot;
 };
@@ -154,7 +156,8 @@ static inline int ina3221_summation_shunt_resistor(struct ina3221_data *ina)
 	int i, shunt_resistor = 0;
 
 	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
-		if (input[i].disconnected || !input[i].shunt_resistor)
+		if (input[i].disconnected || !input[i].shunt_resistor ||
+		    input[i].summation_bypass)
 			continue;
 		if (!shunt_resistor) {
 			/* Found the reference shunt resistor value */
@@ -786,6 +789,9 @@ static int ina3221_probe_child_from_dt(struct device *dev,
 	/* Save the connected input label if available */
 	of_property_read_string(child, "label", &input->label);
 
+	/* summation channel control */
+	input->summation_bypass = of_property_read_bool(child, "summation-bypass");
+
 	/* Overwrite default shunt resistor value optionally */
 	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val)) {
 		if (val < 1 || val > INT_MAX) {
@@ -873,6 +879,10 @@ static int ina3221_probe(struct i2c_client *client)
 
 	/* Initialize summation_shunt_resistor for summation channel control */
 	ina->summation_shunt_resistor = ina3221_summation_shunt_resistor(ina);
+	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
+		if (!ina->inputs[i].summation_bypass)
+			ina->summation_channel_control |= (BIT(14 - i));
+	}
 
 	ina->pm_dev = dev;
 	mutex_init(&ina->lock);
@@ -984,7 +994,7 @@ static int ina3221_resume(struct device *dev)
 		 */
 		ret = regmap_update_bits(ina->regmap, INA3221_MASK_ENABLE,
 					 INA3221_MASK_ENABLE_SCC_MASK,
-					 INA3221_MASK_ENABLE_SCC_MASK);
+					 ina->summation_channel_control);
 		if (ret) {
 			dev_err(dev, "Unable to control summation channel\n");
 			return ret;
-- 
2.17.1

