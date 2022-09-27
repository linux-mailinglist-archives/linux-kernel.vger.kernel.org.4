Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C45ECE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiI0U2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiI0U1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:27:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A610BB03;
        Tue, 27 Sep 2022 13:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqLgqwPJoaRYtSWpq3sL3p0+LT6TE/lWLFgtdArrNEoWXfHiJgvXkfzOcq8e271O6nOkViYiIOz4wKSYlYEst7JgLXgcZa/cq2lOj9YUfCBqJnBKq7NVlh194bftsAipFjtN499rWtXj3XpO//z0WrxFK6LbmYmrkQUrV/Cfnmv6Jo1k1GD3mcRmEfMCFg59dRRFvNACegoptSB4Oe8ppYS8BXyTYg8BCrfpsv34AumJ9s2uZdQrP54TErQXtTRPxqjjGd51Uvq3m7TCdRfFiQT2d5EM5wE9R/I7cDNCZQ6FYSu5/1c0+zlqdG0bjhiNoDigtxN4qxPZl6XSN9iPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hwEygO+ZtpSMiCjBNfp1j9GBV3SnDG0PPiBkcREekM=;
 b=QebQQ5pMMSeYY/5RYHA+UhhINWuQ8dv0nJIC7c30ixfja0u0NS3AOOS5YlvZ1ykOeeP+lA4MfJ93E34qPBqmBTBAecWJkvTa1BzhSpK9+UFGD10qTUIHo2q7aaZXDjOZfNZRWYLQHVWqJK/BGeVZSKdbQr7zkj8VNPd1+JowBgrqvf382+az7yqPqCuzhKvNSSI1oGZh7Y0aBekKWxzh0dF6aolq87JRPzah5OYUn7ZG/m3EaceRcaTSwxiTxt5eQ9Rr/Uv7tZQOXMmiI5sVvuUWdidfiNJ40cQ3BUjf6z8cuRNG5Z+7+/QFa3d7v6ureT6tVbbJLNE4J512iwlDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hwEygO+ZtpSMiCjBNfp1j9GBV3SnDG0PPiBkcREekM=;
 b=l/92k3uZp3GDDcLphgwKyxOMHlKHcJmZRetD8XGJgWA6JMDsGYOzBA9eazBpL3+gAyw/JwG7CEGehIfTtTt9qNLEeBEuVTgfPyKSZvDHbV/qWpoYz5tKWINwcDXqQo5uhoFanK2ZFCR6Vuumd6DcNqzpiyLq6KEPQ7zJ2af1Els=
Received: from DS7PR03CA0108.namprd03.prod.outlook.com (2603:10b6:5:3b7::23)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 20:26:49 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::5e) by DS7PR03CA0108.outlook.office365.com
 (2603:10b6:5:3b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Tue, 27 Sep 2022 20:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:26:49 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:26:47 -0500
Subject: [PATCH v5 10/12] x86/resctrl: Add sysfs interface to write
 mbm_local_bytes event configuration
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
        <eranian@google.com>
Date:   Tue, 27 Sep 2022 15:26:46 -0500
Message-ID: <166431040665.373387.16611336653801046307.stgit@bmoger-ubuntu>
In-Reply-To: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 3006a763-18cd-4f94-263c-08daa0c69b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCIxxsjCwbxIpZVQO5dBW4oxUHmh2EeyWQomXLDIDvs71bmMEpB3eCiw1tlOyGB+8TBs6Vs7X4JOOflYr+XPWbVQPTixIcQH9cL0htj9ys9qgRFPVRT+9pGNp/Ie8bXRKilKdW3kYkrbyNIL/HRolTeAzXshtTZk8s9EUo2EW/QH1zdwCePop70Bl/HHDLp+AdUz5JG58IgbCyI6vF//VWUsnsZ9ZjNpAQafBeVcOX0y5XfLm83U4YBCgE6BwJw/IQR5jlRhepVqJ3ZNNhr0lWjMixHbWZQyZBuaqw8QKJOJ3bQX0y1wU58c+R/KDZaWAoL2u9wY44G+nmHO/vY77cjNhbnV6Qekbxu7l510xMEJDgQldKevU7NTaiYM9Ycp7JaIJVjDv2KZS9U2XLDDTqSoBx2WWC6IxhEtbILRdp4U5+4muwws6B2pFctLx+Gh/atMBYvId2nf7cf8+YRi2dnn7/8CAwSEKNde4avBuVy6WbzQltKca4VsDb0EwLpe/gySasHLGujwXMKYrDgcK0ZNEXBSHIz8RZyyS9he80BGt0yPI0AmKOlcbU5f7JM1P3/vYDLGw2UQ8mH8pB7sFS4yKTIJRp/8JcFQVNREo2Csg0JoZtUL5+Eyp7gGIwG84kkBW43Fm8GlGemrfQxS7TyoB/HJ4z99nLP6YLcGTbdwyur0ZPVYICNb/Ev3X9FQWbEBmZ2Sd4Aj+N5DkaU/ClnqAPv5KLCFUrQGCvTYzfu2EMd4JCoLsmQb8VkSX8CY9SmnyyTgI96i958cE6PnXnX3vfqPlztJn7WnyDAVDi/Q71zwwv2gaTZwyHp7ImJjBVJGqYlkJ40MnZsJHu6iLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(9686003)(81166007)(103116003)(70586007)(336012)(16526019)(70206006)(33716001)(186003)(2906002)(82740400003)(40460700003)(356005)(82310400005)(26005)(8936002)(426003)(41300700001)(7416002)(4326008)(44832011)(8676002)(47076005)(5660300002)(36860700001)(478600001)(40480700001)(54906003)(110136005)(86362001)(316002)(16576012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:26:49.2190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3006a763-18cd-4f94-263c-08daa0c69b26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current event configuration can be changed by the user by writing=0A=
to the configuration file /sys/fs/resctrl/info/L3_MON/mbm_local_config.=0A=
The event configuration settings are domain specific. Changing the=0A=
configuration on one CPU in a domain would affect the whole domain.=0A=
=0A=
Following are the types of events supported:=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits   Description=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6      Dirty Victims from the QOS domain to all types of memory=0A=
5      Reads to slow memory in the non-local NUMA domain=0A=
4      Reads to slow memory in the local NUMA domain=0A=
3      Non-temporal writes to non-local NUMA domain=0A=
2      Non-temporal writes to local NUMA domain=0A=
1      Reads to memory in the non-local NUMA domain=0A=
0      Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
For example:=0A=
To change the mbm_local_bytes to count all the reads on domain 0,=0A=
run the command.=0A=
    $echo  0:0x33 > /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
=0A=
To change the mbm_local_bytes to count all the slow memory reads on=0A=
domain 1, run the command.=0A=
    $echo  1:0x30 > /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   21 +++++++++++++++++++++=0A=
 1 file changed, 21 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index c1d43d03846a..87f3f8018c92 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1629,6 +1629,26 @@ static ssize_t mbm_total_config_write(struct kernfs_=
open_file *of,=0A=
 	return ret ?: nbytes;=0A=
 }=0A=
 =0A=
+static ssize_t mbm_local_config_write(struct kernfs_open_file *of,=0A=
+				      char *buf, size_t nbytes,=0A=
+				      loff_t off)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+	int ret;=0A=
+=0A=
+	/* Valid input requires a trailing newline */=0A=
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')=0A=
+		return -EINVAL;=0A=
+=0A=
+	rdt_last_cmd_clear();=0A=
+=0A=
+	buf[nbytes - 1] =3D '\0';=0A=
+=0A=
+	ret =3D mon_config_parse(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);=0A=
+=0A=
+	return ret ?: nbytes;=0A=
+}=0A=
+=0A=
 /* rdtgroup information files for one cache resource. */=0A=
 static struct rftype res_common_files[] =3D {=0A=
 	{=0A=
@@ -1739,6 +1759,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0644,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_local_config_show,=0A=
+		.write		=3D mbm_local_config_write,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
=0A=

