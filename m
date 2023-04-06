Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45C26DA301
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjDFUcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbjDFUcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:32:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E089BB80
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-4fa3ca41383so1404751a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55wB6FwAFZR2J5GJ5M7aLn7D6PzulcN06rOSgXVQC4g=;
        b=EN2rt01WdBFTfSRBAls5Y9NM9nGaiaOcOOWu7OR6lKgUGnk0HwhDZSKRgwtXQBEk6H
         4LP/Z/rIIPuYLly2xAQm/zGWSnVonmN+shsh4KytuvDM++yV6T9RP5gjpxRM898KCLNc
         7pR2KwQ0n+0BkcM4u3crCcPJOVO69dmEzdmDwYlMHOjsmD+7YAnFBP3BJP0uiCxlEqOL
         s6aEgmXJSPqPouPrcqFMWR6YUIDONYoTO98GEm/Bl2xe+tQ3tXO2dsLp2zEI/y6QWcx0
         4hRAAiWJx+Un89DSN7t8fqL4QbGj1Q+02Ga3JTwbZtmIGZhVEhM7ZePOLWeX62uVqhT9
         x10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55wB6FwAFZR2J5GJ5M7aLn7D6PzulcN06rOSgXVQC4g=;
        b=vBwvotErDmSbNWKDvjGRY6Wi+ChEkLrdIXRPAPhf7ybwKTqvFVz23ehsm1DkGBuwM3
         WhCMW29owauAoyyNbzPDNK4QV7OS7slaRf9xTetw2l0jdwLyirLMyphjB0Clp7IQlQy0
         R2XvDkaw8seMdySgB+bl1GMM6SbW7032qyD5jd2+/TU0/tuDRkGkC9nBQNCbn/41POsR
         JueKAWJnehPhyuuKk7Jlqo3LfRIMvPRpG+6z0ldb+todT/cb8uthrYa9Wlt5UYPWBFRc
         2AfDGMBwaCumULC42Cg74kSX80ybMvk11GysJeXcotKrrJkURXStaTo7oGWx2Ls5KpVG
         kFPw==
X-Gm-Message-State: AAQBX9dWr2pELwGD6vca4PR8+xCoF+G9ROHzgUZQWLhG7ANWurtTmL1d
        nsJ/aK4humYR2pCpPFzmz/0LcA==
X-Google-Smtp-Source: AKy350bRWnrdy2ZCvoo0Syhpuo+hNru3eCGoBtu3JdLZjamkW5ZAZx1rYF9xlQuD0w6bpQtTeZFYtA==
X-Received: by 2002:aa7:c602:0:b0:502:22fe:ef3c with SMTP id h2-20020aa7c602000000b0050222feef3cmr603299edq.41.1680813109276;
        Thu, 06 Apr 2023 13:31:49 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:48 -0700 (PDT)
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
Subject: [PATCH 15/68] hwmon: emc2305: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:30:10 +0200
Message-Id: <20230406203103.3011503-16-krzysztof.kozlowski@linaro.org>
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
 drivers/hwmon/emc2305.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index f65467fbd86c..723f57518c9a 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -479,7 +479,7 @@ static const struct hwmon_ops emc2305_ops = {
 	.write = emc2305_write,
 };
 
-static const struct hwmon_channel_info *emc2305_info[] = {
+static const struct hwmon_channel_info * const emc2305_info[] = {
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
-- 
2.34.1

