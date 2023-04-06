Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11F56DA2CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbjDFUbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbjDFUbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:31:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F639EE0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id 11so4211122ejw.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jy4+y+10/TyiIFChl0T7AFfRzku+iJoGxMYDy55vI8=;
        b=C7UEqgo58Fo7L/uGfib9xvTeji1SyctI3Jt3RyaklkQkG9wMZXwJF2NFgRec6GE317
         tiix2DR7NdtJhp8TfR0kZouIoGuWvMnAHvxXNvD+QB+k5T2KTkaF70wv7E/KLqljJSYf
         Zxra//4DMZ5HNVn0l49kbK1gazuq+P7VYSZUEvnYEzoE4d7HwmE9U02GGYeVEyCK7gqW
         nzp2vY/v3+mMuQPYzUr9x8mvVe9VcoQ2BsKW9YFfWbHmM4UMXrZJFc6epU1F2TLM/2/5
         o6TUIheD8NQMPc0gJzGVAEIVBp2eo+Bk6lpbrKokM3Km5Qnnr50VnXyT3JLfLuzQowcI
         rcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jy4+y+10/TyiIFChl0T7AFfRzku+iJoGxMYDy55vI8=;
        b=dD0dRPh9049VmWAEqu20cMR0/syenpU1Ywa6M+JHZpq8AYppbX5nmpBAvot/9370C+
         xU8M6wf9Bc4HmLcyzpwUtK4gWoe5XcKDheZgfQ/XUCJE5DUq5+lqgLE9EirPY04l+FHF
         FfFjFVktArh04U/dKEmIcW90BnNwH7FgIwtZnpgnG1WavA6YhNfdWh4nrzTOTwl0vOwi
         XYyaYuBg3M3nL9FLZf5tlKqqF7SVZk2H426rCRDgzLt6QYA6zKHhE96c3fky5wzmbtsg
         sxYQI9f7LN94z+5s7r/GWRbu/AuDoA+pL0+bOSGmAj7rWbCMw/3skJPcntSG4wtpIU97
         dqdw==
X-Gm-Message-State: AAQBX9dHOrq1KZVS0NcccyD7IitU5rSWWNvzCaN+lu/3EmydEXIAAfwF
        p27SaiC03FXQPMEoYSUqaOU1xw==
X-Google-Smtp-Source: AKy350ZYtaPIIYNGhlp4siQb+NF5gQ8sPyVw9cUgfYpY29+pp7DNOklvjBe3njmFVQp13IcDEKr0mg==
X-Received: by 2002:a17:906:844e:b0:921:da99:f39c with SMTP id e14-20020a170906844e00b00921da99f39cmr201230ejy.12.1680813090969;
        Thu, 06 Apr 2023 13:31:30 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:30 -0700 (PDT)
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
Subject: [PATCH 07/68] hwmon: aht10: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:02 +0200
Message-Id: <20230406203103.3011503-8-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/aht10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/aht10.c b/drivers/hwmon/aht10.c
index 9babd69d54a3..b8fe3f7248ba 100644
--- a/drivers/hwmon/aht10.c
+++ b/drivers/hwmon/aht10.c
@@ -270,7 +270,7 @@ static int aht10_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
-static const struct hwmon_channel_info *aht10_info[] = {
+static const struct hwmon_channel_info * const aht10_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
 	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT),
-- 
2.34.1

