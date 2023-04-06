Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45206DA2B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbjDFUba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbjDFUbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:31:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA4E7EFA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n21so4218281ejz.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u57ez0Oyy7vwUrJo3VoPbCM/KJTEPduqRqpuIH43A8o=;
        b=XHG3nqXF82IDj/3hwckhgZbxN+s5RQDFGpsCor/HLk3As++7RNt43UfpgKicmj2Pt6
         dFK2ZtMP2KTqTUWzZ4yNuDAd1vZUxX+uWHJ2wvtGtN7iMGoLzfUVOGsRWAHwSVLgsSf6
         ws9RfsZqp6p/BmDu4OoasALISMjpbdtgWu/gu+J93Rx63H2XILuMT/S9hNdq/buQToi/
         tfQnikwdFNGNhuumYNLioCjMiSkSCIdIQn7Z5MpGT/df00vEANoC4da6Ct7JGjTUHbJx
         LjbF0DR7f7G34dGDo36wbdi/NB5XH3sYo6tzrV7KvjtHuSimTWV3HUpEBXfIddKCz2lz
         pVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u57ez0Oyy7vwUrJo3VoPbCM/KJTEPduqRqpuIH43A8o=;
        b=yQH5Vxx6UU22X2okrsr1cTC/Yvx7v2nsfoDCUVslfmaEEPsX+Rm5UNTrO7LGkWOznU
         pxz0Ypiyhu19wx3nkiE89NkNa5ro//KejqbMiwIORZAaoXhWfhhx/ToHrBs5w+4Ztgs1
         QO8DI94xkDojPFSUdFQTJc1hYgA4rdoM3yH4puwySKg2oaIoRbVE+7oVCA8qsy0HaFxO
         tmXamUGxMI3xjkQHvs7DPqWBVvNT5P8O8MkeSZv4CfYU62LuhE7DI+H7NJ7YZmV6gf+u
         NyqawDXcjwSBw9eSSuG+madk8XLufAtBwchrhr31Gtry4Xi46ktcXjcPqdISMzrr+lxT
         eX0Q==
X-Gm-Message-State: AAQBX9e5ujUQ9+pPpeQ6vXYU3PV7CL7eZjLdc05clSFVZ5aAJli8XfSc
        LkSWebrebmG0eAJKF1Go9bitsA==
X-Google-Smtp-Source: AKy350Z6TMKljX6n+0Qj1JlrHMEQEsGP1keeSKPgK3j8/l06MtFFNYR9NxLb8ZpxGjngzuF7RkQkiA==
X-Received: by 2002:a17:906:4f8d:b0:92b:e3f0:275f with SMTP id o13-20020a1709064f8d00b0092be3f0275fmr125741eju.40.1680813081529;
        Thu, 06 Apr 2023 13:31:21 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:21 -0700 (PDT)
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
Subject: [PATCH 03/68] hwmon: adm9240: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:29:58 +0200
Message-Id: <20230406203103.3011503-4-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/adm9240.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 40e3558d3709..9eb973a38e4b 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -731,7 +731,7 @@ static const struct hwmon_ops adm9240_hwmon_ops = {
 	.write = adm9240_write,
 };
 
-static const struct hwmon_channel_info *adm9240_info[] = {
+static const struct hwmon_channel_info * const adm9240_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_ALARMS),
 	HWMON_CHANNEL_INFO(intrusion, HWMON_INTRUSION_ALARM),
 	HWMON_CHANNEL_INFO(temp,
-- 
2.34.1

