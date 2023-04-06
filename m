Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CB86DA34F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbjDFUfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbjDFUeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:34:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD2BCA13
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id 11so4218262ejw.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSE59ealLQGHAo2Ku4q/7kg+0lPG4LrulmfGJlBd0ZM=;
        b=L6tafJzL7iokaK6Im2wvNbxtPfUxPXdCSGsMaWxwbyBHMH5eN00dzBsXBw3wwwJ+MS
         Wa+82tzfWCZQxNiDXLLYzMwaNxb/pjfdcoy3GOBW8NSS7JlPcK9CCbDgRLwcPugvQ10+
         NtdpVlbf0e6cdfJfj4+yzQnfbWNm2zmAZJjViX1ICsqTKQsPsYEwBBeGwSCIGhU9X9QV
         gva/svt7TM9U4+IK5jGDZZNTWxTDH9+XmxdcZuuGRdm9OqUcg9D/kOUyjOSx1clNGP4N
         221m5pE1b+lfaU7G2d8GSdFOU/j3Fl2fS8HO8VXdtw26CBWNrb/PTwylA2dThs96eRhm
         49+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSE59ealLQGHAo2Ku4q/7kg+0lPG4LrulmfGJlBd0ZM=;
        b=fO0aIioiY4fZ+X8qZwHAiupeLAzZCDjsXoTk5hb1OPGLKbsEWTpD5g75QcBa3xiPv0
         mCsXjH/cEBptAqCTgc5dsWO+kv87h1zzSrYXfuejE4m63QPZVl+QSCbXx/cFMujqv5F8
         p3q9H8UHKgHOTgaG0l2Wag5G1KMuOopL0wcdTUoBjjXQyo6njwPboqhfltT00b4tsSRY
         3yT3OB+S20IztXU9ohMd7c8CuM6O1xC9szzYk2ksDtpV4XaGPhOMPrUCWe65Vg6mNX82
         eIQylPrA/PUq6Y3Jm1DXPo+LXVGgf+gBYG49drZCLVxFCOzEUGi6hOshAnYVnkVZkFqH
         ainQ==
X-Gm-Message-State: AAQBX9cgiv/VhDDS7R6K/Yzt3uRcVsXEE3u4Rv/S8iLIP+1M3qeC+pTJ
        Zh3XmNISBtVB+jqLIhCMHj4g4g==
X-Google-Smtp-Source: AKy350aZj+3xCiX8S0pmVurfz0JVDCPQPUB25bHCuItaGxTlBdkkkiR0kaYcyf2W183XNNf/H26hTg==
X-Received: by 2002:a17:906:d0d2:b0:933:1134:be1e with SMTP id bq18-20020a170906d0d200b009331134be1emr115611ejb.53.1680813166736;
        Thu, 06 Apr 2023 13:32:46 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:46 -0700 (PDT)
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
Subject: [PATCH 39/68] hwmon: max6620: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:34 +0200
Message-Id: <20230406203103.3011503-40-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/max6620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max6620.c b/drivers/hwmon/max6620.c
index 202b6438179d..0f277d945ea2 100644
--- a/drivers/hwmon/max6620.c
+++ b/drivers/hwmon/max6620.c
@@ -401,7 +401,7 @@ max6620_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	return ret;
 }
 
-static const struct hwmon_channel_info *max6620_info[] = {
+static const struct hwmon_channel_info * const max6620_info[] = {
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_DIV | HWMON_F_TARGET | HWMON_F_ALARM,
 			   HWMON_F_INPUT | HWMON_F_DIV | HWMON_F_TARGET | HWMON_F_ALARM,
-- 
2.34.1

