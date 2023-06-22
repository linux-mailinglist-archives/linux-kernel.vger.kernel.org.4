Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBEF73A4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjFVP0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjFVP0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:26:41 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7755B1BD3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/W/ynJ9k9ySZTdlV8AfoDBO+YYN/qDNa/08Zw4dd66Q6+CCxzp8K/xWGxv8WoIeYBYQv7jMKviRGtCABXvKOWDQT2Ud3xxL25ElMqzVN/4KT7wanUNBNfpjHqPF84LqDl5T5nQt0UmGWeS6dkcxIko2E0pP/c2/yhgAksg/D84A2jL6/9BUgDeGZTxu4vJ+ub8TPQPfPmO9WZs1bmQA2V2bJGJlttohkUeKZ5YIrCIVOt/NNOU2MJHvKNJsH1nWRg1HYFiCHVs3Xu3SOCduPMf1cppEAyQilM0Zk2QhZVLbTQzLrtHgejx7rwwUNxEX3kDmi+bE8jmeebgKqEB6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvCBKnW1XfiJYktEn5OXvrGZ5iyfve+4NEgu2JLMNvQ=;
 b=nYI6PYpykVJBBRwH6SltpOCPziAapnu8fkfmSvy9w36eCdbpnMI+D/KGRQqfQ/+jYUK8BMEXXUwUpkawoygDcySTYmW4DuAs+5kJODgzpU3OXyIM+r2mLWgx4v8Y5zWvBHnygHsx9ctoYkVATRedBy1f4ivkKeU1E0I1gy7knv48FZxFACUhoCof0f2NT5Cu6ih1nAQ3PJmmShETq+e5QndtljEuSKyxG1T9YiQEHDmuLqREZo4HTYjuVORWRk2ynPxPBrLBdcRivbJbBX+iZbAGJxBPeVSUIIwYtzb8xrDL6NqVG+vOlGz/jgcce9pEL4S4m7botVXIL6xYZHe+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvCBKnW1XfiJYktEn5OXvrGZ5iyfve+4NEgu2JLMNvQ=;
 b=IarlYrr4U0G4zrdngAb4iG7y+vGDSBs4GbEpBtexZ1QFFxblB/a0uHE4b4uMjGTdDYPELdHrqyXxu0jYEb6JkktePsms8ucM5u8/ROzPUEGmIWGm18TcDXo2l1qh+ZmhXSNkPmM8doz1lCnP5QTbQcnYwJcrpUj5yARWj0bEJ+A=
Received: from BY5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:1d0::13)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:26:17 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::88) by BY5PR04CA0003.outlook.office365.com
 (2603:10b6:a03:1d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Thu, 22 Jun 2023 15:26:17 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 22 Jun
 2023 08:26:16 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:26:12 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/12] ASoC: amd: acp: store platform device reference created in pci probe call
Date:   Thu, 22 Jun 2023 20:53:49 +0530
Message-ID: <20230622152406.3709231-12-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: b59ba72c-3d6c-41f8-36a2-08db733505f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XOXJgG5+8qfPIUlYR5ZIW2q1JMs2Km05Ai2OCe7moyta1nYJanMj9Gro5FG03aZIElxUQd38FP1aOopnXw5kHceRgRuz+vK0OFdjrsy0EIxkksW/4mC2ZX00hDReD5WqJ8C9RwGrD3/N4sdWr8yYFJFrgGXx5u1SCypbaX1z2B7EdidAkYZ1ojpgfYc1XOLsQgZl4G0K4dzHxmxh3jUM6WEsL40ARAQbeqDSM+A3XLkA7ZOutN9ijtfTzsJ0KSkN0Fh1bCPCVl8AqFfJw1ZZKXYwVBmiah4yNqUWo92YWWdiHWCKUmo2/dc+VKnIWGtldfPtJzCo0BJ7p3gg+UXwjuT2CHlpVW8svG9WK1e24xYdT2aUYCdrqyOg4x3U4tja7pWfOjIaBif81og2yymqlTBQmwO/AIK5s3pEhXDN3QTVUqtiTWLgEftZEuONaagcqm2ZnD0h1x1mHE0NtKVXvJDrmqLDpOUvt12LazxRm6cw5ysfw10a9NeqaOAK0Z3zBXoS+GkvLLrp+2Ptr9yN198rVJIc0b7Fgg4uZ1G9IQ7Hkg0Ddd9dflm/SOz6n6OtNUQFMQCv2Mlnj7Lc871jXNMBvFhht09hL39jBFxpYl7Rvta0lX+Y8VxQEdMHH/B8ogNspUX+gdH12ixirq0UWHtsZE9eYDml1gS4EmJApkNwaIpQhV2Mgbo30LZoklGGJLXHj7L5COJ8TdjQzIWNfsaLUgIPCi/2F2ZEvA0BpNKVYhsq94DgqZxuD1OB6DFsXWYYj2SzbPf0FOZ8l7gdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(41300700001)(8936002)(40460700003)(8676002)(36860700001)(6666004)(478600001)(82310400005)(81166007)(356005)(2616005)(83380400001)(82740400003)(426003)(26005)(186003)(1076003)(336012)(7696005)(47076005)(40480700001)(54906003)(86362001)(110136005)(36756003)(316002)(4326008)(70586007)(70206006)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:26:17.2330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b59ba72c-3d6c-41f8-36a2-08db733505f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the platform device reference created in pci driver,
it will be used in restoring the interrupts during system level resume.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 2 +-
 sound/soc/amd/acp/amd.h     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index d3b2ccbe7fd8..0d91181364e3 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -141,7 +141,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		ret = PTR_ERR(pdev);
 		goto unregister_dmic_dev;
 	}
-
+	chip->chip_pdev = pdev;
 	return ret;
 
 unregister_dmic_dev:
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 0d8c0febbbfc..f53613216397 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -115,6 +115,7 @@ struct acp_chip_info {
 	char *name;		/* Platform name */
 	unsigned int acp_rev;	/* ACP Revision id */
 	void __iomem *base;	/* ACP memory PCI base */
+	struct platform_device *chip_pdev;
 };
 
 struct acp_stream {
-- 
2.25.1

