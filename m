Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501FC5EDD30
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiI1MxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiI1MxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:53:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EF94D814;
        Wed, 28 Sep 2022 05:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdjd8DuSNcv+/AgzYFq8cn85nFPk7EnGDs3cQpnBLF1e3cCvI7maqfPNdrxqygH7L1yUDwqckgXjbG2QK6uuWx1qHBY5gBqzVaklrc7ppSddW5yLIf+q/MLV17zdhPV3axMek5TKA+jZZPGIJ7SkEKjInQfDjN/iBdgn+xhYLp+Q5sQXU5OZmqrdHBG8MMHCRmIrcMcXogXidnbKL5OQiKOOf1tPUI8t1Z1ANHME7HWvXHCaBq1MVoeBZil56ArFfr1X6/lETyE82IKl6o07zRDVYT/1fEGHB2RSZBnPON1BkE3VGWSZORRMND0yMxWl0L7+mCvVmZbvP4lNBYvucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+Qwn/6V+Eeag8u6hIfJjZnfcOgRGzErwHqXHjEfjCg=;
 b=k0YClwTwDRSutpLXk+VBiI16nRFiMOU30ToB9Ws096XRlRjTj7OYs/8YFvJS/Da7qFIVTsdYBAmEdiKUTi+2aK7+4OC8ULnAhYtUDjHwm0NJ28tuWqXLv5qSN2RmN2VyBTwbFszCaMWrPS7mRjCEuJ4habbqoEa9vg4fNryb63fEDXXGvW5WKQY6y/YyrL8/HYpPywPV4fAX3v6LvFoMnX7UfvmARxloYq4nDoh7D6untGDTAJDQUuWa2m1nWr5ES7BUoN0eDO7KKPRGlyqK+mnQozQKMM5K1eN9GS+yoRUscIJHskZJ9X3NY3RLKcRP5JymsA71IvLWIYO7bpAMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+Qwn/6V+Eeag8u6hIfJjZnfcOgRGzErwHqXHjEfjCg=;
 b=eqBTqLnmGRwpwuDlRCxffPZPBDLeWP9vCrfZP9t3Yk5qjMoEsvVhBl+r9RnJzAVZpoy26vaZINSZ0vtqz9iiXDFzlB8n9fhkSrQvQfVkkAQG1aH4zuXVBrruY88s/S7yZeOmKnpskWzW/ywDHnRI++JoBzk1ukk3pFJWwYkG2RJ46YkpB9qbD/N7UnERfHhzYieYoAHSnj/oFsPGhf9rVMp+M8uPIB6Wn/RnVRHSmJ5hsRFqBlwQ3LRdO/obvJIErmjbx5B7yGq4R2jW11weYc6ZCRj24RxM5g2MfBLloCkziQpO7T3+27sfu3377db2BE2wPd8SpQHdor7cXYaEiQ==
Received: from MW4PR04CA0288.namprd04.prod.outlook.com (2603:10b6:303:89::23)
 by DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 12:53:05 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::df) by MW4PR04CA0288.outlook.office365.com
 (2603:10b6:303:89::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 12:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 12:53:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 05:52:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 05:52:56 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via
 Frontend Transport; Wed, 28 Sep 2022 05:52:54 -0700
From:   Wayne Chang <waynec@nvidia.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <waynec@nvidia.com>, <Sanket.Goswami@amd.com>,
        <singhanc@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] usb: typec: ucsi_ccg: Add OF support
Date:   Wed, 28 Sep 2022 20:52:27 +0800
Message-ID: <20220928125227.3045703-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|DM4PR12MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: c65a151e-c7d1-4d95-2546-08daa15062d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4927P7893oFapJ0ERPARNXI/0TbxzWVHrWCGS23m+PU1xMd+Apy2GEQQtGDiBGWP3hC/ZyGnTgic8wbgem6NRNlyV9dzmvrZjiPRJWVRk+yVLy+jEfEoG4vmqRupaG6YZakD0DvEBDizITMBZjJZmzRJDD0h2ejbZdLq4bbhSP9Mpu6P+CYvpAhVfVKwDpEE0Yqfa2UWllJlHm8u+hT2VKDkO94zyzjieItffId1c1nLtYdZj2jRNGK0HzTLefCJiUbEDVCIUF7QmT0Sl76MQp77p/wfLTG3WpqCC80RUVHvEVsoceKpuR6kcHRWhYW18cKaQBmDZWVH8krzm6qfacY74YP5/ZOlAFdftP+gb3ceiuXTJqjdKQdsAWZz78XYOIopAy547G1zutZveF5a9r+zKpxs/adb7yZC6kpP6b+Su86BQR4ysfi2Q76iqQsnHkgOXppc4AxTn6LqfTeTkQ+zek+vlZ7PYNZT/CCS8cmUgKcx85MB9uP7vOSlmH/P8V79oV401A0zftBmU/4L2cutsJxAIuxyjwz+cN4YbavGstxxKSnxUu1Mfbw0aRdCLyfI9Zni79X/zrehchsTJb09m3ZjAnAXrGXzZKxZls0ogXdQu6uyqrKO9wLbH7oNqflzOevbMzuNQoob1o65ZzteziGJkrBMzpNE1zs1nuVr79sPczB6O1wcac0T9GOiPOa1jfKBc0Pixt+foisZlRwToCwYfV/BECTHp0klB71M0HQ4n/b4Z+DxEm6pc8+sfcpp9el4SW1+Ad1Hhjk1w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(7696005)(36756003)(316002)(336012)(54906003)(82740400003)(110136005)(26005)(1076003)(186003)(2616005)(36860700001)(86362001)(8936002)(70586007)(2906002)(40480700001)(41300700001)(83380400001)(426003)(47076005)(8676002)(4326008)(70206006)(478600001)(40460700003)(82310400005)(7636003)(5660300002)(356005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 12:53:05.2803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65a151e-c7d1-4d95-2546-08daa15062d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change enables the device tree infrastructure support on Cypress
cypd4226.

Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 5c0bf48be766..36442508bc37 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -631,7 +631,7 @@ static int ccg_request_irq(struct ucsi_ccg *uc)
 {
 	unsigned long flags = IRQF_ONESHOT;
 
-	if (!has_acpi_companion(uc->dev))
+	if (!has_acpi_companion(uc->dev) && !uc->dev->of_node)
 		flags |= IRQF_TRIGGER_HIGH;
 
 	return request_threaded_irq(uc->irq, NULL, ccg_irq_handler, flags, dev_name(uc->dev), uc);
@@ -1417,6 +1417,12 @@ static int ucsi_ccg_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id ucsi_ccg_of_match_table[] = {
+		{ .compatible = "cypress,cypd4226", },
+		{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ucsi_ccg_of_match_table);
+
 static const struct i2c_device_id ucsi_ccg_device_id[] = {
 	{"ccgx-ucsi", 0},
 	{}
@@ -1471,6 +1477,7 @@ static struct i2c_driver ucsi_ccg_driver = {
 		.pm = &ucsi_ccg_pm,
 		.dev_groups = ucsi_ccg_groups,
 		.acpi_match_table = amd_i2c_ucsi_match,
+		.of_match_table = ucsi_ccg_of_match_table,
 	},
 	.probe = ucsi_ccg_probe,
 	.remove = ucsi_ccg_remove,
-- 
2.25.1

