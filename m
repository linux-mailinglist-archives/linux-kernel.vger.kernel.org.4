Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC676DA345
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjDFUe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbjDFUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:34:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C026C164
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sg7so4216327ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ9T/kpTs3+G1fhFIIx9oKlSAleOFgKL5NAv0H+g2QE=;
        b=LaBtgceZE8cV6EyJxI34ydQeqmL2JrBiiWsn3ljlZadN0XYLm7dNSfZ8T2h7UC7VSY
         R9iZRsxoetgZjnylmORQEdDnSHn343WSLF4dOBaoqkVgRW6dtZ2faaea4Kt8geQPfDek
         /EwK30ybidaDD/kGorrww59rn3A2FTkEbUot+QlP7YzQtM2UpQAcJVut2PtnALeUklta
         dTsI92V3Uimpw1MV1wMDiPWs61lB7jEYVWygbgNBDtVSGxMsK2MZlztYUo+PXECn4IL/
         Ku6OIg7VNoAvLLvyl1xcyz4St3iUxms9yT4uLNi7quHCHlt+jC8Gqr+654B8kSikeLAP
         FzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZ9T/kpTs3+G1fhFIIx9oKlSAleOFgKL5NAv0H+g2QE=;
        b=K1Y45RRU1PCMxJyLV9x089V8k+DvtajhuVS5tcTox5QDj6KI9kst/y2+K7RMQiHdX5
         GeUDxuvIOF++vo8/S59AMmRyzp0paQ8VpnZn4/9U9mRBRdE3Kt7299YGLPkJF1duN3yn
         JVokeneZ9V4Yu8L2/UA9HBd/Rclcq3JQnca0cOxgCrB6nJGsFui1VdCDHxyVa4yQw9C6
         bNPwFhzvRTabHjd9jZ9YElhXNd3IKP7VEnoMiL/OX9fn0t77lmcZUMBROsVwHc9XmtFm
         OROJgFf1E+i9kz0z0rhBERXDucifyN2+avVBFcl/BnTD8wQ0oIqWnCAeE2VEkj1Ggxre
         acqA==
X-Gm-Message-State: AAQBX9dB3gCoIaspBFUe4eNi5VX9QFr/yMAjXOv+o7tQuk8QFnuogLSR
        zFyxkNJSCrLOD8aY5mNbHCLEQA==
X-Google-Smtp-Source: AKy350bzSrWUeiQT+mO4fswYuEyv5WnNzuhH3RCOB7Fm42Z4puqXwvSFTWLi8fBKTQEgfQDSFBEQfw==
X-Received: by 2002:a17:906:c9d7:b0:933:1b05:8851 with SMTP id hk23-20020a170906c9d700b009331b058851mr170737ejb.16.1680813157439;
        Thu, 06 Apr 2023 13:32:37 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:36 -0700 (PDT)
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
Subject: [PATCH 35/68] hwmon: max127: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:30 +0200
Message-Id: <20230406203103.3011503-36-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/max127.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max127.c b/drivers/hwmon/max127.c
index 0e21e7e6bbd2..49de1d2be294 100644
--- a/drivers/hwmon/max127.c
+++ b/drivers/hwmon/max127.c
@@ -285,7 +285,7 @@ static const struct hwmon_ops max127_hwmon_ops = {
 	.write = max127_write,
 };
 
-static const struct hwmon_channel_info *max127_info[] = {
+static const struct hwmon_channel_info * const max127_info[] = {
 	HWMON_CHANNEL_INFO(in,
 			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX,
 			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX,
-- 
2.34.1

