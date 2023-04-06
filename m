Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29CB6DA33E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbjDFUeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbjDFUeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:34:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1058C668
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id cw23so4220043ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeOUixAi/gafQse1TlsC/rFgutjhxjD+isGU2Fyr4iw=;
        b=qBt12SWqNaZLTSfbFTSlPCwVywTDl2S06oUkfOqIBFP491mmTtMXn+faATcraquTQY
         qYMwWn2c0DV+KHUKv2P3TF34GbHgLADNWPwHg1g3lCstScUdIkLMaSX6B1SIkNS+gMQ4
         3V9zRTZJkkMZPakZEZpYRlrP0PbU6YuxIMuLvcoxKw8OPoW6fmG479okxU0RQKEVmjCL
         Rl1aoHbslbYgG7+pSvsIsh4YbmXmxIIJCJELAl5iUTskjOoLf/CQyGJQArMmZCJEFwRw
         wCY3FJ3YPNaKeqrieDpWQst6k++ZhDVt3vJ+FCW0aLks+kb4Uz94C9Q9sQfQzyWFiq+f
         zLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeOUixAi/gafQse1TlsC/rFgutjhxjD+isGU2Fyr4iw=;
        b=ffNe5zAjLStXHDZOskDaLEIs/J4uKu9OoZ3c2cPLQlLcAAvAhqZpDaAdVFUkqDgBUe
         WP82LxfuwxGsR+CaETCXgj6UF2+QfCD6PNVnObFjLhu4GYYLpaocyiKnN/ZQh0HwgKLv
         jyLH2VFaX3q/K1nt9jns+qx4OZROnB2V6VFIwA227mTn+nswGGQw24hGtAi0eyM/iIc7
         YcGeyJjYNvzUaNwSm6rHYAJbMqIVxluIz5ypkpyrrIWWlgWoxkzsOrd0yHq9g6EFBt3c
         f2mTZaYgzDo481t4Dj43VjzIwni8stFXSwnSGf08h9EKXZ5Tzm31pWtDXCTv7Tf83o/g
         Z02w==
X-Gm-Message-State: AAQBX9c31qnoeg4RoVACjTN37TNT0OLiJPl6EC7w+4rDFbUMPdvuitgw
        Jl+iIOVexCQjqAMu0WOX0bP5/Q==
X-Google-Smtp-Source: AKy350amqDJbdQRa0fpfvDPRb0xsNyl9DO0v3HM0r1nvweJhx2b/T3k0IXoq84Tob+DOETJqUP8DPw==
X-Received: by 2002:a17:906:d04c:b0:937:4001:6eda with SMTP id bo12-20020a170906d04c00b0093740016edamr132439ejb.38.1680813154963;
        Thu, 06 Apr 2023 13:32:34 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:34 -0700 (PDT)
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
Subject: [PATCH 34/68] hwmon: ltq-cputemp: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:29 +0200
Message-Id: <20230406203103.3011503-35-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/ltq-cputemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ltq-cputemp.c b/drivers/hwmon/ltq-cputemp.c
index 019e770d4c0c..08e09a82acab 100644
--- a/drivers/hwmon/ltq-cputemp.c
+++ b/drivers/hwmon/ltq-cputemp.c
@@ -65,7 +65,7 @@ static umode_t ltq_is_visible(const void *_data, enum hwmon_sensor_types type,
 	}
 }
 
-static const struct hwmon_channel_info *ltq_info[] = {
+static const struct hwmon_channel_info * const ltq_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
-- 
2.34.1

