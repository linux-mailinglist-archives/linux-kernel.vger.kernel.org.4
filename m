Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FFA68C4A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBFR0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBFR0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:26:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A72E2CC6C;
        Mon,  6 Feb 2023 09:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgzElGjobOz4ryznXkDqBjNTXw/OPbgnuD4prx8yOb/RAyxgVtHztEftEEFli9UjQcpOYkRznh9qxhTaTkBS+I0rPDtKL1olFPQkpPNhTU3256jIvJWV2lp1DtJZjyo4EmEW6jgmHr6kqUXbA3ZG1Sbl9gEZFmBXqhOjC91GWCBbg/cDnh9H+2L+/BMa2l9bxYyrCsFR5tmaSHy2NmpwZKKtZfImBTaqLKkE8BlEUA8pB4LYO/mMbKuUPrHKEg4zwdndls/0AiAzyMMbyaT0FSwhxr5HGk5RqIwFwVwcSbFELBFR/mq7i/3CJghTyuhZ2/sL80YlHb256kKBRhozRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJhjuqN2cpI9XA5Cy3XLLnCmRSprrL92K3P9WmylBUw=;
 b=R5lZaKFiW2b4pOA43Dhr/fv5NPwLZN0j7CG7M99C5YjwvliMC59llCFbh5wSzJWns4YBBZI7EkTdpYgM1HErIW7cxJNaNRvig1tZze6Oif7m0O6MVKw+//8KtaRYPbqVOmHZRFHkWulWYvGaHu/b8AdZ5zUSshC4STJUzkiu1M4fTU1WJU0xFzxzNtVYqIK9GjJiVTeWn2JwmebzGDCFwBjDH4Jhp+CW4LrEagS6G9uV5O5MAfLtd+mMbMv9lWjwKapmcoKRTBM2yr+PXJYljHAsGGAP0HopsxW0BeSjJVRZCr6Wf+X+9rIUG3xODaiOoCJdAYqPvFbMVOgJymvxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJhjuqN2cpI9XA5Cy3XLLnCmRSprrL92K3P9WmylBUw=;
 b=PObCIR9F89/Fja9hncRHpAJqiOIQnzJPC8Q75PflNMX8BKrnvOw8uKPipiAN2yTIPKksLWwV3gIiXy94Kj+QmDEqrgNjW40zRQLW8hxo0cVjMNDAWKlkVjNlcm/rVeRzRK0T7hGWaHXENmbfaHg/W1dEPaSN9tMXYDq7OKbbs+k=
Received: from DM6PR06CA0093.namprd06.prod.outlook.com (2603:10b6:5:336::26)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 17:24:25 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::64) by DM6PR06CA0093.outlook.office365.com
 (2603:10b6:5:336::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Mon, 6 Feb 2023 17:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Mon, 6 Feb 2023 17:24:25 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 11:24:19 -0600
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
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v6 4/6] Documentation: amd_pstate: Move amd_pstate param to alphabetical order
Date:   Mon, 6 Feb 2023 17:21:55 +0000
Message-ID: <20230206172157.49887-5-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206172157.49887-1-wyes.karny@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff93136-4957-4c96-c86f-08db0866fe6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4K7FAUmofyFjyvHo31LdvgRvru7UOaQWC11XmAnNeyK8c4bLHQ7jqz8aE8yF3P/WA0Av4i+5/gloTVpKgJmPL01MLnJFMwUmrKNVdYc4uAr+dKBcCYarZnbf6hrludI+/Vzn0zmAiVT68iXejfkla0DKqh2NyecbjPMlXcVEu+UbBvwUpj/bZA5AYl88mvO/BMSXyVU22ZU1NJMhg8RdEXUZcmeEZ5L7AagltK2NWrrwokzdcNpCDVaA9nvpwFQMgLAsTgw672vehAPcNmUuarYA6r38Q9I9YnbYPbkXtds/YYjAYedrYyOr0iOs7/7WqjU/cB3reyq6m9t+cyzjoIiIe9IbpuIlU9jDyrcDosGsl8NtX3/8jsyacKFxOVzQ6aLxlIviOKJPyIIYASuA9MUSwhTYTc5GOeJGcrh4spx/YXYunC2b2Wxu7OWXZhoWCO/aM/E0omEROT2cYerMnxOcXxAfzwMD4zjvT1jktkcmOtt5W9RvKkBYDN7Cm2YlRHHBPzo58O6+L6j48CCrkxouNR/DFklYYFv0r5txJWf+gD4wWMNeoXCAxckU4DtvMBlSTz4fWd88k8/u8OdSwcooyQOsbK5BfmuoLJ868Wd9TFHmy0TIohB3K0Z8DmrQxlZiCcmN4IfTv64WaF8T6sH8pmtUsGGCpj253/PB6PjVmuuB9o2HyS5Owb15xQnHtmGLjggqvpHlYepnMehWY1fwtxNU14t8zEKSQ3/RX0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(7416002)(5660300002)(41300700001)(8936002)(2906002)(70586007)(70206006)(8676002)(82310400005)(83380400001)(4326008)(40480700001)(16526019)(1076003)(6666004)(54906003)(36756003)(110136005)(6636002)(40460700003)(478600001)(44832011)(7696005)(186003)(26005)(426003)(86362001)(336012)(2616005)(47076005)(82740400003)(316002)(356005)(81166007)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:24:25.0504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff93136-4957-4c96-c86f-08db0866fe6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move amd_pstate command line param description to correct alphabetical
order.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 56d5c189e458..d7685b4268ba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -339,6 +339,29 @@
 			             This mode requires kvm-amd.avic=1.
 			             (Default when IOMMU HW support is present.)
 
+	amd_pstate=	[X86]
+			disable
+			  Do not enable amd_pstate as the default
+			  scaling driver for the supported processors
+			passive
+			  Use amd_pstate with passive mode as a scaling driver.
+			  In this mode autonomous selection is disabled.
+			  Driver requests a desired performance level and platform
+			  tries to match the same performance level if it is
+			  satisfied by guaranteed performance level.
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
+			guided
+			  Activate guided autonomous mode. Driver requests minimum and
+			  maximum performance level and the platform autonomously
+			  selects a performance level in this range and appropriate
+			  to the current workload.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
@@ -7009,26 +7032,3 @@
 				memory, and other data can't be written using
 				xmon commands.
 			off	xmon is disabled.
-
-	amd_pstate=	[X86]
-			disable
-			  Do not enable amd_pstate as the default
-			  scaling driver for the supported processors
-			passive
-			  Use amd_pstate with passive mode as a scaling driver.
-			  In this mode autonomous selection is disabled.
-			  Driver requests a desired performance level and platform
-			  tries to match the same performance level if it is
-			  satisfied by guaranteed performance level.
-			active
-			  Use amd_pstate_epp driver instance as the scaling driver,
-			  driver provides a hint to the hardware if software wants
-			  to bias toward performance (0x0) or energy efficiency (0xff)
-			  to the CPPC firmware. then CPPC power algorithm will
-			  calculate the runtime workload and adjust the realtime cores
-			  frequency.
-			guided
-			  Activate guided autonomous mode. Driver requests minimum and
-			  maximum performance level and the platform autonomously
-			  selects a performance level in this range and appropriate
-			  to the current workload.
-- 
2.34.1

