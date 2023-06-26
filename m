Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964E673EE75
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjFZWKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjFZWJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:09:46 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C430E7;
        Mon, 26 Jun 2023 15:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO5bQoeQja6RQmSJOGv4K9mortSVrXj+TC8MZX7Xxt27Wgis94JC5RiBgDmT1fCEGMOsWRxUBp2PDAdRFggUQMMU8nDe9g52zYSxm7iJWaHB8HM9Tg5y+LW1VZmG8CzjtlPDLgpYQRwrWT4/AYrM2SajHj94MH7xES+d1nTDm0T186v/Qvw3rwHMelqY47pDeF+chFJM97C70kSYu5GPGDdDriEHnLSgudTb4Hkl9MAMmh205eUyRfNgvqM00OqjYq7gkabA7cJ9scl4rQRm5EY9w7/QSsnYDNDMf2P9Bqf49mkgyJcWrwvFmDSES8X3lRxcAOsorJOei/ASlfIxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6AWKgJErSzUvCvVsgpQC7nwntbSSNupISuzTh2hUAY=;
 b=lITyVNwpx2zsws5R2xfVk+FGLJsE9NLOtoJ54Bm4MtMo93jzcl66wor06Jr1YXU035/DYZiULkksEq8imLxya+zbyjIPCOW5kxNNCWWGTSnI5nOKV5Gx2ZrwVgqg2Y34wxAu7Ugw0C1SxdNWF071nFsdkqbKPbfp7Z54u6mErN255EyUBQ6giTnX6G66IelYEjXCA1LmSpJ/GQuP8DlFUbqBtWrFsPs122XHWy6A3/0izanOCO+1LXz7HhInk1oPLwh2kQK1VW7DTPbuQrY88HLRTtzBosMocWbecnp6nTFdNX/XLgs5jb3wyeHBaDwZoxa2JwYeOlFmkID20ffyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6AWKgJErSzUvCvVsgpQC7nwntbSSNupISuzTh2hUAY=;
 b=iStM06J20o0mYKopV+a6q3lDL5uRzpfDdsRZQrniFD6s+tV1qCCVgUrOAibF+4Qe5znEqNhzlmPxhB1ga6uOqiEsJxs04aEIFOb5PrcQfBVT3SoyswpxV0Fx+OtwL0OKTpwGVqEHlJCC3CcrsRHr49ocbm1nC6HyRa5Hqoye2A/rT87KxqJb80lUXUbYL2Qczg3lX+4Tt5tLeHQ/o1GGgjy6NGf45kKg+g/6NiCbWyw+imQ5UmfWug7rdoCBk5ljz/6Q3ri5MIxjfKscn4hPIrObtkOO8NAynD2eJeFhaaGdHnzm5OX5KFYrSReRLsFAih7u30DerG0kMQkM4wuxaw==
Received: from BN9PR03CA0405.namprd03.prod.outlook.com (2603:10b6:408:111::20)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Mon, 26 Jun 2023 22:06:13 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::80) by BN9PR03CA0405.outlook.office365.com
 (2603:10b6:408:111::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 22:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 22:06:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 15:05:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 26 Jun
 2023 15:05:59 -0700
Received: from build-abmainkar-20230620T092408093.nvidia.com (10.127.8.11) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Mon, 26 Jun 2023 15:05:59 -0700
From:   Abhishek Mainkar <abmainkar@nvidia.com>
To:     <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <abmainkar@nvidia.com>
Subject: [Patch] acpica: Add AML_NO_OPERAND_RESOLVE flag to Timer
Date:   Mon, 26 Jun 2023 22:05:25 +0000
Message-ID: <20230626220525.1654780-1-abmainkar@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: ed561602-4811-48e4-f2f5-08db76918e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xyddirrkkYf/KEk/PizZ40lHTZuM0XNthljnOeXmhLPV0+Agc3UnBh/XwwMy+4Xx49EmF6PjbYC3q8ilY0hZmjzoMojGSYRyZnsac04aqv2uV5gLCHfmufus7jEHMbw2DeU/IJumGaan1VbX4iFkPFM+Z9tYK3l8AFuizqKv2imGf3cbtyC4DmYjboJ2EZonp7Kz1c8+v8xt9a3uQyZSypDP+yx74AhjGXpU4YWpBj12htOLXT3RwFSrqy4IiJBabWC5AGKSZSKGnA0LV1GwG+CGVUu7M0bTvUP4BSFMbG3d12bAqTjsMDIa03gX1BCsGm8Y8gQlXPyjmhzpSHXE3eOnVcJ26Wkyu1755Frq5S/Yse3OYN0vSkSxkz/y+Srb2/8LEggT4CWx51MsMCTr6iAwlml2v5WxLyytYRrhxiuxIHqj4MnTg2XTcnKrz85dTnkz4SD7ZaVWNiFlQi5InioAumlqGyz+FMxMv5GFlU7ibDIBGMqeM0TNiq/d8UyEdErmIeooDhUruA0DX4wmm0jMIEbiBRK2yjr7pfMFiuCUnv2GxkknnFMFOCqoVXDNBsHk1G7KlbOKpRkKAmEg4PnmAsFqJbu6vj/2Ygw38ok2kPf6U7HoxJHk4amEVQoDSCRL0mlsDejZgjuDalRW337IREbgHQ/NKaLEZPO1fHh9++7H/pqPtFoBMh/m7EvriL+/FfqyrNAad1rw4URRxc47RWbz+DlveuzulWXWAfFeMByMC+Pe2NINa9wdXA4
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(4326008)(478600001)(36756003)(316002)(70206006)(70586007)(8676002)(8936002)(2906002)(40460700003)(40480700001)(36860700001)(110136005)(54906003)(86362001)(41300700001)(7696005)(186003)(82310400005)(336012)(426003)(1076003)(26005)(47076005)(356005)(2616005)(107886003)(83380400001)(7636003)(6666004)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 22:06:12.6574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed561602-4811-48e4-f2f5-08db76918e0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

