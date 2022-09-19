Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854915BC41B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiISIPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiISIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:15:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA4914D09;
        Mon, 19 Sep 2022 01:15:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so6210008pjk.4;
        Mon, 19 Sep 2022 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=xm+afcn23GdWTJR/CblLcqXH8d/0puVssJJhrzazZxw=;
        b=lP5t1ontj4O7jZqagDR75QfeOkrLVtRCBxMR8/A8nvb3eLVf6kXgM9m/lJHZparFXz
         XY+g7Upyjy8UpVseXLE7b4rfYUbjKayQNJv23MQFPgFaLGaCrKpQrCunbSbgWMW/EeYY
         6MIRQ2SjGbugAVnHuCScv+6FsH1a3I8lWkBtNd7bfK+5jRyJqWedMTlZNKqCld8Zn8gY
         KusevqL/qQRhQYwIzn9an/gg9rySpCAgEM2QhPDrMAF3qixyvUG6a2d4tKbB/UlV9msk
         YXykv4KPzo5GCfEBmqCuC0zb/pm7A+KNKlKcr3OOGdyYYGhVrewnixA0ZinSqUlpz4fS
         5/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xm+afcn23GdWTJR/CblLcqXH8d/0puVssJJhrzazZxw=;
        b=pBeLdtfvdYb+HZ8J6wtfdwEM709MjUHKw/XVvulsozXnt1r5g4II+Z1sqmgaHQt3D6
         c3Hk4T3ZNk/xzPS8W2+OuyriM8AyAHFyhmT58olvuSs1Ka3vY+Ai9cj3br9axWWbzih5
         fcqtu0hPpQTsWTo2hX/HmLml4/jXSSNW50xDkYqrDoXp8zv+ff4vJdAaVYnxD7ImTOyT
         FG5RDZTxlaqd7etA6yshZGj4HHRyfH+axOwX1rBd8Lw8BmdsK8j9JX2KQnDBIfgDNGGn
         wN+Pa8UE0/+kRUWX9m2cE79lrSQ61iq7Wl8BzTcQppnxEFCJHYEl9b8eRAcnedh/ifxJ
         JwhA==
X-Gm-Message-State: ACrzQf17eu1KhQgoPDkKFXc5RU7WKwRwZPnO+b0/Ne35OuiP02pjuy08
        OXZVyowA+Gx7DYICP6RH4qxTwzxb9qZLNA==
X-Google-Smtp-Source: AMsMyM4UHBgCYJUu4oqB6gtLAns6AoU8pGq2H6ttpfl04xEJR+CfUJpYjk7SlhAn+p7Xk105CRWPQA==
X-Received: by 2002:a17:90b:1b0a:b0:203:3947:1a73 with SMTP id nu10-20020a17090b1b0a00b0020339471a73mr19078447pjb.43.1663575342833;
        Mon, 19 Sep 2022 01:15:42 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id d16-20020a63fd10000000b00439920bfcbdsm7621992pgh.46.2022.09.19.01.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:15:41 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     jirislaby@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        alcooperx@gmail.com, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/tty/serial/8250: check the return value of clk_set_rate()
Date:   Mon, 19 Sep 2022 01:15:23 -0700
Message-Id: <20220919081523.1579904-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the return of clk_set_rate() which could fail if there is error
setting the rate.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 8efdc271eb75..9014853d6e35 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -671,7 +671,9 @@ static void init_real_clk_rates(struct device *dev, struct brcmuart_priv *priv)
 			priv->real_rates[x] = clk_get_rate(priv->baud_mux_clk);
 		}
 	}
-	clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
+	rc = clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
+	if (rc)
+		dev_err(dev, "Error restoring default BAUD MUX clock\n");
 }
 
 static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
-- 
2.25.1

