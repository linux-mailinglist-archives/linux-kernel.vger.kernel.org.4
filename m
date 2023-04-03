Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72386D5357
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjDCVTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjDCVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:18:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737783AA0;
        Mon,  3 Apr 2023 14:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOHosssfIs/wAEMb+XJ8sBacp4tEwJzsS67tzIo1YrGCTMrpuaaU1YYRDTLZejThAlmwAhjPHh69l5t36PRzVHcDq9w2XiFwoWTGM7Tz5rkB80XWdGikMGDcwaWkmIidBvSD7rixc2EIBmvkryqY88qx5sBNRqzbDYSCncDi4HfmOC0v6rOsF6LmsMS84G6WEbTSG3MaPGnzQV891uxYsXJ0x5zKKLTWMfO/VqSn78atCFYpIg1ciMVgntu2JUkF5HRXGAU0HBqnhPbqllzFioNnyhf1XjYlvzw9gHh+Aiw9/nA/07voik2oorFvvDiin5Kc67+M2GJycijnTkqnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaarnB3Al5XNIfHeX1L9mcdX+Pz0wZHei+uhYR7bzBY=;
 b=cmW+rga+Cx/89bZtyw+AciYz/CPCZKUwxZCfnw8zaci2DzDjHWBr8Mf6mE6CdHLupoj9Qq+nCqDvc0b34n1jcbmvypoHPrbBkeqY/FotIzvitaqnghEyS6aTCA3GB2C9KrGidKrI7Gg3FyWOI+jt6n27j26MwJ0JEyd3c16lIq9gvQRM9iHTX+zmThck0aPHHZ5X2GombT4mjnFC7Ev3bPfsnTG5Ya9rl3os68+EXSzCVnuK0jSuyoRFouA0VRsy47YbBWLTOXvqAP1dHRBMMullu5HZE1+0sceE/4Wa2gad3EcsYcBHyrTZy3i8H/h8H1QoFrX1vWhs2nwPs79bPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaarnB3Al5XNIfHeX1L9mcdX+Pz0wZHei+uhYR7bzBY=;
 b=nvej99YP5GyApAAGuLRZ6TucTEH95cGIDHZBAqf2/IrlVBOhgKfa4QJ3pLToUB2aT1bC5XLUDngg0iVHbo4B2OC0OWR3HyINLaoJ8Hn8IawXD+pb91h+dJ0bq6R44LO87nKOzTbs8G9ry3oHjzzXQC7chQ+oxhkHg4xwdJir2vM=
Received: from BLAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:32b::17)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 21:18:52 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::58) by BLAPR03CA0012.outlook.office365.com
 (2603:10b6:208:32b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 21:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 3 Apr 2023 21:18:52 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 16:18:50 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
CC:     Raul Rangel <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        "S-k Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v6 4/4] platform/x86/intel/pmc: core: Report duration of time in HW sleep state
Date:   Mon, 3 Apr 2023 16:18:30 -0500
Message-ID: <20230403211831.4010-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403211831.4010-1-mario.limonciello@amd.com>
References: <20230403211831.4010-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|MN2PR12MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 17177358-c525-4ffd-7b25-08db34890668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5pRxkAXxzckmRkk5Gqw83Gf6I294yfiYvjiugS6vy7w5eUKicfiGF6RxNDzaBUoaQvunXYYl8SkIm9gAmQO3p/zzZhnrvs5Itvi2YHtRZ0vMTtzMHJjHOMNvziAr9IaqS/MrVHhnpwHn0/zF2SmRXTAeOh7JjmvviqHY7sEEw8A7D+Zy33MC8AFVRXtS0XzWBy27U+l/DdboLFt7jedVCbASNtuxiR0Ent9bzqVtUg+1dhyytQIn3ip+9MfKU1wnt1wPmdX0XqDwQGTB69GbmLI70m6b9d61MAB6ccry2FMDtaml8fquRxLeCesEbL+4IOuHM6wEY3T2+9jzLB3Tj3J9JmfmTNKuEebqxWzXaGqiat+S1xvchMaNEKf/wzdqzSe/tp8LtAAf/KQFl3SbIVZU6S6+7tppvuHbuUwAOJJMmZdvo8JfKbisoZ2iyuEeXSibeafSCNZsKRI9qcsXD6xfnX+G3tgJcfTkdcx3jJWhCFQZAlgDFZHL4t+zLfNpuaVcYU3wZ8blWwtkXjUo6lJ/n8M8cCYJgIa526AHqRWoWNEMjVollGQo1EoWnCKDAVA6L2/PcnZ1KHkkzDK2ZlywRTa4BFgjrUtsdOU3suo8g8z4DdzdaFp0P1QId3CKqGmASpME+23LYX+EZsDI+NhORvRoYBK2e3oCX3ic+GaUeQlrEwpKhkVsfdF8WhAl5y5uQMGIZOIb5o/yAagGAjLpv5qZK722HQhGYzpW1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(36860700001)(316002)(4326008)(8676002)(70586007)(70206006)(478600001)(110136005)(8936002)(54906003)(41300700001)(356005)(82740400003)(81166007)(44832011)(5660300002)(7416002)(426003)(186003)(47076005)(83380400001)(16526019)(2616005)(336012)(6666004)(26005)(1076003)(86362001)(36756003)(2906002)(82310400005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 21:18:52.5262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17177358-c525-4ffd-7b25-08db34890668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_pmc_core displays a warning when the module parameter
`warn_on_s0ix_failures` is set and a suspend didn't get to a HW sleep
state.

Report this to the standard kernel reporting infrastructure so that
userspace software can query after the suspend cycle is done.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Handle overflow case
 * Use renamed symbol
v4->v5:
 * Reword commit message
---
 drivers/platform/x86/intel/pmc/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 925c5d676a43..0621756792c8 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1214,6 +1214,11 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 	if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
 		return false;
 
+	if (s0ix_counter >= pmcdev->s0ix_counter)
+		pm_report_hw_sleep_time(s0ix_counter - pmcdev->s0ix_counter);
+	else
+		pm_report_hw_sleep_time(U64_MAX);
+
 	if (s0ix_counter == pmcdev->s0ix_counter)
 		return true;
 
-- 
2.34.1

