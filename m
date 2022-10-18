Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD66023E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJRFlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJRFlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:41:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825769DFBA;
        Mon, 17 Oct 2022 22:41:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c24so12849533plo.3;
        Mon, 17 Oct 2022 22:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTn1dphwNOkdUyNvDetLqqezFlO3LTymy8eZ70ptOU4=;
        b=lz0HD8RW5uepcDP4ExPxobkGeybyVM1a/aLHa5C8LHvYddXJ4DPGBq5N3gTF0xUkdT
         5r+Y/MijFhpqdp9ZYE5yZJGylo3K+DSYD69+IuGZnJni/FEyqZe9sO79SZmNUCSPO1L7
         VXglj6d4U3yuIqtRjTnzn/KYrpjkL4fG6yRwUN3mbojj3elf0Wtr/vELfeGOYgbAF+3B
         nKDRrddxLyXbKnN92Cw09Z8lDqxi4s5Kxmi48bGQWeWrqsTpB7m/iFg8qRjp2gbiaVSd
         lsdjBpgKqsmTW51CbYyK2OOZi888FUKFR9KT4555diSCxYJPobkBmP4kY4mlJWaOKXtr
         lpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTn1dphwNOkdUyNvDetLqqezFlO3LTymy8eZ70ptOU4=;
        b=bL8P92BPaem95UHz+/iLBsRLc54wTozKU2SWw7d5n5Sad1bttG/8Yz/l0F0v5D7c5W
         tFdV0bhw+E7gPxEZx4S26GvFJy21It/PmLLPP3Tm8umWPDRF5k3paXeMqwUvtabwCa7i
         rTZL1NKvs9KIkeEfhlDLpuNr94XXNLy305TkNh0bvdpeazHO08uB5BTM4emsTbPPyY60
         TfDKeQcVzEF+m75JufesPEic+KEVUp5Utf5Ji0Tpvbp9E5/BApOkHMEUk5FE0n6omRUi
         wGHyIWz9+p7T1S1qgSb/LGhmXjEWcPHarS96x3kc0R3YK/i0bvjL7Wy7atFZuKuCXHFT
         QS/g==
X-Gm-Message-State: ACrzQf3JyZA5I9k1QLjnO8ywsSe2dUHH1P76R5MB95X1ibxzM0rzmSO/
        uRusPuhBrk0woGlIIYflJtAeHQjm09niHQ==
X-Google-Smtp-Source: AMsMyM5rs1kB4rFeIfAfMs/wl4emcwgpOJcxfI8D4+foneG1Oqh62ltVnNeCS1hPaOOZKRp3wXqlkA==
X-Received: by 2002:a17:90b:48c9:b0:20a:e225:1afd with SMTP id li9-20020a17090b48c900b0020ae2251afdmr36387992pjb.21.1666071677837;
        Mon, 17 Oct 2022 22:41:17 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:f7bc:1bb5:e0b1:92cb])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm7597435pla.192.2022.10.17.22.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:41:17 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 01/10] gpiolib: of: add a quirk for legacy names in Mediatek mt2701-cs42448
Date:   Mon, 17 Oct 2022 22:41:02 -0700
Message-Id: <20221011-gpiolib-quirks-v3-1-eae9cc2ed0a1@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
References: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
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

The driver is using non-standard "i2s1-in-sel-gpio1" and
"i2s1-in-sel-gpio2" names to describe its gpios. In preparation to
converting to the standard naming (i2s1-in-sel-gpios) and switching the
driver to gpiod API add a quirk to gpiolib to keep compatibility with
existing DTSes.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 0e4e1291604d..cef4f6634125 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -488,6 +488,38 @@ static struct gpio_desc *of_find_usb_gpio(struct device_node *np,
 	return of_get_named_gpiod_flags(np, con_id, idx, of_flags);
 }
 
+static struct gpio_desc *of_find_mt2701_gpio(struct device_node *np,
+					     const char *con_id,
+					     unsigned int idx,
+					     enum of_gpio_flags *of_flags)
+{
+	struct gpio_desc *desc;
+	const char *legacy_id;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_MT2701_CS42448))
+		return ERR_PTR(-ENOENT);
+
+	if (!of_device_is_compatible(np, "mediatek,mt2701-cs42448-machine"))
+		return ERR_PTR(-ENOENT);
+
+	if (!con_id || strcmp(con_id, "i2s1-in-sel"))
+		return ERR_PTR(-ENOENT);
+
+	if (idx == 0)
+		legacy_id = "i2s1-in-sel-gpio1";
+	else if (idx == 1)
+		legacy_id = "i2s1-in-sel-gpio2";
+	else
+		return ERR_PTR(-ENOENT);
+
+	desc = of_get_named_gpiod_flags(np, legacy_id, 0, of_flags);
+	if (!gpiod_not_found(desc))
+		pr_info("%s is using legacy gpio name '%s' instead of '%s-gpios'\n",
+			of_node_full_name(np), legacy_id, con_id);
+
+	return desc;
+}
+
 typedef struct gpio_desc *(*of_find_gpio_quirk)(struct device_node *np,
 						const char *con_id,
 						unsigned int idx,
@@ -498,6 +530,7 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
 	of_find_regulator_gpio,
 	of_find_arizona_gpio,
 	of_find_usb_gpio,
+	of_find_mt2701_gpio,
 	NULL
 };
 

-- 
b4 0.11.0-dev-5166b
