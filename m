Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC636DA31C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbjDFUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbjDFUdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:33:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32876BDD0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l17so4227558ejp.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXFOj5XP6GGH/xdoeDcQ495WqTsc3jvxQGcIULPs+bA=;
        b=tAH530IsOfJwLPhjCRb2a6QLiFZ+A4sm93VHs6F2KU1UpCdiHUfq/w8KyepLOuG+JS
         VbATh4yTNe18i7hex3ZgKFUkiw0ZZ0yFZHXb5X7VEkIjfQR+3rvf81XZOl3L3/ZXg0Ak
         NfRF92uZAuY/FFvihjWGdG2NzU2+mHlC6Mb6bsTEraHlg1z+GeNKIaTVsHCBgW++TR4l
         I6knMQtQhxoBs/FZFfoVnQbbqOXa6WHlTFCxboFnXtYLlqzpXDH50kxvOtHQAFAAo30Z
         XK27U08kPOKn3KmigfbSCVEzGRhYqcJHuaBNPL1V6om3YrBPNsBUHnLqkBtgWk4SJvxA
         tWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXFOj5XP6GGH/xdoeDcQ495WqTsc3jvxQGcIULPs+bA=;
        b=1/nixRuwacoO7XPGSF4J0/V+oyZoovYjHeyc+j0veC7XZeb23igQq6uuHjl/e4wE+W
         61r7Gn2765cXIR9PKwGcdsrrOa1R+th3WOQ6LEJVJXITvcNEBoPe3d2Y2gGqACRPg1rf
         LznQjUoCgduPcu3Xh7FhpIROVWO1iXvAC4G7Q+s/MF2+jXoFKHXX2DnneC3uqKgB8q/N
         ulYYepF1FxSYWTHJfgok82n2yUpp3erOXCnM3oWYARq0mLwsIdOYViAiEqYWgTVaMyqF
         GXtTgnclAubOcqN6xICww/GZx7bKgy+rfLYJHb3yk50+w3ClaQyXFiVAoyO0nOX8QPa/
         4JDg==
X-Gm-Message-State: AAQBX9clAFbPgqAC3jKeobVA4zWsphT4HbvNQQi88xpw5m3lQtqYQvtE
        /fspOxDF4aldyYy8BHVsV9LkXQ==
X-Google-Smtp-Source: AKy350aCP7vJgYzvgsdr1w8OB+3cnrioQgc4Ehey8zq08G4w6/AHxqP7MSkD4NnYB5eXuIOSWR5N8g==
X-Received: by 2002:a17:906:68d7:b0:931:99b5:6791 with SMTP id y23-20020a17090668d700b0093199b56791mr105268ejr.72.1680813128037;
        Thu, 06 Apr 2023 13:32:08 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:07 -0700 (PDT)
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
Subject: [PATCH 23/68] hwmon: k10temp: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:18 +0200
Message-Id: <20230406203103.3011503-24-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/k10temp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5a9d47a229e4..df8f08740c1c 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -332,7 +332,7 @@ static bool has_erratum_319(struct pci_dev *pdev)
 	       (boot_cpu_data.x86_model == 4 && boot_cpu_data.x86_stepping <= 2);
 }
 
-static const struct hwmon_channel_info *k10temp_info[] = {
+static const struct hwmon_channel_info * const k10temp_info[] = {
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MAX |
 			   HWMON_T_CRIT | HWMON_T_CRIT_HYST |
-- 
2.34.1

