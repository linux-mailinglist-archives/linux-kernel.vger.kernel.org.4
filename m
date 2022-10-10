Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941AD5FA64D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJJUb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJJUaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:30:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E0718E18;
        Mon, 10 Oct 2022 13:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f03lkHd39boVNF0B2v2pvV17/HC0GqdtDfdRveDzR7rXuKqLQGQtdmhB/fj7eVHEQiIC2rUtNOup2FMOuz0mRcLJrT+LwLQ5LzlOdbHWYdaHYgzR+ZGFokndwGpkfv0/CW0YXPnyfaYM9uFSncff9ceROzHeoHnmqhKN8jwA+M4cDGstFLj9PSMwFg+rgRyDB8gqEWltHSUiaUKQPgz5lTn/fN28+Pz4MmpMWXyz4jgvUsbkvc7pF00bt+JjlV1CIXiKmr6sN9s0bkVJajEj7j9/UBpU6MZWnKeB+j5Im1/M6+yPFSzGRrYFsVDiTty6HmkHoLB16HG/gQg9acTsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM+oXZbnMqpjECGTF/YoZm7z4Df0pyAytdhS/k1o3YQ=;
 b=ZtSUy60hgKBXxaG7EdLM6aIdqXoTxEl+MbOzP8QT6H28DKtwUSsJeOaIM0Wq2HLGLBwyhNmeUXBOrJ3/kNW6IdMJvY4/ELxoZjH3jV95Ke8QL7a+fjqlrqIOyZUrbDEfcyZZ/GTWsIX3ZhfEbR18iUnHEgUotMUCUSkgXlv+6ExLMKwNM10NpYw54c7nWgBZ1texncLk1l544gPTpf9IsHkNDDlOSquTLbGSBQ5QFlY7HHw/5BteylZzPX9l6gXJoDZTeM5ZFhPU0jM75vMFQAKYW9x0KR0W1ZRak4q5emBUcrM6y3X6MtrJnKAle/4SOrfVqen+3qbRDXkKvr3ZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM+oXZbnMqpjECGTF/YoZm7z4Df0pyAytdhS/k1o3YQ=;
 b=4yJGQ6uSDJox95rXQOWA9YkTRgaXkSlfzHYgbxzr2yDN8OkxHuOFgV2qePApNna4KVGtlJCdeB5b0vYAVR4scXFq3IjSQA0uM+GaUwhzCNLhwG8VgWqj2goWEp0v/Qc5K7LZ8Vwft4yzxbwBNNcOiv2s23N5LS9F4sOgYqrlBz0=
Received: from DM6PR06CA0021.namprd06.prod.outlook.com (2603:10b6:5:120::34)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 20:29:53 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::a3) by DM6PR06CA0021.outlook.office365.com
 (2603:10b6:5:120::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Mon, 10 Oct 2022 20:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:29:53 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:29:51 -0500
Subject: [PATCH v6 08/12] x86/resctrl: Add sysfs interface to read
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
Date:   Mon, 10 Oct 2022 15:29:40 -0500
Message-ID: <166543378060.23830.6262795783125938383.stgit@bmoger-ubuntu>
In-Reply-To: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
References: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: f596394e-8c08-436b-96d6-08daaafe306d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVC2NuJkgFEzsgR0Li+t93XChZlJuvNY/KZyHErdocoKe2rerH+2nrrCZNDvnHjVoPIdsHPjopBAH56OnRBLp2t+A5NV7prgtlQJcC8fzsv8oJrrt4z0UPLFSC4DAGTylojytB5sgNQgQ4cRuz3VmIP71UsqV+5h/IP3MINdj5k65vswlqrhrIT03h8wsUlsweE74XZH8bIBDQJjYwYhqlW0TwBrPLQmRhOaIEAWhUbwbTxs93o76ZX2ph9Qq93odgtFWVqSwBq5yfC4ocF2mPACpat+X32T7qXwN6IpmJwsM2r9QJ2l1GU3eaH31KAjiQ4+0ASCNm9uOds2x2rPp/L+T1+QJmSYkMdSFSEwUlk4fdwNuasV3jwSyZ0XDxd8xBq9ZbGjv2PDpM/c1ggA5UVHVwVT/FMUCHtHJ+OkfVGMAXo3vatYw2tq9B0QA7xD/4qCsAHLQyxNUaeRf/CzFxRc6AEHlfFn4220lsCztSn++5pYpt3i6RhIwFQ1Oi1BflprvpWD/Vkp7QjlcR3f7Re1cWHumMQgfr9rElSn8VqUL1TkluhLKVep2sDGM7zEQ4C5WZgNThT6fDzstDuZerbR2RA+6brQYsMjURQj+3oeOhbgsUFl8iRvKuaVdJizpH3vARtJrRv2G/2VlJvDWeN+aV119ccsVvcjYE4HvoCwO0ZuSes0VwBMcjeywxW0eP4jtSdequUjNS7m1q88O8Gx2HVA4tDtiLT3jCUX8mvRIy5YbcVKwS+PEVdQAkyOES9BOe5tS1hHRjsT9Zk0BRKW+iKKWDSEp7f1gSwUzpmnNbme1JGlnPjE+SzB5l4/RUxhn+5nVvE/VB+FRfOAbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(356005)(8936002)(103116003)(478600001)(426003)(33716001)(5660300002)(47076005)(8676002)(4326008)(41300700001)(82310400005)(70206006)(16526019)(186003)(70586007)(336012)(6666004)(81166007)(36860700001)(86362001)(9686003)(82740400003)(44832011)(26005)(110136005)(54906003)(316002)(2906002)(16576012)(7416002)(40460700003)(40480700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:29:53.6468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f596394e-8c08-436b-96d6-08daaafe306d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
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
=0A=
Following are the types of events supported:=0A=
=0A=
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
all the local event types. The event configuration settings are domain=0A=
specific. Changing the configuration on one CPU in a domain would=0A=
affect the whole domain.=0A=
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

