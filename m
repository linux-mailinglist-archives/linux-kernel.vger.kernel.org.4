Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D1D5BBC28
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 08:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIRG1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 02:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIRG1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 02:27:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DD125EAD
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 23:27:28 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Znm1oh1YIBDYDZnm1ofRWp; Sun, 18 Sep 2022 08:27:27 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Sep 2022 08:27:27 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 1/3] misc: microchip: pci1xxxx: Do not disable the pci device twice in gp_aux_bus_remove()
Date:   Sun, 18 Sep 2022 08:27:24 +0200
Message-Id: <8a3a385b3ae15ee7497469ec3250302b626a018b.1663482259.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1663482259.git.christophe.jaillet@wanadoo.fr>
References: <cover.1663482259.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gp_aux_bus_probe() uses pcim_enable_device(), so there is no point in
calling pci_disable_device() explicitly in the remove function.

Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
index edff3ee73f6f..6c4f8384aa09 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
@@ -139,7 +139,6 @@ static void gp_aux_bus_remove(struct pci_dev *pdev)
 	auxiliary_device_delete(&aux_bus->aux_device_wrapper[1]->aux_dev);
 	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev);
 	kfree(aux_bus);
-	pci_disable_device(pdev);
 }
 
 static const struct pci_device_id pci1xxxx_tbl[] = {
-- 
2.34.1

