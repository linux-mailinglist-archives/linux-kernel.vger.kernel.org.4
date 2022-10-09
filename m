Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB75F89EA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJIHLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJIHLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:11:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A528323388;
        Sun,  9 Oct 2022 00:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8GK3v9kMSMfyZDnjMG8vwxZbdZCaGtogag67Cn3KOsCOolw+yuu/m5AxLlxP7NnEhKjHsIxOF3KisSaH0vuX7QgcEZmU29+NSVMnHAt6dy2lznQwYEv+ri963qdCqpl8J3fl5t7YNCNVw0L0TFJrKs3jBkZlkbvQEC/4VBJl1pq3Ho94M7wvdu2abAdAL5oZFf0PNM1eG1lP9v9YRvCMxV7blmUKPsuK19rU+dWtHmhl4xKqOQmCOGVL2LRixV6NiuMP8VA1ryqTmnH/cFce1FFdMi7JJlM8RMO68QiHtZoQbCX2MAs6vzFbJ4zw6mgaSd9hFy1PHYez8JIiUMnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btPwwPHv+BWB3mpjbjX83dVXxe6qjvTS7bl+4/fSJm4=;
 b=RRZmjy6/5st56sw3BqysUtDm/ZWFwzZlgb/LJ7KnyBMp1Dx9S9bkFsXEz9q/BHBnkl49GC8rEfo8kEOFV8d7ioAPWdKcEAN5jx+eCzlvKjBUe2LNVlxML1FVXj23B+whRJjuAGCoGQYxLZUCFhXsFFmg5xe5P+7MHAUFbOaSxcbQ775NEF7D7FOkxSiGkyhAc2iSBnW/PDvrFqrP/y+WU1gjh/PtCdKLMXiJaCvFNfyvrS6ziInKsXBZgK1nnLscFsYV91uYyX+/rXApnro9iEDozlzwW/2fnbA8XFWAa/v8+BZomUoohJYOOoOtsEv9EJ0psfvOVSOXDjrJoepl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btPwwPHv+BWB3mpjbjX83dVXxe6qjvTS7bl+4/fSJm4=;
 b=LPrZiGaa9S026y+sSaBc/AB5M6etMeWkfO8wuEef4uxRT+cLT6R0SZeX7ctlYbkSnq3QsKJUdcqOGQwuEM6An111JrEIdavI03gaBkXrRkCBjHO/Pub34ctAF9waMEW/kpAY4+LhyIJXOxrM0I8sZOgSG1gjInPwOKD/y9v6Zks=
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 07:11:26 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::38) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Sun, 9 Oct 2022 07:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 07:11:25 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 9 Oct 2022 02:11:14 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 3/9] cpufreq: cpufreq: export cpufreq cpu release and acquire
Date:   Sun, 9 Oct 2022 15:10:27 +0800
Message-ID: <20221009071033.21170-4-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221009071033.21170-1-Perry.Yuan@amd.com>
References: <20221009071033.21170-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: d911f30d-901f-4925-e499-08daa9c57ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkSOr1iMpoYkSFCCDuO1Pw21vNBfRSyiS/6fJ6wIhznv39o1uKDuLxvhs60li+xuwIr0wKllWisLFIlhgWhig9lKs9r+l3SX1U7O88zUYhOcWp18jVO1HeV16JOSpt1JAwSey48TneCtESYetyxS4yT1mNjwoa3RHRHciEoTQdrNGpRkLUx8nMum2S9vLgNHHKQxUucgRIQ4yFSbce91b3sPd68C4BiOgLfnZDXDPaIAUZGvaydGGubFZv61pbjIiNrqRX9T2Cq3PcPNVC5E49sqH4jfWg8DZCRKw+kwW6BQ9we3/MKet5W6jerVIrMMe+CbMlpbGJY1sTdq4VEkaw/W+7WOWEB/hsfvmfr8RRxCp3xlv7kcG7t1yIfrDBztJn0CiBeOMQ2JyIKFaaLRw/a57NZmKVxb/gwDJmMOcYB1DeS3ONvmy5OwGhIBB23xhQsIqdPae6Ba5XYRYcoNZ3/7+vBlO/ap/mhRAiUHnnM1aoV+YBDh7rztyOkYTW9tHorVQ1wCJOSt/RGbIzLQPVowbBNu90IxsCpykO6FWT73sdN8sYehe4SkhqoO/XrPinKg1fJr9LjdLZnaGV44zINHSS+ia5HN3+CmCIuwqifRsFCL3//XgbTpNGvwh+hcsg6qOFw2+AN0KVAosOGnKSHBZ+FAYOK9u1JXL+dVs6ps0ceCekyAj700eAkeZ2BNLxyZmEwtFWPjyusLUhXGr9utuOS4DSBsp0jKibO+LpllVcZVpPjYIDej3OK7YCoeu1gwtUiqPAGLwUadpaowJCzQVO3SkKHxKrKCFkJUIrpR4ZVx5jvR3HIcc1VphIqu
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(81166007)(356005)(40460700003)(40480700001)(82740400003)(86362001)(8676002)(4326008)(70586007)(70206006)(316002)(110136005)(2906002)(54906003)(41300700001)(8936002)(4744005)(426003)(5660300002)(47076005)(83380400001)(16526019)(1076003)(186003)(336012)(2616005)(6666004)(478600001)(82310400005)(7696005)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:11:25.9752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d911f30d-901f-4925-e499-08daa9c57ace
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq_cpu_release" and "cpufreq_cpu_acquire" are only used internally by
drivers/cpufreq/cpufreq.c currently.
Export them so that other drivers such as the AMD P-state driver can use them as well.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 69b3d61852ac..a491fea4985e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -262,6 +262,7 @@ void cpufreq_cpu_release(struct cpufreq_policy *policy)
 
 	cpufreq_cpu_put(policy);
 }
+EXPORT_SYMBOL_GPL(cpufreq_cpu_release);
 
 /**
  * cpufreq_cpu_acquire - Find policy for a CPU, mark it as busy and lock it.
@@ -291,6 +292,7 @@ struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu)
 
 	return policy;
 }
+EXPORT_SYMBOL_GPL(cpufreq_cpu_acquire);
 
 /*********************************************************************
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
-- 
2.34.1

