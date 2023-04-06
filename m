Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A586F6DA2EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbjDFUcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbjDFUb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:31:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360DF9756
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g18so4213564ejx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMh9pMv1c2N5CZKj6o4hVDzOl36SVdvTrKYi4l5Ys4M=;
        b=bpvK+tpA6trKtvJrV4DZCtbwNaI1kDImEVeVQL637eqQHty8z4Qq9fSRbGNcHRWRG/
         FPMf9aY2qxiCS6r+3ssc+K9dV71SFj0TYCnZ2GHj5F16M/z752xuBwB8YxPNXqAuuARn
         TZrkjmRJ/rQCutKuBNz2TU/i/xu064lmxWLYCKcWS54oyvpm2JboWOLAXeyI8hy8SoVK
         pjZ3tPar2gZ6Gfrpr+nUYGX2MDmRbgg2z/AKPjwETZd3VjfaMa47TfTd9QpVeKAgh4c7
         D91heJ9XLjTA52/d2UQYgc+iTqtGkcUYCtjf6kKM9ouXIhYev1rb5rlvfNp/wprEAqHK
         ip/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMh9pMv1c2N5CZKj6o4hVDzOl36SVdvTrKYi4l5Ys4M=;
        b=epY+q7E197Jz12f1HvRszj4qKs0DteinG1Z9kS87a+bchxK/XP43O2OjymRy/+DXWO
         dZutDFEqwHNghNJNgWvnD7TgPXVoOCQjrpCZvBmAc03X6CZ5tRnoGlxr2g7M/qI1cxsP
         XcgnJYoi6JI7+NJhK6K62Ct4TuNUixSOw0aB5jgvTrKKGK4kgoxO1H2P+Cprx1ylEoM+
         7MRXoSfj+GGqHChNvWTeCkAz2eYrJqY4rS0NM0Je1bInFGpOqvEA+A53vR0Gec6C4peV
         oZ4Xun5rwRHIC4Gxer2RjD3tPs2c/gsriAq8rexjTY+yIVyCe0S5xpDhjscGK46q0+mu
         TY2g==
X-Gm-Message-State: AAQBX9fVIKI5OKRvge0AWa4eWzTOcjoSHR3b8qgpDXxpDHRv29Z+3Kil
        +IGihVf/vkL07/QqQG6LZouwyA==
X-Google-Smtp-Source: AKy350Yud0CdyQeRWD/f32T/icmKifXpYmvMz9y9aU59vYOZT5+tyTqiYLMimp0uRkG+9Xvbh1C6OQ==
X-Received: by 2002:a17:906:24d7:b0:932:2874:cc5 with SMTP id f23-20020a17090624d700b0093228740cc5mr235929ejb.16.1680813099901;
        Thu, 06 Apr 2023 13:31:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:39 -0700 (PDT)
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
Subject: [PATCH 11/68] hwmon: bt1-pvt: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:06 +0200
Message-Id: <20230406203103.3011503-12-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/bt1-pvt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/bt1-pvt.c b/drivers/hwmon/bt1-pvt.c
index 21ab172774ec..8d402a627306 100644
--- a/drivers/hwmon/bt1-pvt.c
+++ b/drivers/hwmon/bt1-pvt.c
@@ -379,7 +379,7 @@ static int pvt_read_alarm(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
 	return 0;
 }
 
-static const struct hwmon_channel_info *pvt_channel_info[] = {
+static const struct hwmon_channel_info * const pvt_channel_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
@@ -523,7 +523,7 @@ static int pvt_read_alarm(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
 	return -EOPNOTSUPP;
 }
 
-static const struct hwmon_channel_info *pvt_channel_info[] = {
+static const struct hwmon_channel_info * const pvt_channel_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
-- 
2.34.1

