Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3766AF95F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjCGWry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCGWrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:10 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEEED43928;
        Tue,  7 Mar 2023 14:47:02 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 503E87A071B;
        Tue,  7 Mar 2023 23:46:49 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/32] pata_parport-bpck6: remove PPC_FLAGS
Date:   Tue,  7 Mar 2023 23:46:09 +0100
Message-Id: <20230307224627.28011-15-linux@zary.sk>
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

pi->private is now not used for any other purpose, so store wait_fifo
flag directly there and remove PPC_FLAGS define.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/ppc6lnx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index fdc11875bf1b..9a166f396112 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -49,10 +49,6 @@
 
 //***************************************************************************
 
-#define PPC_FLAGS	(((u8 *)&pi->private)[1])
-
-//***************************************************************************
-
 // ppc_flags
 
 #define fifo_wait					0x10
@@ -405,7 +401,7 @@ static void ppc6_wait_for_fifo(struct pi_adapter *pi)
 {
 	int i;
 
-	if (PPC_FLAGS & fifo_wait)
+	if (pi->private & fifo_wait)
 	{
 		for(i=0; i<20; i++)
 			parport_read_status(pi->pardev->port);
@@ -562,7 +558,7 @@ static int ppc6_open(struct pi_adapter *pi)
 	if (ret == 0)
 		return(ret);
 
-	PPC_FLAGS &= ~fifo_wait;
+	pi->private = 0;
 
 	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
 	ppc6_wr_data_byte(pi, RAMSIZE_128K);
@@ -570,7 +566,7 @@ static int ppc6_open(struct pi_adapter *pi)
 	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
 
 	if ((ppc6_rd_data_byte(pi) & 0x3F) == 0x0C)
-		PPC_FLAGS |= fifo_wait;
+		pi->private |= fifo_wait;
 
 	return(ret);
 }
-- 
Ondrej Zary

