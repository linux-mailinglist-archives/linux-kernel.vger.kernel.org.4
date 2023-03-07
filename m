Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4914A6AF930
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCGWrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCGWrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:00 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E0E059D9;
        Tue,  7 Mar 2023 14:46:49 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 053947A0533;
        Tue,  7 Mar 2023 23:46:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/32] pata_parport-bpck6: remove useless range check from read/write_regr
Date:   Tue,  7 Mar 2023 23:45:57 +0100
Message-Id: <20230307224627.28011-3-linux@zary.sk>
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

bpck6_read_regr() and bpck6_write_regr() check values of cont and reg
but there's no point in doing that. They can only be called with
a fixed set of values. Remove the checks.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 842e8116b649..4d6edb9c1245 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -25,24 +25,12 @@
 
 static int bpck6_read_regr(struct pi_adapter *pi, int cont, int reg)
 {
-	unsigned int out;
-
-	/* check for bad settings */
-	if (reg<0 || reg>7 || cont<0 || cont>2)
-	{
-		return(-1);
-	}
-	out=ppc6_rd_port(PPCSTRUCT(pi),cont?reg|8:reg);
-	return(out);
+	return ppc6_rd_port(PPCSTRUCT(pi), cont?reg|8:reg);
 }
 
 static void bpck6_write_regr(struct pi_adapter *pi, int cont, int reg, int val)
 {
-	/* check for bad settings */
-	if (reg>=0 && reg<=7 && cont>=0 && cont<=1)
-	{
-		ppc6_wr_port(PPCSTRUCT(pi),cont?reg|8:reg,(u8)val);
-	}
+	ppc6_wr_port(PPCSTRUCT(pi), cont?reg|8:reg, val);
 }
 
 static void bpck6_write_block(struct pi_adapter *pi, char *buf, int len)
-- 
Ondrej Zary

