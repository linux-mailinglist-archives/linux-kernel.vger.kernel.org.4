Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D06DA2F9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbjDFUcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbjDFUcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:32:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8499012
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l15so4218578ejq.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kO+PL2OFiPmkOUfRzx6T8b5f8KU+CAGl37StCrMXYs=;
        b=lYo5bC7iQfW8JnfvljadSqJdwd+jSfv9/x+oLITfhU9jsiq6GDzYZ1VDzUKfmv3LmW
         Ici63XQmaGqd8hcJaUwb+omhio2Z3bnDvX8bWMMMMDbil9f5gvNd8ufl2qUq9b59mA4A
         5WagyI+jE8NPsww/pU2d3IJqVrejUStThru5Dfwv8oj40mBP1D6yZNx6nb19oowt21+n
         gQ68nf5/FjDx9z6b6VOfTVk7JUEt4YeyvrMTMA63d6c9OBXhmvVfqEWtSUJbEimAIe1d
         yy8dLmraQMmNdye7f7BtbBUyhFLKSN5PPrjuCjXeZFt8fZunMo3egoNDLE6yhLy/g4YM
         bwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kO+PL2OFiPmkOUfRzx6T8b5f8KU+CAGl37StCrMXYs=;
        b=BwBZWnKfLmY++aj4thdx7Vaa7Y0qpN6dpl08ZSyFw/w9AZfK10qu3z3ltSKJDrjamT
         soW97aOTLyKMV3Q4sSYLBHyxRf7GyNouijKJ8905dB/C0ZssqCaT7RJGOKzr1nq0ql1T
         yu/jk5gVKW1UM0iffAl+PlUanFPEwTCrSvtd7h4H4vQ1ZF2eCJCBGZPa9+hUr+3tUTzr
         4jSkWDeDE3AGNcHjud20wu2MsPeD2A4e7Dd5LoDd54Cwd+YU2Td3sRu9rFKRMIlDwUZs
         nJJnEi/4CzmMaAcTjAC4j5JQwpXb7c+TwOg0DzcWashd9h33zPOUjYLaCZb/ed1YL8Yc
         iJ+g==
X-Gm-Message-State: AAQBX9dxxtcBGaUBv21c7lbSJekY4yjsdnZtmtcgDkGy3nwMxrnVwSYn
        soHzdTtBFvQoBPb3HDvZ62NSMQ==
X-Google-Smtp-Source: AKy350YcLjLUUz1vvV2Oec0ITUhNxaSebo05M98PAAOHSS8hMv2/No8ivJPosNn6kB+9Ksg+aAx6JQ==
X-Received: by 2002:a17:907:a702:b0:934:60b1:a4b7 with SMTP id vw2-20020a170907a70200b0093460b1a4b7mr93238ejc.51.1680813106993;
        Thu, 06 Apr 2023 13:31:46 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:46 -0700 (PDT)
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
Subject: [PATCH 14/68] hwmon: drivetemp: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:09 +0200
Message-Id: <20230406203103.3011503-15-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/drivetemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 8e5759b42390..e73b7bfc6af3 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -526,7 +526,7 @@ static umode_t drivetemp_is_visible(const void *data,
 	return 0;
 }
 
-static const struct hwmon_channel_info *drivetemp_info[] = {
+static const struct hwmon_channel_info * const drivetemp_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT |
-- 
2.34.1

