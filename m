Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C480C6507BF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiLSGn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiLSGnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:43:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6695E6155;
        Sun, 18 Dec 2022 22:42:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP9BaShI7QSWHloNo2LnKT2ohagZ01n3K1Fr581Mf/+2h8DDUIhooFvbNyjh50Lvm7+d3y3cdEb+g2LVtbZ2Z/16YEQK3gizLGGxb5WELsxJnMOm3INs+QVmgmcE/TK0wXJpt39WQudHNP3eNVzo5i7BkbpyX1wpbsyoFFdZvhHUxqEQEyAC4qP2All3pvMUJ5RI8wfcMh8HN+RnkodgqStUF/cIl5v9ZVZNAorTzDjLE5zeAROrhaPRBpZi8r6v0u7gXrYwdnHZ4GB+rjwco0aC17fR22JSENYaPMHeJka7fuEuCkQhEEdLTRA2IiyyYrNZ+KCWgSPObTbFOl6gTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2F3o/I2HXlzonVhtZwhnqyGmh98uMTzlA0ZYJRaa2WY=;
 b=PLRaf0zr0BfmWZAHhhB51KTYbsaG/2QYR8ujpQXGbnxcLb0+GqiH1wxHMee1mCGB2JEjlGlQNYtG9QJj7ppr216kWs4DOIsWilbcmgRiI8r2/F8bBr1fsxAA82y8mqMmcwPbEMinuSnBS4y42JK0hXlxfrqajQ4IXYStsIN4zODRCfhnEFChYmAFrDFObqVLiWDkP2laMMks+mAM/07BXHFDUPGfCV4YfdtGchszPPEcB6DyvvZJmJDqpnikYDAb3/SScVAFxUzN5dPd7izzswnA495UPYyEazX8u0+dwT/FNhwhTHXTEKDoO6OAQXGHjCcYcIyKc8yFR4o379a3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F3o/I2HXlzonVhtZwhnqyGmh98uMTzlA0ZYJRaa2WY=;
 b=s4X9AcOmWTYrNHU5QXfnxbD+XDh2CA0DZdwqe+yOepaOr963nIV6NzHcfsdR6Axhhly2EwXZwYQKB9a7YQOdputZ6KJUTxrDKnfmHzN4hVx0U/1Be/Hk7g5vOLHQP2LhPcRYRk/ndX6P/qU++U7MOY94c3DNRF845FwY7qJzuso=
Received: from DM6PR03CA0095.namprd03.prod.outlook.com (2603:10b6:5:333::28)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 06:42:28 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::ff) by DM6PR03CA0095.outlook.office365.com
 (2603:10b6:5:333::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.20 via Frontend
 Transport; Mon, 19 Dec 2022 06:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 06:42:28 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 00:42:24 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 12/13] cpufreq: amd-pstate: convert sprintf with sysfs_emit()
Date:   Mon, 19 Dec 2022 14:40:41 +0800
Message-ID: <20221219064042.661122-13-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: 46896717-ff0d-4c4d-e725-08dae18c325f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pO1T1wd/dAnX38nmgkVw30ePisYJ8TfhMvZLMvu3S2nJfMk29eTPi80KIIxYpMH9GlZX+w/mY/6wn2EEA9yW4xua1U5w/vS5CpnHjCE8sOoms2h/HC5por4Zu99WQpSY1Tombhrrxe/gd2ReGljRfrRT1Dv1LNwe8ZIDcrkqOpoxeA7wi7nU9AAqWvlrj/VXu3DDrq+W3tPJF7nHX9ojD2GFakca+wmqRq11uQx1j07cgjLKmU1tUzOJmz/0oo28Pv+tXU1HFSocdTGyRA/qjSWwuPQktKAm0ElOo9SS3hvHK4jjGBwAJX/qRS1Tm1Uz8K2COOW72tZsLN2OPUzU6DiBitIKbVYNnonWX/OntT0QxIKHsw6fBahDksr+dOPp1Wit9nSCs3/rcVAGfrhRqkIrzMm/QLygr59mUZxUTx8NEQptxxcrP/atpDAM8AUudyshXGLvgxbsoia8tbLojKkmjkmQY1T1ToZ/OyfLXGG9lOj+QBO3UYukrc2v/a81uBjaeG4DxPnvl2mX5nu4WBQbKaPJkRpzqJ8hklPdf9//kI5WN4udse0Bd/4t0/XxQMSBfdH/rAsuv+djdD7AmfYZYy/PDv5XWoo7zJ+FNvIeNdChdMf9M+JKlQBos2J/FPTqvbCX4LA4juYCh7npbhip1IScoDlyNZqyVVmSioz1zRnC8hQgaOR9JTjHpxUj/Lx1PPR3dXCvKENomIEAa0jXhT30JVl0UJ7xbZWO18=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(47076005)(426003)(110136005)(36756003)(54906003)(316002)(2906002)(44832011)(83380400001)(478600001)(40460700003)(7696005)(86362001)(40480700001)(6666004)(16526019)(2616005)(1076003)(336012)(186003)(26005)(36860700001)(8936002)(82740400003)(41300700001)(82310400005)(4326008)(5660300002)(70586007)(70206006)(356005)(81166007)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 06:42:28.2538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46896717-ff0d-4c4d-e725-08dae18c325f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace the sprintf with a more generic sysfs_emit function

No potential function impact

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e8996e937e63..d8b182614c18 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -709,7 +709,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 	if (max_freq < 0)
 		return max_freq;
 
-	return sprintf(&buf[0], "%u\n", max_freq);
+	return sysfs_emit(buf, "%u\n", max_freq);
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
@@ -722,7 +722,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	if (freq < 0)
 		return freq;
 
-	return sprintf(&buf[0], "%u\n", freq);
+	return sysfs_emit(buf, "%u\n", freq);
 }
 
 /*
@@ -737,7 +737,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 
 	perf = READ_ONCE(cpudata->highest_perf);
 
-	return sprintf(&buf[0], "%u\n", perf);
+	return sysfs_emit(buf, "%u\n", perf);
 }
 
 static ssize_t show_energy_performance_available_preferences(
-- 
2.34.1

