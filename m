Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602EA5EFA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiI2QTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiI2QT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:19:28 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E041E2750
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:24 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e205so1305979iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYYhfMYuObWAhiYmMGCnsuNWCoDnBmdqmdjnjJmMAKU=;
        b=YR9QUp+2XjkZ74L/aPGRq732j3ftJ6Jsln7tm/r/Aveg1hCJhPidZHJ/A76yEQGXz+
         bZN+UhIPBWYYIlAnJ89DxMTEACvciAizpjX2WuD3Oo1CxDs3l8DHnfhGjd2/h5PdTr0d
         6E/opjEVXLf9UA/6pIym2txnw7KIPDUWTSD/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYYhfMYuObWAhiYmMGCnsuNWCoDnBmdqmdjnjJmMAKU=;
        b=N3/Pgx22JKnhfnkM1KVw0n11orVTYWrlnYPRwWEAo3aVzrFSh91EVvQkTR5CT/1bUI
         eMeBhiNjjLmtoHvc+mQSVEu1pmeCzKCkpOhc5wq6TLdSEGCsWMRIByVMQPw/0PUJ5Aim
         y2in69IjHorjjqBGF/4KZTewb+FisHyLD9w89v5uqglgNCagz++mSe2nYuyTKlYetyZL
         R0SoLmigI0GqDg1Zcx4l5hQLoQPvkoNftTqyKV204IEYGxhhpWiVkV4tRO7v/WjNOLtO
         zfVSlQEdSfGvA2HQ2i6OoGrACh8e3X7ke1yvko4EC3g0IeZLmH1wkhZ2JlqxIU+ZWOH9
         CQ+A==
X-Gm-Message-State: ACrzQf29UuQAqf/aFt1YYUyO33ocxtvvTGzpnlf5UCzQSiq34kBaxWWG
        GlW9mhD11u2KwzCiyVP+Cxw5Hc7ej2jZtA==
X-Google-Smtp-Source: AMsMyM69kKtdTZ9M1vSL5osI4q4sy8tylM+deLWVgHOt5tmstPUWzvG59wKEt7eS7JEKCu72InRLcQ==
X-Received: by 2002:a05:6638:238a:b0:35a:25b7:a1a7 with SMTP id q10-20020a056638238a00b0035a25b7a1a7mr2350236jat.92.1664468363646;
        Thu, 29 Sep 2022 09:19:23 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a02848c000000b0035aab2f1ab1sm2965451jai.134.2022.09.29.09.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:19:23 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/13] Input: elan_i2c - Use PM subsystem to manage wake irq
Date:   Thu, 29 Sep 2022 10:19:06 -0600
Message-Id: <20220929093200.v6.2.Id022caf53d01112188308520915798f08a33cd3e@changeid>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220929161917.2348231-1-rrangel@chromium.org>
References: <20220929161917.2348231-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Elan I2C touchpad driver is currently manually managing the wake
IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
and instead relies on the PM subsystem. This is done by calling
dev_pm_set_wake_irq.

i2c_device_probe already calls dev_pm_set_wake_irq when using device
tree, and i2c_device_remove also already calls dev_pm_clear_wake_irq.
There could be some device tree systems that have incorrectly declared
`wake` capabilities, so this change will set the wake irq if one is
missing. This matches the previous behavior.

I tested this on an ACPI system where the touchpad doesn't have _PRW
defined. I verified I can still wake the system and that the wake source
was the touchpad IRQ GPIO.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v2)

Changes in v2:
- Set the wake_irq when not configured by the i2c-core. This is
  different than v1, where the wake_irq was only set for non DT systems.

 drivers/input/mouse/elan_i2c_core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index e1758d5ffe42183..3947474e93d16ab 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -33,6 +33,7 @@
 #include <linux/jiffies.h>
 #include <linux/completion.h>
 #include <linux/of.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <asm/unaligned.h>
@@ -86,8 +87,6 @@ struct elan_tp_data {
 	u16			fw_page_size;
 	u32			fw_signature_address;
 
-	bool			irq_wake;
-
 	u8			min_baseline;
 	u8			max_baseline;
 	bool			baseline_ready;
@@ -1340,6 +1339,15 @@ static int elan_probe(struct i2c_client *client,
 	if (!dev->of_node)
 		device_init_wakeup(dev, true);
 
+	/*
+	 * The wake IRQ should be declared via device tree instead of assuming
+	 * the IRQ can wake the system. This is here for legacy reasons and
+	 * will be removed once the i2c-core supports querying ACPI for wake
+	 * capabilities.
+	 */
+	if (!dev->power.wakeirq)
+		dev_pm_set_wake_irq(dev, client->irq);
+
 	return 0;
 }
 
@@ -1362,8 +1370,6 @@ static int __maybe_unused elan_suspend(struct device *dev)
 
 	if (device_may_wakeup(dev)) {
 		ret = elan_sleep(data);
-		/* Enable wake from IRQ */
-		data->irq_wake = (enable_irq_wake(client->irq) == 0);
 	} else {
 		ret = elan_set_power(data, false);
 		if (ret)
@@ -1394,9 +1400,6 @@ static int __maybe_unused elan_resume(struct device *dev)
 			dev_err(dev, "error %d enabling regulator\n", error);
 			goto err;
 		}
-	} else if (data->irq_wake) {
-		disable_irq_wake(client->irq);
-		data->irq_wake = false;
 	}
 
 	error = elan_set_power(data, true);
-- 
2.37.3.998.g577e59143f-goog

