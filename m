Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA83E5B3D60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiIIQrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiIIQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:47:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87CF146718;
        Fri,  9 Sep 2022 09:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIH7Bc1oLkiMXxC6a4FG+SKum7MiQnW9uWJIi8QbIvDvMs6ZLiMvTe0w0fOR1lPZ0RcEYm0n55yu3gPiaR57TcVc3e8mrGc1xO6WRjuXzavSzN/jTj/BQoLkm+O+VznIYe95ASmCrvDPU1k+SpY5bOmpPDupoiP+ayeu1EMYT+6BEqWskNYLPQlM0TFg7/GwEZT6KoqVcZK7d2q/Op3RBdxuxYb3HTLMUPv72OQHfkjgrmR3uubtJkwDvwvaP32CD9O45A3gt6yo4AIHntpjqlinBHXpiMnWrrcg1+jPh2DMgIEQuBs2uzZEdUpdredENq8b2aNmy+zHuTXHU6x0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC69undPd9prgDfk2+oDR8hnkoDqMpO/heJpaVlZFMY=;
 b=hJGofMJ/sl9875fn/pXvZ2fJuYU9FSFMbs92wyFjSOlhV5c37YE4IXW2MOjuvFejkKBsC1CWljcI5ArmtLirM4HfGajCW2VB2Z3QdpP9RXRW34ewZK7fnmaugYEyL5FvjRiY7d7itrpv4nxd4WsUhWQrI1/wROjmA/7KpiU7EGi21lLAz3Uq52DLwlFfJyp84MTO9MnYj1ZuQ1RcX9kSbKIXgOV/iyhv3B3Qz0aDvqIWgX2ptYbfV9w+gZcSoLIlLPHkzXlnGTmNkyQcvE6CEV3CPSvaxQdJQi8UutaZyQK7Itq3AJSX3sY+QU0AKAW47fQMZ3XsEELfknBoGPT55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC69undPd9prgDfk2+oDR8hnkoDqMpO/heJpaVlZFMY=;
 b=LMOpu4h2NdOL9OAJ4pRhzNIlpt0tqocGkzSkFhU7wOwuKGem/uhDmelJA6TizaspNYw6BB9WZwfkhezcwJBu9iv0Y6nZj8gYXbj9bOe75hjcbDodB+jqJiHu0HTIPpXN9GISMN614dZ3aRY3DKQI7R3KLRYgPHgYoAs4emG0YoE=
Received: from BN8PR04CA0024.namprd04.prod.outlook.com (2603:10b6:408:70::37)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Fri, 9 Sep
 2022 16:47:12 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::c2) by BN8PR04CA0024.outlook.office365.com
 (2603:10b6:408:70::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 16:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:47:11 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 9 Sep 2022 11:47:07 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 4/7] cpufreq: amd_pstate: add AMD pstate EPP support for shared memory type processor
Date:   Sat, 10 Sep 2022 00:45:31 +0800
Message-ID: <20220909164534.71864-5-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909164534.71864-1-Perry.Yuan@amd.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 4531172b-5706-4f9e-fb9f-08da9282f16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcUD3TzWfmXHdrPmzT6eG3I7HcC+JVZQdEHXcIyQnRKv/eRV4CNWQdF9xRECj1n2c4EnHI3E6J76icC6LPZXQ0hJ2w03o58zYM/HuOlCbjOYiiE12ad/PYbyA1jez7qK7//RPkXLOhb0wF9Uuhf4XNTpGApYAM5RBWXVp5qyLA2UiV6JVSVAkBrn+bsGOoMtU3KhKwbEpR1Saq3YGfpsyNTRVcpa6NPXNzcO6cd3raeMXSN1fjY3dRXWeeyKJ4prmN+BKgkh1zySuQ5YsuSjmud+WE5VG3NB4grzF8u3CrPJAM/+IOFXgbTFBJy/ACAZo5YLhTWt1Nl7lAt9mMtwPqh8EeFJv7sBLUdilehbKewxNAXFHeB3h4gvdaz/Mru4Xaicyn9do5Egb5czGsCAtuQQgdZ+Hn6MztU6xR3t7Fq9OEESCQ0pZ/QYSx8dW4tVYLiTI9HQwd7wnX4IJ6yWeXa3aGPyTnSyte1PjNUftq09AyCoMrlEY6sJmx4w4DJDNFYl3tAYTPPK0SGXhjFqaXt+L0spsgDFNbM46PfPqM/2ywnsDHBngr9brepmWSgd1/9cqKcVBuCFYccOWha9JrriCivjc9M+cpQbTapD/K80N5FBkghW170sGUZgKqOj9Mmg4WT+mSKWzY0GSjYUHfRBHMGO+EHc1iXHnSY0Sn7lIcT1JzVAqoPcmVfeYE5jqpWcAUcj3LQjG6MkENCqmf/qgtq5ClLDX1X8eDqI/XKcNmDJZ1RGqKCMfh+Bqb0T0rMEYtqHeKrzjJTOck2KloJGdrMqen+WpqkjFHUYZx/18pWqtf1VKS13rp/EexSuUStSaLNqleoH8EW3WgRRvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(16526019)(54906003)(316002)(336012)(356005)(40460700003)(110136005)(6666004)(41300700001)(186003)(2616005)(36756003)(82310400005)(478600001)(70586007)(86362001)(70206006)(26005)(426003)(47076005)(2906002)(36860700001)(8676002)(82740400003)(1076003)(4326008)(7696005)(40480700001)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:47:11.9445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4531172b-5706-4f9e-fb9f-08da9282f16a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Energy Performance Preference support for AMD SOCs which only
support the shared memory interface that implemented on Zen2 and Zen3
processors, because this type CPU has no MSR supported, it will use
ACPI PCC channel to enable EPP and reset desired perf to be zero.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 451295284a26..fff298744a8e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -133,12 +133,24 @@ static inline int pstate_enable(bool enable)
 
 static int cppc_enable(bool enable)
 {
+	struct cppc_perf_ctrls perf_ctrls;
 	int cpu, ret = 0;
 
 	for_each_present_cpu(cpu) {
 		ret = cppc_set_enable(cpu, enable);
 		if (ret)
 			return ret;
+
+	/* Enable active mode for EPP */
+	ret = cppc_set_auto_epp(cpu, enable);
+	if (ret)
+		return ret;
+
+	/* Set zero to desired perf to enable EPP control*/
+	perf_ctrls.desired_perf = 0;
+	ret = cppc_set_perf(cpu, &perf_ctrls);
+	if (ret)
+		return ret;
 	}
 
 	return ret;
-- 
2.34.1

