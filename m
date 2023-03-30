Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F4E6D0F34
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjC3Tpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjC3TpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:45:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6414D35A2;
        Thu, 30 Mar 2023 12:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUK39n+vS0TogruOQ029/zCCL5rTdtcoHWobrxYsD+Q2EP2ZJBWQSOHrgEl6ZSYHPAO15w0RMrXpk0veFzVizwSSzWeNSCwI5V/jHiaaEuU+ePGplmvPtbqXInkdIChvQ/VibbYZkVWxmXJnLa3Uafk/0EIr7ufO4CCDawxfj7OwmXFA9A1M/IVnoJoIn0ftQo6CdxO3mKWnDdlzdg9T9VYoWonIfRQ/YeYW6awS0x9y5b0kkbWyXXa9w1syMFzOOGPY1kgb8A/mMTV476iEdzJzxyaT98baYoNcZichr/EGSzmL1sRrH/ms1v2TJ25Yex+QXhCevl1TO52TvDpMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48VBBlsJaOLW4Za4yzTcA3Cj70ceCfytneOmalDrPiI=;
 b=RKalaWKfV8JR/7tBnb5UeJLwSvQdgPDFQbS4w2t+ZSWXKvCd/uh63Nj4JexXkkRRJ+ONL70E1WSLwCSA0Pg3y7hai+OILTPNVfI1eJf6AeeDC+aixYdQLMOsitJp0J5RDVOshDVlFC8Z0IYoErBXQOs30MvWVBW+7eJjKFT2/NcSxa8Vm8tb5SnzzSLZhceYpCf6cL2KfQwITZKl2msyDf7OBvmHKvAXQycTfsAgkq4qsFfUrZMUAI87ZfufSG4L66if3LoXDkPUF6jeJ7d0NY5fh1OhSVgNJ2C2jGKzRzsoOtRKgUfO271xJh7Kg2MJ8WLw6wJEoS7DfnxQui7MLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48VBBlsJaOLW4Za4yzTcA3Cj70ceCfytneOmalDrPiI=;
 b=XxsGsW7x6GQT4w4tmsqjcV2zazhoM4+x8T/PJHd3oZ1ULM7bHAyTp8MXRzq/XkX3A6OHVdjB44Cr1agExDZ6ZFbVPmJy37/lEJxUEqQQ0MVbD/msu2k7WlamHb7RLlEu6HddpiDLREFbsG5Zuito7nLC/30XQEt7C2YpZKbh7oQ=
Received: from DM6PR01CA0009.prod.exchangelabs.com (2603:10b6:5:296::14) by
 CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Thu, 30 Mar 2023 19:45:00 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::8e) by DM6PR01CA0009.outlook.office365.com
 (2603:10b6:5:296::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:45:00 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:44:58 -0500
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
Subject: [PATCH v5 4/4] platform/x86/intel/pmc: core: Report duration of time in HW sleep state
Date:   Thu, 30 Mar 2023 14:44:38 -0500
Message-ID: <20230330194439.14361-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330194439.14361-1-mario.limonciello@amd.com>
References: <20230330194439.14361-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e04aa07-4b1b-4c15-2061-08db31573fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HddhdI0XtScSeuDIuGvKaJqKpfeFJ0dYGnvuTGp/HbysjETNvcYuv8WvO5uLDhOds5dCnXiSfoDit6HbOvfofxtkvgWbysJRrkGHveE9LT9RVv/gDK7vH7nOyAYssnjRekxJrSj9aXcEXCpDVHTAYZdbN/gfNmyuGqB2jKS0dckcDErmi5MZ0hipmJIA8gFJ94VCQECgHWXSlUoZJBZRtKxzlHakr44jIQr6aQS67FAMGsl3eIRcLVK3NOrjR9rPJ8s7btv+jn5MKzCMMMdzo76oLPV3u1xH6o9+qeaiP15LlJn4FL8z2sMZSOIMsTiorLuFjtJF8JP+Eta1els9ZHouZVT36bVBho525/31gZOnXOOuXJxMcVWPw7Xy7BbhHsm9xMpjCtYfNuihWDYX9m+/5xBpbhVwhbzIOh/TZwNY5trm4d5HwnmYaVNPcCvVTxVNP0WlVlxxES0R9i/1QuDqubsVCdFzsHb0gGBUrCeON2Jgm/LLWeV7mx61IChs2iIcnB9eiIHqwHfzKtdB9OG3HFwEYvU1LhN9kWI8RPUXO2pjsdZruDu3NJFnvxfzeS5KXZa05LyE1CZp5+9ZbwFY617FqcTGKMB4RBL7WwUxMMHZFQzn7JIjFdxpOnDpRy3W+UFCesSeT+xq+FwFvFfqRsvuKxihgX+aAoFZgfSDN+b/ZZ8zQA8nz4KX9k1Rnvtf91/5GPnmGYxWyU/vLp5kkW/2BjalG0QqdLsnHoI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(36860700001)(316002)(110136005)(41300700001)(70586007)(8676002)(336012)(86362001)(54906003)(82310400005)(4326008)(478600001)(26005)(16526019)(70206006)(186003)(81166007)(8936002)(7416002)(1076003)(4744005)(44832011)(83380400001)(82740400003)(5660300002)(7696005)(2616005)(356005)(2906002)(40480700001)(47076005)(6666004)(40460700003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:45:00.6106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e04aa07-4b1b-4c15-2061-08db31573fe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
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
v4->v5:
 * Reword commit message
---
 drivers/platform/x86/intel/pmc/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e2f171fac094..980af32dd48a 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1203,6 +1203,8 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 	if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
 		return false;
 
+	pm_set_hw_sleep_time(s0ix_counter - pmcdev->s0ix_counter);
+
 	if (s0ix_counter == pmcdev->s0ix_counter)
 		return true;
 
-- 
2.34.1

