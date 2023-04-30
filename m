Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F78C6F2854
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjD3Jfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 05:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjD3Jfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 05:35:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211910F9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 02:35:40 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id t3SzpqrC7QSvkt3SzpzF7s; Sun, 30 Apr 2023 11:35:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682847337;
        bh=RqDQjPSPVAS9useuh9rd9llDLOh/Ap8G6Tllign/gys=;
        h=From:To:Cc:Subject:Date;
        b=RUNDth6gqurw4DEOjvsaRSu2xq/FQHGVT+f3/JQu3U9X7FY7BvbutZrLNpzIXOu0x
         kkBDTyeLSBa5AqdDaF93rjDvd4/2+m+wjBBI062L/SJyXcN1LBHJ069Qw6vfQMzZzt
         VEB3od6qm5hASCf+X/c0g3Ljj5Qvt6TithpzQnDwWFalPal929YXvKCzV7u51le/T5
         4/zfvqdclM01Gv9HwrEQ//HeOq/6c2VPuUblv/OnkF6Rnu0D0C4mx41XbV97JDPVTZ
         TtwsX44gQSoW+vDqTsSmC3XnxpMakMIdJ/faCcRssRu5p4nxISu0mrMq4RAk1jgFMV
         S5Hb6uMU/zPTg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 30 Apr 2023 11:35:37 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: Use non-atomic xxx_bit() functions
Date:   Sun, 30 Apr 2023 11:35:35 +0200
Message-Id: <6b8f405145d3d57a8026dc61ca3f1ae70d690990.1682847325.git.christophe.jaillet@wanadoo.fr>
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

Accesses to 'minors' are guarded by the 'device_list_lock' mutex. So, it is
safe to use the non-atomic version of (set|clear)_bit() in the
corresponding sections.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spidev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 39d94c850839..132fecc02eba 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -812,7 +812,7 @@ static int spidev_probe(struct spi_device *spi)
 		status = -ENODEV;
 	}
 	if (status == 0) {
-		set_bit(minor, minors);
+		__set_bit(minor, minors);
 		list_add(&spidev->device_entry, &device_list);
 	}
 	mutex_unlock(&device_list_lock);
@@ -840,7 +840,7 @@ static void spidev_remove(struct spi_device *spi)
 
 	list_del(&spidev->device_entry);
 	device_destroy(spidev_class, spidev->devt);
-	clear_bit(MINOR(spidev->devt), minors);
+	__clear_bit(MINOR(spidev->devt), minors);
 	if (spidev->users == 0)
 		kfree(spidev);
 	mutex_unlock(&device_list_lock);
-- 
2.34.1

