Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45861FCA6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiKGSDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiKGSCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:02:18 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BF12792E;
        Mon,  7 Nov 2022 09:59:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhxRGouauHH6RtenBRqEXDBrnaVceoOLlpHAO7zGcpbXvpSYCvq2huDS/i4ka52bdtjG0HbzET7h1c9p+UucifUFf+tWqZ4JH5zdI+uLVr9bOYPChgewC3ElOL6TdT0Y+dOlO0io5h2FmFbkL5D+XHwGN/B0kfaey9n0jcvTedT4hc64EamUs7A4HjUN5rmYgGapcLrDQS9L/ezKqnHoDvzi3kF5HRvyFfBhFnf4EedBD24dU7NGyEqqdlPHslfvbLXi16OUKvLZ89WYEjX29LOHgQBt7Gqri6fzGSQJOpx7hAVJDq/8Wo6fD21mcLH4iBWy3TXu5NY1yJEszOo4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmzqqzhXAXpmhecmtyRLBCcvFOxG/63OQKgqSl/Y+LI=;
 b=MLAoESkWxcVi0+br5bdq/+tzzaa1PyEP4tx1p2VhY5pN56a1402yCDmmg2pki7J6rM4tTIl9FD/O30iQMj5q8tS5/1Be6AIRLnaR0LEYw15HsRZ/Ske3yDOIlNKZKa8uBTxP2ozVuxUsgSe8e9YP+4pdw5QuStG70Tb4RoD7zLlCAw7p9LF6q61f0wII07R1gaIe5oKW09W20mPzZsYqjCebVlA3ixUzJukiRNRG+QlbKL9DdzWOvyVG4FsdeFRybDpxXNCYh+7JumU04TvBYgbRizyLw4rAyC5fyJCc/+H8aEYPEhZDmv25sARAUnlCltTEp5nZ6fpkcYSmXxBM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmzqqzhXAXpmhecmtyRLBCcvFOxG/63OQKgqSl/Y+LI=;
 b=lnjFE51yxIfvUjNavpg7zmZeAjxxqvimnKui1MtJ5J8009mTU8DJ4M/cMEEU3xOjJHX0mVnnEBXFAR6gvC8FK8cR7DUA3LzMdECbuHZHyOr4Fymfrissd/vb5kA32pcTADRFPMnVSGm9GV3ECFTNEo2UwisV1kiLclwy+8C84Vk=
Received: from DS7PR03CA0160.namprd03.prod.outlook.com (2603:10b6:5:3b2::15)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 17:59:02 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::f1) by DS7PR03CA0160.outlook.office365.com
 (2603:10b6:5:3b2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 17:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 17:59:02 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:58:58 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 8/8] cpufreq: amd_pstate: add driver working mode status sysfs entry
Date:   Tue, 8 Nov 2022 01:57:05 +0800
Message-ID: <20221107175705.2207842-9-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107175705.2207842-1-Perry.Yuan@amd.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: b37856f2-a699-4666-6ba5-08dac0e9c0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bt/99VUEizP4XoQzqrRNTHUpSnuY5zyVjXwf3TpzSo/9JGVt+1OSLkZ6LQfbHWIs4oT6hefE8wRmXKsisEmuDUk7cG228HbctJ+1z1rYewW1VZn1tLaFQPUSEKQQU7vXlYMpOKpbjHnpMwfqCB/ayQfsae6JjrfR38tS7R1qfwu7rDLl9JmcLJl3hsz1o5ERqftsTT1WFatybuBuFufWnCQ6g9NJqAk1YewL8ONdh5vz9zrGDXS42zysGeXErTxnCn6G3sl5isvduniWNJYRSssIDhf4StiSd0hCPANM4ydZRndYyuCIy+KDTVPRFJPmjJ3Axv2nbywCOC6gHAItGNoqQx5kEmPqiZbQuQHSjmxrihF7c+QG22LsntdrUnqmo58ctxEIiwHgE3nJZN3ob6nJloCshapUMKKDJR1H9vJ8OaYnDjQ+QYQk2JttZQ+0laIc6+3LtJs7V/Be+r+lOQc2MEEI8uBzl5jIoCpyz4jxWjqJECD30ppDz6myacZU2vPvBOYiHjsEHgQjMfiafTJTzA7JsdZRYEEFb3L5ArPzxDRBBhCuHiv1HUN7Ib8uPFIexz3WlzhbvtYdF5b8WEngUrR8+ATXJr/xmkq7ik6mqvyQbBaZQonhAy8pe3bvOFX3wiUs3HOjvW5wrsMVLduJ8UdTDENTzS+qFSkk+etCATZBsBT79pbCqNyJ1afuJhY2pI2Z2Yhhlzupi6xNYbxgY+RVUQAQo6uTbN4Kw4U1sMV9rtRltK1ICjDGr/QM0y+Yq9fr5KZ+IIxSUvpbCfz5DBiYHKfqjJB2pgOXBqa0JZ9zrNZvk8/6FtZkUMaN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(426003)(7696005)(356005)(6666004)(110136005)(1076003)(2616005)(186003)(26005)(16526019)(336012)(36860700001)(83380400001)(5660300002)(2906002)(40480700001)(40460700003)(82310400005)(54906003)(478600001)(316002)(41300700001)(8936002)(8676002)(4326008)(70586007)(70206006)(36756003)(81166007)(82740400003)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:59:02.1083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37856f2-a699-4666-6ba5-08dac0e9c0db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
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

While amd-pstate driver was loaded with specific driver mode, it will
need to check which mode is enabled for the pstate driver,add this sysfs
entry to show the current status

$ cat /sys/devices/system/cpu/amd-pstate/status
active

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6958c5fd9e1c..eadcc9d61d39 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -65,6 +65,8 @@ static int disable_pstate_load __initdata;
 static int epp_off __initdata;
 
 static struct cpufreq_driver *default_pstate_driver;
+static struct cpufreq_driver amd_pstate_epp_driver;
+static struct cpufreq_driver amd_pstate_driver;
 static struct amd_cpudata **all_cpu_data;
 
 static struct amd_pstate_params global_params;
@@ -819,6 +821,46 @@ static ssize_t store_pstate_dynamic_boost(struct kobject *a,
 	return count;
 }
 
+static ssize_t amd_pstate_show_status(char *buf)
+{
+	if (!default_pstate_driver)
+		return sprintf(buf, "off\n");
+
+	return sprintf(buf, "%s\n", default_pstate_driver == &amd_pstate_epp_driver ?
+					"active" : "passive");
+}
+
+static int amd_pstate_update_status(const char *buf, size_t size)
+{
+	/* FIXME: add driver dynamic switching code */
+	return 0;
+}
+
+static ssize_t show_status(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	ssize_t ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_show_status(buf);
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return ret;
+}
+
+static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
+			    const char *buf, size_t count)
+{
+	char *p = memchr(buf, '\n', count);
+	int ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_update_status(buf, p ? p - buf : count);
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return ret < 0 ? ret : count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -826,6 +868,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 define_one_global_rw(pstate_dynamic_boost);
+define_one_global_rw(status);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -845,6 +888,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&pstate_dynamic_boost.attr,
+	&status.attr,
 	NULL
 };
 
-- 
2.34.1

