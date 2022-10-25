Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE89560C942
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiJYKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiJYKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:01:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BFDAD996
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:54:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id jb18so4518459wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:message-id:content-transfer-encoding:mime-version:subject:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fe2kZ1GOC4RiCKtckIokXCknoVb38npm9cAAuR5C5A=;
        b=IxUNwaY3v4m9SoQVwB6LN/6F+sgBLnEMl0dkolNGUME9nZZb00snxD4FjlFxE7fVk5
         O506VbGM4HJ6q3ucQI3++CZoGw6QAxx9qjOGvFJX12BM7ItvlmmxDkrKs1V8oCVFjI3N
         7sRQIH77ZTON+QpNsGTOhA4XhlkpvUo6TgKfotSPeEtxVvpWyvuy7yWLMHVfnd5nSHZX
         RFoprWKgC2Xr3UGGzjx/9A496/PnTpdYgoSn7l3tMNyOuoxoGLaEvMqQhpfROzlThQ1v
         6JEtP5/GHEzNduLSG1FwMvcGSVs/XbsTXcZoyfzdjhJc0PYHW3S3+8DTmonFUf/rgRUA
         BdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:message-id:content-transfer-encoding:mime-version:subject:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fe2kZ1GOC4RiCKtckIokXCknoVb38npm9cAAuR5C5A=;
        b=mO2ON+vmmqs/AmxsF7d+tV2PrlY4uwR9Q+lRb5HwqzpMu90k1Q5uUtcH1tvpktELEq
         Mkaf8yWmw8BXvSxky+LbRfrgz9bahq6Q2VKE3AR18icw7xoWZNkLubgt1JfUE1p4wxvd
         nUoOk8Es3ACCu0oc3Sw2GgsxMZWG8G8ZYArRQgcAMAerNdfo5m0eux7EYZnDAnwxn3fs
         qzwpMuA8BEbBkYi0DL9RgVLgOqjcL7FXMf41kUl+TPyJN5TkV5LPTnVDQ/gO+8uRZVXp
         +To/oqJOHR4VLIrOeIZ7nYbLYbwgO3Tx2N/gzgTLCcjNjBtNtnPIgpHqCv4tLYgvsJNh
         3+DA==
X-Gm-Message-State: ACrzQf1gLFtwaLMZppok70RHPFJfjQSLMr/JTDxDUDNUXTGmoQGmC2ss
        pPe/DtnW+VBd+6e8G71E1xSAsPGDE6bg2Ab1
X-Google-Smtp-Source: AMsMyM7wE5cD6zjopUVK5OWTqEchvEkmtXnLeY/31tbWlLQfoy5Ae1cP/LMHru9cmXn+sjQ2G5jIhA==
X-Received: by 2002:a05:600c:3d92:b0:3cf:3921:d8ad with SMTP id bi18-20020a05600c3d9200b003cf3921d8admr4831493wmb.15.1666691673049;
        Tue, 25 Oct 2022 02:54:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 130-20020a1c0288000000b003cf37c5ddc0sm2195204wmc.22.2022.10.25.02.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:54:32 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 25 Oct 2022 11:54:29 +0200
Subject: [PATCH] mfd: rk808: permit having multiple PMIC instances
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221025-rk808-multi-v1-0-c07b7cf3fd67@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set each cells id to -1 to allow multiple instances of
each cell in case multiple PMICs handled by the rk808 driver
are probed.

This fixes probing a RK818 and a RK817 on the Odroid Go Ultra
devices.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Cc: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/mfd/rk808.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index e00da7c7e3b1..b9cfd249912d 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -137,58 +137,64 @@ static const struct resource rk817_charger_resources[] = {
 };
 
 static const struct mfd_cell rk805s[] = {
-	{ .name = "rk808-clkout", },
-	{ .name = "rk808-regulator", },
-	{ .name = "rk805-pinctrl", },
+	{ .name = "rk808-clkout", .id = -1, },
+	{ .name = "rk808-regulator", .id = -1, },
+	{ .name = "rk805-pinctrl", .id = -1, },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = &rtc_resources[0],
+		.id = -1,
 	},
 	{	.name = "rk805-pwrkey",
 		.num_resources = ARRAY_SIZE(rk805_key_resources),
 		.resources = &rk805_key_resources[0],
+		.id = -1,
 	},
 };
 
 static const struct mfd_cell rk808s[] = {
-	{ .name = "rk808-clkout", },
-	{ .name = "rk808-regulator", },
+	{ .name = "rk808-clkout", .id = -1, },
+	{ .name = "rk808-regulator", .id = -1, },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = rtc_resources,
+		.id = -1,
 	},
 };
 
 static const struct mfd_cell rk817s[] = {
-	{ .name = "rk808-clkout",},
-	{ .name = "rk808-regulator",},
+	{ .name = "rk808-clkout", .id = -1, },
+	{ .name = "rk808-regulator", .id = -1, },
 	{
 		.name = "rk805-pwrkey",
 		.num_resources = ARRAY_SIZE(rk817_pwrkey_resources),
 		.resources = &rk817_pwrkey_resources[0],
+		.id = -1,
 	},
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rk817_rtc_resources),
 		.resources = &rk817_rtc_resources[0],
+		.id = -1,
 	},
-	{ .name = "rk817-codec",},
+	{ .name = "rk817-codec", .id = -1, },
 	{
 		.name = "rk817-charger",
 		.num_resources = ARRAY_SIZE(rk817_charger_resources),
 		.resources = &rk817_charger_resources[0],
+		.id = -1,
 	},
 };
 
 static const struct mfd_cell rk818s[] = {
-	{ .name = "rk808-clkout", },
-	{ .name = "rk808-regulator", },
+	{ .name = "rk808-regulator", .id = -1, },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = rtc_resources,
+		.id = -1,
 	},
 };
 

---
base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
change-id: 20221025-rk808-multi-65dd03a92705

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
