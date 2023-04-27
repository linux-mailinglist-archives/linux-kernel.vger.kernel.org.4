Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1AE6F006F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 07:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242881AbjD0FeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 01:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242854AbjD0FeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 01:34:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDEE4681;
        Wed, 26 Apr 2023 22:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWJiozoC03vwCku2eWfHDMcdk4eiY9jgKIc0G7h4FBI/blmMhtWFNWM+cpg/mFTXvBFZdgOtOokdFDbIIyxszRXTywicz3MZ75HbJZu9++CKZ7eqw1Fbi8Gzyv8SdQrQglTdib6swXMQxTgld8geStTNsB2eb/JjVzdzHoZdtYzWJujMNERbyhREOqFgoLkByNkfri9b8jQ272mjxW95QRodVR+QGd/CgiJ1LmxweoVaMBcRcDrO2QwB1KzQuI+WbS7s53LZKZbf9Bsd0vUpIjIeYUp581jz01/+Lza+i866HjNTGUxaGu6U1kcnAlvJOulneGG6WH3Ft1tRwD9lXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TfZytftbUAc/bIp2rwvah/ZYV/rYgVkLRQ/zEJZmko=;
 b=YgMjGRQvIIqfAWWHw0oBdbSQY0JAIJ6hYROLP1DuCElwrTGK+8LrVN1tgaC1jdixAnKhUXujn8VCA+Y+mQgXgJY/m84IibCVERHw7U9VGds7QcFZprv5KSrUelU1As6pfsQyS3DG5hGXNt5ODLIP0vUbIxWh0rftahJqKi+n5ZVOf6Orr/5Y0eUhh4rAcVMWC7U4YHF1y8UU+/gj8TfTLA+Topg+ohcO9W/kINzybYDEx/hEQWyXtwExRC4QS6xN6Ml/fSFFP9HFdoevO+5iCmj9NFjl+WOGT82FC/nvKWH0yxzPY5ljXqRWIorhLCHq0eT81Ve3Upk+BZPIj6/XjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TfZytftbUAc/bIp2rwvah/ZYV/rYgVkLRQ/zEJZmko=;
 b=WFNcIXXwRQXAr1P8Hta9aAn4TgWKT990bf+vtlTW80PGmqYgZFR2WvORJXjsSPzKucV2ejsOKQqq0sj7yyimRvvbhxjKKt/AwE9lrm16SrhhPDpupi9PeFPDdwurt+vU7Q5JYxMr49i/484hoARU0YXWfQizwydn8tY2k29tXCY=
Received: from DS7PR03CA0257.namprd03.prod.outlook.com (2603:10b6:5:3b3::22)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 05:33:57 +0000
Received: from DS1PEPF0000E644.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::90) by DS7PR03CA0257.outlook.office365.com
 (2603:10b6:5:3b3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 05:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E644.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 05:33:57 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 00:33:56 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Richard gong <richard.gong@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] k10temp: Add pci ID for family 19, model 78h
Date:   Thu, 27 Apr 2023 00:33:37 -0500
Message-ID: <20230427053338.16653-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427053338.16653-1-mario.limonciello@amd.com>
References: <20230427053338.16653-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E644:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4dc419-db1c-4e4f-4986-08db46e0ff4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxAIC3jLLiTMhsDHbO2lRXjQ7Yj0KtVbKPz4ZRLEzzfUjT1ehwFoXs9KYc1rjGaDxChKX2F8AqCkh+jtlUHRGTsFFB1nZFpyPsMVSc2M68l8rPccIv65QWkk2NWF2qtz76TO8CLyaMJla+7QkCtvYnzZneMSHqvBsOxkvG0i1Dgw4B/+s6UCnR2UvVkJH36NL7vuTwYnckXAmc5rTJB+CAxCbGkukEWupcAOCt19CbmgL+pp9yX3Ycf9wFAKU2GqfukYXoyuSDWT9jAK7Db+EOhkjb1gW3yhOGoBNk6uPJj49/YNG24DdypoQRfkljq54X/kjWf5UZ9XcJU7aK+r6tPDwbkYQ3AENiaYtEX0n0DAejea5ewV3ZIz+W/9NFX//wc4zjfiiV8SUbJlv5zZMa02XiDOa/COOqrJJMaMSTzr5W/QNl7WPJyN8IBh1OB4BJvZi1I6lWv40yfSqbZRwYT7QFyvTpJ1sLDbI8qTUKTjp74/5CEZqQEe08VmjNMBXAYHS7FL0+2MDWYZXgwyV4daOCSo/MjZcU6eMh1QyF/RVhyfCG8luIKzYT3P5ngQy6xMmHgOdA9wJ4LE1HhQCa3mCbD8jz5Szjt0BaE0m3P+Cp2mthm0uyvKKC7TzUmjAN55xrwHkwyx6qplTacgUUnn68KuKsyYeGCVCimThzt0GnL1DSaQz+GuP/46iVJU5TBXRUxSRy+WFM/q22UPJZcfG9a2GZccA5nIyLfNPww=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(8676002)(44832011)(8936002)(54906003)(70206006)(81166007)(478600001)(86362001)(70586007)(82310400005)(2906002)(41300700001)(316002)(6666004)(4744005)(4326008)(110136005)(7696005)(5660300002)(26005)(1076003)(186003)(82740400003)(47076005)(356005)(16526019)(40460700003)(336012)(40480700001)(426003)(2616005)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 05:33:57.1640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4dc419-db1c-4e4f-4986-08db46e0ff4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E644.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables k10temp to work on this system.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index ba2f6a4f8c16..7b177b9fbb09 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -507,6 +507,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.34.1

