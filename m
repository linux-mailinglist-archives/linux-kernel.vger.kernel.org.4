Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258D8675DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjATTP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATTPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:15:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8076CA1C;
        Fri, 20 Jan 2023 11:15:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1A09uIufpfpFlIAuTIUnk9CKKItP7Q3QH3PBijpTc50biTdg3RgaYD1qMBE5oLCWu0Q9WqIdymg0kwbZJ48lrcSveVDwNPbAtWIZjHXZj6v36typ8tpwrsNH5I2eAkLIVVaH/cjSdw10y7VABiREaTG+ZSfpJgcaF/LbiG3jTua7hHIO5f97TZGSl8wZgdvHAxssa6qxHz5GCIvIR5Ag2LDavTWMyKQHp9Uj+sd97wZIlrDmGwm+ACaPheqNo2D7JdbyL/kTDnC2EJuaJeX8ctYzHWx7MqlPAPp5DbKA7xTNQucPT66rSzUgU/Knq9SYmVd/exIEk884vUV0dE4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C7PIzKmN+13SGyyZ51BjYoRkF4RjZPpqLFfrREbUIc=;
 b=e9pPK6oRQa+n0xNysKdE7MN6/JQ2nNdPRjfzVqFf9V8yV5Qw+/4kD9dyXCxrLEdaaMTVLp7ipbI2JiWceB+5n1LxsX+Y9A96xka50V4kxbAYRW8g0UfIkSKknBfv+cU7riZLxDknl/GBydq6i/aV4ZSg/nN/IhCNPlWR9XKuElxxTBOjsc73MMVgdKYsgi1GhSUGD7dD1MCLdtnNiHMedpUsY+c4MUfX2Xa304sTnkBizLsJoIVF63BowcXLkieRNRvHoqoPsyrduGXXRL1YG41SNwXtCtoAVyKMuY6PSNq63tl6OEBJbx0RWIpt/N9VpK2pmW8Mr/ngYIWNdIxs2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C7PIzKmN+13SGyyZ51BjYoRkF4RjZPpqLFfrREbUIc=;
 b=C9ljAYO589oO8pFottauqfeFxRrQdy1q0MoF88LCpRcc/jdZHi5eVpnH1XUsTxtcd9pln04oNbq9BFIV5ZBsRv14lFG4n5DLGLlGtLqDbm5hIjZRYcNx00k63ORv8O2U/EKq9XoLbpjBcnu5Q4YxRehIu57YahTFVKpfMdAQ3ZE=
Received: from MW4P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::25)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 20 Jan
 2023 19:15:20 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::bc) by MW4P222CA0020.outlook.office365.com
 (2603:10b6:303:114::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 19:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 19:15:19 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 13:15:17 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <kai.heng.feng@canonical.com>, <xaver.hugl@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] platform/x86/amd: pmc: Add a module parameter to disable workarounds
Date:   Fri, 20 Jan 2023 13:15:19 -0600
Message-ID: <20230120191519.15926-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120191519.15926-1-mario.limonciello@amd.com>
References: <20230120191519.15926-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe6b387-6630-45ff-7ce3-08dafb1aabf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3ZIBH3+MuIZ4nTAZKqkNAVjaRugG8bGL043YNB8zxdczp/TWaHrszUm0KcRKN2A44dxGzYualWLYGo+NGH0/BfEsTRpqTEEDHrXQSgoR2uQNg4FUkh4imscv0P9KZ185uE6WLjYm4SCk0P/sT1GrFsZzLFEn4LAPijLwFXCK6/mz15aoZ5QVmW4df3BxQ58Rp3wBO74P2BZeYbyPzS+F3auFjHwEVjzSd29S3rp3z1PhojOjDqlRP5Q6JoRgFy4dxgxfMV5RaXV/vD4vlPCSD8FQ1H0cn584G4eERn8rKqoeJw30HdpLSFtpQlD45vDf/qVdHShpbd4S4THjns1DdjPAHrGmkCcObXnf359GegvA6Sjb5/QgtTYRSwzBMMP4bSH83k2AN9oEAkfI+u8TWiMxzStIAswU4P9iVw/hMhri+QUxz6jLK0b/2gIr/IIJVhh77yFqUxD8lygKz9v0MahLKAI+8M1QjivLp97PSAxNnDsqEhoXaRJNYIEYApkPLc1bZpxqv6GOfYz0h2h5DUXGgCrMdV/raF6SH3NFJXbPXsHf312tx41NdW2pvHpr23YjMRzRfrV8ih/5pYLBj8m8myyhu34QDzW5MCIF1KDOpfczyjpHyn9azBwl7WHtPBS5PQCER53Z3VDsvsU+3aFcJCS0d/m3h4PN0RFEc2bOYvcFjFBOwekSPDTsX02vGw5SvY0kEra9SSZB7wihavT89FUMaAFStK2WF6VdLA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(81166007)(26005)(44832011)(356005)(5660300002)(41300700001)(8936002)(6862004)(82740400003)(40460700003)(36860700001)(36756003)(6636002)(37006003)(54906003)(7696005)(186003)(83380400001)(86362001)(16526019)(478600001)(316002)(8676002)(70206006)(2906002)(4326008)(82310400005)(70586007)(2616005)(426003)(40480700001)(47076005)(336012)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 19:15:19.7170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe6b387-6630-45ff-7ce3-08dafb1aabf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users may want to live with the bugs that exist in platform
firmware and have workarounds in AMD PMC driver.

To allow them to bypass these workarounds, introduce a module
parameter.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index be1b49824edbd..3cbb01ec10e32 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -161,6 +161,10 @@ static bool enable_stb;
 module_param(enable_stb, bool, 0644);
 MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
 
+static bool disable_workarounds;
+module_param(disable_workarounds, bool, 0644);
+MODULE_PARM_DESC(disable_workarounds, "Disable workarounds for platform bugs");
+
 static struct amd_pmc_dev pmc;
 static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret);
 static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
@@ -743,8 +747,8 @@ static void amd_pmc_s2idle_prepare(void)
 	/* Reset and Start SMU logging - to monitor the s0i3 stats */
 	amd_pmc_setup_smu_logging(pdev);
 
-	/* Activate CZN specific RTC functionality */
-	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
+	/* Activate CZN specific platform bug workarounds */
+	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
 		rc = amd_pmc_verify_czn_rtc(pdev, &arg);
 		if (rc) {
 			dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
@@ -815,7 +819,7 @@ static int __maybe_unused amd_pmc_suspend_handler(struct device *dev)
 {
 	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
 
-	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
+	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
 		int rc = amd_pmc_czn_wa_irq1(pdev);
 
 		if (rc) {
-- 
2.34.1

