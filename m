Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B076DA312
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbjDFUdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbjDFUcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:32:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF25DBBA1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:32:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sg7so4212954ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqwHPALogIS8o9t9XI2PCmXxA830L7wP+ne1/9jP4lo=;
        b=iv6ANrjKsFP0ZigiJpgOTigvQSupXqaPpqtdag1G16pm8J24/j8ce5L59ndg9RVJ8a
         sl8QwkCQWTZa9O0Gn+bvzggaqpnbYHvfeyTUgLOCg+ZDW5yNs3g7jACg1hxEmrqP7cyZ
         c+fnfEGydnbknteHJhk/qtPjj/w4qg5aJpXiiGry0lxJB+8tYqBOUrMBh3As3EW64IPN
         drOMGpdkrx43DerEn2p1hSLmMTEvdOhbYYG3ELOksDBAZeZLFmUxAShY+k8uUi1Z+sBm
         NNiZ2ZDu6CtGDXTvqDsNFktW/F/zGay+uRP5ntdsrwTrDA+k4/CDeQhtEoXayPoNfXj6
         N3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqwHPALogIS8o9t9XI2PCmXxA830L7wP+ne1/9jP4lo=;
        b=VjjXAcberkydOY7sMLS6NXM+hY8DG5Nh5OKRrY3/dZwltpwtIEGHhQy8I2wIkgBazw
         WimkRGGgGGCpf8fFDTsD9wabw/8UMpVq7kcMybgKoPrzThRJgovzD15v96NsxdIu5p8A
         fOqgnSO4jGh3Iue9t9bnvh0cOplPwQsIPmq0aU/ppDMz92ktToxO3VSka2LNzg+WCqAg
         +GFH0JTCcCnCiXNt+E0i7e9PhpqdFavkj3V3UMz+UT77pR2yB9dH7Mpfeqdycf1gpfRY
         g/qT1ELmg0Y+iQEzA01xkaXRkXekd7KVshZTFImYIxw9uAEfgCyCmbVQs7assdQOtpbg
         WQjQ==
X-Gm-Message-State: AAQBX9ck4R2rNXH6zbwk/6GydgpoS2QlqsMdha0giWTYh3+9I4BaPnJh
        kT5CNJfxk6DZEhyrP7FkBBNPSA==
X-Google-Smtp-Source: AKy350YNTXkM6xAyWCAEyvanHLn+j8HqvbNU+aogRqOPOmE/HfD4bNGokqkvcOYR0LGhqiUrpvHSPQ==
X-Received: by 2002:a17:906:260d:b0:93b:62f:82a3 with SMTP id h13-20020a170906260d00b0093b062f82a3mr238281ejc.6.1680813118839;
        Thu, 06 Apr 2023 13:31:58 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:58 -0700 (PDT)
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
Subject: [PATCH 19/68] hwmon: ina238: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:14 +0200
Message-Id: <20230406203103.3011503-20-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/ina238.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index 50eb9c5e132e..8af07bc0c50e 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -501,7 +501,7 @@ static umode_t ina238_is_visible(const void *drvdata,
 				HWMON_I_MAX | HWMON_I_MAX_ALARM | \
 				HWMON_I_MIN | HWMON_I_MIN_ALARM)
 
-static const struct hwmon_channel_info *ina238_info[] = {
+static const struct hwmon_channel_info * const ina238_info[] = {
 	HWMON_CHANNEL_INFO(in,
 			   /* 0: shunt voltage */
 			   INA238_HWMON_IN_CONFIG,
-- 
2.34.1

