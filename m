Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6AA683590
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjAaSrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjAaSrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:47:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE674B4A6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:47:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nofyHf5USCnkGALJOuSvgFUb5FzaqeDRqW8RCDJKYGRjysXUYxSZNLb809Xt8HJ2+DWNuYuwAMCgLFy3xnd7oq+wQoAqkdxp6N4oL+eF07na+wYi/XqYhChMTyLu1SDyzuJ093ENYN94Xx5jG1D71BLpc+uzGYy1eo0fFHeV313JP9QkpCVOTClrGW9Me43d3s2EbuPIRw/jyCsQap/sNylHGPpCgPTJzmYoOqX7f4t/9y7vPH24nwZ9yzJ/RaNuY1f6HfW6Rd/k8ohGYfH1DPg9/SQBzC1rfpQgolBlZNslMMKhHabMdX0kbPXvYc8jtKIX8hY7eFa85N/vX58miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtTA9PwUwiy3U/Dloa2J49BaxS2dkptgUr+JvrRziMg=;
 b=KSizRSBe5+c6ucIGMyIgcyUZbM9kGh5QUDRjbwujWfghKjGsLjs6u5C+uHzrBXL6Xm3rU78ZgKwVBeQG0RdNmzc+PfcJLQ/ZXMxW0gY5/2LQNy8rcrLJP5f5C+fYUtNONK2xkpN8XRq1TO0xAw+g5FzJdYYAcuXxOerwUs1Tk/AcARX9j2x1PxQY9a/Lkz1tlwv7tSVUOAa8BeFOCPuwhB1ko1jqfuvHPcJWzY7962OIneKXVNRNxhN0KqxaMVwkE5Q7RoqbgHjR0mbc/MeT/QdMSIJ1aPok2v4hNo8E2fNNsmvQbRP0gg6KPm/kgcE+wy27eW7SO9KRioNLGcMGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtTA9PwUwiy3U/Dloa2J49BaxS2dkptgUr+JvrRziMg=;
 b=UUcBpi9yFDF/R8YIgYDR7Rl5Iv+x3XyTJAdZN2F2we4Qs+iqfz9reoGO9eIsVXVsMhuOjV9/fxyVerX1tjf44/tG9Mgr19rjv1SY42oUDDlog4qwHs4LfULcYUEGRDJ4wciQyd4B7vNy9br4kHWvskvCyWTzL4lbKLoMNIN8deM=
Received: from BL0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:91::21)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 18:47:10 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::7d) by BL0PR05CA0011.outlook.office365.com
 (2603:10b6:208:91::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21 via Frontend
 Transport; Tue, 31 Jan 2023 18:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Tue, 31 Jan 2023 18:47:10 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:47:08 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH v3 3/6] ASoC: amd: renoir: Adjust the gain for PDM DMIC
Date:   Tue, 31 Jan 2023 12:46:49 -0600
Message-ID: <20230131184653.10216-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131184653.10216-1-mario.limonciello@amd.com>
References: <20230131184653.10216-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9adc26-c6f8-4066-f61d-08db03bb8f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYoIZVCYmkcBCE6qpf+E/Jqe8jB8Dvpmo1zxeVlXIwygl/mn9obPLzTEJpfx9G1GocysZI0Y9qf+H9Oo6YSM2rzq8Jairc4ZGflJgGbQl3mksLqFJxvQ+Vk7/Shb6EicupKS9y/uZ92B5bi8oZaSYIWIHno4/kN0nITTAVwnDpURpXQ03TKCUfoRQcgzh3NVTnbfOVqIv5SOgSZ+zd4nLSI10PKbeOJ3H4oMk5ToU0UQlJy2UAmqwqCZqNnhQOiJ9i34aNhvRMsD25CmS+KJScf9yYGPunzgX6n9hFdYFp6fU+EN66686OvqcA4wQXMppJj0rgG4bWHnYlWveeLN/5cIldm9i68GdVn5rruUS9D3MgtID0Ot6aBuofHHInTVPf0zntIcxuK6uE5cIwwncdYInbsEZNusUkDoZXjKzm3cuRf8h/O3PLeYZz7Wh7iLRoQu6kEQdvrjj6ad4VvALeKvDuVC9zkJ9hFbbaH1g6y7vUxKeerDHlHICF1dtKEKmKd08Wd/Y1Fh/hlGcJOZ5BSC/zw5ids87POyGpQqsEdxqImZEujTtxr+WEFebpezKAmXPiUWRtPkXwuBFOuqy7ZjWpnce1jliDx8HWMvTxDuvQSL46RMa97y/gPP3LV3dgAw086/sXA9CWSv3NbtwMZZw3ddxZquHJ4ycu+w1jDj5vnMIRjYm6iYkTA16/wwc80XbhgNV7UTahwm+mkeKtA3I+L/bsCKb71rGsBOw7Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(6666004)(1076003)(186003)(26005)(4326008)(478600001)(16526019)(8676002)(70586007)(70206006)(7696005)(336012)(2616005)(47076005)(41300700001)(426003)(83380400001)(2906002)(40460700003)(82740400003)(8936002)(86362001)(36860700001)(81166007)(82310400005)(36756003)(40480700001)(356005)(4744005)(44832011)(316002)(5660300002)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:47:10.0278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9adc26-c6f8-4066-f61d-08db03bb8f48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A similar issue that was reported on Rembrandt based laptops with
low DMIC volume is also being reported for Barcelo based laptops
that use renoir acp3x.

Increase the PDM gain to overcome this problem.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/renoir/rn_acp3x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/renoir/rn_acp3x.h b/sound/soc/amd/renoir/rn_acp3x.h
index ca586603d7203..c174f84650d24 100644
--- a/sound/soc/amd/renoir/rn_acp3x.h
+++ b/sound/soc/amd/renoir/rn_acp3x.h
@@ -34,7 +34,7 @@
 #define ACP_ERROR_STAT 29
 #define PDM_DECIMATION_FACTOR 0x2
 #define ACP_PDM_CLK_FREQ_MASK 0x07
-#define ACP_WOV_MISC_CTRL_MASK 0x10
+#define ACP_WOV_MISC_CTRL_MASK 0x18
 #define ACP_PDM_ENABLE 0x01
 #define ACP_PDM_DISABLE 0x00
 #define ACP_PDM_DMA_EN_STATUS 0x02
-- 
2.34.1

