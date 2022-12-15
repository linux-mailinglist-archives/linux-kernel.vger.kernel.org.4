Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C9964D89A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiLOJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLOJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:30:21 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592446665;
        Thu, 15 Dec 2022 01:30:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bj12so50784979ejb.13;
        Thu, 15 Dec 2022 01:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgD/IhEryTzLI7fgwREjgsiNZnMhiP+O1KnPg96xGtU=;
        b=BgCDQ/OHqHTPrhxas7wzRIuA6tFpxWfaC4H4YmVy/ZbAZnCAbSjLiwzbCUOLwzZmUJ
         IGhvwlYuZgThpR9zR3gUV4gjbzB7/3SWBWNgH4oz3R+Ede8egmLu4r6yDKAvTNyrreLz
         Ia7442M3FClbdBvIIDteq2EQsduzET6IOmvDJvtWAnzLOffUJJc+qBnC0V1t8pE7JIeI
         JocZ9FtoSDxMXgQqPbgwXjnb0CEDM91MKlQj1UOdhYrAnsGeXAxF+zInZEprXGl5X4OV
         VXo3m92pCUDpGC6I9fW7OgM+yqwgKULmqyzK3vyTNJ/RHePhLfEXTZ3E5w4ufunyylCR
         vekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgD/IhEryTzLI7fgwREjgsiNZnMhiP+O1KnPg96xGtU=;
        b=n4DONNL/sLefmGBLd1c5NbUZsD6l0WlQ/ZpCViIpLme/xkgwMbXHziROjQPPD93eyR
         DA4DdN5SWK8sy2BnQgIP2D8UCUNUCoTp8TIBUiGIvhBUg78V/xyZYnM0JaG7DYv0/D7T
         xi0RzXCkWhiqcjGSmaDdV7AxT47+2+rou5c32nL4sfeRY6dZz7nEeMlzM3T6awpK8YQe
         Aardf2tFSYevYRqoQvNbb7QEhcL10v6nALRlSkgEhnToLdPD3mp8KyKWUj1yMMqr/NaD
         sEUm1uWKPE2DmiGb5U9R+Ib20LNBBcK9oOlmnOdyRFM3O29iwuJI6sSft8Zcaf5k/xyC
         K4fg==
X-Gm-Message-State: ANoB5pnsEnBHD9v0FLqwO9W+65Pvj0EPxjvsWG5ZA34VTg81GJzZ1yiV
        NWnjPgwEEokZqURcKC996Cs=
X-Google-Smtp-Source: AA0mqf7VephO2wPiq66MWYE5WIf/bbAOFq2wAt45qgFs4lIAV/YzGeJ3uSSllU+WnM7K8ccJdtJ2UA==
X-Received: by 2002:a17:907:9208:b0:7c0:d605:fe42 with SMTP id ka8-20020a170907920800b007c0d605fe42mr17670532ejb.18.1671096617080;
        Thu, 15 Dec 2022 01:30:17 -0800 (PST)
Received: from felia.fritz.box (ipbcc1d920.dynamic.kabel-deutschland.de. [188.193.217.32])
        by smtp.gmail.com with ESMTPSA id ko12-20020a170907986c00b00781be3e7badsm6859873ejc.53.2022.12.15.01.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:30:16 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] pinctrl: mxs: avoid defines prefixed with CONFIG
Date:   Thu, 15 Dec 2022 10:21:28 +0100
Message-Id: <20221215092128.3954-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
that are introduced in a Kconfig file.

Here, expressions to convert pin configurations to booleans for pull-up,
voltage and mA are macro definitions that begin with "CONFIG".

To avoid defines prefixed with "CONFIG", rename these defines to begin with
"PIN_CONFIG" instead.

No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/pinctrl/freescale/pinctrl-mxs.c | 6 +++---
 drivers/pinctrl/freescale/pinctrl-mxs.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-mxs.c b/drivers/pinctrl/freescale/pinctrl-mxs.c
index 9f78c9b29ddd..cf3f4d2e0c16 100644
--- a/drivers/pinctrl/freescale/pinctrl-mxs.c
+++ b/drivers/pinctrl/freescale/pinctrl-mxs.c
@@ -269,9 +269,9 @@ static int mxs_pinconf_group_set(struct pinctrl_dev *pctldev,
 	for (n = 0; n < num_configs; n++) {
 		config = configs[n];
 
-		ma = CONFIG_TO_MA(config);
-		vol = CONFIG_TO_VOL(config);
-		pull = CONFIG_TO_PULL(config);
+		ma = PIN_CONFIG_TO_MA(config);
+		vol = PIN_CONFIG_TO_VOL(config);
+		pull = PIN_CONFIG_TO_PULL(config);
 
 		for (i = 0; i < g->npins; i++) {
 			bank = PINID_TO_BANK(g->pins[i]);
diff --git a/drivers/pinctrl/freescale/pinctrl-mxs.h b/drivers/pinctrl/freescale/pinctrl-mxs.h
index ab9f834b03e6..5b26511d56aa 100644
--- a/drivers/pinctrl/freescale/pinctrl-mxs.h
+++ b/drivers/pinctrl/freescale/pinctrl-mxs.h
@@ -44,9 +44,9 @@
 #define VOL_SHIFT		3
 #define MA_PRESENT		(1 << 2)
 #define MA_SHIFT		0
-#define CONFIG_TO_PULL(c)	((c) >> PULL_SHIFT & 0x1)
-#define CONFIG_TO_VOL(c)	((c) >> VOL_SHIFT & 0x1)
-#define CONFIG_TO_MA(c)		((c) >> MA_SHIFT & 0x3)
+#define PIN_CONFIG_TO_PULL(c)	((c) >> PULL_SHIFT & 0x1)
+#define PIN_CONFIG_TO_VOL(c)	((c) >> VOL_SHIFT & 0x1)
+#define PIN_CONFIG_TO_MA(c)	((c) >> MA_SHIFT & 0x3)
 
 struct mxs_function {
 	const char *name;
-- 
2.17.1

