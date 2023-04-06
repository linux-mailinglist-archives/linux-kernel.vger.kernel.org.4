Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E996DA33D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbjDFUem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbjDFUeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:34:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A3BC654
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id cw23so4219875ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/OgocotLPfWzU4xO81UUQj8QQ2q6pWI8hVfYeZF6v0=;
        b=JCqj6HRrSMiL78IGpyhG0UjUaikqNMwazgPB7//D9j0xI4RWEpwX6e7zkloS07hVoj
         Z7NkWYi0uQr1lefpl4Enf7aOaTfXl4K7gTo0oZQvclbSmlVcm+NvE/53KiZ7oJuVT54d
         7Ujmod9W3PQbhXoZ6TlptoXUE8A/CHIzmgM90D+v5RwmoH5Z6h7dRswpUSITOnxcwsiN
         R357RMVkbSQDqH1d9kJVG8A1qJbtNOnl+pHVmSiHPchrKxbFDR+ETtYyvFWhw2zlcpu9
         ajDSO0UYZRy4a0Fvg0OVJ3rp2FjcwdUMIALu47VnM6hII1RyR+AqEnpQBRiRZKrf2FXA
         byYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/OgocotLPfWzU4xO81UUQj8QQ2q6pWI8hVfYeZF6v0=;
        b=nfSTJ53jZp77TEwyTRUIEldMEf6VH/eIEcpPCUKogtLtTV+c1JRFvfXSD+qGyFflfv
         Is0/e0hQfjadfJNdwkVbNgh5mJaLOAtoH+fexu05AkcZ40OeD2+rgI80JJH8KpD48kuR
         BWCBsFQiH2orMqlsJ4GoEq2vdT28Nq1C8gK8blU+BzKR1nGpGxNfxz2IVJWf6obpnvMm
         boNwGcDg8AagSFplmam+ztqA3DyNfZPoJ6cPfWFtzgCtp3IaBw3gTE9L/jBM4eMZ2qaH
         qo10vZLoi2Hf8xuMZ7Fd0K5lNAYNAUSjWM4/matagyIqvpKD4JBE2eWBJCrBaAFPADhP
         /tEA==
X-Gm-Message-State: AAQBX9cPKLhI62dOZinZYVC2KD5nG5bBIHlCvJQSUDmkwnWb75eOhe+J
        +UDl/WDYvARSAuCFh40H/l3SAg==
X-Google-Smtp-Source: AKy350bUxfidEPotTu0InM0uokm/nb+xqmD4jxUxuAcr/cC92RMUZ9HUOWdYnRwe1kELJZIqEZsJUQ==
X-Received: by 2002:a17:906:190d:b0:939:e870:2b37 with SMTP id a13-20020a170906190d00b00939e8702b37mr117470eje.70.1680813152754;
        Thu, 06 Apr 2023 13:32:32 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:32 -0700 (PDT)
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
Subject: [PATCH 33/68] hwmon: ltc4245: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:28 +0200
Message-Id: <20230406203103.3011503-34-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/ltc4245.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 57cbaf3b39fa..fb9bc8dbe99b 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -387,7 +387,7 @@ static umode_t ltc4245_is_visible(const void *_data,
 	}
 }
 
-static const struct hwmon_channel_info *ltc4245_info[] = {
+static const struct hwmon_channel_info * const ltc4245_info[] = {
 	HWMON_CHANNEL_INFO(in,
 			   HWMON_I_INPUT,
 			   HWMON_I_INPUT | HWMON_I_MIN_ALARM,
-- 
2.34.1

