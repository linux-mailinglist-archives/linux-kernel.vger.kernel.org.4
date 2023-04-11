Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5E6DE658
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDKVSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDKVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:18:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5CF55AB;
        Tue, 11 Apr 2023 14:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwuJSw5851IqutOjVW0Err6rXhBn4YIS+n4m5zrdoG8WJy5qq04orJSoETL05NlGUR7RScp2EgFfedL/02Qs14a5ux8tLm/p9SJE+kJeUuJwbantUSG3ha8/uBdj6DOqbm0gY70BgHiIVJG7WOjA5Ekf9E/B+JiKT7IENjbiKCs60GuBHg+b5PA/5ZZY/E6YKVKaynWuTZjQYAXmfxZryGl6JFJgy1tvVS5uRT6AtwWKUfyA7kWroj59b4T6iGfBhaQNnymRA+6ef7sLjomaKiN/s8xwRmWvqJLzgbOfn4LCtAmT9UQE4JdlgOVciyBFXZNfpjSOUYhJAdTe46dKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az9VBPUEfPgiCMU0R0Wd3LcCEUdr533eDxyOpoQ2V9U=;
 b=U1RnuVhqnfieQIOW8rrBWZu6iH5qswRdaUCkvR86/2Y6UJ1/B1cz/vOzPc5hUEYgQ6t4HWP0P/iENh2zyoastCWywRa9PrIbj1t2N8Uwh+AetO2Fi2hpRwMflmejf/q3vmAx0iA7D9EBrzX0FU9sMZSggznu/01T7AV3mmZyIkhwlUAUo+FY8leWDiWQSNnt9Hm3Q5p2WqypDAli1OxzHoHfMHjplXy3yQ1oeek7N87M69qfEbYe5gLTI+IAh3QzTLaXAZqHlwMhw4l4ZzYT+BxZ0x85AdEeyibBiCVQWp4bdCWMs1PK/yL5nDR+PuBucFGQkEQQRMACDIxtmYLkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az9VBPUEfPgiCMU0R0Wd3LcCEUdr533eDxyOpoQ2V9U=;
 b=Ex4w5PxuirIMU2OB96DQLrZ25jllbu1ey+nCKYwCU0itMmTPbV1om9toTA1BeCVdc+bBlJV+aNTemYZH/rbvwd1px+axy64mlWOnz9QWIkrdOcoAlMvw/dmxwTbYvSKiwa3LVYKJW7NDp3gyXO7h1dUWTGXzFRdIFIC2gOcrZWs=
Received: from BN0PR04CA0158.namprd04.prod.outlook.com (2603:10b6:408:eb::13)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 21:17:54 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::e) by BN0PR04CA0158.outlook.office365.com
 (2603:10b6:408:eb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 21:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 21:17:53 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 16:17:52 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/4] platform/x86/intel/pmc: core: Report duration of time in HW sleep state
Date:   Tue, 11 Apr 2023 16:17:18 -0500
Message-ID: <20230411211719.4549-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411211719.4549-1-mario.limonciello@amd.com>
References: <20230411211719.4549-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef83f87-25f8-4f0a-233d-08db3ad23693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cc8VNi4dqMVHfD/U+8rNpojWFMrxJQlN1GjrxgTvdvscOC6insEDZ8bsInA75pVlQ9BCN8XzW/ItMdhQ5jFZBi8dN+aLxMEDZnMLqT2WAdOFXQSO0ihd3YLBTnI8IChbSCQx4ADWbLLORDYd8CcOdXJgfREcGrtoXwjHYZh3dRO7PwoUMXH1+QCmxy0BB2MP1W0ILwkHhx759q9YBwnyBeW9XemdwV/1H/Ehiej3oAYb/5ywd+kY3jBTONnpX+OsLiqBib5J9gBXu813zCZMborDtTGHRzTNmnTwEtofNAtDFvSSiDYDcZNr6WdB7Q+1HuD8GfzG79fDERPRF8XXs5hk+QU0efg+U0mu3+d0ZUvdoVt5YY+YUZFpmws37jcREpdLL1whVEu0smhWq/UNhXNze2gFt9nKsXRJ+kZJQBtzcdbc6/TePcwG8kaN4Jkxo0QOcZVbvcU2orTe4G/zHDXrJ54FJD+ePdt5FG6M7jv1rKnjEkYyCsRgxhijquARg4dYuXGHDRMUZ8a077/1auTusn1+dssbOr3xkuriMjyFJWJ8xZ2Y4mjD97uK03R2PEJrUJV8R0/8Z5MDu6xMbOyFnBYdwRPDrbg21kR0gBLm7hqnXOrvjj8Cfuk76J8ZW8B8WkEKyjsPVuX2WukUeUZtGdHF/rhp1BSsVWRp1WRvMu06dazpb0qdD8jfw5V4YxLEewqlzeb/4j9U7qDFF+TqBfk3WDkOda+OqTTd9r4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(316002)(81166007)(82740400003)(26005)(1076003)(6666004)(7696005)(356005)(83380400001)(36860700001)(47076005)(2616005)(336012)(426003)(186003)(16526019)(8936002)(82310400005)(7416002)(5660300002)(8676002)(36756003)(41300700001)(2906002)(44832011)(110136005)(86362001)(40460700003)(54906003)(40480700001)(478600001)(70586007)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 21:17:53.5744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef83f87-25f8-4f0a-233d-08db3ad23693
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
v6->v7:
 * Handle overflow by casting instead
v5->v6:
 * Handle overflow case
 * Use renamed symbol
v4->v5:
 * Reword commit message
---
 drivers/platform/x86/intel/pmc/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 925c5d676a43..5b1e65876b8d 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1214,6 +1214,8 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 	if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
 		return false;
 
+	pm_report_hw_sleep_time((u32)(s0ix_counter - pmcdev->s0ix_counter));
+
 	if (s0ix_counter == pmcdev->s0ix_counter)
 		return true;
 
-- 
2.34.1

