Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB34A5BD1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiISQA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiISP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:59:41 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D1AEA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:59:27 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id l6so15020610ilk.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F4E89pQ2FrSepPnER/REAyEkKBd4VwJQnWtxeznDInw=;
        b=iFJyZLoTNe7+opOt+z3rUQwztfNt/FK4EYWkMUwYtkKWivqYMWX4oRAj8/WgM8D8hT
         XLVEJFNpUSuxDT9BKpCVUISLK8n+KtT3pbkARlzUy56+QnmMZDWCDiLULv6kZnJHcmb0
         PjpvNExYUFPOiMS/5WO5lEedVMaBChBMXBkDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F4E89pQ2FrSepPnER/REAyEkKBd4VwJQnWtxeznDInw=;
        b=Sipu9h7JXDUBnTiLOQWixqK06qC+vgJ+FbJ9JYjwWu0ne7CRbmq+im4GuoovqPznqJ
         I/neoCyePorYtfo3hGC+0tyUjMfFI+Dny96p1vPpV638jDsmHxoXfVsWN9+54y2TsIMS
         g6gIc9HXvnR43EzwpiTi+uLFmHpLRshvo5VWBm88CdOb1gFXaVEz0vNR536k8z2ttNWD
         vHcsxRc0HcTVjAbC5Cn7DMTZKOmijsNERW3h6ZC3uTrxvszppbQEKolJajTJwuSYzPql
         l9VfSAHXNsiQxUNuaGGf8nwnMckhlLbLTACWvcr5sciXfbcTJV17DLRMrsojKM1OPPsu
         He/w==
X-Gm-Message-State: ACrzQf0Z3nqq7O934/yMLmOb32Z3g6NY3p2EYRBpOesfVqj2SPD7lh0W
        KbxLUEEqYtsYhuJif8NtyV8raA==
X-Google-Smtp-Source: AMsMyM74MaxgKJOfvmWy1ebOERp87QX10dA8/v0WHA9glnbmsbgaHQWtCcDmpHn38HRQ/7/SP9seeg==
X-Received: by 2002:a05:6e02:218d:b0:2f5:45c6:fd12 with SMTP id j13-20020a056e02218d00b002f545c6fd12mr4567137ila.77.1663603167576;
        Mon, 19 Sep 2022 08:59:27 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id t70-20020a025449000000b00349fb9b1abesm5634154jaa.106.2022.09.19.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:59:27 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     timvp@google.com, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        mario.limonciello@amd.com, jingle.wu@emc.com.tw,
        mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/13] ACPI: PM: Take wake IRQ into consideration when entering suspend-to-idle
Date:   Mon, 19 Sep 2022 09:59:10 -0600
Message-Id: <20220919095504.v4.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
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
2.37.3.968.ga6b4b080e4-goog

