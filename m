Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272175BD1A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiISQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiISP7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:59:35 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409BBA0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:59:33 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g6so2607693ild.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uhn02vEcgNMuC4NDL/sdnIiKkA3NV83noPVamoKM5ng=;
        b=GK6NZXg+SRbg6dlYceBGo3Bdp/8+QXAkMNPp1hBOtDl13ijRJBL7lt2nm1VXjoA8lk
         c5k+LXWC8GocTjRZSQITTdz9QWBggrsAHr2rlB96VnjYnfOt4sU0EiPRaHKElgg9/K0I
         jJPJ+xXtUkAMDOO8330oC5RE43uPJHbfzxouE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uhn02vEcgNMuC4NDL/sdnIiKkA3NV83noPVamoKM5ng=;
        b=zM0kstqaxwr3q2hyMVy9YLqHeNxsvTX6npfneUpFYS11XL32cPjBj73rqxAlpWNpdr
         9hoIhjEcFrYo9KBl6EB1FvJg1mSa+B79sxZ7WFem8eCiUeb8eBaYhXV/bZfDT9/9P3On
         34LlQmFTiFmIyVuPtg8qkZ06Z6e6eHxdaJ+DtGES9uRe34d84R6cgFcQPTY9WEcX+3h/
         p0IAzdGgEZf/mO4pa17eJHCuOsDeIT1i0vIOqV31xIKg56fmre8ZoAJ/mO9u+hM5aH8t
         63jfpbcZLJoCZDMWs2RYeK1yJpYP+GznZiK/FpWmDkRyZgGMm317mcR+n0TRKOrgWMFO
         R3Cw==
X-Gm-Message-State: ACrzQf0kel0Aoq07WNyxl4y00tghnHXTXjQo+j7yc3bxNICzd+v2GAv/
        mQLqVdBgPwTbSikdx3ygDK6oQg==
X-Google-Smtp-Source: AMsMyM5ls8r56kVd8P5UbNod0oeDjqkEjXi/yi/ji3Sa3JWilEMSvxaR2aRHwjrDZtRA8WmAXXqiYw==
X-Received: by 2002:a05:6e02:f03:b0:2eb:7a76:f9b8 with SMTP id x3-20020a056e020f0300b002eb7a76f9b8mr7612007ilj.41.1663603172286;
        Mon, 19 Sep 2022 08:59:32 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id t70-20020a025449000000b00349fb9b1abesm5634154jaa.106.2022.09.19.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:59:32 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     timvp@google.com, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        mario.limonciello@amd.com, jingle.wu@emc.com.tw,
        mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/13] Input: raydium_ts_i2c - Don't set wake_capable and wake_irq
Date:   Mon, 19 Sep 2022 09:59:15 -0600
Message-Id: <20220919095504.v4.13.Ia0b24ab02c22125c5fd686cc25872bd26c27ac23@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220919155916.1044219-1-rrangel@chromium.org>
References: <20220919155916.1044219-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

