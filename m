Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29767164C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjARI30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjARI0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:26:05 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D695B5AA;
        Tue, 17 Jan 2023 23:53:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2N0lV6aTmdSAoKZiGvth4IIo8tFq7ALMCyLz5ZTBfNvmozkEUUGFv0WNE3aFooIpOM3KqhBMG+gxrfr7pjVjtVM4aa26k4PqIwXNXaOcsebfQ18VlSkRkhUzklWAemvrWhn+K7U2tg2Hvyh9SZJkB5b2XjLFMUKEevix2nfjw4kTnn1c3FPAcL9kSqDRupQsGkrFvKfdbC5vdj7zHp8ni5Wnvbd4C66A0615jx2NyX/pL2zbxyWHuTYd6OTpSDZhacPMtABZkdzF2nXw26GC3NhBRfYiy1mEuAO+S99UySrYhqUuezN8FguqrY8HYq3YmjN7En8hm8dvaz1fNdPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2GVHcLNR/twzU8JAKREu4Ip77DvURPO2RNl6+bGwDw=;
 b=LK4f1sx6eWnyfViLwV3k7c2X+Zqo1yjLI5e9jpvy7VxU+KdIPGemgPBBWdtztKx0GZyrNiOWGbQ0SEZRawq6n4DJh9719wIpfg+IuvtPDueVxSptJ3ekpLGcaxd7ra1FcJqMkwRQyqdIx4bumrJ8ouYsuoc4aj9hAhEfE9LARVpGnZgnkx48azw2JA2qv4gEpCu9xfmpBAXzTKwthmNvcF3yAm1e18KPn6MZ+j4ox4eWodbSbydWXOWps3RCyBx9W5w2Ep3nx/kQotPThSFAyj3r1rJYnQUORAXXLJRFHEW83WwgMcJsJ0uzdUpbuKIUp1zkRI3XUSBARZR8hY9uMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2GVHcLNR/twzU8JAKREu4Ip77DvURPO2RNl6+bGwDw=;
 b=EbNLhfz6gL9oDRizuRqeTbOTDFMe0dgWO/0hitMbeTQUkFBdJqPiIoIiUf/NExt9q9l39UPZDNq2+qfiF+N9e3EGT4CWuDQc/SVCTklDgqhofeSrBl11DNEJV/YSeREbSDdIF0/6+JU2kFnqFOZA1ZLX9CkIpOMK1KUU/ZuAnhw=
Received: from MW4PR04CA0128.namprd04.prod.outlook.com (2603:10b6:303:84::13)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 07:53:18 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::7e) by MW4PR04CA0128.outlook.office365.com
 (2603:10b6:303:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 07:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 07:53:17 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:53:13 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 09/11] Documentation: introduce amd pstate active mode kernel command line options
Date:   Wed, 18 Jan 2023 15:52:08 +0800
Message-ID: <20230118075210.447418-10-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118075210.447418-1-perry.yuan@amd.com>
References: <20230118075210.447418-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8e90ff-5559-4083-d689-08daf9290fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9azR7B7EWDLBjAirE/t2me130r/lHQXH/ZXNHpG74emI3tlYq9AwNai15dMPk/UcU0jVnf5zbguKccyMykyPacmVtzbtDBIQow8uZHrP2qCjbTtp+zbTvyxf30amhFjDKKpKhTLt3o46eZL7K6XxEX0prZHqUifhTw534HlSfswWxFI2YhJa4DqYJ+WCLqka5MB/ddbaZxMw6SZJg5neCnWyi/l6b7yKsBK/OGP2cAIei7CZm7kSQniMFqJouye5OtJJ8qSUSCCmdLRP1CebZuWU7Du64QpeMfQUVLJaFmj5mNcBK6H/5+Zu1KIW7fDCmL9/icJin7ko7yBQ3jNCkCn//ZqjUBbMcXdm1ZPueq8ZIfC0a5BSxOTE8c9eqMxU17kzm8t8Kf3UcUgXfITzPxcW0gavYMbdb/J8vMPOM3mCVghAN2asldH7QtibJXO+rfykDDjcpShVP8Oc1vbn8KAE874Gqw27T56C90/7Y8H0UtzofMmn819X7N6dxT7mEaE+b727kV+IXNvsCv54849KOtZoOysdM6MNmB/1ZKHFTRG2TLt88H6XBYVtUtwj4r/7yvXMsrbTzcgPXKfMwmLCUg9MQMXnawflKLdMkeBEET5+E95sLmtv2H3LlPmpK+W+Rj9PJFGvClMxCxB8ook7hlYZf25EUBNQ1yjJ3ft1w0AWnY4FWHRWKgTD6kp9PD3wcw2KY+F51f81/s7R3Oc6RC9f3hdUxaNDW6zaXCc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(4326008)(41300700001)(6666004)(8676002)(70586007)(8936002)(70206006)(40460700003)(36860700001)(36756003)(336012)(2906002)(82310400005)(2616005)(44832011)(5660300002)(316002)(54906003)(110136005)(40480700001)(7696005)(86362001)(186003)(478600001)(81166007)(16526019)(26005)(1076003)(356005)(82740400003)(83380400001)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:53:17.5570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8e90ff-5559-4083-d689-08daf9290fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Pstate driver support another firmware based autonomous mode
with "amd_pstate=active" added to the kernel command line.
In autonomous mode SMU firmware decides frequencies at runtime
based on workload utilization, usage in other IPs, infrastructure
limits such as power, thermals and so on.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..e3618dfdb36a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7020,3 +7020,10 @@
 			  management firmware translates the requests into actual
 			  hardware states (core frequency, data fabric and memory
 			  clocks etc.)
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
-- 
2.34.1

