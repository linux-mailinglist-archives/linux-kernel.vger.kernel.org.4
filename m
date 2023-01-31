Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254B568282F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjAaJGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjAaJF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:05:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0171E10C9;
        Tue, 31 Jan 2023 01:01:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVvZsdHo0CHET9rAA6DoIaYFB4DMl7Xdh2njeK1vfQa10BqH+7HQTI+R9jLLz6p3eBQZYqp1G9lNW7qf3YsD1Ns07BI2jaf3l/VQiU73l3afmHjqzDRIPRRzgx12XSl3Qkpa8GJT1yuxtT0DSecjytQfEi6tVwzl/RI5O3ybPm2qZXga2SviQajSuwWgcp3Jnt2WZSiwYT+Hj8TjTyu7PmRmoUHyV8w4yUQ3wlM/aRsD5+mtDtVEKMAWLYeAGUmZYvThGBCB3SEthi8NBijoNYUklYGOcoFLuJlg7HBcvkbNvuW4cmoAZIjuOqSn3O8K0um5DwS5o5ol8k5cgYDYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xda4OiAKmiXwyzVnmNK4E9zKPNcx1ZD+EK0JjIaoTr8=;
 b=mh/7ohaz9ezrjvSTQNTIhnO81dZhchAO3tq5cEfmx5mH3mC247cKwjrcKrbJ94gtvpM8MXG75oStqIjfM6ny6qCQ3bdwEquZVLLtecqrfEFHGvozzp/MaFfrY6IJ14MINYEYX7f+BqgcqK5SF60TJ362X+JOId3rVmgCd2tZDMDXR9hL5e7e22ReNITX9CXjgCKKKzYpH5b7v3px1FRjXVlLuorMdtbTlIUJ4FdY8DgsBkyqrcsNP/M/LWfZWWERkOrnQAT5XhbMo3LicSdUMOkdJRX1hMOxT8atJimo2fbUflxc2KPVRAzBprMa5pEsYRquUETuWhEtjIYDPH++6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xda4OiAKmiXwyzVnmNK4E9zKPNcx1ZD+EK0JjIaoTr8=;
 b=3KocDhsr2SwpKHpMX9q9Yc2lT/rhog2te25ZeZPOBR15O5CW8uinZUNddHDsDN/LeNbP5nlAGQu5I3W4Gcg3n+9baadA5ws3UtoU495Z5t0jARL3T5mIn4Sb1+HOslJLepg1OTc6nOmz1BXzrTWSSG2/3ijF7+jp7h8EEJP0YAQ=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Tue, 31 Jan
 2023 09:01:20 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::24) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 09:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Tue, 31 Jan 2023 09:01:19 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 03:01:15 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 10/11] cpufreq: amd-pstate: convert sprintf with sysfs_emit()
Date:   Tue, 31 Jan 2023 17:00:15 +0800
Message-ID: <20230131090016.3970625-11-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131090016.3970625-1-perry.yuan@amd.com>
References: <20230131090016.3970625-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: d57313f1-0b16-4598-c350-08db0369b7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9u3Y1kB+T0eq98fO/t5rjw5M7Iq8DcjRRQJIwqmjwH7+sFQAegbg7NTp00jCkG8ArzhKVgVWY+70XQIQkxVLhF8/fEG2hHJJa4YVzlIII/PMuRxwrrTsQLirHdOxmsO62sJCwf299Dw6DS7nEdLs6r9ACxM/aIIf5zkHXuX+aH0lRYux5rHWKpS/r3Kw7Mzj/0b8LkSj+ed2Pl7SARjJKc3by/Z5cbYk553yiFiRtJ/WGBkh+kEHr11QpImBj+T+/C1Li83cZFz1ApN0/M8CP90mhRV2iI8p979fg2hvyfJLKL8Kmn03sO+fIHshL7dMhviuCUGIB68l3pPBXxZz/vqMYOG/xupvpc32fwbwKCP+zxlc7oP73XQ3I5ElkZDeKJampVXZBewA5qu82A9mRODGefbWAsQBSwkFz96BiALgNt91hLstl8GJMmLkW8LqCsGueSZHpwK34x4zYEvz5QQAYbOvDPGjk+odLfKInkG50Tp3b/Sdkucz9tkrNXaiIG9DCuxqxY+mKHyPm4Cn9h1xakhWtgfCwAu3eAkiED3LF2Mi5JzoRrCGQP3BL6sF2fzl7TpkvDxuXQzXT6CTTt/xu/ATeuKAEXjIljfudP/Hgc/fZc+6cAyvDCylnFKbTBGJYbSp3DKOBVakKxck9LvaviFNx3C69w4xiiERdSsBQda/o9yqU2rLBPDQ3mspD4ZpLLZIXtQxENTWzU2WXzKqDeV2Is4es0wloIoJiLU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(40470700004)(36840700001)(46966006)(47076005)(36860700001)(5660300002)(186003)(1076003)(36756003)(82740400003)(110136005)(54906003)(356005)(8936002)(81166007)(70206006)(70586007)(316002)(4326008)(41300700001)(7696005)(2906002)(40480700001)(40460700003)(478600001)(8676002)(44832011)(16526019)(83380400001)(426003)(2616005)(82310400005)(336012)(86362001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:01:19.4649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57313f1-0b16-4598-c350-08db0369b7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace the sprintf with a more generic sysfs_emit function

No intended potential function impact

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1ae2e0d56ed1..168a28bed6ee 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -736,7 +736,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 	if (max_freq < 0)
 		return max_freq;
 
-	return sprintf(&buf[0], "%u\n", max_freq);
+	return sysfs_emit(buf, "%u\n", max_freq);
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
@@ -749,7 +749,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	if (freq < 0)
 		return freq;
 
-	return sprintf(&buf[0], "%u\n", freq);
+	return sysfs_emit(buf, "%u\n", freq);
 }
 
 /*
@@ -764,7 +764,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 
 	perf = READ_ONCE(cpudata->highest_perf);
 
-	return sprintf(&buf[0], "%u\n", perf);
+	return sysfs_emit(buf, "%u\n", perf);
 }
 
 static ssize_t show_energy_performance_available_preferences(
-- 
2.34.1

