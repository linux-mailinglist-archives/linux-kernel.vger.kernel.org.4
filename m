Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC536DA2DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbjDFUcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbjDFUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:31:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA699767
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id by26so4206129ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fstBy6yWcExH6RGLHLt2IS0s2Pvrh3Q8g8Pb+fMMd6I=;
        b=ZnhjZmqw++GXIV66u0SJMdSn0ABd8Ck+cMBwrxscy7ExiQKNxRSIZOVNB4YpQWAez4
         gVgFqj2axWjpWbqV4pgxLNCcmmnCDnN9rQmgr9PuBIoyhbQMG+dkJWUnKn1Cz3AZkuNT
         Wx4/GxsKwjAAoDqjrHgh1r6VJ6MRdrZAs4wpmZl8IUlIUG2Rh8Q9JiuiGnr1Ieq0gOMy
         g38xMZio5/a7kNGhbYZxTjWu7GiVPX83+sYjr5XeuYPuvmPAY3++28MbL1Bs4UUj9ZGB
         0M9AfZvvfLmaWCsHcuVMlmCSYu3BrmB/LXgBE6nZrzYkLuuGWSQD9y+UvrtXC6BVEifq
         6GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fstBy6yWcExH6RGLHLt2IS0s2Pvrh3Q8g8Pb+fMMd6I=;
        b=dEYWzOwpEq/5M58JMABBmsx86NmGXnvaCdnfhp3QFGjTgOiZC1f4KCitIQ2hosvUue
         bYeXP39eBSGWCVwB+DkQhN+n5R/8Zfo9hsYfYP/3m2lAROIJKBAhnioiIwnLA2TdsFda
         w7EfArGaswh952+Ws8XyES49O7j3q6OsXhY0nZNMYpsVfnFfK3TGgIOpM5xINGJ9T/xn
         EHUtwFJJa6/Pp5qSbxhdVquY6COWLnddFz+X2p6Bbu4PeBIt5unN6l53e0O5lZKQHYRq
         PvltFRyHJA0aJ+CMOHhxhNamwM7HLP65rgDDXX9wRczAcEGFl3DJBp5Z/KWeMam1vqJ8
         1PXA==
X-Gm-Message-State: AAQBX9dK1szX+Rc2/rCnBxqu3AsTE9aGBgVMLliG0o2yLtn0BL8AATBi
        rbegcWjFnP8R6kECsbZaEVUdSQ==
X-Google-Smtp-Source: AKy350a+NU0k+SMmkfaOKPj/I9Wth66NJKumih3jnB2M3CUI7kwp2CZYW1SslvpEMjt+glLhGWcj2w==
X-Received: by 2002:a17:906:f9ce:b0:93e:24f6:d7a3 with SMTP id lj14-20020a170906f9ce00b0093e24f6d7a3mr258509ejb.8.1680813095377;
        Thu, 06 Apr 2023 13:31:35 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:34 -0700 (PDT)
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
Subject: [PATCH 09/68] hwmon: as370: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:04 +0200
Message-Id: <20230406203103.3011503-10-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/as370-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/as370-hwmon.c b/drivers/hwmon/as370-hwmon.c
index 63b5b2d6e593..fffbf385a57f 100644
--- a/drivers/hwmon/as370-hwmon.c
+++ b/drivers/hwmon/as370-hwmon.c
@@ -76,7 +76,7 @@ as370_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
 	}
 }
 
-static const struct hwmon_channel_info *as370_hwmon_info[] = {
+static const struct hwmon_channel_info * const as370_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
 	NULL
 };
-- 
2.34.1

