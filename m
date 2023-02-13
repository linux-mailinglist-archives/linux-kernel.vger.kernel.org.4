Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB04769531E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjBMVgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBMVgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:36:01 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C322008;
        Mon, 13 Feb 2023 13:35:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Atx6FeAOCFpnzD0ZP87YoBJB7X713NUp8vHD69mmMwPVofnVIM2JWY+p0PlGbI2L5RlAGenufyJkJQlW3evEGLdx8zHc89EpPhdUbskvh+7FBMTHtJ9flZ2CUAPiIBINY3L8wZZ1iCmVxeYYAKIu1i2865YJKKYs+TMF1JI5K+ITn4GrEM+KDjTPiRAhSQV0iW/j7sfKGTfybl4anqO9TyksS7KS2C+CjP2VL1JugMfXoOLmoC1UMen2QxgIecdeqN6NrbDZddWMpEgoqMoPuixJc9HbRDXjqxVPs6qKoT8dr9ym66PBiHE53FyHPeIDweNJbMZ+JHU8nbvVMU9cSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t95uYB5xN04QyLJWbTuvuDlUkt6+xw8fBUBAosCZ80=;
 b=iYq4tJd+CMyjvPl/qAiXlJSSBXA1oFVRSXHXo0avBrWQTUeBScm0Wuv2I4UBET8ZHDlEiFIlSwQ2SSwVlMSKDChu4yUSYfgfw//Y8vqYG9OrGgEAhiTSHXHfZ4ZP8DDVALhnnVzd7602Be6/j5eefJLLLRo6ZEvuobkOoCVf7lv2jMif1uRzvLaHiyEVzKfbag7n+lbF6Mv5qi+i4Q/u5M7N38ozN69HUHaQrdWNKPBLCLA5IjdF5/n7oFwOxTNxNCtTNR0UkDo2Y0M+Cl2Isj+XbHUY9F9nKd8oMlnu4MBO9Mu++F34xtcHgKGBPceLpxGu/QUf7JcHxH29vhLvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t95uYB5xN04QyLJWbTuvuDlUkt6+xw8fBUBAosCZ80=;
 b=P1/PSAVZeVfeZtYC9eBYeyeBbIfXPp7uSvVs4hAPpZrSICdFspKmtuRnXJYC2ryub41A5g3hjb9/JUxmU0ipADl2xb67G2iJraby9ZALr4QbsqKv0fCNcrYZbAyFQqwYajjb7Yy8b34n2a+YHIgEos1sjUPTC7lZ1GefJnHGRkg=
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Mon, 13 Feb 2023 21:35:50 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::51) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 21:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 21:35:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:35:47 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        David Alvarez Lombardi <dqalombardi@proton.me>,
        <victor.bonnelle@proton.me>, Len Brown <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH 1/2] ACPI: x86: Add more systems to quirk list for forcing StorageD3Enable
Date:   Mon, 13 Feb 2023 15:35:35 -0600
Message-ID: <20230213213537.6121-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2c9c68-7dc5-4ccf-11f4-08db0e0a460b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhmyh5QhSa+i42hUDy51ddi/YMyejkOE4tyuVA/65DyalcLpjPufuIU/dUDke2+0j1G53Ubax9517f+O3XSNARLSYB8AgaM1z5trDJrQdh/SF15wDJCXWumWYhtrL555xhz2zDUjY3UHw6cT816QcBH/AJJlvAfe9EqvofKvB9ozzOjBK4NYS1lW1Nxr4UiVEWo9+552DCDjDch2sDO7Zdj06F3S+OZnxBZ2jmk8A0PCkOZEPWmU0f5FphcBU4WilL8rQRdnkGWjaM1ty/YKt5+V20qVuDnOSiTbFrAOqO7NAAPg/gqitnA9C0L7jTLclkX819azp88VaHFGSkr1uSDYfbiJOVNj1lkZszkKGi1syWVBCI3TwzWcCRRUfWjUuz2DMoy4z3jCB02aMZqaPPyOXUYYD2Q96ZyLfmRfQV3DdUsP2MRY9LBBQ6dSq+jDaTAOIBkb6AWPyS5Tu2C337ScklR3CVBEmafe2CozZ/5HsYly0C19ehiZB/U7ifG3Wg853cYZ5TowblP2/dtoUSPEuuoyOCLYMhaMxIeoq7HeKZMjvsk1QIqHGzvSRFFvNBovXgwoyczyY8i79jitLaWIo9m9/QBTHWAivFJWsl1YAv0SBJGXR1MGbfBYS63duJv2aG6+k/6CU/NCLFKufeeqTcyRkFwzJA/G3LVnSgoztM+125xWvKlhDxbdhI80elqQUnMFD82xZwmhOjv40+az69jJ7Kx1kiGfYb2+DS8dIbXIVQTWwepCiidKw+9Tc41vED1xX0cBo1MkFITgCJ2ueZgTSUUvWiMHnz1SPjQZaWb1TQ/jpbJWENhJL9Es
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(63370400001)(63350400001)(478600001)(966005)(40460700003)(36756003)(36860700001)(86362001)(82310400005)(82740400003)(70206006)(47076005)(336012)(8676002)(2616005)(16526019)(26005)(70586007)(186003)(426003)(40480700001)(356005)(81166007)(1076003)(6666004)(7696005)(316002)(110136005)(54906003)(4326008)(44832011)(41300700001)(8936002)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 21:35:48.9243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2c9c68-7dc5-4ccf-11f4-08db0e0a460b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 018d6711c26e4 ("ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1
for StorageD3Enable") introduced a quirk to allow a system with ambiguous
use of _ADR 0 to force StorageD3Enable.

David Alvarez Lombardi reports that Inspiron 14 5425 suffers that same
symptoms. Add this other system to the list as well.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216773
Reported-by: David Alvarez Lombardi <dqalombardi@proton.me>
Tested-by: victor.bonnelle@proton.me
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/utils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index d7d3f1669d4c0..3409ce6513afa 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -213,12 +213,19 @@ static const struct dmi_system_id force_storage_d3_dmi[] = {
 		 * _ADR is ambiguous between GPP1.DEV0 and GPP1.NVME
 		 * but .NVME is needed to get StorageD3Enable node
 		 * https://bugzilla.kernel.org/show_bug.cgi?id=216440
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216773
 		 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
 		}
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 5425"),
+		}
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-- 
2.34.1

