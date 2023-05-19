Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC12709268
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjESJCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjESJCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:02:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA6BFB
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:02:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d11974b45so1344539b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1684486960; x=1687078960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dgyhdD0Z5uIMOVTz0Ju4X2/oVNPW1i/oYYXsh7N4X4M=;
        b=OWYBiz6WlIh1V/l9X/Gdf+xPSgBsF7e7sXV6UyuHEndXrapxhmrB3TkC8R3zfq/hCB
         3z1Q1aBMLMESjZAzDRx7Fh+BF0rEqnRHgzz5uOvdWZ4uvQAK7lp95KBQdSKKsfs+YH/m
         paaxoRemHtRz+QfjeLSxWOHRgbF+QdNq7CjbMhxHIn8lIjjDCXynHoJDi58uoqzKNgFW
         tkTVDKAoA/kBReaBp0KaewU/1eYhT+5kRq0V9jQjW0VxL2hI8oqlMQFyfGHbCuB5DE3G
         q9UO7sUdKNhlxskD0bSC80KJPycUjuPk7oU92vWmsykPaF+RaTr0FMys670hQoP9Aizb
         sx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684486960; x=1687078960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgyhdD0Z5uIMOVTz0Ju4X2/oVNPW1i/oYYXsh7N4X4M=;
        b=ljtT7bYr9QMu/v5P0jRfsRB49iIYojjUtP+/LYZpn3MEIwa1EPKQIgGY4CEJnf8eW1
         j4wdEb15a350EKMt7qQmmXNbx62LZNLZ9QderUzIkRT4R1LPjT3DEqP37meDb5QJJ08d
         c169Bot/FZxNvOsHWMw+JGZm8fc23IFmt8BC/DdI5OhNaRDoBLFZ+27vE3Xbb7l6uME5
         WJugyprRQSq5PlH9ddDQ4OZbntu4zDHQ1IFYAKbaojgj9DQJnf6VnQn9e3Bf72DvDQev
         Nr/6tNMDWF5iP+FUkRXXv4EDOdHfSSc+jK7+LjJWYBSORAaONSlcjvKTBfEOf1+rGehe
         xKbQ==
X-Gm-Message-State: AC+VfDzoEKdcXPh2N7dzfRq5luqqxCDsJjvB8/i8V0YofnEvvRANHgiQ
        O7U1bYB0u3tBIKO6HEVJ8CPYWg==
X-Google-Smtp-Source: ACHHUZ7wFFt/rKk0Cxr4ucwSXRW4PIJaDmBYFThv9U1k7G56FqIDDwZ4dNN/aLv5j+zmomsAxW5B7A==
X-Received: by 2002:a05:6a00:8c7:b0:64d:1215:a0f5 with SMTP id s7-20020a056a0008c700b0064d1215a0f5mr2448868pfu.34.1684486960613;
        Fri, 19 May 2023 02:02:40 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78e18000000b00622e01989cbsm2649274pfr.176.2023.05.19.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 02:02:40 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        dianders@chromium.org, mka@chromium.org, dmitry.torokhov@gmail.com,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH] HID: i2c-hid: goodix: Add ili9882t timing
Date:   Fri, 19 May 2023 17:01:49 +0800
Message-Id: <20230519090149.4407-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ili9882t is a TDDI IC ((Touch with Display Driver)). It requires the
panel reset gpio to be high before i2c commands. Use a longer delay in
post_power_delay_ms to ensure the poweron sequence.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
index 0060e3dcd775..c5870b683a26 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
@@ -101,8 +101,14 @@ static const struct goodix_i2c_hid_timing_data goodix_gt7375p_timing_data = {
 	.post_gpio_reset_delay_ms = 180,
 };
 
+static const struct goodix_i2c_hid_timing_data ilitek_ili9882t_timing_data = {
+	.post_power_delay_ms = 200,
+	.post_gpio_reset_delay_ms = 180,
+};
+
 static const struct of_device_id goodix_i2c_hid_of_match[] = {
 	{ .compatible = "goodix,gt7375p", .data = &goodix_gt7375p_timing_data },
+	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_timing_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, goodix_i2c_hid_of_match);
-- 
2.25.1

