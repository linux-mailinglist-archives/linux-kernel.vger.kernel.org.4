Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F175E6ACB9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCFR4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjCFRzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:55:48 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B3616907C;
        Mon,  6 Mar 2023 09:55:17 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 4CD087A047E;
        Mon,  6 Mar 2023 18:28:28 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/18] pata_parport: probe all units automatically
Date:   Mon,  6 Mar 2023 18:27:36 +0100
Message-Id: <20230306172752.7727-3-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230306172752.7727-1-linux@zary.sk>
References: <20230306172752.7727-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only unit 0 is probed after registering a protocol driver or attaching
a new parport. This causes bpck and bpck6 devices to be not detected
automatically.
Probe all units just like in manual device creation (using sysfs).

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/pata_parport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 294a266a0dda..49e99c9465fd 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -530,7 +530,7 @@ int pata_parport_register_driver(struct pi_protocol *pr)
 	if (probe) {
 		/* probe all parports using this protocol */
 		idr_for_each_entry(&parport_list, parport, port_num)
-			pi_init_one(parport, pr, -1, 0, -1);
+			pi_init_one(parport, pr, -1, -1, -1);
 	}
 	mutex_unlock(&pi_mutex);
 
@@ -665,7 +665,7 @@ static void pata_parport_attach(struct parport *port)
 	if (probe) {
 		/* probe this port using all protocols */
 		idr_for_each_entry(&protocols, pr, pr_num)
-			pi_init_one(port, pr, -1, 0, -1);
+			pi_init_one(port, pr, -1, -1, -1);
 	}
 	mutex_unlock(&pi_mutex);
 }
-- 
Ondrej Zary

