Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC1C601C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJQW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJQW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:27:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA1C82624;
        Mon, 17 Oct 2022 15:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4TmJ4y+0NfbccWZXWqOTl2tZits9amX8XggFfmzNhwCV7zETgZOVj6fF102BpWqpZLWKdSuPYC+Nyn9GT8JYsdzQGkLi2bstcYJsvQz00HHhTUT88msK57GkPMD2OR27+BZ43OSs06h+MkwS3hL7xkFAjigOcYMUUTfwXGHXNWf8aT+rfZM4wtipJjzu9Vd1ygA+IdCAsww4dn5P03IHsN7h14XgFkQ5HqmAyY/4u9vcYYPgNn8PTItGZF2OgSuA769kV6IBfW1twmEIFzBP3m6jacYnWXt7Fpa0YAJtqtmfnbhoy2RV2RNOtr1ejgWVj6zN9KKrs33/FKe13JVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hnahesWWNyTbNZ1ButkTkUbtkZsNsmt8fw8JaY9VI8=;
 b=R6333LvD/bMGM+MjY1OVYD0+RC1SwDL96HYb54BQfvhGOo+R/8PyZCWFbC7JxEniF2JctXZOJvM8Np+Zscm07AkVFgT+Is4OeoTg8YwShVhEKEd1kS1DwlW8P5XCz7aIpUufjqBdUv29ms8umTJRVkWG8/Z0O9O9DyAqtqVBr1jT3xGh79CD+rCTQ9nUgMcxzBRkUWSEOiT9jZL8TKmqXvQhHT9WkrvmTa5qKPXWZFleoayvzX53sqS1VcDgoXbT178APKDuuy1fPMAlgvgaXSjs9S5a4CnyOcueK19NsmMB5GRWWTUMceyDSiISFG3q2ArCr85f/RhL7MdAiaHg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hnahesWWNyTbNZ1ButkTkUbtkZsNsmt8fw8JaY9VI8=;
 b=QoE6aqERtl9jtnlqOu3eod6WWyQGLh2FUlzGaS7zBG1+y/cpn1O9Y5aP4TqyM/skV5hZwu3BeRAM2ZTRvsOIFvVvJUTO9Unif4399cfy8zeR04j/ggmeCU8hTH9SkVLaWr/zY3zMHSvmbF8aO3WEXWdWZhRJF4l1KUMeHM7xS1g=
Received: from BN0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:e5::9)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 22:27:09 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::86) by BN0PR02CA0034.outlook.office365.com
 (2603:10b6:408:e5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Mon, 17 Oct 2022 22:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:27:08 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:27:06 -0500
Subject: [PATCH v7 08/12] x86/resctrl: Add sysfs interface to read
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
Date:   Mon, 17 Oct 2022 17:27:05 -0500
Message-ID: <166604562588.5345.8522911881213355951.stgit@bmoger-ubuntu>
In-Reply-To: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: f72fade5-c9b1-46dc-6c4a-08dab08eba4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NFwFSB80bKTSqNj3JYZ8GdnRRYhDZMer/tYkVPgJYHdNmvuSJgz9pgR08JEzI8exblPB0RvD03JMPIu1tf9AtSA+gBTk1mEc3gP28Y21ooAI/Gl7queu6W5D9Mc0RyZsOzCs7BOAeJ5FEkBv6yZcTtnXd+uFrAPOFu9HCObRMlHAVTL5smiXFov7HxxKEwcXMy3VM3BzEaWiHWSGrzunCsCjGanpIMkyTVLtvEDW9Vr3TZSQl4V8/nNSzNTsbQVAGvfpgnv0y/PKL3ANJINUYgSSdA1a6IaKWZtFIK3EJPdrQg/yBpf02SjElZYF+1UcH/Xo6o9FIS4YwKe6KHLE2ZEFlNVnyapuDHLkWA1mQb75YIst/gf7ykP34BcEoMBUUb/tGTdlb7Kr853lO6mFIrU3+owlutxDQRc0ywjLPyezuGGga0Ly1g9p5SJdoa9JQuAvQL7DJnQQPioPj4DQQh+p6y7EMfIG5G5Y6EXkUCD3696S9ub5XGFWjdX0tunDzEv41BGbLCyCVJJV2cNwbqgdulMEu+ZfKw98qPFPdwezDgovcGXIkwtoQTGr+/pXDuAb9Er9c5dL6HGRLFm/2c6jVKuCK/2UjHSEamJ1O7Hyjqvm/ITv9edzegN7D4TKG1ohrwyY9PYcAKtKZldRFSIIhMRnZVF4JTNBHaOFlxcEQKq3awZRulryvVjXot7dszBD02jOubKQH9qnQ33XyhJOVThSO8NvjysbU9D6Gcq2wDKIsK0JoawZdc1l5vxBIHUltgACZX8xjqRd376FND62DhzhY64yxJakgpdnR0uAAs6TSwQWmY3+Dm04+3PsSKd9mnEscIBiHR/xMI9eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(316002)(16576012)(110136005)(9686003)(8936002)(54906003)(2906002)(336012)(5660300002)(26005)(16526019)(186003)(103116003)(40460700003)(7416002)(36860700001)(44832011)(70586007)(70206006)(86362001)(8676002)(47076005)(82310400005)(41300700001)(4326008)(426003)(40480700001)(82740400003)(33716001)(81166007)(478600001)(356005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:27:08.3424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f72fade5-c9b1-46dc-6c4a-08dab08eba4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current event configuration can be viewed by the user by reading=0A=
the configuration file /sys/fs/resctrl/info/L3_MON/mbm_local_config.=0A=
The event configuration settings are domain specific and will affect=0A=
all the CPUs in the domain.=0A=
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
By default, the mbm_local_bytes configuration is set to 0x15 to count=0A=
all the local event types.=0A=
=0A=
For example:=0A=
    $cat /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
    0=3D0x15;1=3D0x15;2=3D0x15;3=3D0x15=0A=
=0A=
    In this case the event mbm_local_bytes is currently configured with=0A=
    0x15 on domains 0 to 3.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   20 ++++++++++++++++++++=0A=
 1 file changed, 20 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 0982845594d0..305fb0475970 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1484,6 +1484,16 @@ static int mbm_total_config_show(struct kernfs_open_=
file *of,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static int mbm_local_config_show(struct kernfs_open_file *of,=0A=
+				 struct seq_file *seq, void *v)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+=0A=
+	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /* rdtgroup information files for one cache resource. */=0A=
 static struct rftype res_common_files[] =3D {=0A=
 	{=0A=
@@ -1588,6 +1598,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_total_config_show,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mbm_local_config",=0A=
+		.mode		=3D 0644,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D mbm_local_config_show,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
 		.mode		=3D 0644,=0A=
@@ -1701,6 +1717,10 @@ void __init mbm_config_rftype_init(void)=0A=
 	rft =3D rdtgroup_get_rftype_by_name("mbm_total_config");=0A=
 	if (rft)=0A=
 		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
+=0A=
+	rft =3D rdtgroup_get_rftype_by_name("mbm_local_config");=0A=
+	if (rft)=0A=
+		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
 }=0A=
 =0A=
 /**=0A=
=0A=

