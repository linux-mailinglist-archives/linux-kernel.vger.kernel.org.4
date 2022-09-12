Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7575B636D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiILWPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiILWOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:14:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B1B4E636
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:13:57 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 138so7152223iou.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=voPhsoaHT770bZnSxaOidypoc2wPeBFAreupfLjJEw0=;
        b=Inhtl0nBvTwwMMQkeB+30lBb3w7BnKQMzlRF90y/59z/Laj3751CdVOlt820XPfxI4
         2mOFNQEYq3gGqaMigySGpLd5UXSvrTlpfT39gFPUCsd1Cf3P6HNLBY+Xh+IcZdRGIyVf
         2BlDn7tOU4M5HrB5tqjwrAMJtfye7mR5OJTQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=voPhsoaHT770bZnSxaOidypoc2wPeBFAreupfLjJEw0=;
        b=plnPP9PiEuZ/dUMb2gD1VjDf9W6rdR6oEmLf6RqV1H28WdJkPtkIfJpzwVzfT+mPvN
         mJ8r2xChrrB+ds6ar/5G/1MBnSelvoiVOk43mllMEMI4Lwh+aRe0H8M/Nw/1B0I5Qp0O
         BBKnNgIpCk/VlFAGyRiS6+zhZBpHT5k573e9ijy8Gdrhs31qID5AiArVFOHNn+AsyNQP
         5vu9lJZ0d+auEbUnXU34uCIOpKG0x2GnGbUgl+Axa42p/zPeCpNP1DLRr8LDvKY5EBP7
         4Hrt+GRtpE7FA42wKMBPNUlKnx/lShGdDPasEn05wzihYeUs/7MkQ6zDbxsdLeI3sCCK
         KcXQ==
X-Gm-Message-State: ACgBeo11/8MtESUMWduWSwNgLV3fuzGDU2v7QW8R4038qrenHXxaHC4t
        s3HixF7QPL8ytqSxU3Ln5D2R0w==
X-Google-Smtp-Source: AA6agR5D1AVvH2kkuflK8l+Rg/N+BNYFqxo59H5yFAw8LkZQlmKDXiuh0/SYfadlNmkzxI64kSbtOw==
X-Received: by 2002:a05:6638:3802:b0:351:d8a5:6d58 with SMTP id i2-20020a056638380200b00351d8a56d58mr15378011jav.206.1663020837468;
        Mon, 12 Sep 2022 15:13:57 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:13:56 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] ACPI: PM: Take wake IRQ into consideration when entering suspend-to-idle
Date:   Mon, 12 Sep 2022 16:13:12 -0600
Message-Id: <20220912160931.v2.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220912221317.2775651-1-rrangel@chromium.org>
References: <20220912221317.2775651-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support for ACPI devices that use ExclusiveAndWake or
SharedAndWake in their _CRS GpioInt definition (instead of using _PRW),
and also provide power resources. Previously the ACPI subsystem had no
idea if the device had a wake capable interrupt armed. This resulted
in the ACPI device PM system placing the device into D3Cold, and thus
cutting power to the device. With this change we will now query the
_S0W method to figure out the appropriate wake capable D-state.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v1)

 drivers/acpi/device_pm.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 9dce1245689ca2..6bc81f525d5160 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -681,8 +681,23 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 		d_min = ret;
 		wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
 			&& adev->wakeup.sleep_state >= target_state;
-	} else {
-		wakeup = adev->wakeup.flags.valid;
+	} else if (acpi_device_can_wakeup(adev)) {
+		/* ACPI GPE from specified by _PRW. */
+		wakeup = true;
+	} else if (device_may_wakeup(dev) && dev->power.wakeirq) {
+		/*
+		 * The ACPI subsystem doesn't manage the wake bit for IRQs
+		 * defined with ExclusiveAndWake and SharedAndWake. Instead we
+		 * expect them to be managed via the PM subsystem. Drivers
+		 * should call dev_pm_set_wake_irq to register an IRQ as a wake
+		 * source.
+		 *
+		 * If a device has a wake IRQ attached we need to check the
+		 * _S0W method to get the correct wake D-state. Otherwise we
+		 * end up putting the device into D3Cold which will more than
+		 * likely disable wake functionality.
+		 */
+		wakeup = true;
 	}
 
 	/*
-- 
2.37.2.789.g6183377224-goog

