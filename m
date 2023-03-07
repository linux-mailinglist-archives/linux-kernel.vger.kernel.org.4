Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA47B6AF959
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCGWrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCGWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:07 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DD5229E15;
        Tue,  7 Mar 2023 14:47:01 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 957DF7A05DC;
        Tue,  7 Mar 2023 23:46:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/32] pata_parport-bpck6: remove org_* from struct ppc_storage
Date:   Tue,  7 Mar 2023 23:46:02 +0100
Message-Id: <20230307224627.28011-8-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
References: <20230307224627.28011-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

org_data duplicates saved_r0 and org_ctrl duplicates saved_r2 in
pi->unit. Remove them.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/ppc6lnx.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index dd9f3040f9a7..7ea8e8a31aeb 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -74,8 +74,6 @@ struct ppc_storage {
 					// 5 = EPP Word
 					// 6 = EPP Dword
 	u8	ppc_flags;
-	u8	org_data;				// original LPT data port contents
-	u8	org_ctrl;				// original LPT control port contents
 	u8	cur_ctrl;				// current control port contents
 };
 
@@ -127,17 +125,17 @@ static int ppc6_select(struct pi_adapter *pi)
 	if (i & 1)
 		outb(i, pi->port + 1);
 
-	ppc->org_data = inb(pi->port);
+	pi->saved_r0 = inb(pi->port);
 
-	ppc->org_ctrl = inb(pi->port + 2) & 0x5F; // readback ctrl
+	pi->saved_r2 = inb(pi->port + 2) & 0x5F; // readback ctrl
 
-	ppc->cur_ctrl = ppc->org_ctrl;
+	ppc->cur_ctrl = pi->saved_r2;
 
 	ppc->cur_ctrl |= port_sel;
 
 	outb(ppc->cur_ctrl, pi->port + 2);
 
-	if (ppc->org_data == 'b')
+	if (pi->saved_r0 == 'b')
 		outb('x', pi->port);
 
 	outb('b', pi->port);
@@ -195,9 +193,9 @@ static int ppc6_select(struct pi_adapter *pi)
 		}
 	}
 
-	outb(ppc->org_ctrl, pi->port + 2);
+	outb(pi->saved_r2, pi->port + 2);
 
-	outb(ppc->org_data, pi->port);
+	outb(pi->saved_r0, pi->port);
 
 	return(0); // FAIL
 }
@@ -214,11 +212,11 @@ static void ppc6_deselect(struct pi_adapter *pi)
 
 	outb(ppc->cur_ctrl, pi->port + 2);
 
-	outb(ppc->org_data, pi->port);
+	outb(pi->saved_r0, pi->port);
 
-	outb((ppc->org_ctrl | port_sel), pi->port + 2);
+	outb((pi->saved_r2 | port_sel), pi->port + 2);
 
-	outb(ppc->org_ctrl, pi->port + 2);
+	outb(pi->saved_r2, pi->port + 2);
 }
 
 //***************************************************************************
-- 
Ondrej Zary

