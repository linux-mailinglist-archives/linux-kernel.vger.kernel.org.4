Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7843E6BA2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCNW7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCNW7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:59:16 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EC0551CB4;
        Tue, 14 Mar 2023 15:58:52 -0700 (PDT)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id E6A2A7A0081;
        Tue, 14 Mar 2023 23:58:11 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] pata_parport: fix memory leaks
Date:   Tue, 14 Mar 2023 23:58:05 +0100
Message-Id: <20230314225805.9124-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cf8c7b34-3c5d-2b9e-b410-d83f4af7274a@opensource.wdc.com>
References: <cf8c7b34-3c5d-2b9e-b410-d83f4af7274a@opensource.wdc.com>
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
Move the ida_alloc() call up so we really don't have to free "pi" in
case of ida_alloc() failure.

Also move ida_free() call from pi_remove_one() to
pata_parport_dev_release(). It was dereferencing already freed dev
pointer.

Testing revealed leak even in non-failure case which was tracked down
to missing put_device() call after bus_find_device_by_name(). As a
result, pata_parport_dev_release() was never called.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202303111822.IHNchbkp-lkp@intel.com/
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/pata_parport.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 6165ee9aa7da..dc77b4c6fcef 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -452,6 +452,7 @@ static void pata_parport_dev_release(struct device *dev)
 {
 	struct pi_adapter *pi = container_of(dev, struct pi_adapter, dev);
 
+	ida_free(&pata_parport_bus_dev_ids, dev->id);
 	kfree(pi);
 }
 
@@ -503,23 +504,27 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 	if (bus_for_each_dev(&pata_parport_bus_type, NULL, &match, pi_find_dev))
 		return NULL;
 
+	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
+	if (id < 0)
+		return NULL;
+
 	pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
-	if (!pi)
+	if (!pi) {
+		ida_free(&pata_parport_bus_dev_ids, id);
 		return NULL;
+	}
 
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
 		put_device(&pi->dev);
-		goto out_ida_free;
+		/* pata_parport_dev_release will do ida_free(dev->id) and kfree(pi) */
+		return NULL;
 	}
 
 	pi->proto = pr;
@@ -534,8 +539,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 	pi->port = parport->base;
 
 	par_cb.private = pi;
-	pi->pardev = parport_register_dev_model(parport, DRV_NAME, &par_cb,
-						pi->dev.id);
+	pi->pardev = parport_register_dev_model(parport, DRV_NAME, &par_cb, id);
 	if (!pi->pardev)
 		goto out_module_put;
 
@@ -570,8 +574,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 	module_put(pi->proto->owner);
 out_unreg_dev:
 	device_unregister(&pi->dev);
-out_ida_free:
-	ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
+	/* pata_parport_dev_release will do ida_free(dev->id) and kfree(pi) */
 	return NULL;
 }
 
@@ -696,8 +699,7 @@ static void pi_remove_one(struct device *dev)
 	pi_disconnect(pi);
 	pi_release(pi);
 	device_unregister(dev);
-	ida_free(&pata_parport_bus_dev_ids, dev->id);
-	/* pata_parport_dev_release will do kfree(pi) */
+	/* pata_parport_dev_release will do ida_free(dev->id) and kfree(pi) */
 }
 
 static ssize_t delete_device_store(struct bus_type *bus, const char *buf,
@@ -713,6 +715,7 @@ static ssize_t delete_device_store(struct bus_type *bus, const char *buf,
 	}
 
 	pi_remove_one(dev);
+	put_device(dev);
 	mutex_unlock(&pi_mutex);
 
 	return count;
-- 
Ondrej Zary

