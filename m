Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0847560280A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiJRJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJRJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:13:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E9272FC6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:13:20 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA09C3F5F1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666084398;
        bh=Hh8fsE9KkAVKP7Lv5PdzMeHsN9pjYg33humb2afrU8o=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=aDqCQd+FewwtieF1tSynz0H4EEaGHP3TwjG83GTfFE5yRZXZVVQPRMWFSqYlmrBwn
         mkdAPLeRbieFvpgGvz6QOOVO/6IE7/9kX0AZvLSdtbaaphpXvE7utxQ9bBsmVIKVNG
         Jj3w+BaeMhUVDzfr8bJH/qCr7VrBnQTm32c7fuF3wbFI/70+i5WzF8O04DgIu5I/MF
         MwNiQLOK5tjQmpqU1Y13an4KUnVwNaCYr4n+F637HyPP2jcn+ahx/RJAepXi7/AsTv
         xZVNUQ2kS1vXhYdM06yraHwySelv/fZJoG9NHb7uE7+WhMejLZJUGe5aCZmBrBrsNd
         Vyncmzq0mq7QQ==
Received: by mail-ed1-f72.google.com with SMTP id h9-20020a05640250c900b0045cfb639f56so10490198edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hh8fsE9KkAVKP7Lv5PdzMeHsN9pjYg33humb2afrU8o=;
        b=WqqSkPo8CuPospzt9eMTExpjZB9m4uNwaHr9RrdrcCcEWKrnQ6oB1MPUnZYDVp2qpa
         LQns4e3HWnvOUxeDHI3FVY+Og0o5tJnd2H6bFDu1G73MQ7ff8ZpvPRDPJ5Xy3nolHKMZ
         9RrlsaAXBzMazOU2UOLeiacPtr3c8LisoXUiRfZGSfp6t4aiNiW8SWsvdp47SfwWYqYt
         6IcmoDf9m7sS4q2Dy++Ye2va2HF0YYT83yzb8EiVU8HlT6tYD6cDft+WPO6pkxL9aROV
         ixMPyTkg5xyBr4g8Gnfg73JVbkQlGZ0CbKmd7WAXPis7x7tPE9WH8FC7FkyHWzJP3Q/c
         TxTQ==
X-Gm-Message-State: ACrzQf0NjzEsWn51J4aRsifNBpD+Mrh8dDNOE4IJjJ5e8UMYjEe+n/2T
        mlqRaS2OqepJh6ebErW8MFg8kHJPCBpwZEYpOqTq8OO6K6cKPKFqutfyo0tHXqLgPCvXkIFHQlJ
        RI8QD1xN5BtRE8oo/bhJCn1ADVxpJJv0op50QRKv8KA==
X-Received: by 2002:a05:6402:548f:b0:457:ed40:5f58 with SMTP id fg15-20020a056402548f00b00457ed405f58mr1673590edb.408.1666084398207;
        Tue, 18 Oct 2022 02:13:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6RtBiVWqlow4RIWQd6Iya71pSIgsGy2YuI+R6Q4lXOuU1BXFxCyytUUPbyjbx6D0cVL2MX/w==
X-Received: by 2002:a05:6402:548f:b0:457:ed40:5f58 with SMTP id fg15-20020a056402548f00b00457ed405f58mr1673583edb.408.1666084397997;
        Tue, 18 Oct 2022 02:13:17 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id x9-20020a170906710900b0073a20469f31sm7270172ejj.41.2022.10.18.02.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:13:17 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>
Cc:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] pwm: sifive: Always let the first pwm_apply_state succeed
Date:   Tue, 18 Oct 2022 11:13:16 +0200
Message-Id: <20221018091316.415685-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2cfe9bbec56ea579135cdd92409fff371841904f added support for the
RGB and green PWM controlled LEDs on the HiFive Unmatched board
managed by the leds-pwm-multicolor and leds-pwm drivers respectively.
All three colours of the RGB LED and the green LED run from different
lines of the same PWM, but with the same period so this works fine when
the LED drivers are loaded one after the other.

Unfortunately it does expose a race in the PWM driver when both LED
drivers are loaded at roughly the same time. Here is an example:

  |          Thread A           |          Thread B           |
  |  led_pwm_mc_probe           |  led_pwm_probe              |
  |    devm_fwnode_pwm_get      |                             |
  |      pwm_sifive_request     |                             |
  |        ddata->user_count++  |                             |
  |                             |    devm_fwnode_pwm_get      |
  |                             |      pwm_sifive_request     |
  |                             |        ddata->user_count++  |
  |         ...                 |          ...                |
  |    pwm_state_apply          |    pwm_state_apply          |
  |      pwm_sifive_apply       |      pwm_sifive_apply       |

Now both calls to pwm_sifive_apply will see that ddata->approx_period,
initially 0, is different from the requested period and the clock needs
to be updated. But since ddata->user_count >= 2 both calls will fail
with -EBUSY, which will then cause both LED drivers to fail to probe.

Fix it by letting the first call to pwm_sifive_apply update the clock
even when ddata->user_count != 1.

Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 2d4fa5e5fdd4..ccdf92045f34 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -159,7 +159,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
-		if (ddata->user_count != 1) {
+		if (ddata->user_count != 1 && ddata->approx_period) {
 			mutex_unlock(&ddata->lock);
 			return -EBUSY;
 		}
-- 
2.37.2

