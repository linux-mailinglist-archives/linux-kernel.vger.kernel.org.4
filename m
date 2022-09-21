Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086FB5C0357
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiIUQCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiIUP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:59:58 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607C0A1D62
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:53:27 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g8so5439142iob.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BLdt6ZhvGr0RaD7VzP2mPYzzyAyFxpk+jb6URS+dUyM=;
        b=NW0DxOZCIOhi7D7pIYBZmi1MjcIGOGN5aKSPvNUUuHsu91/a4vEXXoU9yoKtVcVFy1
         KdBLpQG6bfggGEj+YyGfdWIl7h49HmUDstUFnDxLcYrTNuZABzYm54SCfyQ65BqaDLVZ
         NEk5ON3+abjpYKgiOp6c76ILaDUJNeCAz8ecg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BLdt6ZhvGr0RaD7VzP2mPYzzyAyFxpk+jb6URS+dUyM=;
        b=CHeChonFQsXj95gkRUciZ9LCBTTdFrYmkzyetZBoMRaCuqW6tXjOMbTZJ9DNMRqGoA
         h6bubdoOgfbGrZanFOf+2CxOrqy+ufEwV5AH7tdEI7Lw85angFM8hlCvQBzHU1EWxNmN
         EEPvHfC0JxlyAiiQthnaDg3qKy56zt4xz5kCpI2uL1UEDwm2qJ7GDT69DUhR1IRnFQW7
         NxJkVlefF/iCQKM7qC0MCjAJB1lI7q+J7Dguha1pF737fvPpoXCah9+WPFSd3eQENZ1+
         ulpoaBjZuwoulTRnpfvD3ENpGsRq2kZeiRmgymH+rDk8wGqh2YuV9J2Jvre1xkIkxjRn
         khCw==
X-Gm-Message-State: ACrzQf1UYvANscugiOkE/EeZ4AnlitmhG07EWkyzMdhzjUVzwBmThLyo
        VjK7JNYvrRgsXTmzakbUurHwIQ==
X-Google-Smtp-Source: AMsMyM7Imln63wm+6aXB+OaGfTzsZGZphFcReZdUZOOOW5iAvoeaP8vqNuJMBYexE48ezn3l+879nw==
X-Received: by 2002:a05:6638:3a1a:b0:35a:26bc:8856 with SMTP id cn26-20020a0566383a1a00b0035a26bc8856mr13100319jab.47.1663775540394;
        Wed, 21 Sep 2022 08:52:20 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:20 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/13] HID: i2c-hid: acpi: Stop setting wakeup_capable
Date:   Wed, 21 Sep 2022 09:52:01 -0600
Message-Id: <20220921094736.v5.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
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

This is now handled by the i2c-core driver.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Changes in v5:
- Added Acked-by: Benjamin Tissoires

 drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index b96ae15e0ad917..375c77c3db74d9 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -105,11 +105,6 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
 
 	acpi_device_fix_up_power(adev);
 
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
-		device_set_wakeup_capable(dev, true);
-		device_set_wakeup_enable(dev, false);
-	}
-
 	return i2c_hid_core_probe(client, &ihid_acpi->ops,
 				  hid_descriptor_address, 0);
 }
-- 
2.37.3.968.ga6b4b080e4-goog

