Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581226DA2E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjDFUcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbjDFUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:31:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E514C9039
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n21so4219645ejz.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o/5+RoY1xsbRUDa2AFV0+g4brx+liGdLo6ECyosb9g=;
        b=e1j2ok3u7VKsR1y6roskcfNxp1+JClKqjk7Csr46nCNqwp+tvujjHQEMIxbTKklgfQ
         xf1Q+6FoEZZaW0f3QmwUdOlf+txDQNXpyppc7ZPBeyq5F1sEugpq0ioWRrBR/9emC3Qk
         P0pPSi2jA6Yb5MC3ihtndLjnK427/fl1CpixkdRPS4uuZOXTnJPNT0vYQsShb2NttnKy
         Qmjsx9Q8X3FnKjQ8PnDQ89IjAC2xYBdayz5zCxdwn3liVhMBr+51fP3qqFdOT03SWUOo
         jIiHY08xSbx2ArReXkFEzh9RIvmLh3EpyMkqjCofJl85Ziun01chGFqxDu6nxJfbJXsB
         YXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o/5+RoY1xsbRUDa2AFV0+g4brx+liGdLo6ECyosb9g=;
        b=vRWGzoe+bguyhLGav8Idps3hQF3MtXeli+VqMGalTOzDCD7WJ/Pga3XiOQolb7lZRP
         J94BY9yEuRnBEWPNi3wfOKaoiMMA2O2CBFpsi3tFumJk1Twhk+0KSvux1eVh782stz0G
         1I91YAkCfg4gNW7rdMA3kZQn/o0mtbXG3fe7+gZYP3xB9cJftfcKPCUzs/CjavGX25AP
         q/b0o0kwMVy5fp5eaWgC7hMJc//vtfo0FFE9wZkJbqmTt/KYYCaQw2EFX13du13szrmk
         sWgblTi4FZ72YCVY9xijZ01BAtboFOC3ah95Pym4GVk0QMrwCw3Czws7aOmA1Z0xR8PW
         EUqQ==
X-Gm-Message-State: AAQBX9fM+Z3Gyt3MEBKnYY4A3vdvI+QIHFM0JKhozDCQFvoG+h6bp6cs
        82yHts3AryxjftRV68Gnjby03w==
X-Google-Smtp-Source: AKy350an67ONjArurlKU83f3QFsUI86J4oBoCp0dWaiAvD+CmcW+xp7O+S3fVmQkXomQA9I3TeWW/w==
X-Received: by 2002:a17:906:924f:b0:884:9217:4536 with SMTP id c15-20020a170906924f00b0088492174536mr73325ejx.64.1680813097470;
        Thu, 06 Apr 2023 13:31:37 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:37 -0700 (PDT)
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
Subject: [PATCH 10/68] hwmon: axi-fan: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:05 +0200
Message-Id: <20230406203103.3011503-11-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/axi-fan-control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
index 6724e0dd3088..5fd136baf1cd 100644
--- a/drivers/hwmon/axi-fan-control.c
+++ b/drivers/hwmon/axi-fan-control.c
@@ -394,7 +394,7 @@ static int axi_fan_control_init(struct axi_fan_control_data *ctl,
 	return ret;
 }
 
-static const struct hwmon_channel_info *axi_fan_control_info[] = {
+static const struct hwmon_channel_info * const axi_fan_control_info[] = {
 	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT),
 	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_LABEL),
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
-- 
2.34.1

