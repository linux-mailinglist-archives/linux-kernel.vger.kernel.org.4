Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A605B9161
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIOAAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiINX7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 19:59:19 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AC38A1DC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 16:58:28 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b17so8870164ilh.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uhn02vEcgNMuC4NDL/sdnIiKkA3NV83noPVamoKM5ng=;
        b=CUY+j8lfqODpV6DVbuXvgKk/Ghv9VtblK0owray+MH9wC6UJNBrLrCh9A9Yyywkhlm
         yaAi8kGepOFd43VgdkMBlZDFmoErxsdPdjxgvgTbmzPE0a6muHa33Z5uQhjAExy6SiiR
         XUFcUXayPecAeAVe07X1tc+re030iwcVilHCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uhn02vEcgNMuC4NDL/sdnIiKkA3NV83noPVamoKM5ng=;
        b=ihQUp7h2nm0JDc7EYo46tZJKcTkMIKESusbOWxKNQgq8UYvFDSdv9iGc2xizCQtWWV
         U3uF1sLg3KRSVxPKiBydPkOLGKz1NZYS6mvJ49OcqvfwWnxtUUPVOBOq2JorZQDjGT2l
         ByDrzQgNxFd3Kk+RFVu2krCkhCg9OITMsXt1XvD1zEfxJEJCDxGpHYgNWa9O5zxZaDte
         6rv52NUT1vmYBZ/kIgY3nw6q3oVyuxR/8fIuce0muoAGvZ7hZee0Rd1Z4FlcbL5G/eXo
         sRFhMklan2jpDUBFChFqZldpOTobJ/LGoZ0w1SGMUjPj7dj1FHc/jfseWkFGopuk0/v/
         RwGg==
X-Gm-Message-State: ACgBeo0nL6/9l6LjBSFHlePasIfbyW+a448GQTkn0/Aqtx3T2Op04KoC
        IAeIChb4r0P2/sXwsjqRAeL+Gw==
X-Google-Smtp-Source: AA6agR6hBuemwCwJosU43o/dcXHSnguus+BYHG6PYVnm3q74Ihk+SI6tjIeZ7CFKssUKKX5eQ2TTgw==
X-Received: by 2002:a05:6e02:16cc:b0:2f1:b896:efbf with SMTP id 12-20020a056e0216cc00b002f1b896efbfmr15983168ilx.102.1663199907391;
        Wed, 14 Sep 2022 16:58:27 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0034c0e8829c0sm353721jac.0.2022.09.14.16.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:58:26 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     jingle.wu@emc.com.tw, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/13] Input: raydium_ts_i2c - Don't set wake_capable and wake_irq
Date:   Wed, 14 Sep 2022 17:58:01 -0600
Message-Id: <20220914155914.v3.13.Ia0b24ab02c22125c5fd686cc25872bd26c27ac23@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220914235801.1731478-1-rrangel@chromium.org>
References: <20220914235801.1731478-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-core will now handle setting the wake_irq and wake capability
for DT and ACPI systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v1)

 drivers/input/touchscreen/raydium_i2c_ts.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 66c5b577b791d4..88d187dc5d325f 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -1185,15 +1185,6 @@ static int raydium_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	/*
-	 * The wake IRQ should be declared via device tree instead of assuming
-	 * the IRQ can wake the system. This is here for legacy reasons and
-	 * will be removed once the i2c-core supports querying ACPI for wake
-	 * capabilities.
-	 */
-	if (!client->dev.power.wakeirq)
-		dev_pm_set_wake_irq(&client->dev, client->irq);
-
 	error = devm_device_add_group(&client->dev,
 				   &raydium_i2c_attribute_group);
 	if (error) {
-- 
2.37.3.968.ga6b4b080e4-goog

