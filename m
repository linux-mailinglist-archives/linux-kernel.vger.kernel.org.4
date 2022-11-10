Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E32A6248E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiKJSAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiKJSAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:00:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E674D5F1;
        Thu, 10 Nov 2022 09:59:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFzaPlgkDXgEx+6mUZF3ckPD5YnSoctMAOwy5o5u+CBoj2YJGPmILQ24iAPmPupZzZoOM+bG0IScqTarNtaIo7xe5gSBQAX1nKuy9F2ZvGKV8PBW/sgNLZS/gxT6a6FULwCrZUSoHiIhPdhhq1fP7vKJ/zCEZwMKS0pHqFXwJP9eXP7ZqclcDOfMnXuxM3A55B2RzFjrtgoTkkVbvqfTLXsKF5hBlmMalPrht4eDrUTkOwRah8C5wh7ELF8Rs8b+per1dC8O0vZWfhEZLfAXffCD5Knh8SQ8d0MnR2yz9/oHoE0DCruZfn/Zjcg31KDY8G35CeWbfRJmqAkuNswsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0Vg++G6NTCpEK3CPxdr1P7oz16Ijhl8gM43pSpJxi0=;
 b=EtPNEk0yAhszdEzjdKxQU+cjDh9xZDPH8f8ifDorY7CvZDjz1SNmZ5Po80IK7XitwgiOGIjMCJCem//3f+CU316Gy6f8oMYkcVnR++fJ1Pey0Y3e9rbOMqcuQ8hWnTgJbmnkoxgp9/bP7+bLI2gtJGuBdQ8HSAqDngL7RZr9s+xYCKs/R0dntPHqwvQw5JpcV84iFsUqqM2KGJVR8GO5NS3Tab5X3JFLAgWeDP4L9Ob/v4cDtD4kCUgyRl4yYPAmWQMdI+AwlMqESnYlJXctIcOOropq5pheNf008IhdTEWkbgyYesRmwOIysY4JukhZeA6MjTVKkRLCp41u91hOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0Vg++G6NTCpEK3CPxdr1P7oz16Ijhl8gM43pSpJxi0=;
 b=Cd00ybCKl399H+E/B1wnopehOKsVBMkIS6/EnRp++F/IWYlAtcWOPWXCYwdvH+TsOsJSH4ThRxKEScVUgkXCsZTpGmMlPW3LtHvYIDkpdCFBmrLrsOiMf74ZANdM7uDi4GQt4LSEQ7jFUGlkOIuqT6ZeKi/S53+qYufTRaVIefs=
Received: from BN9PR03CA0168.namprd03.prod.outlook.com (2603:10b6:408:f4::23)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 17:59:42 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::33) by BN9PR03CA0168.outlook.office365.com
 (2603:10b6:408:f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Thu, 10 Nov 2022 17:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:59:41 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:59:38 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 8/9] cpufreq: amd_pstate: add driver working mode status sysfs entry
Date:   Fri, 11 Nov 2022 01:58:46 +0800
Message-ID: <20221110175847.3098728-9-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110175847.3098728-1-Perry.Yuan@amd.com>
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb6216d-e96f-418a-d98e-08dac34557ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yjAyGGgTmT1W6RpohkG0NVB5OLBds/gnAV1rJZ9HDljs664kgw1Q+JLBxPrSWXLbhp5rTMYxilUleWLp75EypGJ25fCidRQdKMXNu60MDUesxoYiUtHhF7CoKNlCiauZGcsqIsWbMKKzJQpHFiZW014AJ6ueIK32LU0SiU7GNkr5ZiEsfPeGanc71q1niYEi+ufMMV7btkvDTeQOEEiiPLgye7YAXi6AFSfO+4mjg1TSzbYg3yUTdi6juDaEb6gc1Atx1sIhqItBwmDjEFcLL8ngXibkO5qIm0jXj9oxXWfhmUeBJ9UnQOQsYKIOp9q9F67STrIPs1eb0+Ita+4HhCMppZnZ3dQjUIXJL3e6RvHdIl+M/3FsIiTJbu7nRb6OlGTIWeUXeIiP3s9LQgYSbmvPkbhd9JY6ACe0xibQ5mNbR4LZWgIKjWpOeu/pa8XzeaBMe7kdvduq4NAJTkk4DSY/h8d5EaFfFuHgUEsGO3U5l0hnBgTKEy8RFcqBhZt8QCUBCNV6In19ToGPLaWf4lbNnO7YYgQyDXvjJcE1nTlIrJWu4k2uVpKqLsA+x/TUHybb7aLwU/WEngXzUkbjY7Cia2DrqAahRXwW1m/p3179BlYHLKJWoYExfUYZ9wiGGTvZb45sF4Isgu5SvWrDohysX+HbRIGfaZL8zfjWQr88v3wuhjKUP65vFY/+mMkJMg8tBT4AlUwgYuJTD7mZpwH2/dm9vNEyuqnx4VwCQ04RDGgTgqeKsDPlCA3mygCZuYn2/PKWrv1Grtdd5wRsuy44GzcgpcLacHGz1/oI06A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(40460700003)(356005)(6666004)(86362001)(426003)(82310400005)(2906002)(1076003)(16526019)(47076005)(70586007)(36756003)(82740400003)(4326008)(81166007)(83380400001)(336012)(41300700001)(36860700001)(70206006)(110136005)(26005)(2616005)(7696005)(186003)(8676002)(54906003)(8936002)(5660300002)(316002)(478600001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:59:41.7114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb6216d-e96f-418a-d98e-08dac34557ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575
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
index b71bfbbb7639..6a3b610cb084 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -65,6 +65,8 @@ static int cppc_load __initdata;
 static int epp_off __initdata;
 
 static struct cpufreq_driver *default_pstate_driver;
+static struct cpufreq_driver amd_pstate_epp_driver;
+static struct cpufreq_driver amd_pstate_driver;
 static struct amd_cpudata **all_cpu_data;
 
 static struct amd_pstate_params global_params;
@@ -798,6 +800,46 @@ static ssize_t store_boost(struct kobject *a,
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
+	/* FIXME! */
+	return -EOPNOTSUPP;
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
 
@@ -805,6 +847,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 define_one_global_rw(boost);
+define_one_global_rw(status);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -824,6 +867,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&boost.attr,
+	&status.attr,
 	NULL
 };
 
-- 
2.34.1

