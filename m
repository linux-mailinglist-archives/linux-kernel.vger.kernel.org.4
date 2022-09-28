Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32375EE0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiI1Prx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiI1Pru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:47:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75477D74D6;
        Wed, 28 Sep 2022 08:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9x4X9S/1+dN6z8mXwLroTZemqNymNPoUnGaIuv4M+RbSBP79vXXQpRgrcsyhhUd7WrRSKthq4GjndEWwAMk++tPEA9bINaMpaxa/57Irxr/RBlEB/mvmkxLFtDBiOV9pPCOouPfP3QDouvX3PSt2uX47JF91xnnRLmfdqz+pCiPfOGDfjxrh3yEfECRAMxScWOCja7rohXd7FSdLS2l4Jfr+QXfQVfuA1UCT4dUlOIoooh/6OVRZgmHJFlAeeGECb+Qb18qXntAUCZEwet+zhT+kA8xa7gY94iD33ok5qZYBRtiQPI8EKNxPFik5Ypow+l6RqIKQNywlCEw/dzf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmytCIfU0q0HFZtdSw824ApWbs2IEYLxez4JZUy1rmg=;
 b=oJf6pud5sOX6m84xt3TKbqlLILVh/BXaHq+oyBAHvgNl4BwuSFNQyJU/cGhPm+bI32Vk6pyv8sIefvo/Q0WFQJ8pUX25YdFwfsAKumetsgbE0rkoxwQwjDl6/zT6c+DaYLBofwmy1oPnIm8PsjgwKGwePdILdVLfbndSUcHKF24hLhmLZWz0EhLBKpOPnobm6c9p1H9K3Bwfw/tjIybfLBvIVNdtcD4KOuRTBZSr1fxvmNcExD66KHTdlxnwlts1HNd9QabWJ7sl2Doy+mwDg1md8irLvbaMMysWBLrcXlJXyeCk8C4kLLQPcRWxczh4mS6gbMP65YohruCkHkYzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmytCIfU0q0HFZtdSw824ApWbs2IEYLxez4JZUy1rmg=;
 b=Cy4WS8F4IBUs8t3XExlRCXaSeVT0CNcg79+IQJbAmWcWox6udY+IfMGl5qB/Yvh0VkFbCmDzGSOZ2C8lgNVbUduE7HcRiskyKvZOcPKsITVCvjm6EcOuJHMDXj5WHduxnfus7H+UuaZqM+h3Fkn03PP6P6JVpl4y/w53olc6VwWICC17XJqr3ZyHjJ8e8vqYFLUHPYN0amjSOYhRzaCCSpcmeNZeF4JVchVqY2M/4mfc6x40Sj7e0D1+uB3zFMG5ry5lvKM/IwPu00Fpa3PFHDYg2lMnabsaH6NxTyOGSL/c0oNyHOsbUBDVDU5iPiCKRRUPECDvmTgIxbD7qk0ExA==
Received: from MW4PR03CA0169.namprd03.prod.outlook.com (2603:10b6:303:8d::24)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 15:47:48 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::7f) by MW4PR03CA0169.outlook.office365.com
 (2603:10b6:303:8d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Wed, 28 Sep 2022 15:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 15:47:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 08:47:37 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 08:47:37 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via
 Frontend Transport; Wed, 28 Sep 2022 08:47:36 -0700
From:   Wayne Chang <waynec@nvidia.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <waynec@nvidia.com>, <Sanket.Goswami@amd.com>,
        <singhanc@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] usb: typec: ucsi_ccg: Add OF support
Date:   Wed, 28 Sep 2022 23:47:32 +0800
Message-ID: <20220928154732.3806953-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a20745a-bf4b-4e6d-0164-08daa168caf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVJr4uhs58+MDOyJO6Iix3ACM0n1BaFNEGHlhP9fTTJsYqLIud2597tV+kNKH+agVmMnP/VXDqluPHzTMBDFKtwXgxei3n6J3qJohMB1uRPO935V2cguJm5NdSGlngpDBr36FpSAp5O6R648tSXZYg8K/OJsS6vwEt7uHBoh0XJYdHD/3kVzJx5rxIx+gvCU4k5MaTyLZZhSgxqMaL/p32f474mxNCVrUJ3ztSxKszVL4lM4YP2lPFzm0NYgWS1PeNCDNGMO8rMUuqH/s1SDX9gNexeURtwn8Q4i1WoLyDJ0+A8/qYKyhKA4s+kK2+jcMNqu7mMEdK3xWXqzJ76S6pUZrpAb4IYJbvRBAV9+YdYcfDQUBwlrmAhWEPmd3hotTGlNZT9pIcdD2dQC+0K55+BDZ975IUTTNP3sERLSNrcUj5aI0/4kUYJXtikGPcsyegv4prdby+7QqqPMMyd8xsRsxjbfNVqsXfEFTzlv6pQLqrh1WXOj5XxWiS3kX8J+N8qPBxXWJxXi3i4vIUKffMWPqYHtuXfO9x9D8Ie0+INCVgBSA+Ydpsuj3/bVNhII/yxWifDMfjRheTVaBI5M9H7dR+clGx6AXWKunnTzQNpNWe6ao82xQtIu79QJua3xOQxAqte/tH4UThosG2mtVPXfz80MzNfCjrIxzbYwa+cLpNAzU36kSi0JlNijzawTVW9JwVZd30UGKO2NP4VpUI7dDLcLzMvaVmIKjpRyWYYB1BIrYkVgYtlXeEzB84LMXQ3fSIqFb7oEqgmi5pUNFg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(478600001)(6666004)(26005)(83380400001)(40460700003)(186003)(47076005)(336012)(426003)(1076003)(2616005)(7696005)(2906002)(8936002)(40480700001)(82310400005)(54906003)(110136005)(4326008)(8676002)(5660300002)(41300700001)(70586007)(70206006)(316002)(356005)(7636003)(82740400003)(86362001)(36860700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 15:47:47.8443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a20745a-bf4b-4e6d-0164-08daa168caf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
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
V1 -> V2: updated the change with dev_fwnode instead of device node
 drivers/usb/typec/ucsi/ucsi_ccg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 5c0bf48be766..7e034d765a0e 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -631,7 +631,7 @@ static int ccg_request_irq(struct ucsi_ccg *uc)
 {
 	unsigned long flags = IRQF_ONESHOT;
 
-	if (!has_acpi_companion(uc->dev))
+	if (!dev_fwnode(uc->dev))
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

