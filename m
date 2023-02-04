Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ED468AC5A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 21:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjBDUzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 15:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDUzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 15:55:37 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C4671C337;
        Sat,  4 Feb 2023 12:55:36 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 90B747A028D;
        Sat,  4 Feb 2023 21:55:33 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Dan Carpenter <error27@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_parport: Fix ida_alloc return value error check
Date:   Sat,  4 Feb 2023 21:55:27 +0100
Message-Id: <20230204205527.16716-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <Y9uwqRothHhaOeDO@kili>
References: <Y9uwqRothHhaOeDO@kili>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pi->dev.id is unsigned so error checking of ida_alloc return value does
not work. Fix it.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/pata_parport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 9e8ad93d7e59..294a266a0dda 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -424,6 +424,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 	struct ata_host *host;
 	struct pi_adapter *pi;
 	struct pi_device_match match = { .parport = parport, .proto = pr };
+	int id;
 
 	/*
 	 * Abort if there's a device already registered on the same parport
@@ -441,9 +442,10 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 	pi->dev.bus = &pata_parport_bus_type;
 	pi->dev.driver = &pr->driver;
 	pi->dev.release = pata_parport_dev_release;
-	pi->dev.id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
-	if (pi->dev.id < 0)
+	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
+	if (id < 0)
 		return NULL; /* pata_parport_dev_release will do kfree(pi) */
+	pi->dev.id = id;
 	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
 	if (device_register(&pi->dev)) {
 		put_device(&pi->dev);
-- 
Ondrej Zary

