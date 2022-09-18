Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC05BBC2D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 08:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIRG2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 02:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRG1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 02:27:50 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB5D2611F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 23:27:47 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id ZnmJo9OZsAOp2ZnmJoqqJY; Sun, 18 Sep 2022 08:27:45 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Sep 2022 08:27:45 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 3/3] misc: microchip: pci1xxxx: Fix the error handling paths of gp_aux_bus_probe()
Date:   Sun, 18 Sep 2022 08:27:42 +0200
Message-Id: <1b41531de02ee029628d9b0ec2cf1ee7f180fe10.1663482259.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1663482259.git.christophe.jaillet@wanadoo.fr>
References: <cover.1663482259.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several issues related to the error handling paths of
gp_aux_bus_probe():
   - some resources may be released twice. Once explicitly in the error
     handling path, and once via the release() function
   - auxiliary_device_delete() should be called after the first successful
     auxiliary_device_add()

To fix them, reorder the code:
   - move the place where we get the irq for the 2nd wrapper.
   - call kfree() and ida_free() after error checks, rather then in the
     error handling path.
   - have the error handling path look like the remove function

Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative and untested, review with care.

Other solutions are possible.
For example, we could use devm_kzalloc() to simplify the error handling
path and the release function.
---
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 74 ++++++++++---------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
index 32af2b14ff34..d3253e98f2ec 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
@@ -32,7 +32,7 @@ static void gp_auxiliary_device_release(struct device *dev)
 static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct aux_bus_device *aux_bus;
-	int retval;
+	int irq, retval;
 
 	retval = pcim_enable_device(pdev);
 	if (retval)
@@ -48,8 +48,10 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		return -ENOMEM;
 
 	retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
-	if (retval < 0)
-		goto err_ida_alloc_0;
+	if (retval < 0) {
+		kfree(aux_bus->aux_device_wrapper[0]);
+		return retval;
+	}
 
 	aux_bus->aux_device_wrapper[0]->aux_dev.name = aux_dev_otp_e2p_name;
 	aux_bus->aux_device_wrapper[0]->aux_dev.dev.parent = &pdev->dev;
@@ -60,21 +62,38 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	aux_bus->aux_device_wrapper[0]->gp_aux_data.region_length = pci_resource_end(pdev, 0);
 
 	retval = auxiliary_device_init(&aux_bus->aux_device_wrapper[0]->aux_dev);
-	if (retval < 0)
-		goto err_aux_dev_init_0;
+	if (retval < 0) {
+		ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[0]->aux_dev.id);
+		kfree(aux_bus->aux_device_wrapper[0]);
+		goto err_aux_dev_uninit_0;
+	}
 
 	retval = auxiliary_device_add(&aux_bus->aux_device_wrapper[0]->aux_dev);
 	if (retval)
-		goto err_aux_dev_add_0;
+		goto err_aux_dev_uninit_0;
+
+
+	retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (retval < 0)
+		goto err_aux_dev_del_0;
+
+	retval = pci_irq_vector(pdev, 0);
+	if (retval < 0)
+		goto err_aux_dev_del_0;
+	irq = retval;
 
 	aux_bus->aux_device_wrapper[1] = kzalloc(sizeof(*aux_bus->aux_device_wrapper[1]),
 						 GFP_KERNEL);
-	if (!aux_bus->aux_device_wrapper[1])
-		return -ENOMEM;
+	if (!aux_bus->aux_device_wrapper[1]) {
+		retval = -ENOMEM;
+		goto err_aux_dev_del_0;
+	}
 
 	retval = ida_alloc(&gp_client_ida, GFP_KERNEL);
-	if (retval < 0)
-		goto err_ida_alloc_1;
+	if (retval < 0) {
+		kfree(aux_bus->aux_device_wrapper[1]);
+		goto err_aux_dev_del_0;
+	}
 
 	aux_bus->aux_device_wrapper[1]->aux_dev.name = aux_dev_gpio_name;
 	aux_bus->aux_device_wrapper[1]->aux_dev.dev.parent = &pdev->dev;
@@ -84,49 +103,34 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	aux_bus->aux_device_wrapper[1]->gp_aux_data.region_start = pci_resource_start(pdev, 0);
 	aux_bus->aux_device_wrapper[1]->gp_aux_data.region_length = pci_resource_end(pdev, 0);
 
-	retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-
-	if (retval < 0)
-		goto err_aux_dev_init_1;
-
-	retval = pci_irq_vector(pdev, 0);
-	if (retval < 0)
-		goto err_aux_dev_init_1;
-
 	pdev->irq = retval;
 	aux_bus->aux_device_wrapper[1]->gp_aux_data.irq_num = pdev->irq;
 
 	retval = auxiliary_device_init(&aux_bus->aux_device_wrapper[1]->aux_dev);
-	if (retval < 0)
-		goto err_aux_dev_init_1;
+	if (retval < 0) {
+		ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[1]->aux_dev.id);
+		kfree(aux_bus->aux_device_wrapper[1]);
+		goto err_aux_dev_del_0;
+	}
 
 	retval = auxiliary_device_add(&aux_bus->aux_device_wrapper[1]->aux_dev);
 	if (retval)
-		goto err_aux_dev_add_1;
+		goto err_aux_dev_uninit_1;
 
 	pci_set_drvdata(pdev, aux_bus);
 	pci_set_master(pdev);
 
 	return 0;
 
-err_aux_dev_add_1:
+err_aux_dev_uninit_1:
 	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev);
 
-err_aux_dev_init_1:
-	ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[1]->aux_dev.id);
-
-err_ida_alloc_1:
-	kfree(aux_bus->aux_device_wrapper[1]);
+err_aux_dev_del_0:
+	auxiliary_device_delete(&aux_bus->aux_device_wrapper[0]->aux_dev);
 
-err_aux_dev_add_0:
+err_aux_dev_uninit_0:
 	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[0]->aux_dev);
 
-err_aux_dev_init_0:
-	ida_free(&gp_client_ida, aux_bus->aux_device_wrapper[0]->aux_dev.id);
-
-err_ida_alloc_0:
-	kfree(aux_bus->aux_device_wrapper[0]);
-
 	return retval;
 }
 
-- 
2.34.1

