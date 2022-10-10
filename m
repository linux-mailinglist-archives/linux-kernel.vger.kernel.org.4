Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65A55FA652
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJJUcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiJJUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:31:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6238F75CDD;
        Mon, 10 Oct 2022 13:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSnDGZhOYeEsF6oLEhusXlG4J+u7sU+A6wedt9odjsDo/ZII25kIHzuMi+iTsCuPxEdsNZglqwHrEN72AgYsCJpQqtjkF/HsjVx1Hq0f7rYxPzJJvZ03H79ASUJ7Wvv9gdwfF/m3Gdqiosb3xFrAfU1Y5Kraik7JF3SOYN4esEu/92nCZvsLY4PAM4JShgYsb+3BFsfmDOg9W2e3rPVtwkaWcXMg9OVDv9rcAkeywVK8VIvMvC+uEQXdM97I4MjBb5vdScKcALuADkLY6saEfQrcCrBHLgzuGMEwwjRG59x1UHtzOvhGBy+j1h5Q2ujMH8GD2Hl+sV+JQ9q4RwxZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9c457DaMouXXgIbBNk2nk4XR8CR45Nt+k9MDEZnUUY=;
 b=UYShcyhtNDOXyPNoNqk9UmFcSUJx7x8ELUlXtcnpX20Ea0hlNLrTjfwD9CA4YGIGV8xJlYhtzKm1UkjZgMj+xY5luMcPfLFxQekNYe9PXrANEcNpdHjuqTk7+kSBL1eFqI4IanlsdUIujM78/3OhrqNegqG99+Ekn9WSyyKD+0zXnRIRHjOPi551hpXjSrchBB6L1iCagfBFL6EXphy4KMoss+b9af7ohvXnyqKsRM1A9JhWIOIxdelxyWxnI1yYr5Lmi43ab7qaQa2r5omfg9L4vVfU5qMT9kRIR+0fuGVHSjdn+rVs+qpcqH4dv4MSVnMVfOY09xy4YTm0ADWcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9c457DaMouXXgIbBNk2nk4XR8CR45Nt+k9MDEZnUUY=;
 b=fpxHFzZiIvZdqogMlQJJ+ORLciSZLE5qU82CIzqNcoCQEjIZe22mpqDw2WvEOla+z+J07+zk7SvK/y3p2UPItIHKY2VTDhm+Z2IUICj6E0hCSalywtMeyJ5uHSrmBt9oBjXRL/5wuZyHnfan6ThyPTSecm72tpnAqe6u2vVwpfA=
Received: from DS7PR03CA0186.namprd03.prod.outlook.com (2603:10b6:5:3b6::11)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Mon, 10 Oct
 2022 20:30:28 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::af) by DS7PR03CA0186.outlook.office365.com
 (2603:10b6:5:3b6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 20:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:30:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:30:26 -0500
Subject: [PATCH v6 10/12] x86/resctrl: Add sysfs interface to write
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
Date:   Mon, 10 Oct 2022 15:30:10 -0500
Message-ID: <166543381031.23830.5870006320102530890.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ad2eae-22fa-4de3-94e0-08daaafe4516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVeZCFvXFYnlRMg0Uun1ig2XJf5kqAVB/0eBdeBx6HJDoccu1fUgzpWP+AB1Pcg6hjgrIpqsX04hARJCeAWDcyf7x8nhmbNZqNn9xhlHiqN3lW4yyTY8juYrxwvmzJsvptrlC3rd8Spn5PFKlfNl7UCiUizA+G08zLFinDWZTHHFJZT6IgB1G7LxBQHkN0ln2Mh2xYwEzmy+K5I3QaYpOCo3PMyocdXZSaQ5BnmGve7G5CqBaIaQRQF8hhjTwBuJNfNGfFNud1PssB6B5VIZ1On8O+s+j1CwWqcSTJweAsi9cOtO3TsslQSwD/jMX2T5TtBQxrFosZ6IFZI8dTfR5Es7luAhNaOVn1hM7Kx3TkS2FJtJ/FzMNOWrAp5MI1ScBFcFB+qcCp5tFIeousMtmEBvuzirMFKVExvfZTylH9bLdDTzJcq6n6QlC45BZRHIVLSzeEzayjOGLHmcAaQ0xJT0UByef+nnttF/qGhInmPJPbjGaRLvgt5/LeQHve+yYlnxujhMtDnw/2ILorGVZgvjYB9MZRXPzgGbnMRsq5ZofKUnO4/8NnHb6RTNzwXsyjwPSG8sAZR8OwxVrWbcbTmpxORHjYKuQ9Nyf0sERVZ7W22VFgNDk3upm1hZJV2Nq/uIqNoB1nj5KdTjdAazkScOuRa43icvuYHaO1PJg65Ltex0nTzjzim38da4eykCaCMXjJaWEnJ0W+ksYXAtaOuLWw7eQzNg2WzynYAR5TK1NsOaJxc6UUYHbJEtki/xL4Twtpiq0xtdEh0gSvIp7YiIW1XDf79T+W4HrRYTpoLNfFPe8jxGuEi/pE6caBa0oem4ur8F/ZDRb8JGbCbCXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(110136005)(103116003)(86362001)(82740400003)(81166007)(5660300002)(7416002)(36860700001)(356005)(16526019)(47076005)(426003)(186003)(336012)(9686003)(6666004)(26005)(478600001)(54906003)(316002)(16576012)(70586007)(70206006)(8936002)(33716001)(82310400005)(41300700001)(2906002)(44832011)(40480700001)(8676002)(4326008)(40460700003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:30:28.3244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ad2eae-22fa-4de3-94e0-08daaafe4516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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
To change the mbm_local_bytes to count all the non-temporal writes on=0A=
domain 0. To achieve this, the bits 2 and 3 needs to be set which is=0A=
1100b (in hex 0xc). Run the command.=0A=
    $echo  0=3D0xc > /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
=0A=
To change the mbm_local_bytes to count only reads to local NUMA domain 1.=
=0A=
To achieve this, the bit 0 needs to be set which 1b (in hex 0x1).=0A=
Run the command.=0A=
    $echo  1=3D0x1 > /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   21 +++++++++++++++++++++=0A=
 1 file changed, 21 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 25ff56ecb817..e744db5dc057 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1639,6 +1639,26 @@ static ssize_t mbm_total_config_write(struct kernfs_=
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
@@ -1749,6 +1769,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0644,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_local_config_show,=0A=
+		.write		=3D mbm_local_config_write,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
=0A=

