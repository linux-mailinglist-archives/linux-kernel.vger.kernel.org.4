Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB27E6931A1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 15:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjBKOmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 09:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBKOmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 09:42:53 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC38E1F499;
        Sat, 11 Feb 2023 06:42:50 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 3F28C7A05AB;
        Sat, 11 Feb 2023 15:42:49 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] pata_parport: remove devtype from struct pi_adapter
Date:   Sat, 11 Feb 2023 15:42:23 +0100
Message-Id: <20230211144232.15138-4-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230211144232.15138-1-linux@zary.sk>
References: <20230211144232.15138-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only bpck driver uses devtype but it never gets set in pata_parport.
Remove it.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck.c | 2 +-
 include/linux/pata_parport.h    | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index b9174cf8863c..451a068fe28a 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -241,7 +241,7 @@ static void bpck_connect ( PIA *pi  )
 
 	WR(5,8);
 
-	if (pi->devtype == PI_PCD) {
+	if (1 /*pi->devtype == PI_PCD*/) {	/* FIXME */
 		WR(0x46,0x10);		/* fiddle with ESS logic ??? */
 		WR(0x4c,0x38);
 		WR(0x4d,0x88);
diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
index 9614ce53470a..3fc6b002c7c8 100644
--- a/include/linux/pata_parport.h
+++ b/include/linux/pata_parport.h
@@ -11,15 +11,12 @@
 
 #include <linux/libata.h>
 
-#define PI_PCD	1	/* dummy for paride protocol modules */
-
 struct pi_adapter {
 	struct device dev;
 	struct pi_protocol *proto;	/* adapter protocol */
 	int port;			/* base address of parallel port */
 	int mode;			/* transfer mode in use */
 	int delay;			/* adapter delay setting */
-	int devtype;			/* dummy for paride protocol modules */
 	char *device;			/* dummy for paride protocol modules */
 	int unit;			/* unit number for chained adapters */
 	int saved_r0;			/* saved port state */
-- 
Ondrej Zary

