Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C368970A8CC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 17:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjETPRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 11:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjETPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 11:17:48 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DF2FE
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 08:17:47 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0OL2qxEf9KkqR0OL3qE16C; Sat, 20 May 2023 17:17:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684595865;
        bh=NYS0+POCoqp3fqggV8ajYmceozpIyaDAzScoVhfOmvk=;
        h=From:To:Cc:Subject:Date;
        b=c5vX2GpYoQNcaWitUgGn3tivkOqJmcaiO0iuBAdXG/MnjO3qH054AmA+C/wZ+dCHN
         Ze7m2ICI3C+0CHlL9VUY1aifbWkBESuetxWtC6oj2c9jfhbHJemxIcg6ibupNyMXDr
         wE336W9rOvgvhUZJn7lnE4yKOKdZXXKVrBJ+xe0ExGMWAxZot0Dm+9h3GqrCiCWqMe
         uFRMYpYz2Ee0NgkQLPJAEB1yK3QvQHJjS322ZlWf6m30Taxy7g80uyx9vxPfmR+o2q
         1NjtWgePMGXiN8O9Pq4cUwGQT5sBgxoerF6WFrQJ3MbKYMkGsatlFbn4yPKKYb/KNR
         4/O+QYx2GOBhg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 17:17:45 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_ll: Use the devm_clk_get_optional() helper
Date:   Sat, 20 May 2023 17:17:43 +0200
Message-Id: <2035c65977818626011f512d17cd018b6d877925.1684595848.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() instead of hand writing it.
This is slightly less verbose and improves the semantic.

This also simplifies ll_open() because clk_prepare_enable() already handles
NULL clk.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/bluetooth/hci_ll.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 4a0b5c3160c2..de463d8bf265 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -129,8 +129,7 @@ static int ll_open(struct hci_uart *hu)
 	if (hu->serdev) {
 		struct ll_device *lldev = serdev_device_get_drvdata(hu->serdev);
 
-		if (!IS_ERR(lldev->ext_clk))
-			clk_prepare_enable(lldev->ext_clk);
+		clk_prepare_enable(lldev->ext_clk);
 	}
 
 	return 0;
@@ -703,8 +702,8 @@ static int hci_ti_probe(struct serdev_device *serdev)
 	if (IS_ERR(lldev->enable_gpio))
 		return PTR_ERR(lldev->enable_gpio);
 
-	lldev->ext_clk = devm_clk_get(&serdev->dev, "ext_clock");
-	if (IS_ERR(lldev->ext_clk) && PTR_ERR(lldev->ext_clk) != -ENOENT)
+	lldev->ext_clk = devm_clk_get_optional(&serdev->dev, "ext_clock");
+	if (IS_ERR(lldev->ext_clk))
 		return PTR_ERR(lldev->ext_clk);
 
 	of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
-- 
2.34.1

