Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CAB6DA34C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbjDFUfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbjDFUel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:34:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DEDCA08
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j22so4228480ejv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyU4R7+rVxuTRbNla/dZpdNR+174rHG6NC4kuQr/+W4=;
        b=ZyrN+KeV4TLYQjcjz4bAGx6FzuzFIaHoyBJ5Q+EncEHnlNTdRX/2/NLxQnpRbIE5PT
         cDRXu63gYGKnCgiY/+fnjRbbfcJkLjU7J++SdbVaYF16jIHuufsGSww3oXT48GPvvCK0
         ejWy2bvrxJbVbkpOEmIcXBq9hcBM4TXyqYaFMFMd3jn9kOIrItEvSCSmwzn4J23gnxNk
         mFue/Ou4BfYZ+WhEV7A2nwxOuBJjYH34fxSLVVTDGCdxLgtpfR/EvIXNy/iITrRB/WIl
         qsihOJlw1tqaSVWLyacyyMg4f1GOJ8q0VJo6dAk9UUpZXTInEgb98q0RTNJTJgNUdXSe
         x3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyU4R7+rVxuTRbNla/dZpdNR+174rHG6NC4kuQr/+W4=;
        b=ESkvkXZlHuG4Dyr5reGO7XA/mAW85nJ9C2mXQZiLXuSPBECTscP/sBUTPDXhBbJ9/C
         W4r5e06qukV53U0IhPb8o+WzAhoj97ismJy3X0df5qEXXTg+o381YfS6il5YpR3W9ByY
         7b9Lcvrdw96mkiAK4mKHEfZGIupmRgZl9wAKYr4lms7/Od2Ww9LyL0kK31EuiLgJXc+I
         recZ8hNjAljmvYZHW/nad4qfgOKRWcXQMuirrKT92j7JRrWZgPkldxEITwgE+EyQyZOx
         FB9wrhWVcAi4avDzKu0u6EDrD5CWpKjk6HVMY1BK+6C2yBPfjBK1T0BXMdvmY7wZrsAb
         ojnw==
X-Gm-Message-State: AAQBX9fUeTv18H+fxFqMFx0dZGEstA5wLR3MblrO5TSGZkjAcd9yh+9U
        GSMjD9Q+Z/xxRT8jBPAU4fktwA==
X-Google-Smtp-Source: AKy350bii7iEoKCPegCaCQ0FeAKw4HkZrsyHUjyITLNrI94PP6vX0m3OcrNQyQTeoBcZRZQaL0ysFw==
X-Received: by 2002:a17:906:399b:b0:932:a056:e77f with SMTP id h27-20020a170906399b00b00932a056e77fmr97415eje.60.1680813164450;
        Thu, 06 Apr 2023 13:32:44 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oded Gabbay <ogabbay@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marius Zachmann <mail@mariuszachmann.de>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonas Malaco <jonas@protocubo.io>,
        Aleksandr Mezin <mezin.alexander@gmail.com>,
        Derek John Clark <derekjohn.clark@gmail.com>,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, Iwona Winiarska <iwona.winiarska@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Walle <michael@walle.cc>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Agathe Porte <agathe.porte@nokia.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 38/68] hwmon: max31790: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:33 +0200
Message-Id: <20230406203103.3011503-39-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406203103.3011503-1-krzysztof.kozlowski@linaro.org>
References: <20230406203103.3011503-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointed to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/max31790.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 20bf5ffadefe..6caba6e8ee8f 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -445,7 +445,7 @@ static umode_t max31790_is_visible(const void *data,
 	}
 }
 
-static const struct hwmon_channel_info *max31790_info[] = {
+static const struct hwmon_channel_info * const max31790_info[] = {
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
 			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
-- 
2.34.1

