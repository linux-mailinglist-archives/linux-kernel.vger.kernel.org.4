Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B356DA333
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbjDFUeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbjDFUdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:33:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C29C160
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qb20so4219640ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDyUmonauZ8nm6n5G/LkXb2fBKeLEqNmyMFXN+56R/0=;
        b=YMS5yzUgMpMduF8w1083GJyyM6G6mP2dHeTaOtQucecobZTroK8AAqIAmDn6/gJfrG
         ixVUYsEiSU+LJT4zWFOe7Ptebv771vH7Vay68cGCplldTOwBeRcj1S0c47TJagJd9Ab0
         B0VIJAcrQ1aVhxBoW5MBMLiegaF47uXPlYUF0SJ6QCNdhhkinlV8OPOngm5VKzqrURVS
         50xVbFPq8CtFxAmoA7S3p7KME50ER3N2prf22Ax4x/dy9mtv9rg/XqrNnj4kjT7Dqwx/
         dxV/zlM/71fKfQn5h7ZzgAVkNSeuHav8BPytem0sIENRe/dSezZUULJjjpodkHqvG/Ex
         l2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDyUmonauZ8nm6n5G/LkXb2fBKeLEqNmyMFXN+56R/0=;
        b=XPOmCG5rLnQ0Oz7dsIzX7OVFUzUyALNeerwJpJfuBVRkCyQlUV0uMiot115VZsipuI
         7vTT510WQJgdDzk1ByJEYrnXPH23iCto6+rxdTt+0Gh40YU6H/Zi2niCcByZEC9LfYps
         xFt86+pR+tinrU/wwLixGu8P8RYlMfjguUVpUTn4Td0rlm3hB16t05vMQrIvC5GTKPAa
         WfQ6hq7Ddimq/7Gpnj275DE5OF2h3w0H3QtZl6NjZ+w2tH3EIl/Q7eK/R3yF1Ji41+PF
         g5xPYBDa6fkbSYyOh6FFJZ3jQaSddnlrBjhlO2CVQ83LVUSRUVQd/v9tJsvAGqJwK93Z
         N/dw==
X-Gm-Message-State: AAQBX9elFOXY90WIMEWTeYXVgpw2iDVAYhifQBNRVJ0MKb/dre2k6GKo
        sd+EWN7pkze3+7B8/IA0GYg1uQ==
X-Google-Smtp-Source: AKy350ZF8nPTGR4RDE9lm1XOWYeECS7YDWeUJSraSmbL162uZx4DgwowpRCXrEnbKVyGKSKX+TbtLw==
X-Received: by 2002:a17:906:80c9:b0:931:2306:f363 with SMTP id a9-20020a17090680c900b009312306f363mr150222ejx.21.1680813145115;
        Thu, 06 Apr 2023 13:32:25 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:24 -0700 (PDT)
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
Subject: [PATCH 30/68] hwmon: lochnagar: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:25 +0200
Message-Id: <20230406203103.3011503-31-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/lochnagar-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lochnagar-hwmon.c b/drivers/hwmon/lochnagar-hwmon.c
index 8b19adf2eeb0..9948e2f7208d 100644
--- a/drivers/hwmon/lochnagar-hwmon.c
+++ b/drivers/hwmon/lochnagar-hwmon.c
@@ -321,7 +321,7 @@ static const struct hwmon_ops lochnagar_ops = {
 	.write = lochnagar_write,
 };
 
-static const struct hwmon_channel_info *lochnagar_info[] = {
+static const struct hwmon_channel_info * const lochnagar_info[] = {
 	HWMON_CHANNEL_INFO(temp,  HWMON_T_INPUT),
 	HWMON_CHANNEL_INFO(in,    HWMON_I_INPUT | HWMON_I_LABEL,
 				  HWMON_I_INPUT | HWMON_I_LABEL,
-- 
2.34.1

