Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8D5BBC29
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 08:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiIRG1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 02:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIRG1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 02:27:38 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916125E87
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 23:27:38 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id ZnmAoJp3fTyouZnmAoYlTc; Sun, 18 Sep 2022 08:27:36 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Sep 2022 08:27:36 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 2/3] misc: microchip: pci1xxxx: Fix a memory leak in the error handling of gp_aux_bus_probe()
Date:   Sun, 18 Sep 2022 08:27:33 +0200
Message-Id: <17e19926669a1654e5f2495bf3b289581183d02e.1663482259.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1663482259.git.christophe.jaillet@wanadoo.fr>
References: <cover.1663482259.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'aux_bus' is freed in the remove function but not in the error handling
path of the probe.

Use devm_kzalloc() to simplify the remove function and fix the leak in the
probe.

Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
index 6c4f8384aa09..32af2b14ff34 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
@@ -38,7 +38,7 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (retval)
 		return retval;
 
-	aux_bus = kzalloc(sizeof(*aux_bus), GFP_KERNEL);
+	aux_bus = devm_kzalloc(&pdev->dev, sizeof(*aux_bus), GFP_KERNEL);
 	if (!aux_bus)
 		return -ENOMEM;
 
@@ -138,7 +138,6 @@ static void gp_aux_bus_remove(struct pci_dev *pdev)
 	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[0]->aux_dev);
 	auxiliary_device_delete(&aux_bus->aux_device_wrapper[1]->aux_dev);
 	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev);
-	kfree(aux_bus);
 }
 
 static const struct pci_device_id pci1xxxx_tbl[] = {
-- 
2.34.1

