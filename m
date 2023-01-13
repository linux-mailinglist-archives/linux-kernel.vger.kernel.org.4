Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859AF669CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjAMPvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAMPuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:50:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBFB7D279;
        Fri, 13 Jan 2023 07:42:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaPF8JN5LwP0nX6u6MCy2DgYVZjkYILjDYlYY8tMP/J0L5X/b71rv6/W8gMM/oy1aFWiu7ggvIpP6VLVbiAltMq7IOzznVwgr6iu/vus9l7P1AudE0J9kHeXADM9CN1sfAEy/K0Ys4q67Ulo3Hr4D4nGFNfWs/KmUsXHm0lPJ80znqfhj+4cBPMYUBVosf8LyuCuSva3Alk+RNvyMhqis4eKqhaiVXFbQqg8e+u6ubHzFN+rcsEaLa3nMF5bErW3LLBHLYdAOLfMEuHa68pxZsRowGOma6JgXPyTCYO7r78dKywD+URpIP/jSj8pyAtjYlsQT6BUCjlWPiEOxrqXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUx5/xazjhDZXHda27FNgtfe4fEKA3csrPyF9PE7PCw=;
 b=h6Ahh731V6F4na6xTtGNZqEeC3VFXwS/jlgVN0NmRf1h5CZNh4siimjSHiLLcwrDyIEQqTU9K+A6rdsthIcK/Fm/4Gd/nvYejRvjq2n2K2X+Tj7F/jn8tq9TKBHePjT6Oz3YeumA/4EQHGJBJrSwAxuCzDsf4ULFVYWB4sM/pT1UOWVRijqoWBg9uTo64ptGFY+m/N8X2qKfSV0SNsQ2OSiBsZSDxsixbTi9rncz/Mh46CA7AVKxsA4L1NzablWJjpdN69/zKrs6h1uRVfIG4SxXgsXPkprDHz9/6MCYpw4XZ9OtYvjdqLnxB4QK44vrQY73jamFR9UspAdKxAA0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUx5/xazjhDZXHda27FNgtfe4fEKA3csrPyF9PE7PCw=;
 b=SOTq6YaJ2hD8y0zVqobw9E3AkcsIFufWpbBGX3XqZOYmdCMaTtGNYpkZjziehGVm9+fENKfKZX95qR/tXrABk0PJLFZyedpw/+5Fj54szviXipSmfCV8w81vWo0YdJaeM3NQ/njfEBZtGBmBqZyXFgitF+to8l/NEOiTy7Ft4ZM=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 15:42:57 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::13) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 15:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:42:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:15 -0600
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
Subject: [PATCH v12 12/13] x86/resctrl: Add interface to write mbm_local_bytes_config
Date:   Fri, 13 Jan 2023 09:20:38 -0600
Message-ID: <20230113152039.770054-13-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113152039.770054-1-babu.moger@amd.com>
References: <20230113152039.770054-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 4973e8f7-2553-4cf7-12ea-08daf57cd743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJVqhqoQnan+6EVKZRoJHAI5L41tTNqamCifTiM+XCWE+oxZhMwayBVN4q6qCNd99Lg+97lqcCEjP2CNUaImoOaxOj0E6NgfDjHD2ZahER4xnR0Uym/wg5uZq0TChuzup3r4tjGjYIw/IbrvttQ1I8HUruiryWe6ZSuiPDFxtKNZvxhoAYFJaqyASq2WHfBrmT4+u9z/CIzzp9tV/Kn9GoszUgr9LMYZRMnm4gMkSK0NePB49+iknpZ/nlKsfK6QnVD49svvOMyDbTkRnRAdwCdmhLK3TofO6xtOymWmwoqTSBUgyIOSm+papVAwG5dz1r0VeV+Em7Ffc/3Uozha7Q1iUmIRrflLrM635ZfkISY+XnZku2nFypcNs0aNZqpb1QJMMZ4/4MWY3zXmoDAlhebLb0w+A3ZaBWfNPgJvvqtSwqiJtoQKbN03SxBXxHKbGI1cNhTKGXNhLC56C1m/ZhbLagA0WOKmryd8KZCkAGva/dSxQnfFgUve+xd94qiAkI4by/atCBLTz/Askr3DWv0mH3ejuf6wk0IEERhXXyOYnTV2GuqYj5GLnLiwc6nyyzNMFjfgsGY86GiwYz/ZmirJ5Yj/ycRnnzOB761mh4VOkCtuXnMU1JluB36tEbv34sH30LgxogllmeL6Kcmi3aN771W+4foTm1ExnzvhhjL4UIdjCKBNlvTfaANELicncDLg7aEnPts0t3GVLk1uQXkwBK4Vn7qfajFAUzbytNM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(426003)(4326008)(82740400003)(478600001)(356005)(47076005)(81166007)(70586007)(16526019)(41300700001)(1076003)(40460700003)(86362001)(54906003)(110136005)(2616005)(316002)(26005)(336012)(7696005)(82310400005)(186003)(70206006)(40480700001)(36756003)(8676002)(7416002)(6666004)(36860700001)(7406005)(5660300002)(2906002)(44832011)(8936002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:42:56.2124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4973e8f7-2553-4cf7-12ea-08daf57cd743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 27 +++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 03284a61c1a0..5990589f8a21 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1638,6 +1638,30 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
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
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	buf[nbytes - 1] = '\0';
+
+	ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1745,9 +1769,10 @@ static struct rftype res_common_files[] = {
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

