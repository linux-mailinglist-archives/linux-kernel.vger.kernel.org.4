Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92F6A11AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBWVIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBWVIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:08:11 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7985D470;
        Thu, 23 Feb 2023 13:08:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZiNOXbhr81Ihn3UtTwxVUDRebQ9ziV7V9t2GLzo3GNqtTFT/6WV8IzIw7lvEvQF1MPYeu64XpzKIS+5RA+WRUPn+SCdqtMwEsokElrgKB6ZkLfPkoqmohqDzK1CLW6O4tYgYA9Gx67p6lJY2nAuyX/RRgEjziHr5qPB2GpU33C9aGxRozchxtesZgPksYz0XKqcS2qKhtT/vhTdSRtUUWYPVQs69ZUnCEIKeayWtbHoYt7voSEcTOk34gAboTxmYBgrXAjAdp39wlx8UgsrsZrks/+/NEhTxgm9RNzkbHHn21THinyBgYtLWnSUDOb6PozQw2MmRlynPxpxZaNBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSvv2jgP8F93I9zxpzdbIugaHjw5LkCPHDITqHt/p/w=;
 b=lrUViVIHYbehgqNoyCRfRWaQ/UislwDe/qUM8lnAnp4ssRFHPI5UOL42+PVsEbCn+u4i6RQmZS5y/iy/MwMTn3gcrxSRJKulxoyfRTD3Hl0D9LFhLUrs02kZUFWte/rf00JEo9KYMP7kz1Dte1P4qezGDMlH7V3AzpvN1GTqUrZTiFesMVJriEzqqbwVJqSrskDJtfJH/2ovTiiBVUfR3oF+08/8gY8TplgIkrLNjVMZ0ky/8I7H5ZT1/UJcTXL7iNYd3YKgjOV8yMQTgRZzo8q0HHTYAwABDQcQo9Pd+hMPFUvFdcnv+3rluxOmcIsC1N38ePASbL0OSfDVgTI3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSvv2jgP8F93I9zxpzdbIugaHjw5LkCPHDITqHt/p/w=;
 b=zdTxe94U7M8kKIY5UPK1OJgZTVO7i6snbUVQuauu06NgIWhAx8LrCIiFB1KN1XUxZfFL5MXfZa5KebSEdESqfrg2x6T82kqWxjXFG1NggIbCbx+vxGIeUUxMfIPnMcGUotpXTOtyO3+addFnm0RcTQqg2V2MJC3VExYmPpGtuRo=
Received: from MW4PR04CA0174.namprd04.prod.outlook.com (2603:10b6:303:85::29)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 21:07:58 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::74) by MW4PR04CA0174.outlook.office365.com
 (2603:10b6:303:85::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 21:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 21:07:58 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 15:07:56 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Yehezkel Bernat" <YehezkelShB@gmail.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset
Date:   Thu, 23 Feb 2023 15:07:42 -0600
Message-ID: <20230223210743.9819-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223210743.9819-1-mario.limonciello@amd.com>
References: <20230223210743.9819-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: a92d5a0c-e53e-46f0-b97b-08db15e20a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5maEbhcs6Q4XufbYGYRh6AjNmNhW1NsJaLz6/p5FEkUERiuUGP0kMtP+huhoN8ntaJA1Wk76ujKk9dduvd0a2u+AgUbUKmUF3xpX6YdO/sXn6/kUUeDjsTsuHK1wX2+7BPJ2q9iJGgffc5dwBXY+17uIAI4gy6u862hJ03/8Jgm3OvQomSu4VjaONbPRJ/0PRHZ3PBsXZ+9hkBRa3VtpRgPLpencM68Wuu53GMQdKnR3w+7YdgrMhQ3He28PLUkvm/BELcBE67LzjpVn0ZksRXciqsBETz9dJqTG0uurC/pVHfC4gcJaXPsajtZgyA9k0neBdsDUDPVnb283Bn4iJlTQsusTWC7RJD7JQOiXZ5goBq2Xk6DY0BjDdXjzR5NGtIkN3EpkvVROzEpCi7Mpc/6SFs4lStYvAA0lJixVmONuqGdWUpGTdlSl8ZwuRsicXs1EppaSst4BnJm5FmoBnp1m3JG1LSg1nvGEr+irFPPMcgOCRHG0h9a1Arpy1ckb/GT+s2mj1fTyVJXjFAM76Q8UTvxgSGTpc6XqmY/VFnf5XkK14RHlGyGPMfSY/Z5lKg+e+4iCwVn+ZC5njXZlsH7b1NPfE9l/dP/a1RwHwwe9MJUUO5FXV5xfDMFKoBKZkLcu8c7/XNWv0vDzz0Ggxm37u42Cq6ZAboE9mwdh7zU0xJUenkDx6oMnoz3kQ88TFxyj+/JjHbk68Zi079AN9d2oGwHaKwxV7rtbjlfuplP6rvWjjh03iFLG0ezSs7f
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(316002)(336012)(40480700001)(186003)(26005)(16526019)(41300700001)(70586007)(7696005)(40460700003)(70206006)(82310400005)(83380400001)(8676002)(478600001)(54906003)(110136005)(1076003)(6666004)(2906002)(36756003)(4326008)(86362001)(8936002)(2616005)(47076005)(426003)(356005)(4744005)(5660300002)(82740400003)(44832011)(81166007)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 21:07:58.0628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92d5a0c-e53e-46f0-b97b-08db15e20a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static function `tb_eeprom_get_drom_offset` has more safety guards
for the DROM offset fetching.  Use this instead of just `tb_sw_read`

No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/eeprom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 8c9e553e2fca..873fa4300507 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -471,14 +471,13 @@ static int tb_drom_copy_efi(struct tb_switch *sw, u16 *size)
 
 static int tb_drom_copy_nvm(struct tb_switch *sw, u16 *size)
 {
-	u32 drom_offset;
+	u16 drom_offset;
 	int ret;
 
 	if (!sw->dma_port)
 		return -ENODEV;
 
-	ret = tb_sw_read(sw, &drom_offset, TB_CFG_SWITCH,
-			 sw->cap_plug_events + 12, 1);
+	ret = tb_eeprom_get_drom_offset(sw, &drom_offset);
 	if (ret)
 		return ret;
 
-- 
2.34.1

