Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4EB5EFA40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiI2QVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbiI2QTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:19:42 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AD42655
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:34 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b23so1302755iof.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iThYjZd1ViNBfkkSkGo3l96iqlm3APk4Vux0ZrfYlgo=;
        b=E3IOPc/UPROW7BFpAFuU5Db/HYddtpiIdOykPLTUF/vLxG8l4cl8SUVGPGjEM5LVM4
         /H+dvbAtK+UpBwZQh3uQgfbqEEkKpwHNeN/e/mJQaCzGGEw/zWT7Pmjy7VtI2op1Urrr
         kzOjLE//7EHr8ITY+/+ixrsJgHuVg7bRUje2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iThYjZd1ViNBfkkSkGo3l96iqlm3APk4Vux0ZrfYlgo=;
        b=Z2ZLaqa3zLHFD+kb5GGxsybzYacxbtsYj+lmiQgV6THtocrLzG2Lp9HgbQufRCBxIK
         63P8Cj5mR4mpzKAREZ3tw61hvod1y7TS8NPJdcKkaHA6LrlSTHWjZPOMZ/P4nEf+rkYh
         7e1/OnaeXya6RaLbuCwECkhz6btratiPkOwcNyjTNSVTJjJOK1qIZnJeCXW5f+9CRs+Q
         IzuvwQ5qpDr1OYRCbF8QsuGPEAkoIJ8bQuvUAbaQJsqJBMgQD+EP9LHR/RBUJlGqpQfw
         oDZ4l179fVlotA2ET2kN2Ss/vDHcf4XQHf2XFoqNOZXhcwtjtS4S/uc75hw5j1+sZDlq
         iEeg==
X-Gm-Message-State: ACrzQf0M9IQlxYqMbQE07uCQpjOak9PezcNqoijT8lQE1+JqcCBqOOdL
        w2Kcz1N0uk89Ar8wO6lMgiq7qg==
X-Google-Smtp-Source: AMsMyM5VT4z8ZpZ/XHcO/fVXipxSwbfAltCjh8RrdQ6VkDlp3cjJFmSiYJ7hTyk5FlPtoujoiF1oHQ==
X-Received: by 2002:a05:6638:40ab:b0:35a:52aa:3ceb with SMTP id m43-20020a05663840ab00b0035a52aa3cebmr2305857jam.130.1664468374095;
        Thu, 29 Sep 2022 09:19:34 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a02848c000000b0035aab2f1ab1sm2965451jai.134.2022.09.29.09.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:19:33 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/13] Input: elan_i2c - Don't set wake_capable and wake_irq
Date:   Thu, 29 Sep 2022 10:19:15 -0600
Message-Id: <20220929093200.v6.11.I7309b8f322082437b93581c6e2953886eeb998d7@changeid>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220929161917.2348231-1-rrangel@chromium.org>
References: <20220929161917.2348231-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

(no changes since v2)

Changes in v2:
- I chose not to keep the legacy code around since systems without DT or ACPI should be rare.

 drivers/input/mouse/elan_i2c_core.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 3947474e93d16ab..b25b94aba3e88e5 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1332,22 +1332,6 @@ static int elan_probe(struct i2c_client *client,
 		}
 	}
 
-	/*
-	 * Systems using device tree should set up wakeup via DTS,
-	 * the rest will configure device as wakeup source by default.
-	 */
-	if (!dev->of_node)
-		device_init_wakeup(dev, true);
-
-	/*
-	 * The wake IRQ should be declared via device tree instead of assuming
-	 * the IRQ can wake the system. This is here for legacy reasons and
-	 * will be removed once the i2c-core supports querying ACPI for wake
-	 * capabilities.
-	 */
-	if (!dev->power.wakeirq)
-		dev_pm_set_wake_irq(dev, client->irq);
-
 	return 0;
 }
 
-- 
2.37.3.998.g577e59143f-goog

