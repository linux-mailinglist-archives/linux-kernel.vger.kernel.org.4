Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D066DA32F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbjDFUeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239953AbjDFUdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:33:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CAC143
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qb20so4219408ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQG7cqdEyfvgPiaN3cNryt/86XntNmRJN2oVu5IHW7Y=;
        b=XJ44jdrRUc4kmM1br66U6rAOf/+J2P4kKVwI+KigpUoEt84wEJ7+ahpdDZh0lXfDsg
         Zo+YSwYFZeTAdqXM5z1SKrt0YWzUgauAPRPkAmwG8zZwUXR9Kz//biE2tQLr20a2eybt
         goJiW94Kcuan6+Eq33KmOod8cL+wq7JoiGfBxsWVSlGlD42arsqJI9o+hNMNGa4gwtDR
         sOBCJvALAiEB2jUn/42KnmlOtZmEHbtffkvFpHS4faMyw+tvioNqFy8kJbFtI6AFZOS1
         cnUaWGdtiR38mhNGPVZymKjgNosdn20ThR3rBSsau736cXbtjAFQRoNixz0/0nC7YO/8
         yNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQG7cqdEyfvgPiaN3cNryt/86XntNmRJN2oVu5IHW7Y=;
        b=DhygCtK7WwWQzrkc7sYjjgQVpKcA1uJGZ1x5pfwVrySNYTjUGsOurEK5rS+ykCbPAj
         LWJGf1hxOTrL8i+8EoNDVRbhGi5beC7+eBUXrEDJ0RjuWZUGBo5TDLCAfQiY6YrpZYFR
         mJ12Be2B3vvwW872TG7CH//R30OF47nhHC3hcIWzTNTLNuon8DUeZ2MoON+BE27RdynR
         xvLbcSeLxk4/C9OoMGEl/8AsBfZ1smhcW0ZCr8TR/O8yUkMjB8YSM4OuxYIuJlCTbNLc
         H9jlPx71wUtuU65AqqTrpL11DnMBt/94MvE/9oTLQc5pM41ti2nNHx5vHzyBOBOJb4NU
         PmFA==
X-Gm-Message-State: AAQBX9e5OsHz4zklkRZhRHMXSbk392TYzmLi4wJ7IF+TwHbqRJWH6ch/
        lcjq/KBNL7i3gPpJLDIOrsPplw==
X-Google-Smtp-Source: AKy350Y+6+5n4zHzDsmLkCFWD6JwwfjRxF0GIrJC3syTwj2hmXC7+JMPJgNcDMorii71vq2OJNJ7Zw==
X-Received: by 2002:a17:906:39c8:b0:93c:847d:a456 with SMTP id i8-20020a17090639c800b0093c847da456mr167306eje.22.1680813142562;
        Thu, 06 Apr 2023 13:32:22 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:22 -0700 (PDT)
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
Subject: [PATCH 29/68] hwmon: lm95245: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:24 +0200
Message-Id: <20230406203103.3011503-30-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/lm95245.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index c433f0af2d31..4236d1e0544d 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -523,7 +523,7 @@ static const struct regmap_config lm95245_regmap_config = {
 	.use_single_write = true,
 };
 
-static const struct hwmon_channel_info *lm95245_info[] = {
+static const struct hwmon_channel_info * const lm95245_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
-- 
2.34.1

