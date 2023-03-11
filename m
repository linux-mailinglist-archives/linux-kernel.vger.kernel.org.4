Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796336B6114
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCKVo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCKVoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:44:55 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F325B67813;
        Sat, 11 Mar 2023 13:44:54 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 3C9497A0158;
        Sat, 11 Mar 2023 22:44:54 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pata_parport: fix possible memory leak
Date:   Sat, 11 Mar 2023 22:44:47 +0100
Message-Id: <20230311214447.7359-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <202303112239.21234.linux@zary.sk>
References: <202303112239.21234.linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ida_alloc() fails, "pi" is not freed although the misleading
comment says otherwise.
Move the ida_alloc() call up so we really don't have to free it.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202303111822.IHNchbkp-lkp@intel.com/
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/pata_parport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 6165ee9aa7da..a9eff6003098 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -503,18 +503,19 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 	if (bus_for_each_dev(&pata_parport_bus_type, NULL, &match, pi_find_dev))
 		return NULL;
 
+	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
+	if (id < 0)
+		return NULL;
+
 	pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
 	if (!pi)
-		return NULL;
+		goto out_ida_free;
 
 	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
 	pi->dev.parent = &pata_parport_bus;
 	pi->dev.bus = &pata_parport_bus_type;
 	pi->dev.driver = &pr->driver;
 	pi->dev.release = pata_parport_dev_release;
-	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
-	if (id < 0)
-		return NULL; /* pata_parport_dev_release will do kfree(pi) */
 	pi->dev.id = id;
 	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
 	if (device_register(&pi->dev)) {
@@ -571,7 +572,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 out_unreg_dev:
 	device_unregister(&pi->dev);
 out_ida_free:
-	ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
+	ida_free(&pata_parport_bus_dev_ids, id);
 	return NULL;
 }
 
-- 
Ondrej Zary

