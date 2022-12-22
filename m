Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A27654960
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiLVXdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiLVXcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:32:24 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFAC22B1B;
        Thu, 22 Dec 2022 15:32:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUXevUcht5QEAtbIyRNz6InSOA8F3w7yYjX15SYNJns2+5pfWtt2CISUyUYcUHxcSLGQY0WY3nHZZex/L+oBkjbLxA1XUTUs4msqzKEP330pbMSA5HBaiAmp5hNV+ixshNkDrDFI22cHQcfVO9+RAsz0j1woQs6YUmtRwyl2JZf1fpBEIAAd6rJR/Ued1gQ71MfHKVXS4icQSDPXsjQaX1HWI/ifz3LFI5g7mmrpRhQkz7D+f3tBRB7OSvTO5K/QDjolT+++9Thu5s5uceryh2Tp12Ed6gAX4VRPdm4E4gfPDbaKYNYPMx/4Xjm0S4GLXIWZb1UN67pqaEuDBL3XHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFAQwsg1S0v31va8+qhDloTy7uUSCKJdnxX6oD0yzTE=;
 b=D8Ov1X1vrSHbXpWniMKl9jigrTbI/rk0A4f1JHkZdYZrwNoMIxAatPPgcua1fByeLA3GQMo7Bpjdwy55KO3/HZRU5IY8ZBiSnZPvHPPFnOQmFWd03t7ijjLPWdOjZubpvYkul4Idy+TpBF9WgNnh2D/eDQJmZtW49HR1FYWXISHcGc+YHi+uEqdzd8ZbxU5OlB9TIeP9cU+dFNUtVjCQy1WatOek5GolHfsrXBIWrEIJViQ2YUr0fKcRdKr2iDVhzsc3jhJ9EWiFyjDZvbexkzgBMIXl9W1yIE0wA3uiSYaPFOoOVxKdZCOs3nS5QH3Abs0MzPX5mr4QGVTXU1WLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFAQwsg1S0v31va8+qhDloTy7uUSCKJdnxX6oD0yzTE=;
 b=CaPArotzF+BXEgE84DQrK7qbGcUYcKtRbgQ7PTYoOvvl+h42ld3iP3ZgiyaIKzrM6VPHElTivLSVQumfPhuAL+/4HDF3QXdOokIvUqz5ndDVoVHN7uokeZ+s949lVe6antqdyGxLySqeT3h8sphXVaTDNKgQGJpl51rdgsZ9lGo=
Received: from CY5PR19CA0127.namprd19.prod.outlook.com (2603:10b6:930:64::14)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:31:57 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::de) by CY5PR19CA0127.outlook.office365.com
 (2603:10b6:930:64::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:54 -0600
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v10 12/13] x86/resctrl: Add interface to write mbm_local_bytes_config
Date:   Thu, 22 Dec 2022 17:31:26 -0600
Message-ID: <20221222233127.910538-13-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222233127.910538-1-babu.moger@amd.com>
References: <20221222233127.910538-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 70333f94-2314-4157-0fc3-08dae474b760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtbtjwkUf3Y5g71/duRf3F0YhWTghQ/HMOsAVLQ4DbFfq6++KKcw6XmfhlQkmNP3Bs85frE2n6wQ9MyZXyix1NQQphXEd8CeI70RfCa7cz8Eqb77rC+XVtt1tLSksXlD+MOsvVfEkO6NYGg+VHmwAevirCHxCJkttOuJGybnAaEHK2OWavOBNfmIVdmQAUME3+a0bbYlxq+AQ70/mRUxdyDcQJ+o7bK+63W93d/1TQiylbcGiJZVHw/l5xV1VMtBcnadtyRBU2+SPbrI5tBiGQlSjZHWKrOmCt7MRtJKufdBb3AN2d75v23p6dWS6ykXerRZAMnyJCs6gotV2yPrLRtzmeLoIzUmRla+9tNawVQZXqIWEKfMbNtqDQNjxwOuc5+h3YU+/3DJeui+o4R2epQnP98zKnDp1oBWEhz9Xq/YEhp0+gaNlx/q6lKFqU7NaLKO/FnjAtXxuCS9Hr3pdK5a3G8o+C0YRQoU3fpBe/9fHSczXKN2wVCVIgFuR61qTdXw5OgdHjorZy28Y7rqTHSQSVRu8PYmMG+057tziUGi/+WKfk5FAkiDi2JvLwINz9SQL6wJajZklidvBsE4t0kGBRM00Bp5H1uGnZUogQKNzi6tA/ZWprPExLmOo8+Eoo/oSUwnneCn/6e4J+1eJCidDYo15IiiKp1ODtW8iaktG+bwIRtqerZmnEVKdwsNNpBc/y86XtJOCv04oFTPc4SoD5NNvpOyxpXakqF45Ww=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(70586007)(4326008)(70206006)(8676002)(40460700003)(86362001)(36756003)(5660300002)(336012)(316002)(8936002)(47076005)(82310400005)(41300700001)(1076003)(16526019)(6666004)(2616005)(186003)(7696005)(83380400001)(26005)(426003)(36860700001)(356005)(40480700001)(81166007)(54906003)(478600001)(82740400003)(44832011)(110136005)(2906002)(7416002)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:56.7243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70333f94-2314-4157-0fc3-08dae474b760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event configuration for mbm_local_bytes can be changed by the
user by writing to the configuration file
/sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config.

The event configuration settings are domain specific and will affect all
the CPUs in the domain.

Following are the types of events supported:
====  ===========================================================
Bits   Description
====  ===========================================================
6      Dirty Victims from the QOS domain to all types of memory
5      Reads to slow memory in the non-local NUMA domain
4      Reads to slow memory in the local NUMA domain
3      Non-temporal writes to non-local NUMA domain
2      Non-temporal writes to local NUMA domain
1      Reads to memory in the non-local NUMA domain
0      Reads to memory in the local NUMA domain
====  ===========================================================

For example:
To change the mbm_local_bytes_config to count all the non-temporal writes
on domain 0, the bits 2 and 3 needs to be set which is 1100b (in hex 0xc).
Run the command.
    $echo  0=0xc > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config

To change the mbm_local_bytes to count only reads to local NUMA domain 1,
the bit 0 needs to be set which 1b (in hex 0x1). Run the command.
    $echo  1=0x1 > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 29 +++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index acaf19f5d65b..59debc997162 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1638,6 +1638,32 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
+					    char *buf, size_t nbytes,
+					    loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	int ret;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	buf[nbytes - 1] = '\0';
+
+	ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1745,9 +1771,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_local_bytes_config",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= mbm_local_bytes_config_show,
+		.write		= mbm_local_bytes_config_write,
 	},
 	{
 		.name		= "cpus",
-- 
2.34.1

