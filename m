Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF256DA343
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbjDFUey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbjDFUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:34:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BABAD18
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g18so4218871ejx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppNE/j5dH4h2kt/jgazVM6wfbsekqqd/ryXw3i4bi1M=;
        b=cQgako4VzcQupeFA8QvrnuOXoQ5KeRWJ1lAGsViufDEK8wPY4Nj5S1aYfozyq6/bU/
         NAv+2rf5QIGvFjbb0f7CinR03b1RxkXEQ+lyM5bhcW3jfUupKTOJM0+MLKGeSIi/trsn
         Eta0Qdrcxi7qmX81Um3MTiLu8D/Gu8SNu90BCc3E270I4w3xH3bfBQvomRv/y3/exaWl
         7j99fW+W+fbPgH5dvpuwWqDXwEi22ruCJXJZUvSo1epPn6D7ExpksQ4JsvQ3LxBx/IeP
         Ax1fkWw7nAUpf2oIGXMHplxMFJSXgv6mqpA136lolg5Ek1FMixre+pHiOjWYNQjLiOr5
         a9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppNE/j5dH4h2kt/jgazVM6wfbsekqqd/ryXw3i4bi1M=;
        b=1zz8G7gBiZ8FbedBIte0m/cSqRxtwqqo6VMgFi8sZzA+tr6Qr72I2n5x26Ix2hg+Jo
         wXNzQE8d5IU/f0d/6h8/d8G8K1VQYlOOUSgf63kJ/ZBn91K0ZRVX5D9s5DnuvEji6L85
         vCu4Kel8K6ZWF165U9ffGUhHZTFu73kNG1A6E3/nFvaGLb+JDkBOIqCK+oeQJCruCq+6
         PgXPmFy107vi/d8PCJ6ZLPsAUEAkdpWYIgCe2r+XYJlMzUSnXrL2VAdegrQsiGkr5Sc/
         ozYDgUcMXVNcIEGlSBrvi71GL3AMLfjSSt3d7nQmRC4XK35aeDtVw7INvubFpI2+SzuM
         pzJg==
X-Gm-Message-State: AAQBX9cHRNQc10WGK3Hxz+Y25cJ8lB8LkhbvI7G+IeXNVeGDkq5bGqJQ
        cMtOp7wx/6D+2aTGbot/rpo9Dg==
X-Google-Smtp-Source: AKy350aghcMvibuC07Vsb1fyHFGf7R3/xbMTh207yfOWRgC42TQZhq0hGqVSSQR51VINp6KB122GeA==
X-Received: by 2002:a17:906:f142:b0:948:f810:2960 with SMTP id gw2-20020a170906f14200b00948f8102960mr6266458ejb.22.1680813159668;
        Thu, 06 Apr 2023 13:32:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:39 -0700 (PDT)
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
Subject: [PATCH 36/68] hwmon: max31730: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:31 +0200
Message-Id: <20230406203103.3011503-37-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/max31730.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max31730.c b/drivers/hwmon/max31730.c
index 746a767c9fc6..924333d89ce4 100644
--- a/drivers/hwmon/max31730.c
+++ b/drivers/hwmon/max31730.c
@@ -248,7 +248,7 @@ static umode_t max31730_is_visible(const void *data,
 	return 0;
 }
 
-static const struct hwmon_channel_info *max31730_info[] = {
+static const struct hwmon_channel_info * const max31730_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
-- 
2.34.1

