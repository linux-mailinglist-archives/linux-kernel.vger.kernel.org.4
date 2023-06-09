Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4C6729681
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbjFIKNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbjFIKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:13:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA514210;
        Fri,  9 Jun 2023 03:02:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-973f78329e3so282575766b.3;
        Fri, 09 Jun 2023 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686304957; x=1688896957;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sy3PFH0i16OR495KV2SRJ9doNRvKz2foyZHcs8gVG8=;
        b=F0Ba6tXNsPudB2pZ2F0mCXv5biLezbUIw8pnUlcxQcn0zO0/VEvYGHXnDXJUsr5KUn
         X+umIxtRTdq4m0rMvcjVwLXaZ3qhBU/O+YW/mdfjSkTpOJZj+95QQ7CqRftoc4AxB8WK
         OUWZLytwgjVUYmYAGt2ILIPnI+tZiNHNx0yZnREMgQj/iq1/xOGXF2OSwDiHTDsec+/K
         dSxaB3PTibkwdORlubFqcdhTHNKQ3b5DbYnYt3jPz7YsSUjhQgQ5nDhzcqMsJXIJmGtZ
         QfkdUKqhrf9TJmRuCrmCDzr88II+qBqDm6UZeNn4ZgqfPHOiYckq9jO8CC2PT0pNlUZQ
         rA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304957; x=1688896957;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Sy3PFH0i16OR495KV2SRJ9doNRvKz2foyZHcs8gVG8=;
        b=H+EkXjiqzsyhpxoLqapJ/zk1Wq8PYnBcOxwsaF3+5Clx9jGEi9XNH6WSOSObcZQ9uc
         Yd6GPw/U1hEvONKCH2101Sqig35px7NZIRcTZhX/WIXk0rw8rbWOfYXstJd4pHeqpQKI
         fdmaPQMCEWiXDqXg1cj4F922SrRiLEOfI0EWjctGYxLh01IksM2rAzS4W9kFWP6DjYxI
         WqFEzxjQVZ3eDpr2NhP9vC66lISikdJERhQQHnKV4ZlIIM9bxTDnuIy6oFkQl301BkQW
         sGIr9VglK60d/hucCjzu0vgppjrGEpTjNG1+IIbFy+XSJGMRCh104QQKYb2Le+8MnwKh
         GFmg==
X-Gm-Message-State: AC+VfDySGJqjGky7yJZxqI6QJdIEc37SBgG9UyfIKFFDb9lytOY1WHpL
        3AG0uJnAFU+JR6nn2b+6WjaRPi7WSJs=
X-Google-Smtp-Source: ACHHUZ7tlE78bo7phZxc+4W/jhKp9bIIfvPnF2aJ3QHzGcMGyBy3fuQPnAoGaDzXmhb8e0JU4L9dxA==
X-Received: by 2002:a17:907:6e12:b0:977:ab43:731f with SMTP id sd18-20020a1709076e1200b00977ab43731fmr1639678ejc.66.1686304957254;
        Fri, 09 Jun 2023 03:02:37 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:f180:ae6e:6e9a:f400])
        by smtp.gmail.com with ESMTPSA id oq19-20020a170906cc9300b00977e0bcff1esm1123149ejb.10.2023.06.09.03.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 03:02:36 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        linux-leds@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] leds: fix config reference for AW200xx driver
Date:   Fri,  9 Jun 2023 12:02:33 +0200
Message-Id: <20230609100233.4111-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 36a87f371b7a ("leds: Add AW20xx driver") adds config LEDS_AW200XX
in drivers/leds/Kconfig, but then in drivers/leds/Makefile accidently
refers to CONFIG_LEDS_W200XX; note the missing A!

This typo makes it impossible to add the driver to a kernel build.

Fix this wrong config reference.

Fixes: 36a87f371b7a ("leds: Add AW20xx driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/leds/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index df6bf408212c..d71f1226540c 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
 obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
-obj-$(CONFIG_LEDS_W200XX)		+= leds-aw200xx.o
+obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
 obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
-- 
2.17.1

