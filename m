Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93772ACC5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjFJP7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbjFJP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:59:47 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3047230D6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 08:59:45 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 80zwqFULNV4eY810CqBQ6F; Sat, 10 Jun 2023 17:59:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686412784;
        bh=x5Q7JFOBqrMC6o8LYzgUOOfoq0P2ZHbeu6tRAx/Ruf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YY/e99CuaAkuIPwh6/SwneGP1bgOzZ4odMId2zpnEkjSh3cZgft7aYxVRg6Wnj3Qr
         hoAVzpPPXUhZ4doPh2Nf4+hQUrE01Ce/6zSCNAiKs8HMFrxxsP3bZWmqwx9+378vXp
         fRqwQHcYiJ3v+WlDVbhROmisSkW5xwLzjf5w0F8enIwvJjpm5mvRPzCwUnYZC6pAav
         FUMjzRH6n00FqPIoVyf67rr1tF0+nIXXxSnP2kCXbLHlUpcBKCl02JWpzHU+EsMhkD
         jwVgmjma1/1IKVYO1C+ZbRdUX2XhcVVRqisluDxYBfB83SJvP8Atgi95U5FstO/v/5
         LYkv4i5LVGZHw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Jun 2023 17:59:44 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Walter Harms <wharms@bfs.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 3/3] tty: serial: samsung_tty: Use abs() to simplify some code
Date:   Sat, 10 Jun 2023 17:59:27 +0200
Message-Id: <7bd165e82ed3675d4ddee343ab373031e995a126.1686412569.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e4baf6039368f52e5a5453982ddcb9a330fc689e.1686412569.git.christophe.jaillet@wanadoo.fr>
References: <e4baf6039368f52e5a5453982ddcb9a330fc689e.1686412569.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use abs() instead of hand-writing it.

Suggested-by: Walter Harms <wharms@bfs.de>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: new patch
---
 drivers/tty/serial/samsung_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 0b37019820b4..b29e9dfd81a6 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -24,6 +24,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
@@ -1485,9 +1486,7 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 		}
 		quot--;
 
-		calc_deviation = req_baud - baud;
-		if (calc_deviation < 0)
-			calc_deviation = -calc_deviation;
+		calc_deviation = abs(req_baud - baud);
 
 		if (calc_deviation < deviation) {
 			/*
-- 
2.34.1

