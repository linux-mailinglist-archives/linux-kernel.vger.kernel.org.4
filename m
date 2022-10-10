Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9943D5FA63A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJJUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJJU3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:29:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490941EAEE;
        Mon, 10 Oct 2022 13:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxzQO9nginFjti2Y5XFBxW3zXKXdNbZ8EqS6ASI+7wQG8EXfhG6qBv+KcLDPqUn8BkY8W4xMgTiJs566ayXFXXj1x/86l1h7vPEp/foGRJVPAZijm+HLIwEIAzvJJE6ICIvA79lsIPgssB5bYc8NZYHLzgr4t75Yi9HVawnMHHDfxxcmE4jBtzPUk9+H2okGs/ucaL9uvq9q5CioTOXH0ryxCwZZ/Ijk+AIaC1000wTUfG1t2eFJ/VMtErsgba37pwYPJlqey4Nr0EZPXxG0chY52Mfkzi+4bOnHj6MIyc9Bc55LOitvzTw3lPXthUqJTWrjTSA/xgHAnx4aP/m+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXUWND517tmbByaWEbc2CT2bAWf2K7vLcbL3Ozw2Fjc=;
 b=OPgTQ0zYI5175IxE978Svx6X2opMAMXlCgWAp+XHEqXMj79XGycD+0egqcPyQo/XLwzdlT2bj/5QpdlTQYwxMAQWYRm65Hlja0aLcftaWrWncwg7adyJnbnT2yCs0cKntJJtttoTkAbYRVkF5R9DqjF9OuA5p5OkZAFj1XEN9LSWj/m8EJg+QeUD49mlGxH2F/MgFeLnYcC2eRk0kjXQc6sNvK1Bk9/m4sakkNiAzLj2O4ifq/NArWcvrSI4im1KlmitR5w4phtHf8hZV3XiOSrcYxdWXdjemvBtFodtQCzd8RRjva5VzmYZXitlkdGHj36Cdx1I+LnvfihQcKzCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXUWND517tmbByaWEbc2CT2bAWf2K7vLcbL3Ozw2Fjc=;
 b=zn2Bou18Z/a9rLYKw1BmkHfkM+bLadEDbYNvJGjTf842fO8dGzXBlxwH00BU0lIq9kqwXnN0qDwG7VIG9RJcXmzS6pvmyDqjU02yUb8PakBZRQTPS2NIJB5lB9hx6JFFQA15PyPRgDCj1yO3PObdk6Jt8yxnoHTMUnxjAjCOMHs=
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 20:28:47 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::4b) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.10 via Frontend
 Transport; Mon, 10 Oct 2022 20:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:28:47 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:28:45 -0500
Subject: [PATCH v6 02/12] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
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
Date:   Mon, 10 Oct 2022 15:28:44 -0500
Message-ID: <166543372483.23830.14249332360278807042.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f1d1e1-2ee7-4dca-4fc1-08daaafe08f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyxVbjfl0utLKVFJaTXpPKUHVpdB/ue4UrofL5Vn25Kr2eLaywmTEFXBRp21FPL5BKljNLIONEY6oj01VIzZPQFaW/dNWV205YqwjN6P36UqMMXm1TL55FE/GEsr6kcyLx1VAqGS+EvoLDs+Or8PszQaEIc+i3XYjyuhnj2C90dj0bbCLMrdNJ0i+VDb1Tg1+KkWwE2eqW54gUtBRFF9EO+uwPlCB7tr1X78msjKyuC79sr3CVEmxol9OAxOYhzAt9zaCKzc1xLKCPETf5lcfK3RXB2XJSHUKU9VUKIWXyYBG6sytnlXw4KkHoczxk/n4W7fEkd73+HSrZUEmPsph1ajk0wJW+9Jxtcj5aNIio3SXQjws4hR1rLlPpxHzWbvP06rbEDohXnz0sUDG3vbH6AKWo6XEV1Lr53e/2p4MHtD29RruyjFFnfUvB3sIchGLrQ+Ein+YdD3+A0ekSabr3bApKZFgfoHlXfOy6/Am1HQAwHxBTl+cAYbx1ULUZU9TNtQNdqVxBjs7iOWINAsd6vLjX+yP/4vyUNvYYtlv6DeDApE1r2Z6R3pmrjDsZh+s6u+c0IGRpW2j1XdUkJ9ewDe/oFs29P7o7LtODmfTT1Y1PMXVmp/9rFKuW4Rf4PomTmNNxNErRPqxSyjFMpGOlBkfkvXkYUsWDZ3W00JMKJeAfcp+QrEP7QypY6i4MHHh4fC7dXv/ZJnoVnO8ueCkrBKbsKENDGmwQ0eZSCXkgSNqjOg0M++4gzbyPa4UbxqiJ+/JYajCo7DZ3homTDUU5r2T8e22P796DY7kL5TGzRYnrKzfUExHQMRZuG+IznSr+DHgvegleA8K6GrbIk97w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(8676002)(8936002)(5660300002)(2906002)(7416002)(36860700001)(41300700001)(40480700001)(110136005)(86362001)(316002)(103116003)(16576012)(70586007)(70206006)(4326008)(44832011)(33716001)(356005)(478600001)(82740400003)(26005)(9686003)(81166007)(426003)(82310400005)(186003)(16526019)(336012)(54906003)(40460700003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:28:47.3543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f1d1e1-2ee7-4dca-4fc1-08daaafe08f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new resource type RDT_RESOURCE_SMBA to handle the QoS=0A=
enforcement policies on the external slow memory.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |   12 ++++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 2 files changed, 13 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index de62b0b87ced..efffce716f3a 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -106,6 +106,18 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.fflags			=3D RFTYPE_RES_MB,=0A=
 		},=0A=
 	},=0A=
+	[RDT_RESOURCE_SMBA] =3D=0A=
+	{=0A=
+		.r_resctrl =3D {=0A=
+			.rid			=3D RDT_RESOURCE_SMBA,=0A=
+			.name			=3D "SMBA",=0A=
+			.cache_level		=3D 3,=0A=
+			.domains		=3D domain_init(RDT_RESOURCE_SMBA),=0A=
+			.parse_ctrlval		=3D parse_bw,=0A=
+			.format_str		=3D "%d=3D%*u",=0A=
+			.fflags			=3D RFTYPE_RES_MB,=0A=
+		},=0A=
+	},=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 5f7128686cfd..43d9f6f5a931 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -419,6 +419,7 @@ enum resctrl_res_level {=0A=
 	RDT_RESOURCE_L3,=0A=
 	RDT_RESOURCE_L2,=0A=
 	RDT_RESOURCE_MBA,=0A=
+	RDT_RESOURCE_SMBA,=0A=
 =0A=
 	/* Must be the last */=0A=
 	RDT_NUM_RESOURCES,=0A=
=0A=

