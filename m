Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859CB6DA313
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbjDFUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbjDFUcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:32:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FDEBBB1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j22so4224327ejv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7Jy8Z4lQeZ0wRB6o7UIjx/s2l2tRer+BWQLAS8zWPg=;
        b=Z2eFE6i7URGSrUcq19N/qYIU6025nFLK2hWRYbP7q/Cq06Q69LTeZs5RMcQTIMXLVb
         3GHpjVPXAqoVVTOw6JK42HXPDXsTbbsqk4Kwz1CSpH2dicwn7L3p65C+xVDebLPONsHT
         pHUTiFhJhi53VA8QEY6qBY9w2OgxhjcwL+GG1X7ApeF/CYuxstrcEuf3/hopgWFiFrOI
         weqXUj7Jn1UWWf1nKdrL/UU31no/btv0AYqzRv3ZMmjd6QfDg6RiR0NS7benxEF+sQK6
         R1mBFXwD5ecjSe6BvqnE5orT7bskqLCxT8XxJ5oeu+D3fsYmXXR4GBDYcPO6jVEBvqia
         nBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7Jy8Z4lQeZ0wRB6o7UIjx/s2l2tRer+BWQLAS8zWPg=;
        b=byTq8X1XQci/QtOPa9OP2qyF069C11PVeiNNX9+BEVM/CLIvtsWqixJKQLeNVqDalO
         /cMyeNnQPlYZYezbb9ion5upN25rr9v/+0c8pchYfogMjGXgL1SVCs49AxBvOJjAmzwa
         ynZvTqZN+5XtVtPdZuwHCajjW+wOUu6eehoUM92TITNidH85b51CpHzm0tyJuhFSqlN9
         wZYRv1HbnwQeiDQx+/1F2bFBaFVLIQYNgxf11GDy/eKQQMILbdRhlkuuxdpNVkGprCIC
         +qOqOobIEWcrM3aibl+EloZ107x/cqbhF0gjfnZ4cHY6yh/v1hqnD1bBJdjxgQGZhqpE
         mVlw==
X-Gm-Message-State: AAQBX9eVZz+b5Rl/IU+/DVS5c2ZecML/Ss97VgCpJDeScAkiHOG4f0Nn
        N4DgbIdVU70Md5547GW8ki8ZbQ==
X-Google-Smtp-Source: AKy350ZWpcLNtPVNGNTGeWcT9D6JcdnabpEIq7kEjhcu9FSp1PxTjFsVhQwwsMEPT5I+96ZRKvmQ6Q==
X-Received: by 2002:a17:906:6046:b0:93e:9362:7607 with SMTP id p6-20020a170906604600b0093e93627607mr129978ejj.20.1680813121112;
        Thu, 06 Apr 2023 13:32:01 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:00 -0700 (PDT)
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
Subject: [PATCH 20/68] hwmon: ina3221: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:15 +0200
Message-Id: <20230406203103.3011503-21-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/ina3221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index f3a4c5633b1e..2735e3782ffb 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -650,7 +650,7 @@ static umode_t ina3221_is_visible(const void *drvdata,
 				   HWMON_C_CRIT | HWMON_C_CRIT_ALARM | \
 				   HWMON_C_MAX | HWMON_C_MAX_ALARM)
 
-static const struct hwmon_channel_info *ina3221_info[] = {
+static const struct hwmon_channel_info * const ina3221_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_SAMPLES,
 			   HWMON_C_UPDATE_INTERVAL),
-- 
2.34.1

