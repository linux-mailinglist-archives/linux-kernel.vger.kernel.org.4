Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A5C5C0358
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiIUQCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiIUQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:00:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E924BD2B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:53:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y141so5385693iof.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RxwwHMPvk5ayq6Q0eWnQYvYby/RH2VOKKKhXm3+laCU=;
        b=LJOfJcIhk0yQdlJbSJLsffLY9QE0ItNjkIbsxhkWVifYPBdvXTclI2ynnNkd0fsMj1
         ero0vR/f3i0Kvoy1WG9JCgsgqeSn3mr5T14kzHOeNKthpAVOGCDgY4rXZe5illCWXn3m
         CB+4PnJjrTitKBtcfISGYikqVVlrnjgpi9dTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RxwwHMPvk5ayq6Q0eWnQYvYby/RH2VOKKKhXm3+laCU=;
        b=3kIbSkgXno/eVLAocSeNuMhSG8OdKLFm42kjpmUOtb4iDiyBp95khhDAUI6hjvr/vi
         Vg0aba8P1YvTOwpm8jaK95BWnzUalVnkf6lMdoSgH0ebvrijOes9noSWJ4Bxde8QgaIN
         sjHtY47mQFKguwsgmX3pjYC/dtYzrpCYlWetF2CqNq2c0GzhJV5sg+jcRsKi+4+niAtW
         piK6wxKtT9MDENtoe1mhC20eTT4WU525Kn8uCLfvK9DpdsVklrQ3Y4o1yIsnqgRtWeko
         ezJWQeGwQzZtIOoC88Bwp8wX1Xo9RVBnc5DoGUxrbJfR4BsyiQqGGQDdPU2qGzWkc3c2
         6PoQ==
X-Gm-Message-State: ACrzQf12dkIt1DSCJ3meyla5oIqknKCPIt3mt5KBgM/s9IIshjg9ZYzw
        6CJ6FaO76kWTbsKJ1c9BRuz1eg==
X-Google-Smtp-Source: AMsMyM4HNU9p1Dc70gExDsuZAIHaSFxoo7r6SNYVPn+iImB9Fs6jDcQEM5mRn+8XnBttrvjUafvlBQ==
X-Received: by 2002:a05:6602:1352:b0:69d:e793:abd with SMTP id i18-20020a056602135200b0069de7930abdmr12256877iov.172.1663775538996;
        Wed, 21 Sep 2022 08:52:18 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:18 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/13] ACPI: PM: Take wake IRQ into consideration when entering suspend-to-idle
Date:   Wed, 21 Sep 2022 09:52:00 -0600
Message-Id: <20220921094736.v5.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220921155205.1332614-1-rrangel@chromium.org>
References: <20220921155205.1332614-1-rrangel@chromium.org>
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

This change adds support for ACPI devices that use ExclusiveAndWake or
SharedAndWake in their _CRS GpioInt definition (instead of using _PRW),
and also provide power resources. Previously the ACPI subsystem had no
idea if the device had a wake capable interrupt armed. This resulted
in the ACPI device PM system placing the device into D3Cold, and thus
cutting power to the device. With this change we will now query the
_S0W method to figure out the appropriate wake capable D-state.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

Changes in v5:
- Go back to using adev->wakeup.flags.valid to keep the diff cleaner
- Fix a typo in comment

 drivers/acpi/device_pm.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 9dce1245689ca2..3111fc426e04fd 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -681,8 +681,23 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 		d_min = ret;
 		wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
 			&& adev->wakeup.sleep_state >= target_state;
-	} else {
-		wakeup = adev->wakeup.flags.valid;
+	} else if (adev->wakeup.flags.valid) {
+		/* ACPI GPE specified in _PRW. */
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
2.37.3.968.ga6b4b080e4-goog

