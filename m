Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0296ADD5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCGLay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCGLap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:30:45 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBEC567B0;
        Tue,  7 Mar 2023 03:30:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ago1p5S2Zi7U/v3X+MOaxC7hhqq58JVQ5IjLBGnnXPQMigLmxM37O5tdRvY9K69INv25zvYJgkio0Jp6yN+LPgjeAr63UEjtc3bKKFvTNWZOMu1TdwRXoTtzPHqewLoTmVrNzoQu6bq4K/s2qu/N68J8skpHqIrZphsjt7OPEioLkM1qAgvLzukE6juxa+fPK2DQQScoD2i8LUHk9WzgjYVhxuL8XRXR5jdR8I99WIEg9kowP8Y8k+S8CJ3aamf/sL0puhT77NRGr0RGAE8pWeACcuros/m1ZqDTLoE1baJ/uCufbc6EugGGFwauIbleqWbMAKzRnECkTspLF9DxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6K56Vtva2K4+MI78IjTL4CHbuBG3tnEi6JeH3Niey0=;
 b=DhuaRyJyabZAKq9Cvd7nXc+UCZKWAPeqsTcRMdqtPt5/1/j9EzdbS98tDlvyUldHlHY14qYNgkVsAcirvNeSi2lTVdAvx0eCFR1lD0JXkfiz+M/PRwQngBaTGx11xMUsojGIcxN0XkwC4Xvg0PwNn48ZqJ27xVB14q/e5ogWHRQKIBjqiS4MqFM+TMXS1n2CvYpRXt6mm0dNQsVg13nMpl9J/OxW0nnNprjozRIonPYeKBwvT4rtY4fk0mJ4SPMlz8/uen3YfBmvENnDnVeKK7lsaLAz0G2U/YR6g8ZP7zmsXFH8H1jNTxWGgyx0WO3LbWg0PtsqV+eIExML0pC9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6K56Vtva2K4+MI78IjTL4CHbuBG3tnEi6JeH3Niey0=;
 b=5d8sZaTzTYF3rNUP5eiB+zBNfiCQMttMa/IqwpgHpS6HtSNAjCei29bj6ofhGfpeX6jvoPxNPKOxVBAe4+tUrYuYexFmFOgIfbedi3eIE1XCU7fx2IdRITystMlirGkhFtmOQUokSF6f/Fg0+63D4926MOnInFs/+WZb+A5xl1Y=
Received: from MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 11:29:36 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::80) by MW4PR03CA0134.outlook.office365.com
 (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 11:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 11:29:36 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:29:30 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Tor Vic <torvic9@mailbox.org>,
        Russell Haley <yumpusamongus@gmail.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH v8 3/6] Documentation: cpufreq: amd-pstate: Move amd_pstate param to alphabetical order
Date:   Tue, 7 Mar 2023 11:27:37 +0000
Message-ID: <20230307112740.132338-4-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307112740.132338-1-wyes.karny@amd.com>
References: <20230307112740.132338-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3369cc-bad3-42b0-2467-08db1eff3b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rblhgAAoP3d5cC4BzXKUMnX8GHBfRtifH/4udRFaUwJcsQeqPaxbcDiu1QsZfRAnizcXZrO68az7UB7QnvypPVAA03U8LJSO7LVA5MxgzKvSclox6/1GAzVgOnb8HVzwY8hRsSM+IlAlEalIts/KyC4pVOdWMoJS9sLkbJjU6hXdagDgZc0GCfcmBfzD0etPWVYhxODeVHNK/RFAaOpBYTWAaijPMkmshfpEgCD3yG6hVZzytNDx3wHPQeiCfh4OhoB7gQOLew5JbsmjSOMI7CU7V8CioKbWs8s7084H5AimB2KdtTnvMoQRpRfIoGgWQnmOjuiJ3DaZ0JHOMd/js1quztNkWgU3u08wUo8zEf0K1oCZMEpiLfI0vXXMo/gjqW0n8MRlQVU/fQqr7Lxuy3tesCNZiMCexyssqn6xdBCmFeH/KkBigoR/OP3/xfhuCslP9+FmNcvJOEpTdFgjCTDC7WzWmNGXwFwiYrI1d+8px9h4eNbnzrjwYrBflgg7fQGc1HyEH59gfKat32ddfBxBrDJnGeBvkF+lDz+0O58Zh0Sz4HP73rtNowYyH/ROVzCVD6Io3rbEHpg7E77PATAZGiuoAkJKJqGPgD/JQf2NWsuzvJ+Ik/+RkqiqyNHGKEpJz/IlnUTqxZE331YI9LUL5ue40hyPs1tfR36t4BVCwGzWKkq+39PDxo4Ws6X7WpjItbtARMIlMFdKEX2t+q1lq1nYdZ9YHyNbcotSuog=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(81166007)(36860700001)(86362001)(356005)(36756003)(5660300002)(2906002)(70206006)(4326008)(70586007)(8936002)(40480700001)(7416002)(44832011)(8676002)(41300700001)(82310400005)(186003)(2616005)(40460700003)(47076005)(83380400001)(16526019)(336012)(426003)(54906003)(110136005)(6636002)(316002)(26005)(1076003)(7696005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 11:29:36.7142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3369cc-bad3-42b0-2467-08db1eff3b9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move amd_pstate command line param description to correct alphabetical
order.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..1e38f3ae0e62 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -339,6 +339,24 @@
 			             This mode requires kvm-amd.avic=1.
 			             (Default when IOMMU HW support is present.)
 
+	amd_pstate=	[X86]
+			disable
+			  Do not enable amd_pstate as the default
+			  scaling driver for the supported processors
+			passive
+			  Use amd_pstate as a scaling driver, driver requests a
+			  desired performance on this abstract scale and the power
+			  management firmware translates the requests into actual
+			  hardware states (core frequency, data fabric and memory
+			  clocks etc.)
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
@@ -7059,20 +7077,3 @@
 				xmon commands.
 			off	xmon is disabled.
 
-	amd_pstate=	[X86]
-			disable
-			  Do not enable amd_pstate as the default
-			  scaling driver for the supported processors
-			passive
-			  Use amd_pstate as a scaling driver, driver requests a
-			  desired performance on this abstract scale and the power
-			  management firmware translates the requests into actual
-			  hardware states (core frequency, data fabric and memory
-			  clocks etc.)
-			active
-			  Use amd_pstate_epp driver instance as the scaling driver,
-			  driver provides a hint to the hardware if software wants
-			  to bias toward performance (0x0) or energy efficiency (0xff)
-			  to the CPPC firmware. then CPPC power algorithm will
-			  calculate the runtime workload and adjust the realtime cores
-			  frequency.
-- 
2.34.1

