Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7856B4E66
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCJRVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjCJRVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:21:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFAF111B33;
        Fri, 10 Mar 2023 09:21:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzmUPhsE8j/hOtyD3qgShLdKvlBQcv6kDGzCUyUsoS5ySkgr7bkxkiy+p+QJjBUS0yVwt4lldvrbiMJ3sChg4EReor9cesM8yDdL7GbkU+N1rB597TYHX4BopWrs/j2ZY7qaaISYjusgQrq+KM1Aqw8WlwN/nazKN3tBVsvRW4cAOSH8FGlyNvw/4VegyzZWQwMs9O9sIMxjkDGF3z3ASdPXnCYMhmJ9namC6Kew4gmC/8qqcxqmAKC3Mrm9F2L/ueOpgDmqeTiaDqQ5JrBabkK+3t7pf2oATviJZCELGqzhyj8wEC7tlQkwmCzUa2iRYVYskF7V0QCzyCebpyzMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYLh7oKEDEQpKZKPlsjawgYtuWLj/QonKCOfcm7t30M=;
 b=g8cYj9YQoC8OfkHH7C3WVB1360hZbwFpqwjkNnpDbYg8ZIQDxwBnICb1ExjtrT2VzCrRJ7YQn2EOSkfaX8XmJWj6g4Wge54T4ngvENrKmctGQgkRgjdol9Yx5DFwCyWliQPDw4AR7cylHJoJjivfNW3uG7ca+Z6rzbdrcl/gOCJJQSIGK1AF/kxRE2tfNeWNqxKnv2wWKpsacRXJixPd68rzUvK+4fXbDnVutzCJaqgMzDYzYVzMMTjw/xDZKMRB/glHbkuTXcyadDGJySytoYQ3uu3imNQFagDVsC82NY+fB4vV2wgV9h+50C3INRsK08IJ/dDvpPOGxK/abZ9d8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYLh7oKEDEQpKZKPlsjawgYtuWLj/QonKCOfcm7t30M=;
 b=r6iOOzrIm623gtMmrU2qxBVRqdLGlDRp3Kv2oYy64ROjgLFE4WKanZHma4YxEuXCfGU7l+pfnulfvebkR1Ke3AdxmOHO4SqnOvjN1ofYGrmJM4eJwlJKqZE9RM9SOCpoGjYUq5PnCtHpudJmFo2RHwHdiZsGhZ+zRZoLLf8qqrc=
Received: from DM6PR06CA0088.namprd06.prod.outlook.com (2603:10b6:5:336::21)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 17:21:07 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::33) by DM6PR06CA0088.outlook.office365.com
 (2603:10b6:5:336::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 17:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.12 via Frontend Transport; Fri, 10 Mar 2023 17:21:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 11:21:03 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
CC:     <anson.tsao@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Sanju Mehta" <Sanju.Mehta@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] thunderbolt: Disable interrupt auto clear for rings
Date:   Fri, 10 Mar 2023 11:20:50 -0600
Message-ID: <20230310172050.1394-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310172050.1394-1-mario.limonciello@amd.com>
References: <20230310172050.1394-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a8bc00-e4c7-45a4-039b-08db218bd5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGa+9k+uzGeeIy7h+vPT9IUaiwNTQmGDchkGT6ydKpijMyj5LXD7TdG2qKpjfsDnEFMD/N2JVb0sgZjsiBNQK77i9V4JQTHgqvH6QJtqR9sbQM1d2J0MAZIeQwNUzM/d4/4YkbD/DcXxg/znXPjdWgV/gppdA5xHlQLqdMtHzaM2KUbUthHdHclimi+8enTabIv/lgbEoMdpcKLTJE0KGSvDqcdq+gyfJDM9XGykn/OpxndTmP8TDfFUkor9ZkmsoaNzJuas6dKx7zzZ6dZUDy/5hIscB7bo7npTZEwX1KI9/avuld/2Ch4+951vSTm9B0t4vqzYJcI4ZFIO1moFJ/2etIlrFXg/6xDq5ENgpeO9MjpYC3Xa+cf+P8GqWFG/gzd4vgWmyQztGS8YOLXKVaEG5+hFq+ISYIGrG2nJqS31bTj78cmgN/amElBbXW37pz2k46mkAmqXJw3epktEYEX9H3I4fVwdZTT88yxEJznmdvcle9iRf4xEOH40ugl1HMlIHwK6lGyYyc8N1j+W3kKz8P9B/1uXmEtNBwkh+dkKTAfFrXXCrRJ3n9p5m/Rayeb+aUPD2NAt9ZH1czbX+nv81yFrvMShuRR6vuWb4a+Na+WkkJ0QNUdhEz7+aB3cC3bZOtpsNIldSm8/l+0ddCAo3VeXxpBAmbaLZfYDc6EjfwA8Qqb9TOdPFFfsQh/iMMqNK1SHw7UXc7Uu2wUBKF/JglenkM0vYvAEpgI/ojA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(8676002)(4326008)(70586007)(70206006)(54906003)(6636002)(316002)(7696005)(41300700001)(110136005)(44832011)(5660300002)(2906002)(6666004)(26005)(1076003)(2616005)(16526019)(186003)(47076005)(426003)(40480700001)(36860700001)(336012)(8936002)(478600001)(82310400005)(356005)(86362001)(36756003)(83380400001)(81166007)(82740400003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:21:07.0742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a8bc00-e4c7-45a4-039b-08db218bd5a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When interrupt auto clear is programmed, any read to the interrupt
status register will clear all interrupts.  If two interrupts have
come in before one can be serviced then this will cause lost interrupts.

On AMD USB4 routers this has manifested in odd problems particularly
with long strings of control tranfers such as reading the DROM via bit
banging.

Instead of clearing interrupts automatically, clear the bit corresponding
to the given ring's interrupt in the ISR.

Fixes: 7a1808f82a37 ("thunderbolt: Handle ring interrupt by reading interrupt status register")
Cc: Sanju Mehta <Sanju.Mehta@amd.com>
Tested-by: Anson Tsao <anson.tsao@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/nhi.c      | 40 +++++++++++++++++++++-------------
 drivers/thunderbolt/nhi_regs.h |  6 +++--
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index fdc0c3ba2ef01..318d20bd5b695 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -71,24 +71,31 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
 		u32 step, shift, ivr, misc;
 		void __iomem *ivr_base;
 		int index;
+		int bit;
 
 		if (ring->is_tx)
 			index = ring->hop;
 		else
 			index = ring->hop + ring->nhi->hop_count;
 
-		if (ring->nhi->quirks & QUIRK_AUTO_CLEAR_INT) {
-			/*
-			 * Ask the hardware to clear interrupt status
-			 * bits automatically since we already know
-			 * which interrupt was triggered.
-			 */
-			misc = ioread32(ring->nhi->iobase + REG_DMA_MISC);
-			if (!(misc & REG_DMA_MISC_INT_AUTO_CLEAR)) {
-				misc |= REG_DMA_MISC_INT_AUTO_CLEAR;
-				iowrite32(misc, ring->nhi->iobase + REG_DMA_MISC);
-			}
-		}
+		/*
+		 * Intel routers support a bit that isn't part of
+		 * the USB4 spec to ask the hardware to clear
+		 * interrupt status bits automatically since
+		 * we already know which interrupt was triggered.
+		 *
+		 * Other routers explicitly disable auto-clear
+		 * to prevent conditions that may occur where two
+		 * MSIX interrupts are simultaneously active and
+		 * reading the register clears both of them.
+		 */
+		misc = ioread32(ring->nhi->iobase + REG_DMA_MISC);
+		if (ring->nhi->quirks & QUIRK_AUTO_CLEAR_INT)
+			bit = REG_DMA_MISC_INT_AUTO_CLEAR;
+		else
+			bit = REG_DMA_MISC_DISABLE_AUTO_CLEAR;
+		if (!(misc & bit))
+			iowrite32(misc | bit, ring->nhi->iobase + REG_DMA_MISC);
 
 		ivr_base = ring->nhi->iobase + REG_INT_VEC_ALLOC_BASE;
 		step = index / REG_INT_VEC_ALLOC_REGS * REG_INT_VEC_ALLOC_BITS;
@@ -393,14 +400,17 @@ EXPORT_SYMBOL_GPL(tb_ring_poll_complete);
 
 static void ring_clear_msix(const struct tb_ring *ring)
 {
+	int bit;
+
 	if (ring->nhi->quirks & QUIRK_AUTO_CLEAR_INT)
 		return;
 
+	bit = ring_interrupt_index(ring) & 31;
 	if (ring->is_tx)
-		ioread32(ring->nhi->iobase + REG_RING_NOTIFY_BASE);
+		iowrite32(BIT(bit), ring->nhi->iobase + REG_RING_INT_CLEAR);
 	else
-		ioread32(ring->nhi->iobase + REG_RING_NOTIFY_BASE +
-			 4 * (ring->nhi->hop_count / 32));
+		iowrite32(BIT(bit), ring->nhi->iobase + REG_RING_INT_CLEAR +
+			  4 * (ring->nhi->hop_count / 32));
 }
 
 static irqreturn_t ring_msix(int irq, void *data)
diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_regs.h
index 0d4970dcef842..faef165a919cc 100644
--- a/drivers/thunderbolt/nhi_regs.h
+++ b/drivers/thunderbolt/nhi_regs.h
@@ -77,12 +77,13 @@ struct ring_desc {
 
 /*
  * three bitfields: tx, rx, rx overflow
- * Every bitfield contains one bit for every hop (REG_HOP_COUNT). Registers are
- * cleared on read. New interrupts are fired only after ALL registers have been
+ * Every bitfield contains one bit for every hop (REG_HOP_COUNT).
+ * New interrupts are fired only after ALL registers have been
  * read (even those containing only disabled rings).
  */
 #define REG_RING_NOTIFY_BASE	0x37800
 #define RING_NOTIFY_REG_COUNT(nhi) ((31 + 3 * nhi->hop_count) / 32)
+#define REG_RING_INT_CLEAR	0x37808
 
 /*
  * two bitfields: rx, tx
@@ -105,6 +106,7 @@ struct ring_desc {
 
 #define REG_DMA_MISC			0x39864
 #define REG_DMA_MISC_INT_AUTO_CLEAR     BIT(2)
+#define REG_DMA_MISC_DISABLE_AUTO_CLEAR	BIT(17)
 
 #define REG_INMAIL_DATA			0x39900
 
-- 
2.25.1

