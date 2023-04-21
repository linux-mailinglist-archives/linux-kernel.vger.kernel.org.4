Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646136EAC49
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjDUOIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjDUOH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:07:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F61BC0;
        Fri, 21 Apr 2023 07:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiiLMUWcZpPdCJpLVZSkYL4VMg+e7sKMF8Z0lMY8pr5tRF5z89P0cbj2c5dRIQCPmK98sTyF7fsdf1iG/Sb5SB964dxwgg5ZEpI+gpC0n2t/BuWcOZj/otoppcLmymzVXz0+m/z4DC5+ucDo+XBcUCrwWoT5lrf5sON8Eh1qYrQIyrqTbYk6mr1U429TbFdaI5+EN72qT3+yjL89gArjqbWR21q0SkjKY+9EkELyPoQ0wgGn7s5q2lrYGVxUwAWm+S2TH8JC9+bRr3mQzIa5aahGcNSgPMxxwKrDMICUi5hjVTONoDIEBBYhPGEwgUnGbj5z3mxfSB2koM/HNdS/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmesdzkhLU5evKDz8cs9mjCfTxQoXkgTSopuH3wGBfU=;
 b=QZPKnxDTcPGBDn4GaQxXpkMxg+0BWl9/VyzMPP5Fl1CwAUowPmyCf/UWJCSvReKpNr0wPZMP7UCF4Vb/af7Mrc+bK/VGA8bgfDJ+D4ci/bzIIaLcvUi0ZJN9QMIQTbVvxbiUfu+fBxykwkDaL/jUcMlul71JxdQ7ps3qjysPcPsBI21Wmcde2v4DE27pV7mqCUGS4PZxGAahZu5CZ7LNRS/Gw6RPYZmE6e2/l1ppgxir3TlXukTZQbaOuTaMM7LoY5Ku338vQSxOfLS19mJhmO9mFgqKTqJHVNbewEDrZEPXDrzbsa1ua5outh+7PL73D5YZSyMRUuMtQADkeiYHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmesdzkhLU5evKDz8cs9mjCfTxQoXkgTSopuH3wGBfU=;
 b=aJMiu2FHt+1zVQsGdE2hUqAk5321UTCTFEgqiI8vMDQi4E9zLBPmg99hJb9hwxsFF/hv8OSyHS/p/jnGpLg678PM4pMnxbm8y0SZQZOgg6chdPV81qcuz/+1bubw+umNljMGdkeYaK/tYzJVoskUOctxYORBiOp1eidUYA0aVpM=
Received: from MW4PR04CA0081.namprd04.prod.outlook.com (2603:10b6:303:6b::26)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 14:07:55 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::aa) by MW4PR04CA0081.outlook.office365.com
 (2603:10b6:303:6b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Fri, 21 Apr 2023 14:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Fri, 21 Apr 2023 14:07:55 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 09:07:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
CC:     S Sanath <Sanath.S@amd.com>, <richard.gong@amd.com>,
        <Sanju.Mehta@amd.com>, Takashi Iwai <tiwai@suse.de>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] thunderbolt: Clear registers properly when auto clear isn't in use
Date:   Fri, 21 Apr 2023 09:07:24 -0500
Message-ID: <20230421140725.495-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: e130469a-120c-471d-feb2-08db4271cdd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: it7bxBo8Lf7QjnSf6WDu0tUim6VP88JJovSm2s9ySsIJFvriOlYpjT0W3TEq5G/NjhN6lXkMD1PuegSfiKBru0JzAPLXOft+R3XE/Mojoya5NwoIjJxNCf5KvXrveRSVdOqeHfYMJ68d7Ae8smf6hvB2GsPD1bWNSKn5rDcCtDLh/9IWK5jC0jkgVmdJrLO/s4P5du/lxCz+GxKdBJODDmwukncy2EAiRalCuhikuvTSmeaJeJJybFhmPnd+X/GSG1623ZDkbkAyDAW+WCIRt6ihQRzGTM/iioxqDBKOVVekI+hPSMv4Qe978VCB6VeMVQ+v/B69xr0HxtK0Kd1TP8SGd5w30GPwcBcFFzElJkSW0/IAV547q6O9X5WIVOKtxvs1ST0FvLqmt/Mpsz2ga4oA8VqTLlAALIr5AUrh24XR23NkbQnt86ZceonDBxfvMANtTGPcW3H6bpMq+o7UNicqmvoywEy2NP0EqUdRBO57xp/+pKdkEPvInc/bAoILc9qENn47aUkmjB9CAr4MMJUYtKSgjm/SscBm4zrbUWsN2bBk3hmMkXqZKAjOpReIdZjGmutinZa8yjEdFIDX9fH5JqtFucNVK0LLT/kmTy4RXof6eApQ1UE4YTUMILs2PADMW1JK7CMMP4/res9vmCpey/16tzt/+hBGFYAmO7OZM/ciSMJK0f/SoHoB755F62c+91ws40ncjw6mph+bDp6i4NGbT2QrpOY89kDC4oA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(84970400001)(4326008)(70586007)(110136005)(316002)(966005)(54906003)(70206006)(7049001)(36756003)(1076003)(40460700003)(16526019)(36860700001)(26005)(81166007)(336012)(426003)(2616005)(47076005)(186003)(83380400001)(356005)(40480700001)(5660300002)(8676002)(41300700001)(82310400005)(478600001)(7696005)(2906002)(6666004)(8936002)(82740400003)(86362001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 14:07:55.3364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e130469a-120c-471d-feb2-08db4271cdd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When `QUIRK_AUTO_CLEAR_INT` isn't set, interrupt masking should be
cleared by writing to Interrupt Mask Clear (IMR) and interrupt
status should be cleared properly at shutdown/init.

This fixes an error where interrupts are left enabled during resume
from hibernation with `CONFIG_USB4=y`.

Fixes: 468c49f44759 ("thunderbolt: Disable interrupt auto clear for rings")
Reported-by: Takashi Iwai <tiwai@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217343
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
---
I tried to base this off thunderbolt.git/next (tag: thunderbolt-for-v6.4-rc1)
but the following 3 commits are missing from that branch but are in 6.3-rc7:

58cdfe6f58b3 thunderbolt: Rename shadowed variables bit to interrupt_bit and auto_clear_bit
468c49f44759 thunderbolt: Disable interrupt auto clear for rings
1716efdb0793 thunderbolt: Use const qualifier for `ring_interrupt_index`

I cherry picked them first as this patch builds on them.
---
 drivers/thunderbolt/nhi.c      | 28 +++++++++++++++++++++-------
 drivers/thunderbolt/nhi_regs.h |  1 +
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index d76e923fbc6a..7c543a6a5711 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -61,8 +61,9 @@ static int ring_interrupt_index(const struct tb_ring *ring)
  */
 static void ring_interrupt_active(struct tb_ring *ring, bool active)
 {
-	int reg = REG_RING_INTERRUPT_BASE +
-		  ring_interrupt_index(ring) / 32 * 4;
+	int index = ring_interrupt_index(ring) / 32 * 4;
+	int reg = REG_RING_INTERRUPT_BASE + index;
+	int clear = REG_RING_INTERRUPT_MASK_CLEAR_BASE + index;
 	int interrupt_bit = ring_interrupt_index(ring) & 31;
 	int mask = 1 << interrupt_bit;
 	u32 old, new;
@@ -123,7 +124,11 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
 					 "interrupt for %s %d is already %s\n",
 					 RING_TYPE(ring), ring->hop,
 					 active ? "enabled" : "disabled");
-	iowrite32(new, ring->nhi->iobase + reg);
+
+	if (active)
+		iowrite32(new, ring->nhi->iobase + reg);
+	else
+		iowrite32(mask, ring->nhi->iobase + clear);
 }
 
 /*
@@ -135,12 +140,21 @@ static void nhi_disable_interrupts(struct tb_nhi *nhi)
 {
 	int i = 0;
 	/* disable interrupts */
-	for (i = 0; i < RING_INTERRUPT_REG_COUNT(nhi); i++)
-		iowrite32(0, nhi->iobase + REG_RING_INTERRUPT_BASE + 4 * i);
+	for (i = 0; i < RING_INTERRUPT_REG_COUNT(nhi); i++) {
+		if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
+			iowrite32(0, nhi->iobase + REG_RING_INTERRUPT_BASE + 4 * i);
+		else
+			iowrite32(0xffffffff,
+				  nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + 4 * i);
+	}
 
 	/* clear interrupt status bits */
-	for (i = 0; i < RING_NOTIFY_REG_COUNT(nhi); i++)
-		ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + 4 * i);
+	for (i = 0; i < RING_NOTIFY_REG_COUNT(nhi); i++) {
+		if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
+			ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + 4 * i);
+		else
+			iowrite32(0xffffffff, nhi->iobase + REG_RING_INT_CLEAR + 4 * i);
+	}
 }
 
 /* ring helper methods */
diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_regs.h
index faef165a919c..db95ad5d2814 100644
--- a/drivers/thunderbolt/nhi_regs.h
+++ b/drivers/thunderbolt/nhi_regs.h
@@ -92,6 +92,7 @@ struct ring_desc {
  */
 #define REG_RING_INTERRUPT_BASE	0x38200
 #define RING_INTERRUPT_REG_COUNT(nhi) ((31 + 2 * nhi->hop_count) / 32)
+#define REG_RING_INTERRUPT_MASK_CLEAR_BASE	0x38208
 
 #define REG_INT_THROTTLING_RATE	0x38c00
 
-- 
2.34.1

