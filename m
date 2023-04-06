Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C7B6DA32C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbjDFUeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbjDFUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:33:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410AC93E4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j22so4225865ejv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WDgIBkollEzDBIBjWhtjP5ugtMko4aj0Kcc2FaKa74=;
        b=R/wx04KxX7kTGS1tkTDAu14ouXso0l5PgJMuS4BC9ZqoTgFumWIY68wpkSHtUdTlIO
         gF2BT/RMDFfHRWEiTPUeuWoo4JOFvGl7cObxgV2+6qm9dkk7RIp2iktkHCnHWNDPqYz+
         0vrhmwkd7YTHzw+T8QjC4SzIidAEMivBBBrmnKmpbPSGjDQxltVG9Gkm/3WCQrY0iUaa
         D20+FPkuIq1jyWZSimsciJJuYFCfZ2LXGh7l1uJB4C6XfZGjqnTuJ9hZ6IDQ0H4FjptS
         QeYOYdf7Hwzh55/ssuHtp90ccijyIeibonJYzVGsV7H9xnxX/WxOuGQ9SR/bt8zj1KiM
         fdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WDgIBkollEzDBIBjWhtjP5ugtMko4aj0Kcc2FaKa74=;
        b=LrAkeg1HeuYh+vRBxEv1QwQEuZjHnq5VLoPlCJ0MqGYhtV0E1oMa+LFSO943VUCOsA
         HQVlPDOaUGiFRy/caGztm6+fbiH906C2dA3qry6fZCqSmFK1I7soSyXqBsJ7FM8IzD9U
         PJEniIYUNhf6HEmO+snz4AN9dEwkZapLBXj3Ig98bRH7gvvYnfAXe5fsLFO7U6hluj6R
         uyXDeKo9gNyCJ4Irsnv+YhxsadwBcWnu1VTKZzrTCfrCuiXztYM+R5qE0PMK0M3L+3/A
         41bmxb9/ABh8lgTpWhn+D/mPvd7BN3jlS9X2+kAuJb48rMs2ZRkVjfsCPysOiM9D9mPc
         TsGA==
X-Gm-Message-State: AAQBX9fBm4aUa/jJSc+K8G/zA/+W71JIsjK1kgU7fJmnOBjowWIuwAV0
        W9DHmgdOiHSthUpD63a3Yd0nWQ==
X-Google-Smtp-Source: AKy350Z2LdQYIdnwn8LF++hSLAjg3GDMSKGQ3iuIRuhmX80GFpyd6xkh5ySgSj0g/RAFei0/4fSjhA==
X-Received: by 2002:a17:906:b05:b0:926:9c33:ea4 with SMTP id u5-20020a1709060b0500b009269c330ea4mr221643ejg.27.1680813139797;
        Thu, 06 Apr 2023 13:32:19 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:32:19 -0700 (PDT)
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
Subject: [PATCH 28/68] hwmon: lm95241: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:23 +0200
Message-Id: <20230406203103.3011503-29-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/lm95241.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index f1ed777a8735..647a90570bc6 100644
--- a/drivers/hwmon/lm95241.c
+++ b/drivers/hwmon/lm95241.c
@@ -409,7 +409,7 @@ static void lm95241_init_client(struct i2c_client *client,
 				  data->model);
 }
 
-static const struct hwmon_channel_info *lm95241_info[] = {
+static const struct hwmon_channel_info * const lm95241_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
-- 
2.34.1

