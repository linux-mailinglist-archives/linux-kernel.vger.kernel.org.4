Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3105C0364
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiIUQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiIUQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:00:21 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583B51659B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:53:44 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y9so3343739ily.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uhn02vEcgNMuC4NDL/sdnIiKkA3NV83noPVamoKM5ng=;
        b=J+m/6s3OweW7a/eo9st4eaQgCj5FBjVxWu4cd0CaPO5cml8TYlNkg/w5YMuvK+r+GQ
         wzhrojO6SeTZXM/fmsxo/ctc7AJ+AoKGqVMF18GQ8VM2foK5SHjyhGHiByVZJBVAX1i1
         obzlAwJ08YXB3oRiWQZ0lmKoLJMRn+Pegtamw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uhn02vEcgNMuC4NDL/sdnIiKkA3NV83noPVamoKM5ng=;
        b=rRDj+fsNpThpN/2wfbhSCnBhZHEqf6YgEhQhuOAp1SF2f2am1fit4XaMxeZOEfpuFW
         JGlmi9+v2EUrdpJppGc0XWG1H3zog4ae4xCsAiXJh09dwVKXmCvr34eaL87YVICzC9Kd
         AiLEjqttb9uqDqAAN3n60z5UKjEUS+PK7Eo4DCmbinakqhQeBBuxpC2O/uShFHDKYe2H
         7nXPButeROJDKPevW5ryIhGSjswm7TMGKHdamx7CPvuarALdkrK/n+EKNBVTHn3R1ovy
         Dun8GveBaSdvlJkOJj4QYjzZEHnBTX2q4YuMBXcOALn8PHEMfk8iG537+9A5rmEehgxR
         h7tg==
X-Gm-Message-State: ACrzQf3ilVin0QvfRJXKFtF5KzixTDCHy6n5AcOZWN5eXkzS5aO7nwl8
        9hsBM0b27aXzO72TpPZb5zKQhA==
X-Google-Smtp-Source: AMsMyM5y+0hpMGJsf2ExwaciR2mijAedWncBixNTzl39icNIG8bLyvsSsOzqJ1lKOuRVy46al2qq4w==
X-Received: by 2002:a05:6e02:20ce:b0:2f3:4a1f:3db4 with SMTP id 14-20020a056e0220ce00b002f34a1f3db4mr12919850ilq.278.1663775545355;
        Wed, 21 Sep 2022 08:52:25 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:25 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/13] Input: raydium_ts_i2c - Don't set wake_capable and wake_irq
Date:   Wed, 21 Sep 2022 09:52:05 -0600
Message-Id: <20220921094736.v5.13.Ia0b24ab02c22125c5fd686cc25872bd26c27ac23@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220921155205.1332614-1-rrangel@chromium.org>
References: <20220921155205.1332614-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

