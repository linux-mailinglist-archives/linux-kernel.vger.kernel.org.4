Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8665B9157
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 01:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiINX7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 19:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiINX7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 19:59:12 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D756B89CD4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 16:58:22 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i7so4664139ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rcvDP2WJ+fQZJ5qsY5Dl3GZhszdSslMkj/qO46b14mU=;
        b=kDCQFccX2w7tlX6d2bXrWMrcaaS35CZD/Vo0cp8z8vLHUxNox+MW9MuYtm0sNXoyMy
         bqHFfJsYkqcfgCkg5RQOj0p6TD9nX4rjmahMnQJdT1WPBFPjCIBI5vL1/QoluEsfwB2y
         s7ejhz0ldATLHLOq141U+zdmMdaUc3g9XeRNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rcvDP2WJ+fQZJ5qsY5Dl3GZhszdSslMkj/qO46b14mU=;
        b=bI4cO4gM0F6YWJDf/4IN53aaehI0ElEKI9NidZcWyrOz8l+n26VF4FMqqdcS9U1cNB
         Hc17DTiWmZKQINWJuDlniU3I4p1j/BbhpyYo5Uiqqo6T3/MCY51IERtJl7dCVN6QhQ26
         oxg5Nw7EuB+CHAWRHcpxdGDZRGS+nyGy6OPqJwg78ZXWtpLvXr6p3iIwCRiCOjg95K+7
         WfWD0PbBc1ykf469XnNuwnIK/BuAVSnEoAfMwCM5y003iQ2qxJvgf799/HBZMnYx8+UC
         R/KXxylU9HQRTyOKDFYcBMF9s3t+TbCqTVMe8S/d+NKJY07eyghC0x5/dmmTLgiUFSp+
         TZ1Q==
X-Gm-Message-State: ACgBeo3LnCw54KVWgiM4LWRJgs3zXkaAiyBM+wNSTc1NYawfGO1+YfYZ
        0XLtthRws7Pdd21lZf/Wk9U1KQ==
X-Google-Smtp-Source: AA6agR7RCrayZe6uYU6txqlWKyIA7Yzw/43TVXUadSMJuymKB6iwV3TNib0B3yWzAVCT8sb/tC8agQ==
X-Received: by 2002:a05:6638:1492:b0:35a:5484:b8db with SMTP id j18-20020a056638149200b0035a5484b8dbmr5460661jak.236.1663199901611;
        Wed, 14 Sep 2022 16:58:21 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0034c0e8829c0sm353721jac.0.2022.09.14.16.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:58:20 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     jingle.wu@emc.com.tw, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Raul E Rangel <rrangel@chromium.org>,
        Alistair Francis <alistair@alistair23.me>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/13] HID: i2c-hid: acpi: Stop setting wakeup_capable
Date:   Wed, 14 Sep 2022 17:57:57 -0600
Message-Id: <20220914155914.v3.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
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

This is now handled by the i2c-core driver.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v1)

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

