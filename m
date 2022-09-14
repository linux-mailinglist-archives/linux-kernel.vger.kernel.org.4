Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83FF5B9160
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiINX77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 19:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiINX7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 19:59:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6489CE6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 16:58:24 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q83so11598424iod.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Tzm/qE0nIcj5tRamCrRt6njHA6IRj7QMwAd5TFMNttM=;
        b=f+uY/ykQ2N1q+rdYu8jKDpUxlM3M+rtbNbs4D9RuWOKew6gZaVJ3lWicXvGpa/XlQv
         4P26C3WsM5OzkXp4sYO+Io0NP/b7YfZKRCmnVeyvsTKawrGXyE98bMF/UH8ZNBNV0iYs
         M+81ec/KLITJHp2ZZzavFjJV/x50IaUXJvyps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Tzm/qE0nIcj5tRamCrRt6njHA6IRj7QMwAd5TFMNttM=;
        b=OtkySyv39Eb/j/I40ADyWZ8iaz80Os/XBVd3HdzKXCrJ55QmmIUkka4k1gULHtSeoq
         A/RxBHJi6aZ2S84g/KWk/nAfUa2p2wNwffa9u7xPts2Wt2zdIGovAw83NgXFel8IHxmt
         EM7/CbDAJKdKabbZ/lXUJCm8AdiuPRWDvm86U20EvAatH6Tp4dYtChMd8bbFLsDK9H6j
         F6QzhAswbs3nxv4AJpVuVxxWJ29D0CwlBVEyPh21/vGWHC3fS3OSQQ0uxMUFNBCYYEDb
         Bl1Nc053jp8jlu7Y3W5o41FTqe/F6vmEG0kPoBDp8TMqfPIRVhbzvr0cJ4EIAf9MeDDb
         aFGQ==
X-Gm-Message-State: ACgBeo1bH5rwIr8KaJmdEJ26bo7+WjX7mVQywWVigXg9VPXgIyEoubOe
        1AifYFtoXGQNEUzyEO3FDur51A==
X-Google-Smtp-Source: AA6agR6aE4wqc9ke7SPbqL8w3vmm6itl3pgxCmCedNuAqe/EnMEiQCxXSA0p93LMJLkGd0PZ8MoQ0A==
X-Received: by 2002:a05:6638:3470:b0:35a:1b16:f140 with SMTP id q48-20020a056638347000b0035a1b16f140mr10963554jav.150.1663199903108;
        Wed, 14 Sep 2022 16:58:23 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0034c0e8829c0sm353721jac.0.2022.09.14.16.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:58:22 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     jingle.wu@emc.com.tw, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Raul E Rangel <rrangel@chromium.org>,
        Alistair Francis <alistair@alistair23.me>,
        Angela Czubak <acz@semihalf.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/13] HID: i2c-hid: Don't set wake_capable and wake_irq
Date:   Wed, 14 Sep 2022 17:57:58 -0600
Message-Id: <20220914155914.v3.10.Id22d056440953134d8e8fe2c2aff79c79bc78424@changeid>
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

The i2c-core will now handle setting the wake_irq for DT and ACPI
systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v1)

 drivers/hid/i2c-hid/i2c-hid-core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index a2fa40dec04ea5..65b7a95956866d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1036,15 +1036,6 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	if (ret < 0)
 		goto err_powered;
 
-	/*
-	 * The wake IRQ should be declared via device tree instead of assuming
-	 * the IRQ can wake the system. This is here for legacy reasons and
-	 * will be removed once the i2c-core supports querying ACPI for wake
-	 * capabilities.
-	 */
-	if (!client->dev.power.wakeirq)
-		dev_pm_set_wake_irq(&client->dev, client->irq);
-
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);
-- 
2.37.3.968.ga6b4b080e4-goog

