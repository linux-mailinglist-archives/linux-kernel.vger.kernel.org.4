Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEBB61275B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 05:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJ3ElF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 00:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJ3Ek7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 00:40:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A143F13E9A;
        Sat, 29 Oct 2022 21:40:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q1so8096274pgl.11;
        Sat, 29 Oct 2022 21:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5DCWOE96cYEzH6EecCbh3f/7PYy8DU5D8wpQ1RpsyU=;
        b=IySmURz88rctW9YDMc+3u2/p1+WoDnyxJ3j5G9B9/SE4W8skp5pET1FkoCjfGPSQ+6
         rYcCPtHLo5Z7J5LOeFozXftT8dD2W/stvU3T2ptN8BQVxwp2C5Yu9acYLlh5qztQjoTi
         5dALitDl4y69Y+9JiI3bObMJ1mpY7jvvyqswTHD5eAX2bvqh6vhDkfVnr+XziPNSQbUV
         KwcDLPT3yK6wWDh7ZjsAbd82jVv3q5xwhaY/KCs3w+COIJh3d6kU5BfW9aeiQmzluyD0
         UPr8zJTI4ab9ZaTmkcNgRHcDJfuQtGWd71ANsYcsAiSHw7JhcZ+B0egOcE8AWS2k2HFD
         7jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5DCWOE96cYEzH6EecCbh3f/7PYy8DU5D8wpQ1RpsyU=;
        b=0b/DvNCA9JcEYj0pE0pqb8pWQC0U55iYXEpXsIOFjCxOVmDEG52O9LsYIWDtK5fajG
         X4nkpSEH/5M8AfY4jF4BJwNQluCBPZshwu25sl9zlsBWgdMRzWJwGUSLTWhSFAyKlurc
         JMqhGrbU2TUMhqh5leJCj08LLyfjrhWdzCbihbuYx+GNICCr8E9L1RNFhhhQQ22P4tCZ
         OCtGceIgvGKTBo+MTV4WyABrhYQICL24AgWsRxO0Kk7EcYamt1GzlXRqFNGw40hwUAQf
         v3wZDVHcOS9Kj93jX5AT73gf78iKZ9JPJBdgkrgXyfjjJfFy4y7Sk2Vpo668lDgf7HDX
         46Aw==
X-Gm-Message-State: ACrzQf35q3UWV6qgmGgaZ9gKbTjFBcL3OAXfhIeF6YkttzJzZk9dFA9v
        Gw5Vnqozid5YT50RyNku0X8=
X-Google-Smtp-Source: AMsMyM5aMVgHsv9YdrIf/ju6ox8TgMOBzXfRjq8N60ypxi4ZEGnx7RWPK43UjTQCeE/cP87P6k+TAQ==
X-Received: by 2002:aa7:88c9:0:b0:56b:e851:5b67 with SMTP id k9-20020aa788c9000000b0056be8515b67mr7328688pff.78.1667104852964;
        Sat, 29 Oct 2022 21:40:52 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b0018123556931sm2029632plh.204.2022.10.29.21.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 21:40:52 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] gpiolib: of: add polarity quirk for Freescale PCIe controller
Date:   Sat, 29 Oct 2022 21:40:47 -0700
Message-Id: <20221030044047.423859-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221030044047.423859-1-dmitry.torokhov@gmail.com>
References: <20221030044047.423859-1-dmitry.torokhov@gmail.com>
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

Bindings for Freescale PCIe controller use a separate property called
"reset-gpio-active-high" to control polarity of its reset line, add it
to the list of quirks in gpiolib so that gpiod API can be used in the
driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: make it actually compile

 drivers/gpio/gpiolib-of.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 331744c75faf..206100d62db5 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -208,6 +208,15 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 		{ "fsl,imx8qm-fec",  "phy-reset-gpios", "phy-reset-active-high" },
 		{ "fsl,s32v234-fec", "phy-reset-gpios", "phy-reset-active-high" },
 #endif
+#if IS_ENABLED(CONFIG_PCI_IMX6)
+		{ "fsl,imx6q-pcie",  "reset-gpio", "reset-gpio-active-high" },
+		{ "fsl,imx6sx-pcie", "reset-gpio", "reset-gpio-active-high" },
+		{ "fsl,imx6qp-pcie", "reset-gpio", "reset-gpio-active-high" },
+		{ "fsl,imx7d-pcie",  "reset-gpio", "reset-gpio-active-high" },
+		{ "fsl,imx8mq-pcie", "reset-gpio", "reset-gpio-active-high" },
+		{ "fsl,imx8mm-pcie", "reset-gpio", "reset-gpio-active-high" },
+		{ "fsl,imx8mp-pcie", "reset-gpio", "reset-gpio-active-high" },
+#endif
 
 		/*
 		 * The regulator GPIO handles are specified such that the
-- 
2.38.1.273.g43a17bfeac-goog

