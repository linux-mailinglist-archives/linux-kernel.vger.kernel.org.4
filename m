Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85994613AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiJaQFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiJaQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:05:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050FDFCA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:05:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v1so16620776wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:message-id:content-transfer-encoding:mime-version:subject:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMcMEvm8w0Wh/uUg9tQfpvnyjGSnqr3OvUHb1KDw93o=;
        b=wECf1T/hIprOVUIsVIa0UREMNhSTOAIqnqQYSEFB80mGeffnIa89iRuURvIgPdJyld
         l/SMCaMmg3AwsliTcYeVdiCk90bnMY0lOEeiBrJyTWSROPB5CxWzSJzPpsPwnH33pRDF
         uh3FcEUhf0UBDW0OB0W9Qt7hLGixoq4mqE1GlXSQzSa0wMHuWhcMfsbNFujkQ9f3wCn+
         IXTsAhJqU7VdngqVFdCrOSShclp5ClEubDIAxTmt/4xGK5a75ag1HD+RYHN6v2WcUNmH
         ebP5VjvN66Ecq5e4amJuj1w2bkPuzk/FpC4kc3Qkb+FK/h4Mn2VzWvgmrINM5Muhijfe
         dbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:message-id:content-transfer-encoding:mime-version:subject:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMcMEvm8w0Wh/uUg9tQfpvnyjGSnqr3OvUHb1KDw93o=;
        b=JhR4NRUYRglk8HUjYCYeqHhG9BHNVtnIipxn9YwrcmQmWcBcGn9nhYypv0YUreVVxo
         vLx2/kiE+IRSJSke6abi8vdTF/mW93fUtOIPQJma11T5bQ3bC6yTm8ea9N+mWBXHa86E
         TAC8tbpcniy4sbdLXppKEX4ULObb6Qwp9CxVeqvzBo30WuI6dZXet5HOftyMCH5SVWwd
         NIWZ/n527gKWw9lXcwvBE7B4gAU/wApMbWTe+YSnRH8IMWt3WrTX5emYV/WjKfP1dqrt
         OH6pEUn5FCIcfyvOyXLTCvxuNn7LQgWJ1ynkUw18D1JIVBFlUJNM/ErlYOpZFQmA00xF
         QaLg==
X-Gm-Message-State: ACrzQf0rjjalmV7z6cCDYhYX5vTTwMDVz4lcko1oNRSIS8XoEe5zqpVX
        TSN+2ocjX9GQCXTIcBb5rJFhww==
X-Google-Smtp-Source: AMsMyM590cIRFkjODWNxwVVGHGZd5giq9uN++iUfG9ZTF7Xn08soE9JcRIp5EBhS977RbaA9zasSYA==
X-Received: by 2002:adf:f5c4:0:b0:236:c419:710f with SMTP id k4-20020adff5c4000000b00236c419710fmr4787510wrp.56.1667232310598;
        Mon, 31 Oct 2022 09:05:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003cf5ec79bf9sm7701997wmb.40.2022.10.31.09.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:05:10 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 31 Oct 2022 17:05:07 +0100
Subject: [PATCH v2] mfd: rk808: permit having multiple PMIC instances
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221025-rk808-multi-v2-0-d292d51ada81@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set each cells id to PLATFORM_DEVID_NONE to allow multiple
instances of each cell in case multiple PMICs handled by the rk808
driver are probed.

This fixes probing a RK818 and a RK817 on the Odroid Go Ultra
devices.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Cc: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- replaced -1 by PLATFORM_DEVID_NONE
- Link to v1: https://lore.kernel.org/r/20221025-rk808-multi-v1-0-c07b7cf3fd67@linaro.org
---
 drivers/mfd/rk808.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index e00da7c7e3b1..c9337c1fd748 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -137,58 +137,64 @@ static const struct resource rk817_charger_resources[] = {
 };
 
 static const struct mfd_cell rk805s[] = {
-	{ .name = "rk808-clkout", },
-	{ .name = "rk808-regulator", },
-	{ .name = "rk805-pinctrl", },
+	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk805-pinctrl", .id = PLATFORM_DEVID_NONE, },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = &rtc_resources[0],
+		.id = PLATFORM_DEVID_NONE,
 	},
 	{	.name = "rk805-pwrkey",
 		.num_resources = ARRAY_SIZE(rk805_key_resources),
 		.resources = &rk805_key_resources[0],
+		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
 static const struct mfd_cell rk808s[] = {
-	{ .name = "rk808-clkout", },
-	{ .name = "rk808-regulator", },
+	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = rtc_resources,
+		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
 static const struct mfd_cell rk817s[] = {
-	{ .name = "rk808-clkout",},
-	{ .name = "rk808-regulator",},
+	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
 	{
 		.name = "rk805-pwrkey",
 		.num_resources = ARRAY_SIZE(rk817_pwrkey_resources),
 		.resources = &rk817_pwrkey_resources[0],
+		.id = PLATFORM_DEVID_NONE,
 	},
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rk817_rtc_resources),
 		.resources = &rk817_rtc_resources[0],
+		.id = PLATFORM_DEVID_NONE,
 	},
-	{ .name = "rk817-codec",},
+	{ .name = "rk817-codec", .id = PLATFORM_DEVID_NONE, },
 	{
 		.name = "rk817-charger",
 		.num_resources = ARRAY_SIZE(rk817_charger_resources),
 		.resources = &rk817_charger_resources[0],
+		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
 static const struct mfd_cell rk818s[] = {
-	{ .name = "rk808-clkout", },
-	{ .name = "rk808-regulator", },
+	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = rtc_resources,
+		.id = PLATFORM_DEVID_NONE,
 	},
 };
 

---
base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
change-id: 20221025-rk808-multi-65dd03a92705

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
