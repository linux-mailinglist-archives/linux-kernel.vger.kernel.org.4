Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99036DA2CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbjDFUbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbjDFUbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:31:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FBFAD1D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id by26so4205624ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4v5eQ6uNtmwpFMgRe8EaIBJb4MZtfu8baTOThAbc48=;
        b=mZkZh2ihElAmXpc+gvjW4iyD3G81bS1xcX04W3p0yGmEl952kZ2/BbZgOSgXRno2bu
         LbMW/sOWeNFx7qYlS/RztN3Yy1WPTkHmt+hy8oQk1S3Baf38fEh//h6KtNqfzb2auHaf
         2i6k50L8ETVq26xxcqZcWiy5dD+bCuG96xUCuMF2mbOmTareYO0GEtyq7RP0G9auMukK
         Mt4nPxyBGmLPCXYSVf0Ioa/IkDR/NGu3KeRuYr9Inc51Z+2zSfr/q4Btkp8buGWHEJYP
         aDtJcUQ5X6zyKD70mz49SiphGZhB6Fa6OYtNUhxYEHpjbeEsEj+X2oUdxGYXHSsiCZ8x
         1dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4v5eQ6uNtmwpFMgRe8EaIBJb4MZtfu8baTOThAbc48=;
        b=NwfPI+klr/ySet9VFE2pywA+YewjEGadAgDEYHqCHVxbC1jGGnO6qjamVLd0OYFgYT
         IeWhjEPp9GjPvZuPaGZnfNCb0Zg53nc8NU6RfOHTAzJKplSuGTyA67PeAqQWKXHpYNn+
         qUVSkB7gJzREbTidwHosyxBTh1TMRwBtYOU4N1UzQQ+sdgEMP73VgD+7BXecWA97PFY4
         nU1AAUG23s+u2fhC3y2SHaMGA73+fU2X6dGPpJLpXm8ghO26weDfEeEklt6jZeEfTBOF
         e290ECGmICMZ7YadEzXqsNE43CzedXlYh9QleeH5AwqVBwj+aAJF3UtUeW2TsCNPokW8
         KqdA==
X-Gm-Message-State: AAQBX9exjqaxtWQITbDIQiNBAk3L4u5vTY34aooxHkpdNY5sTOyxxC8Z
        ybdQvvzIEg30Ealgdu8oO4Ro1w==
X-Google-Smtp-Source: AKy350Yudjg1cQz744cj4XdN94KceoalOMB5GdOd9sJA+cB9OFNaDOxgIsWxQXir9sQGWZ45/o8++w==
X-Received: by 2002:a17:906:2414:b0:931:42d2:a77f with SMTP id z20-20020a170906241400b0093142d2a77fmr221247eja.15.1680813088528;
        Thu, 06 Apr 2023 13:31:28 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:28 -0700 (PDT)
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
Subject: [PATCH 06/68] hwmon: adt7x10: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:01 +0200
Message-Id: <20230406203103.3011503-7-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/adt7x10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index da67734edafd..6701920de17f 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -309,7 +309,7 @@ static int adt7x10_write(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
-static const struct hwmon_channel_info *adt7x10_info[] = {
+static const struct hwmon_channel_info * const adt7x10_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
 			   HWMON_T_CRIT | HWMON_T_MAX_HYST | HWMON_T_MIN_HYST |
 			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
-- 
2.34.1

