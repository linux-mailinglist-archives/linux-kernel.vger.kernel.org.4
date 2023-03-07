Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321106AF988
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjCGWtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjCGWrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:45 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EE4B9FE78;
        Tue,  7 Mar 2023 14:47:08 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 1D93D7A077D;
        Tue,  7 Mar 2023 23:46:51 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 32/32] pata_parport-bpck6: reduce indents in bpck6_open
Date:   Tue,  7 Mar 2023 23:46:27 +0100
Message-Id: <20230307224627.28011-33-linux@zary.sk>
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

Reverse error handling conditions to reduce code indents in bpck6_open.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c | 48 +++++++++++++++++---------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 53d0ad1d6e89..295dbe5cdaa4 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -318,30 +318,32 @@ static int bpck6_open(struct pi_adapter *pi)
 
 	j = ((i & 0x08) << 4) | ((i & 0x07) << 3);
 	k = parport_read_status(pi->pardev->port) & 0xB8;
-	if (j == k) {
-		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_AUTOFD, 0);
-		k = (parport_read_status(pi->pardev->port) & 0xB8) ^ 0xB8;
-		if (j == k) {
-			if (i & 4)	// EPP
-				parport_frob_control(pi->pardev->port,
-					PARPORT_CONTROL_SELECT | PARPORT_CONTROL_INIT, 0);
-			else				// PPC/ECP
-				parport_frob_control(pi->pardev->port,
-					PARPORT_CONTROL_SELECT, 0);
-
-			pi->private = 0;
-
-			bpck6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
-			bpck6_wr_data_byte(pi, RAMSIZE_128K);
-
-			bpck6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
-			if ((bpck6_rd_data_byte(pi) & 0x3F) == 0x0C)
-				pi->private |= fifo_wait;
-
-			return 1;
-		}
-	}
+	if (j != k)
+		goto fail;
+
+	parport_frob_control(pi->pardev->port, PARPORT_CONTROL_AUTOFD, 0);
+	k = (parport_read_status(pi->pardev->port) & 0xB8) ^ 0xB8;
+	if (j != k)
+		goto fail;
+
+	if (i & 4)	// EPP
+		parport_frob_control(pi->pardev->port,
+			PARPORT_CONTROL_SELECT | PARPORT_CONTROL_INIT, 0);
+	else				// PPC/ECP
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT, 0);
+
+	pi->private = 0;
+
+	bpck6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
+	bpck6_wr_data_byte(pi, RAMSIZE_128K);
+
+	bpck6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
+	if ((bpck6_rd_data_byte(pi) & 0x3F) == 0x0C)
+		pi->private |= fifo_wait;
+
+	return 1;
 
+fail:
 	parport_write_control(pi->pardev->port, pi->saved_r2);
 	parport_write_data(pi->pardev->port, pi->saved_r0);
 
-- 
Ondrej Zary

