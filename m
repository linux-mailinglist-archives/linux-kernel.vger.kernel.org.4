Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6307D6023F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiJRFmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiJRFli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:41:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABB2A4857;
        Mon, 17 Oct 2022 22:41:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 70so12977103pjo.4;
        Mon, 17 Oct 2022 22:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Iq5wXewW+3MLQ47QaRSsdQhrIqjL73N0jwmptRfg2I=;
        b=JQB+eZ4i05NAahlAWprnOds04fTCwA66xi1PBCvw2NsAD8IJGCoC03i4GSFNm5yadT
         FcBha25882OHsG44R9qqRzBjDU8V6yiJphui8DvrJE2VWzWRHTH2PtAml+vDOXmI+HAH
         0BRxMcBqGj4GPM5FgMS94xP5gLNiGpGa9hYpBTAETp6KMSh0uKbODdUKLZIuCfwLwibj
         tSA9REgAVhA10Mu6VLAH3HPgmOy/r/2cQ6K7y45shGOARzDZafsWzMzxXZu7ivqD37y1
         pFfOP+H7Z6EfGIfSRE2fHOQFfL1V5LAlyELPuzSEPSHGRphzr9fABIfNGKHZZ/1a7cHc
         h0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Iq5wXewW+3MLQ47QaRSsdQhrIqjL73N0jwmptRfg2I=;
        b=RZ/B+vS+QGezZezttfQmq6K2vJsI5ZiHgEQ2kn8NJAHPBrsZL6bpAWepJHV7Ob5rq1
         8SOsjzDI6FOJxqTPoAPVipd3N+Skqp1uW8RjQXW1P8rE8MwXrWArPYKydFyzvOWkz6gs
         5Nmx8XkpWOSo0EiLDA/RoyS4VWJQKBtZFGBs5EDWUv8Mh1Ej9zooxsmGKip0ST0rNId9
         yI84ryfCXBY7VDN+41CZwAMrLegeFJ60V6POlXUcp/gsCjlVWDYuBRXkBDYx1PL4NjSv
         PPhLxfUpYQUw0bX6MJCwG7a5B/EU7fgaUR0ZnXLL+UUsR2Za2tYpwmGYe9xtddWUYkMw
         RiYw==
X-Gm-Message-State: ACrzQf0ryj+fZvEndHFLAiL9J2Ku9MCf27x4uT4rR9aAUAl+u4XkHCxe
        qGJhVqaJDeSyZnuqpXI+Jrg=
X-Google-Smtp-Source: AMsMyM5gBeGncCbF84yTFH4n1ABrlLB8WKM8Ryt93L29N3lO44OWDACsNtGrHRQRXDcKIK2MujAfpQ==
X-Received: by 2002:a17:90a:1a43:b0:20a:ea98:b962 with SMTP id 3-20020a17090a1a4300b0020aea98b962mr37411322pjl.118.1666071687002;
        Mon, 17 Oct 2022 22:41:27 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:f7bc:1bb5:e0b1:92cb])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm7597435pla.192.2022.10.17.22.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:41:26 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 06/10] gpiolib: of: add a quirk for reset line for Cirrus CS42L56 codec
Date:   Mon, 17 Oct 2022 22:41:07 -0700
Message-Id: <20221011-gpiolib-quirks-v3-6-eae9cc2ed0a1@gmail.com>
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

The controller is using non-standard "cirrus,gpio-nreset" name for its
reset gpio property, whereas gpiod API expects "<name>-gpios".
Add a quirk so that gpiod API will still work on unmodified DTSes.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index a9cedc39a245..ffdbac2eeaa6 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -418,6 +418,9 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		{ "wlf,ldo2ena", NULL,		NULL }, /* WM8994 */
 #endif
 
+#if IS_ENABLED(CONFIG_SND_SOC_CS42L56)
+		{ "reset",	"cirrus,gpio-nreset",	"cirrus,cs42l56" },
+#endif
 #if IS_ENABLED(CONFIG_SND_SOC_TLV320AIC3X)
 		{ "reset",	"gpio-reset",	"ti,tlv320aic3x" },
 		{ "reset",	"gpio-reset",	"ti,tlv320aic33" },

-- 
b4 0.11.0-dev-5166b
