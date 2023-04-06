Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BF46DA2BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbjDFUbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbjDFUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:31:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B177EFE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g18so4212237ejx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhucnMOCApJwyrEh0T24y6L+m2gTCLyybnOQH+V/c/k=;
        b=wR3fRjCMK/Nm+NAs+aDoFi7bFJLAXJVC0YhPYyMuXkwOH+qdJya105MiUcrEOikccV
         FVkPPvG6mUjTiHcIlHV75IUE5gJWrgDY0hbYWWKiMGmNXcYckF9EnYbQKwR4jbZfbek3
         LU+rW5vOUk7e3ZZ9lmuxXOefPUUJSUCS6k4p57xS/W1px/gDTtey0wdkbWlYGpxjTE+T
         mX3GkCd0mjn+wchxzZ5/p7KFlVuaRQw/Sr4oDcGgrdFdGHS3A00MxhfCdL/IBX58FUs9
         MwPBHFIzs3OkVCg1pD+EmY/8xq9fqilatA2IexETzAWTPRcholu1HSkndQEEoSf+DWpC
         rVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhucnMOCApJwyrEh0T24y6L+m2gTCLyybnOQH+V/c/k=;
        b=oKBw0pNEj2vIYMXdVHjhO4zC+JstWDikKb3B4AjfYWpYT36XFkJ8o+zhqHoUqF6a07
         +X/34g1qbxFzrB/DpVOhMGg4MH4ebFptJyqREPYPcuhuyzfu7FUB2oXPhM7XKTRmkwJv
         6LU+A0U0+hgFBi9MNbIcV/prJwHxVpmFBNXQsm3kid58aiUy0S9GsciHNIrwgMmiFuwh
         wT2dg18xuSrKzYCvzdM7zjXgcIzKfeHqdkDOZ9ydUuoWtEgovQTEpl1vAjysYCgl4Puh
         wrWoSitVTuvUPzNZa8Cr+PMejC4arFAZur0EX5KrQqJSMLIOWr0b5HPdwDnIB+p/D6TI
         gB2g==
X-Gm-Message-State: AAQBX9eRXAnHyavTuRhTHpk/tJI7zc7eE2+Xr8h5Sx8nP+kLZ9hMEjIC
        xJ3v3gQLrBo8dlvI28CEecTjzg==
X-Google-Smtp-Source: AKy350Yfxe/TgPhGqHpSDsSER21k9DB/mHDHNa/1jjakwf+HEnuaeB3XQN5e29ccpPoI4DLjOEB7DA==
X-Received: by 2002:a17:907:76e8:b0:92f:efdc:610e with SMTP id kg8-20020a17090776e800b0092fefdc610emr102574ejc.66.1680813083809;
        Thu, 06 Apr 2023 13:31:23 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:23 -0700 (PDT)
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
Subject: [PATCH 04/68] hwmon: adt7411: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:29:59 +0200
Message-Id: <20230406203103.3011503-5-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/adt7411.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index bf5c5618f8d0..6ba84921614f 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -636,7 +636,7 @@ static int adt7411_init_device(struct adt7411_data *data)
 	return i2c_smbus_write_byte_data(data->client, ADT7411_REG_CFG1, val);
 }
 
-static const struct hwmon_channel_info *adt7411_info[] = {
+static const struct hwmon_channel_info * const adt7411_info[] = {
 	HWMON_CHANNEL_INFO(in,
 			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_ALARM,
 			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX | HWMON_I_ALARM,
-- 
2.34.1

