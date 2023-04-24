Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FE46ED5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjDXT52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjDXT5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:57:22 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E5976A;
        Mon, 24 Apr 2023 12:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbqA7DwxoN0YpCo2YMWUe2Zz4l6KbS8JV3IhKpX3MOgD76oXytWCx3AQltWH7fbHgYOqBH7WjIiLYV+ZrOlRy19yox5g95bEZSI49BTRucXK8l7IEk+40WmD8HOI1Prc7OuQehd1FL0tS777KmCKrdE5/LevInvl8oA1P3SSnMO7n9M1pei2G2IS/sqdB/OXr1xFngoId2zAsKWXlgC1nqo6aBVdOvzzUScHdI93ldvrPNLBiw0Dh7E039OM5drvyBokGCYmexh7AEnz8UlQ3YuuEzn+biFkahkrI9WfWjA3bczq2Iy7Ont4aLd7ATAR2MRFVRKDFErJM1zaRYGr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu+ACcCpcuNHxckjN9Qn5d7ZlbDaz6O5tRwd2R3gk0g=;
 b=PqjqWaZldvE/I8vvT1vanANN29/WBR7Ovox3q2MdUqutxXPqPKR39pxZdWQTF8iNsRN+5ELe68Ui9Wq2UQOGrUbYq1y1XM00lAzl5Az6iUIy+7Uj0Tk81UhK0t/268ItiJLrOJTUhBpmuHl6kyCF4PwzJMauyKdF5TrgVeYgPnF89haF2pH2CZ9OMHDLvP0/J+Ue5rH7LF3NBg6jUiT1mf4+8iWzz1iKz04zSZkSdcWeruU66w4IW144ucQjOB0JseKSzoCk64J9OfR5QfCYPQu4rBSByrRqSexj1aWzGw2NAB4KARYQRHpMTDVVkO0qeR9dzq2GAZ4B7cMiPKiHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu+ACcCpcuNHxckjN9Qn5d7ZlbDaz6O5tRwd2R3gk0g=;
 b=jaLDA6NjduPgydSVU2BJkVmMPfZOAB6txR+FUYdfiIn5ET/xqm4w085uMd4M0vaQBhUVA5rYCTaW51ckW5vU9VgNFCGzBZWBesNZ6KyvSMa7a0is/SJ97cAR+JD8bdegoCAlgnej1yRs8YF17XE26ma1XdRnAhKrzxzTR8m8izQ=
Received: from CY5PR22CA0059.namprd22.prod.outlook.com (2603:10b6:930:1d::30)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 19:56:16 +0000
Received: from CY4PEPF0000C96F.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::f7) by CY5PR22CA0059.outlook.office365.com
 (2603:10b6:930:1d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 19:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96F.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Mon, 24 Apr 2023 19:56:16 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 14:56:14 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
CC:     S Sanath <Sanath.S@amd.com>, <richard.gong@amd.com>,
        <Sanju.Mehta@amd.com>, Takashi Iwai <tiwai@suse.de>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] thunderbolt: Clear registers properly when auto clear isn't in use
Date:   Mon, 24 Apr 2023 14:55:54 -0500
Message-ID: <20230424195556.2233-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96F:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f90cf74-3866-4b21-66cb-08db44fdf6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdceKmsJadhZvbTyMJDbzFgIKMrVEfY0GqOASIgyCpQa7Z6GMyH8v9zjvqslbdjtEy/BG0CFHdm4avtmpYnV7rQdP2eAlWqCB/IT4NNisSPLWNzuMU/KcfkmCFXigb49hyPh4JT+gbikJYKkuHYlOIYqKO6hp2g9lIH3rWBwtYQfsPmOfahVfIdZK8ILUIe/8e8Ac2lnKK64cJeVu+91MygTTd+P/0qWOiByCg/axZ0tHzm1u/JHt6RGoXfELJ1OJPmmvpkZcar3y/TrVySJpIUtOPHycFmIlBYHg/6PKQDPyYvp4z6XaHqlVeXS05UZC77UHRpahyyWiequkU58445MW0JgGsXB8H2vUL4KtdeCzb7LGTGSCBJAfsudgcgMAtmCp2ZqRFJ0PGcY5S6lvy61/6QRJYnNyHCmTqrO7+xhpSWDNDCM9j68M4sVsrzNtAev4JJ0vPd235L9Esu89Dpyq0Ro1sh4O3L8EAFWDn0cHoskGYV0WDvPX9jqAckxKqd+ML4ArViFrY3qGRg7vp8kFWEv4q61cDNEyyLs7V70nBJTG+dbLhsxev10OvRj+cLFhELGQtLxR5BTqEK9ABRmiYnsuRNAl7CPXfkVdv/+6aY9nf3WQ5H3g9cCrdGnm5y+SeWdEd8+1MQw2iN32Xs8DmJh2XJuhmObmJtVdVfTYfBEni59eg9ziT5bRmVlx/mpSfWaWVoesIKgSS6UMXxLy9WnhJje6jIb8GwWY2s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(36756003)(8676002)(8936002)(54906003)(110136005)(40460700003)(7049001)(478600001)(4326008)(70206006)(70586007)(40480700001)(356005)(44832011)(81166007)(316002)(41300700001)(82740400003)(2906002)(5660300002)(2616005)(86362001)(36860700001)(186003)(16526019)(966005)(336012)(426003)(26005)(1076003)(84970400001)(7696005)(6666004)(47076005)(83380400001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 19:56:16.0034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f90cf74-3866-4b21-66cb-08db44fdf6cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
---
v1->v2:
 * Whitespace changes
 * Add new static functions for nhi_mask_interrupt() and
   nhi_clear_interrupt()

I tried to base this off thunderbolt.git/next (tag: thunderbolt-for-v6.4-rc1)
but the following 3 commits are missing from that branch but are in 6.3-rc7:

58cdfe6f58b3 thunderbolt: Rename shadowed variables bit to interrupt_bit and auto_clear_bit
468c49f44759 thunderbolt: Disable interrupt auto clear for rings
1716efdb0793 thunderbolt: Use const qualifier for `ring_interrupt_index`

I cherry picked them first as this patch builds on them. It's expected that
this patch should apply on top of 6.4-rc1 properly.
---
 drivers/thunderbolt/nhi.c      | 29 ++++++++++++++++++++++++-----
 drivers/thunderbolt/nhi_regs.h |  2 ++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index d76e923fbc6a..c0aee5dc5237 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -54,6 +54,21 @@ static int ring_interrupt_index(const struct tb_ring *ring)
 	return bit;
 }
 
+static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring)
+{
+	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
+		return;
+	iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
+}
+
+static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)
+{
+	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
+		ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + ring);
+	else
+		iowrite32(~0, nhi->iobase + REG_RING_INT_CLEAR + ring);
+}
+
 /*
  * ring_interrupt_active() - activate/deactivate interrupts for a single ring
  *
@@ -61,8 +76,8 @@ static int ring_interrupt_index(const struct tb_ring *ring)
  */
 static void ring_interrupt_active(struct tb_ring *ring, bool active)
 {
-	int reg = REG_RING_INTERRUPT_BASE +
-		  ring_interrupt_index(ring) / 32 * 4;
+	int index = ring_interrupt_index(ring) / 32 * 4;
+	int reg = REG_RING_INTERRUPT_BASE + index;
 	int interrupt_bit = ring_interrupt_index(ring) & 31;
 	int mask = 1 << interrupt_bit;
 	u32 old, new;
@@ -123,7 +138,11 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
 					 "interrupt for %s %d is already %s\n",
 					 RING_TYPE(ring), ring->hop,
 					 active ? "enabled" : "disabled");
-	iowrite32(new, ring->nhi->iobase + reg);
+
+	if (active)
+		iowrite32(new, ring->nhi->iobase + reg);
+	else
+		nhi_mask_interrupt(ring->nhi, mask, index);
 }
 
 /*
@@ -136,11 +155,11 @@ static void nhi_disable_interrupts(struct tb_nhi *nhi)
 	int i = 0;
 	/* disable interrupts */
 	for (i = 0; i < RING_INTERRUPT_REG_COUNT(nhi); i++)
-		iowrite32(0, nhi->iobase + REG_RING_INTERRUPT_BASE + 4 * i);
+		nhi_mask_interrupt(nhi, ~0, 4 * i);
 
 	/* clear interrupt status bits */
 	for (i = 0; i < RING_NOTIFY_REG_COUNT(nhi); i++)
-		ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + 4 * i);
+		nhi_clear_interrupt(nhi, 4 * i);
 }
 
 /* ring helper methods */
diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_regs.h
index faef165a919c..6ba295815477 100644
--- a/drivers/thunderbolt/nhi_regs.h
+++ b/drivers/thunderbolt/nhi_regs.h
@@ -93,6 +93,8 @@ struct ring_desc {
 #define REG_RING_INTERRUPT_BASE	0x38200
 #define RING_INTERRUPT_REG_COUNT(nhi) ((31 + 2 * nhi->hop_count) / 32)
 
+#define REG_RING_INTERRUPT_MASK_CLEAR_BASE	0x38208
+
 #define REG_INT_THROTTLING_RATE	0x38c00
 
 /* Interrupt Vector Allocation */
-- 
2.34.1

