Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52E56206D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiKHCeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiKHCdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:33:42 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AAF1EC68;
        Mon,  7 Nov 2022 18:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3jreRAaxG20g+E6gltzUFMTDX3lJBv2zm8dHEvNny3g8bCh1kxKk+yRmG8t7IbNGmVGS3//xuP2FOGWe8mihHzETv1OvkaxhybP60QKHnQ+zmX4WnA/6MiJBK5S88L7lsT0l4Vvhuu4Bl2ahZwB0lBjLPFt4jTc7akpWsZJgtOGKv9INIP3yHh0YEWbfsXykSQY5kM/osPSCAXC/21bNNJ6AYPEFyS8XhtPt0qClSBYqHmyI9aGggUA6oqEjSHfFxOREbMRXrkpqszEn3654NZQa048NrVKYX+1Dk4I7iKrLPrFd1y6aIoBL4Kl/TLCqXeG8MVAQecsT6QhewYyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvZbJ4D1WYhOXCI2zk+vyNTUjFP2Q8B5UwUaSkfl8WE=;
 b=mX21IB4YR2IlNOh7wvzRWFivjd/dcwcbOM07sQez/dAzdL5ziQo8Gg68n4BLoVxSw9cGckXjMTxuMpsELl+vcTGBUdrFday+6Pz6rALmbZ20nihocWovDBW1WDku+37vvGt7tRE6JIrJu6W/D2TTDVx2kiW4OPxhXPQa21s8zQx81fudIDb9b83Mvs9j7bFUyV+7UCx/6e0M8JxGA2zw4wR6Ist8EtNKCj2W8cEQw8RnrC7pKbKq6cfInV99ZogbE6RvjxTOcIiaJ5vRRHnQHTRrL7tcyt9TzVAPfQ7+R8mDpZxcU8ZFyBHrFHRMlepkFRbrKr2nqt+SGSS5WecNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvZbJ4D1WYhOXCI2zk+vyNTUjFP2Q8B5UwUaSkfl8WE=;
 b=CsYcmAQwoq+uo07DLbeGMyJOsVfqlqCIXef9ceQUPlKhx/MLFtchtMpmsebEAsHr2fl2/rqzFNSdP/aBehyGs+ly4tI0Td/6pWGT1kUBh0vxMEzsv31z+oss4VvsE6ZdNS2oIKvpNRw0j1tjobOhfbnAA6olCckp98UMnzI5Buw=
Received: from DS7PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:3bb::35)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 02:33:39 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::70) by DS7PR03CA0090.outlook.office365.com
 (2603:10b6:5:3bb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Tue, 8 Nov 2022 02:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 02:33:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 20:33:37 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <liyupeng@zbhlos.com>, Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] platform/x86/amd: pmc: Remove more CONFIG_DEBUG_FS checks
Date:   Mon, 7 Nov 2022 20:33:23 -0600
Message-ID: <20221108023323.19304-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2c5906-4e93-4191-b635-08dac131a4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jm5nlrjbfRF92CgwBfCUx2CK+giEeoGKPc7ebdx1texdordnl/byETuJWA0hjmZBCG2hTQszAEoQAwQNHWatmJvnZMr53rjOl7Gxm62zzXKB2ipnzrlWL1AUw+lAcDbNOiqR+Z9ZPH03gD0REZoTy0YvVgD/PP+SKksWAt8tjqM+64RV6npVcG6VYVHBseI0mke306ebZ32XuMQe5J+ZhI/7csZSJ+4uW55+SiFkOEa0t2Vq0wI0O5hh/SnPdNug4Dtv6PY4vtJxYgIH4jxaqL8rdi8EUw/Grg09E857qm5CIPZNhoTP84ZihPxDzJYIm3MJar2g/WvvFYzGkQDH1Fez09iZdl2jmrW4dQ0NitgZfy+ccp4mo5V+zkpknQxIkKqlLQ2VjsYVepuPvvnYjqHMFdQ3F9di7I3xNo9WMgpqj0AfdaTwc4OgoP3VH3aUbjHo57p47G+xkpHOZgFYNQnUk0TRIILctReEbo2IeAa3OhtdUu9FYCu2Nc35U7E1zQvRWE/6M7smS5Ph91JSXgybS4k4iiSzvoltgVilzqbwJrLgwV7Jm0oEz1oiVKqFE7Cp+MwxMhI/wbKea1ZIWr+5/ApH68rY6sOsz/NHBy9CiEr2X8tvHy7rSZvSyhP71Npk0H86TQ2iG4YmttSerPnvdCBt0JjVkRrwx4XCMmm8VFwLzoBcSVHZDo6L5Og1h9l9Qfxd7E3bKnESu3JzUvsRZBZdyUDZZqi4LurDL3UyR5l7HpaoOzDUdCceVUkw/A8KrNFMpGPBkkHRspKygEu8Me3IaM/wWcR5IoxXDuDhN8pBdM9M56mqVH11cH0F
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(4326008)(36860700001)(70586007)(8676002)(70206006)(54906003)(316002)(356005)(110136005)(44832011)(40480700001)(41300700001)(7696005)(82740400003)(8936002)(6666004)(5660300002)(186003)(83380400001)(336012)(40460700003)(1076003)(26005)(16526019)(426003)(2616005)(478600001)(86362001)(2906002)(81166007)(47076005)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:33:38.7937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2c5906-4e93-4191-b635-08dac131a4cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b37fe34c8309 ("platform/x86/amd: pmc: remove CONFIG_DEBUG_FS
checks") removed most CONFIG_DEBUG_FS checks, but there were some
left that were reported to cause compile test failures.

Remove the remaining checks, and also the unnecessary CONFIG_SUSPEND
used in the same place.

Reported-by: liyupeng@zbhlos.com
Fixes: b37fe34c8309 ("platform/x86/amd: pmc: remove CONFIG_DEBUG_FS checks")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 96e790e639a2..3b44f2fff5be 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -276,7 +276,6 @@ static const struct file_operations amd_pmc_stb_debugfs_fops_v2 = {
 	.release = amd_pmc_stb_debugfs_release_v2,
 };
 
-#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
 static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev)
 {
 	if (dev->cpu_id == AMD_CPU_ID_PCO) {
@@ -351,7 +350,6 @@ static int get_metrics_table(struct amd_pmc_dev *pdev, struct smu_metrics *table
 	memcpy_fromio(table, pdev->smu_virt_addr, sizeof(struct smu_metrics));
 	return 0;
 }
-#endif /* CONFIG_SUSPEND || CONFIG_DEBUG_FS */
 
 #ifdef CONFIG_SUSPEND
 static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
-- 
2.34.1

