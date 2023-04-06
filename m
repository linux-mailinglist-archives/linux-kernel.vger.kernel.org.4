Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E204A6DA2D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbjDFUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbjDFUbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:31:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B0DAF0D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j22so4221924ejv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OysLbRAf3FePlMQAvxi6ECtmAIY3wqal/J8BkLquJ4=;
        b=WAF8L0SzNrjHfnlyjmVp6od9k2EnBovOLiPR+pKqvJ7byni4G13TBQS3Safv+UA7xm
         63g+Vjp5DECN1x4IqQ6BA2GuXw+v9oP9uAI4ht7dB6qHYzbSHGYoL8Usys29aYBaJds+
         DXUwpkw8yoE8hqXIi5PaOSm8MuRCc1yYKjeXcXgmbc+c2GpFtIkrNv+ggfp0l9cVLEGk
         pxkxIG9EAgY4d0n5oktwaV4yIlPk+D4YKu9vWOncvI+amxpV92hSlGGHxl94tVpg+3ZK
         A3RtPXsssapZNNRuRkMneXWKhNDamsLBi7NCu3kE5nvvtkfqSA4H1lYScDAV8cfOJyCx
         lGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OysLbRAf3FePlMQAvxi6ECtmAIY3wqal/J8BkLquJ4=;
        b=k+KFBaw/SaA6yjopdrqbCpl6nA9VAConVWtoVB97jezjrQ1bpVyGLM97wt2s4wDv9v
         Le6C5RHBx4eYvSMvbFRIXKoadROlX29CYDNMiUhCoPlV9tI5oxmnVA4IykwdkNyoDHFp
         nKUaaUApQpipDdY6NwZAMa1hjkylShT82Ltv/X4OvIuCvpCud3Uf3p0zlCJTGs8yyjOY
         sILNaFLos1jGEsOL3b64XweP82Ur0otBGza+5KemAxCq1u4WwNA6d7i+cXk8tsgkKiSp
         dH40f1kfnwSX0r1KDFKlQrQoz4o8EOqqbtxs/dazFUz3ngs6kkmecr1NFMkhUMoaukCM
         I4iQ==
X-Gm-Message-State: AAQBX9eT/3FSUb+WIPqh8yi053xUZ6sd1rbBzCAB4VUp3Xttm1iXcy2+
        waBgIUnyVyoZS9ddd8L0xFNKTQ==
X-Google-Smtp-Source: AKy350ZG+kU5MGyTXsT6ZvJ+plxOSXcJkKLmeifDg92uAby6efORfna3F71Oh1L4yH5Ox9lEdI3V3g==
X-Received: by 2002:a17:907:2c61:b0:931:32f5:1f31 with SMTP id ib1-20020a1709072c6100b0093132f51f31mr244641ejc.9.1680813093118;
        Thu, 06 Apr 2023 13:31:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:32 -0700 (PDT)
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
Subject: [PATCH 08/68] hwmon: aquacomputer: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:03 +0200
Message-Id: <20230406203103.3011503-9-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/aquacomputer_d5next.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 17fad3142118..3bd35d833e69 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1038,7 +1038,7 @@ static const struct hwmon_ops aqc_hwmon_ops = {
 	.write = aqc_write
 };
 
-static const struct hwmon_channel_info *aqc_info[] = {
+static const struct hwmon_channel_info * const aqc_info[] = {
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
 			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
-- 
2.34.1

