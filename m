Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A1662B96
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjAIQpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjAIQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745905F43;
        Mon,  9 Jan 2023 08:44:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogP88M0/epeBVwkaD6yk4DJWTTA5OTcEQUIIGFuZufZhIcZFtlVpoRGihnQ8yfUxiJLQWSgnop2ECCkVLyA26e5jvxGjnvq/pLDU6ui+J3T/QsqEcZy5YykUxM0BA8omqbxx+ZUyJWIyCMQyVjYNr5fvH+WKodt+7FOXQd1ID1/3YZ37Rq9k7cVU++aOKis+f9Ba5EONVsbxMtez0BNaqCmEe0W4x6z0//768rfIi4xuomFBKigBIZvZixRFv//1e3ISH+z0QXbKq7CGS2fLuLzQsiuL9cQm0A3I+uKLpUKhyKWq3BPsu8S8sEmlF8Q+mwlvBYcAfZ3f83UdvZ4cBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZNIE/KiQlDsnqpWez8nLH+XR/8AdS9CmM6H4W5Pkbw=;
 b=Zg0g17+LElJN2qr5py1HMD7BHaFDFTX8nleIpQ+NswCpMkqx7H3sKb4aIa23gPsI0C/nSYMWZZIe054XXo/M/X8xG3YiuYCZrBKgWucAWkFCg0J95HEaWHZNMF98vLHNdnizbNUnulE2jmeB/mB8i/+IY8K6t8oMRecIp3aSHOQefRpyXTuyaQLFzX6i7PRcayV/eu/fwkZReKdhcXz9+0nsJjtoMQNBJUFKhgea0Dw1nv5F6eUTs4i/7eeqZpfslM91oVIWYNh1jyiaHlu8jWk1/KJITxVuk9ZDOQ8AwV82O7kTtOsMVMIYN+3qYj1zDuurfxFKvy42b2cFOk2GKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZNIE/KiQlDsnqpWez8nLH+XR/8AdS9CmM6H4W5Pkbw=;
 b=MvWTbNT+6r49lv7tJFuK606ZrGzeqnxiiYxFoNtRWZvmwtk76Oecr3OqI1mOGloyPtozAQrNwMhufo62YAuvu+8liQFdxBhQa/FX7ZXWBbKkPrtmEEFkzDFsgx6GnaoTngiGFvaS9SAotOXLi7e5EyKayjOsf8ZHPeMqqeL5g9I=
Received: from DM6PR06CA0018.namprd06.prod.outlook.com (2603:10b6:5:120::31)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:44:33 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::e6) by DM6PR06CA0018.outlook.office365.com
 (2603:10b6:5:120::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:33 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:31 -0600
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
Subject: [PATCH v11 12/13] x86/resctrl: Add interface to write mbm_local_bytes_config
Date:   Mon, 9 Jan 2023 10:44:04 -0600
Message-ID: <20230109164405.569714-13-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109164405.569714-1-babu.moger@amd.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be6ccb4-a575-49ea-2db9-08daf260c931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZNaaf60Y7XkqTN3/OeylUz7fXnd2mdFdnAdR+kmrjbJ72/DJUs6y+p+oxWbH4mPc4NqkO6MzMzkLMPYdAxhCPJw1sO1lHFErqGmz2OEsn8OzBp2zHg02z9LJBLEVwl3adYfVaRGw1WSR7XUf3lvMwmmGvrs7M/pQnWDBE66Jg6UA3TSBYfGZeCOXzXZtffTLGpaux4OG3rY3egBT2aluwlMJ9X0rjOpfs/r9zA5nyHPPnFolQbFre9BL5uyb4PI8+pEx5C/tBwEZ2IaJL05kcTz02MbLd8Ndcz4PAVNo0qymwXXjZq4XbO7vkBwX7thbn9hkVxMaVVqav9dKdqdGyYT1/7K9bzX2KdK9xviOQ5P3Kx1/fXFvmDW2WMVBijGA6S5sFq7Kl+RZknhC5ojTMm3RzDK7sUQfHhhMrP9QT7iPnL7cn6hbYeAFGhthH5ah917Vb3Q8zGZnJTd0BcLocF7c2ZDV0gAwNL3RVbbAXVKMc7mqS8p0Vgqd/zSnfm/oCpu/KHZY2wirM3/QF2UpmfDbRltIh+7pdtZPCOeiFckNNHQOjvs8jOX/BFDzzk27y0WcA6/1ldoKheG0lefWDiLImZMhTipeIbuwie+KPUUI3fWf3CH8oe5dRA1OKrHvtJMcMyM2sSpFUaPuc8Z+Za8SCEJw1yifOG1SNXHLxtjOzWPtzBe0tAsMlpL6J6faZ1phuaxJLHNa5kRLKZg/zeY/S2MZ/FGw0akuZW5mug=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(82310400005)(44832011)(8936002)(36756003)(7406005)(5660300002)(7416002)(2906002)(8676002)(70586007)(70206006)(316002)(7696005)(110136005)(54906003)(16526019)(6666004)(47076005)(40480700001)(478600001)(336012)(4326008)(186003)(26005)(2616005)(1076003)(426003)(40460700003)(86362001)(83380400001)(36860700001)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:33.1790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be6ccb4-a575-49ea-2db9-08daf260c931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
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
index 21fdb4a48a11..9fb8e32f4d00 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1636,6 +1636,30 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
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
@@ -1743,9 +1767,10 @@ static struct rftype res_common_files[] = {
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

