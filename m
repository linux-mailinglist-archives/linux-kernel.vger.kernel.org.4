Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE4D743380
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjF3EZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3EY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:24:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092AF1FE4;
        Thu, 29 Jun 2023 21:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnLIvOwFWHNjaSh7VP+2h7ANh3S9i578rUeF9peeOyPZAjfZUAw5SpSFr8k79Et5/zzGN3ELcoqZMKODWmp1XfZA2d+mDpZZsoIFv2rq/jIRr3d2dt7iaHFhqVHqfZDhDy7xV2oO7MBEhXFLGMTV+vGDpDTLauQyoa1zSic8xAJYqN0EINyHd8U/900YZ6cIti0ZIPa2hJ2D6I4jjEhiN7aPGiTIyNBMNeJHU+XNhCel7Vvmi609+WIxrVq3JM7UypGdbNqg81xKxs23MArKP1JyddV62BGClJpiawX27nFUsTGwQNNOETKfEabJcmfkLQtr1AIxelElleCwz7jbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2VdafCqgjlIjfQcPApAq7OBBT127Sy+bPj65GIDT+4=;
 b=icOrdWKj1PllwVpJx/0yiDn6SV3UIiFxL0dmFGLTzUit/nTYyHz/ZpUsxUvLi+VBBEf1GVHUZASiWvn3vDPKdSb1Bm5L+qDU3A/70mY+GNC2K7Z9JjoRn/mAWHOOIo4DFcrdf4TED9hPfWrRe3mSTpgdJfLZoqvS5h0WiYPkiLoAmlITpfOHfQeLo/jk/z3WAYMFGdvIWtacWN36oqC99bKQ/xOgwZZeY9Q2mCnDoRMmSi9rYX/zhTtU3M6x4+ZmSFGLBeIJETrShTIHIU3CuEbKorS1eKYMVh7ARqRVUOPNvTumV03U10GDJn9O/kTUG88e76OVplF7/EkZtUqsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2VdafCqgjlIjfQcPApAq7OBBT127Sy+bPj65GIDT+4=;
 b=edZyEJJu9EHemWh2Jv9fhvdyOaO3ASDgKTlqL4xfpK1mhIHxgAQ8F9Nf+Djofze4PqVV6xUS36uOutjW7fZRdQ3abkwz2Kw5vUWqO5Yi1wXgmCmYo/54VnN76cGHJU7QSAxWVvbnGhyhWe7tSHFKe08GqdsR759+0NkdcGZVagZ+i4q0txbfHugaVBjfGV31qE+eE294Et9+lKY45MHOyI3opJ1BnOM/u79YtGNwzbpFTKwlPl2U5bbmX8JrFHO1CEujWloaS6Yaatw4k8mnOIC/45iO4rVvva1VewNcO18W4kOrBq+4pzjTUrUMnsQGag2tyaDNGe+h06poVKaVdA==
Received: from MW4PR03CA0120.namprd03.prod.outlook.com (2603:10b6:303:b7::35)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 04:24:45 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::6) by MW4PR03CA0120.outlook.office365.com
 (2603:10b6:303:b7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 04:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 04:24:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 29 Jun 2023
 21:24:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 29 Jun 2023 21:24:26 -0700
Received: from build-abmainkar-20230620T092408093.nvidia.com (10.127.8.11) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Thu, 29 Jun 2023 21:24:26 -0700
From:   Abhishek Mainkar <abmainkar@nvidia.com>
To:     <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <abmainkar@nvidia.com>
Subject: [PATCH] acpica: Add AML_NO_OPERAND_RESOLVE flag to Timer
Date:   Fri, 30 Jun 2023 04:24:19 +0000
Message-ID: <20230630042419.1947389-1-abmainkar@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cd3b28-20df-4f6d-b01b-08db7921ef24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIrMOAeHGw11N+FnH4kssbP6tGDfvo+ptldhCBx8Hp45gzylzQEcQ6pJzpmOTq5Oda196x8NG8VDhghHiOidhZXoU5V7VHF86ikcUD2lf5HIWkRUm2p2Se+btt1GzQVHzRvzcrDtFXIlQNwhcMDi2nQKPaTxtxvhKESj6tdAC/tCXkmXHf84I9xJjnPTcCbCtI50wV3eDgFOh2OQN1tbgacJCVQo1z7Tm1RIV58d4MpUgeQFqBrqEiACZWtOJBeERunbo40x8i9uHkHicGJpDX0Ghu1klFvhCT5NvsrKrWQJFoPGX66nekBraislS3qsevMfsIK2+ffzMM+VfONaaXN1NffWvrddCx39yQtZAFGMfhV42lpBvlfnaV1bzpAE5hZa4dCGUfk76dI05lxFCVs9oNCpkcB0TEHHaaq9kiZlmod3zntBYZA+PoHctcZ/lVNWVqGyHBF9ya3Tbi6qCEC+8atBkzf7hJ2rbUb15xDzJXpppKvucjyeZaEODFyZ2Qzf+chYn6tPZgi8bFOMHyLzhjCGlsw1b/zI9wTp0sginDKLXr3+/fy8IjydZgyfKlHLewtK12hKvG/EmpuvebWTvCjvE3UXpa4drAeYnPu4PrTuLPhR17PU0j/olg2/MUb1XU75dGwoZ4tWFjYcUpk1ceq+aMJD3ZS0C+q0fsWnvyhL/xeCW4/VI25G8hXU7K1maxisp9X+d97ZPo8Zb6XBH8dHrd+5NTi01XtH5uJ55dqHg1Wha1o16Hvy9knhLrT37xd2sp6Ga+V6E06QhvheYDm9Jh11NWKMZTNcalc=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(2906002)(186003)(7696005)(82310400005)(40480700001)(86362001)(107886003)(82740400003)(83380400001)(7636003)(2616005)(426003)(336012)(47076005)(356005)(1076003)(36860700001)(40460700003)(966005)(110136005)(41300700001)(54906003)(26005)(478600001)(70206006)(316002)(36756003)(4326008)(70586007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 04:24:45.1879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cd3b28-20df-4f6d-b01b-08db7921ef24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the ACPI specification 19.6.134, no argument is
required to be passed for ASL Timer instruction. For taking
care of no argument, AML_NO_OPERAND_RESOLVE flag is added to
ASL Timer instruction opcode.

When ASL timer instruction interpreted by ACPI interpreter,
getting error. After adding AML_NO_OPERAND_RESOLVE flag to
ASL Timer instruction opcode, issue is not observed.

=============================================================
UBSAN: array-index-out-of-bounds in acpica/dswexec.c:401:12
index -1 is out of range for type 'acpi_operand_object *[9]'
CPU: 37 PID: 1678 Comm: cat Not tainted
6.0.0-dev-th500-6.0.y-1+bcf8c46459e407-generic-64k
HW name: NVIDIA BIOS v1.1.1-d7acbfc-dirty 12/19/2022 Call trace:
 dump_backtrace+0xe0/0x130
 show_stack+0x20/0x60
 dump_stack_lvl+0x68/0x84
 dump_stack+0x18/0x34
 ubsan_epilogue+0x10/0x50
 __ubsan_handle_out_of_bounds+0x80/0x90
 acpi_ds_exec_end_op+0x1bc/0x6d8
 acpi_ps_parse_loop+0x57c/0x618
 acpi_ps_parse_aml+0x1e0/0x4b4
 acpi_ps_execute_method+0x24c/0x2b8
 acpi_ns_evaluate+0x3a8/0x4bc
 acpi_evaluate_object+0x15c/0x37c
 acpi_evaluate_integer+0x54/0x15c
 show_power+0x8c/0x12c [acpi_power_meter]

Link: https://github.com/acpica/acpica/commit/90310989
Signed-off-by: Abhishek Mainkar <abmainkar@nvidia.com>
---
 drivers/acpi/acpica/psopcode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index bef69e87a0a2..8c34c0ffb1d9 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -603,7 +603,7 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 
 /* 7E */ ACPI_OP("Timer", ARGP_TIMER_OP, ARGI_TIMER_OP, ACPI_TYPE_ANY,
 			 AML_CLASS_EXECUTE, AML_TYPE_EXEC_0A_0T_1R,
-			 AML_FLAGS_EXEC_0A_0T_1R),
+			 AML_FLAGS_EXEC_0A_0T_1R | AML_NO_OPERAND_RESOLVE),
 
 /* ACPI 5.0 opcodes */
 
-- 
2.17.1

