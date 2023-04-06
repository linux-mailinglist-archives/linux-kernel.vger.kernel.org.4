Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA86DA32A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbjDFUeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbjDFUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:33:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1572C150
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lj25so4211515ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGgSmDun0Ka3ENM2dsOo9c+VSxguejpVGHkMFXaCcqA=;
        b=MUiM7bglLZqVCKsBSwDDkMv7LvSjNxNCs/0PTUXNkcKvc9liGgPLm0ici6sWKV2qbd
         1WfkT8pkPiJWIF8+y11XHFB85qJsSg/9Za0u52IOA8PMRfIXrdhmruMPOGQeLxKfOnGY
         KbsWXZWnx65MO2+JBIbf0gLFPP/KC/pdmDTtOW7BdurQXCwUqfAbdE0AuL4G8EMH7kEI
         VuRR+7aK1iAecpo7/aw8apuAP8dPPCiGerws0AaqVAI+dYO6wYL/e+77HRWf65pNHD34
         6VBeP7MW/IyFucHwruF95DP0b2Y8kBXeT7SlQcetnLF/I/+rcMXPng5TAIsPziZiOmqc
         4uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGgSmDun0Ka3ENM2dsOo9c+VSxguejpVGHkMFXaCcqA=;
        b=m6MDExfl1mnvAuzsHtirCzPKf9NUj8NAnATvmMYokP9EJ8RVlj6NNrOjcRi35DIlRy
         T1zXAO6MJsjEJWprPZql+GHNmaRdFb0O42umksoN6QkSr245KvA/ExELtBcQjfwrGaJl
         0Qq10hsRX7UboBr49Ul/T9UGcLhDQ0u0ZtHdBew0yvH6JVvlvpxNei+diuV2rbRUnwhZ
         FkPTImv+n/FRGPv6vikIxrrIf6JmYZirl05Zirn5eBYouJcFLXW+whhfRUbVQJeZkZGr
         klE4nYAkt6pyPi4yuY/IpHWB1SHDk3e/alYUdgxWmHtsJFn9ZUSKq6WyFQEjv4g5DPUm
         Vnjg==
X-Gm-Message-State: AAQBX9ft7Nb/IbFINQJ+JTfZAhwecwFPtGUGnYJcWdUdPZrJunSFJ48A
        oyGs3duRkcJg70d3K2svmLhyzA==
X-Google-Smtp-Source: AKy350aFQhS8NkCHu6j449nJK60w/ICqdvNrbFT+w873VTYfdgfIjtPAcMmUwC80gKAmg9AXqnXKoA==
X-Received: by 2002:a17:907:6744:b0:930:d30a:6c20 with SMTP id qm4-20020a170907674400b00930d30a6c20mr154044ejc.17.1680813137576;
        Thu, 06 Apr 2023 13:32:17 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:17 -0700 (PDT)
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
Subject: [PATCH 27/68] hwmon: lm83: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:22 +0200
Message-Id: <20230406203103.3011503-28-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/lm83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 616449f2cc50..bcaf31ec176e 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -337,7 +337,7 @@ static umode_t lm83_is_visible(const void *_data, enum hwmon_sensor_types type,
 	return 0;
 }
 
-static const struct hwmon_channel_info *lm83_info[] = {
+static const struct hwmon_channel_info * const lm83_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_ALARMS),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
-- 
2.34.1

