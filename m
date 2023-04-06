Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE076DA30C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbjDFUdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbjDFUcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:32:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BDA9ECC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jw24so4217930ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL4brmswtz5kXr1fmKwInCxjlH6he8VKwj0V627SpbA=;
        b=RjZypuk+y5AU7f3XGxF5Rl/jr+svjnDPTN9iBF6vzU2NIzHfxpiTldbo9kjAyzTdbg
         siMjyV5++Q/pJbxL3XpSeIi5EYdDDBVkmNTDsZR7PASY3ISre7+gaVxy617XJ98Iz28T
         6XxNmWW3iK3GSbUNNXZWOdt+LPtPv3AOZd/sfF1Gx2iDkRv8hDvlYixMzzWZkOS59c2U
         Cr7A2FRodgYfoRP7uAoT/UEfvocSX5XwEetx8J54khfAJRRib2MIkTpjqVAXRfX8eZsP
         Td7j3+I1vKj7aIDWtHX87uEC8KUPDhqVYm1n/Zk9DE43P/PjyqbFFqI6cXyIPIce4d4m
         IL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mL4brmswtz5kXr1fmKwInCxjlH6he8VKwj0V627SpbA=;
        b=GXyU+OxyEAy2L5ZvTou9Vq42t7DSrN+O7QeZ9pTovNrUY1PtVKJScthtCKY9oHHDSu
         4Qbf7msKzxKaf6AemiYmuYmlolEkI4OZGj8Qik5RR8fg0z3+3xxN6AQU/MiurxG/RY+H
         vzNSBDrxVWw5gDjpvkulTZ4RbAnxHuhhYKDWmBfFI8VbLQUIMH8VlSof1RB9YXn7sk5O
         MJwhS5i39APlPkMnyz1QcXKeZYoK3vSUpBu8kzt6m8eeOzl1nJJTUiraqMxsKxcW0/zn
         yb4KTdGX7/d/Qni5P+YMI4dhpOPbzqyZsdVpdwn2mTcUEZGwecx2zAhzw1fZJxy/u4f0
         qRiA==
X-Gm-Message-State: AAQBX9e6we9fLwNMEutc2SPgUsScbdKMIOnIZ2DiMe06ddtKBnHW2oQy
        dkNUaLZI/9V90DbN8vzSKlBCyw==
X-Google-Smtp-Source: AKy350ZCJBJl8mtDFBbKnabpZnzVxKYkofKV7TXIl6boLppM6CpYFOeo9dFuZLiozCFvFobLsk6V3Q==
X-Received: by 2002:a17:906:aec8:b0:931:59f:d42 with SMTP id me8-20020a170906aec800b00931059f0d42mr171521ejb.29.1680813116456;
        Thu, 06 Apr 2023 13:31:56 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:55 -0700 (PDT)
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
Subject: [PATCH 18/68] hwmon: i5500_temp: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:13 +0200
Message-Id: <20230406203103.3011503-19-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/i5500_temp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/i5500_temp.c b/drivers/hwmon/i5500_temp.c
index 23b9f94fe0a9..7b00b38c7f7b 100644
--- a/drivers/hwmon/i5500_temp.c
+++ b/drivers/hwmon/i5500_temp.c
@@ -88,7 +88,7 @@ static const struct hwmon_ops i5500_ops = {
 	.read = i5500_read,
 };
 
-static const struct hwmon_channel_info *i5500_info[] = {
+static const struct hwmon_channel_info * const i5500_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST | HWMON_T_CRIT |
-- 
2.34.1

