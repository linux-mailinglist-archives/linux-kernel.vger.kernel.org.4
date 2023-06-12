Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85F72C33A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjFLLjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjFLLiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46190658D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso4832613e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686569470; x=1689161470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq7NS+iMzs82fomvoYuidxYVGVMWQQf8sysX64TDkNs=;
        b=EpTSnNpebF6RNHMi7hhR1Rc9CBjLQijktT6OPL8V00DFjeXsu4j+bxPvA7nQ/3lzSv
         FmdlUMEtZdkle4tew7XltHFvviIEl9WjG9C9GoDTRYCh1PFUVk7fBHiCBHkeHDhZaQjs
         n9wtRqhnsOMq4/YnZyVe2GGzAQs7C0Q+WmFJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686569470; x=1689161470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq7NS+iMzs82fomvoYuidxYVGVMWQQf8sysX64TDkNs=;
        b=OuI35JnY3OzaNdzZ8kb4JmyTyWadzIQs3l86Z3YyKNqgjLx4NkkcCx+OSZZZVf5iAp
         bvSS0qBMeak8xDP/NLW1UwmFNvZmc4ZYmizKIX8yGc8kSBRFGeo4nNIdth57RYSJ4Wg2
         yV5rFQ4pAjddHwOz91WHcLSMdCATZzNVjjzlAeHwYA5WquwGLp/BhxVrvWKQLZiZcXAK
         6OOO7uHa0or4MgnIxt62bv3glpAaZaczt8SJvAimGaKXVl4rwvJ8NYRVRwwqWhibZ5oH
         pAmSpBiE3131P6T4E1VcOntyKYzNwJxUi6cWTB04ZL0GZbIYuBz9ZkKkP2VB4RGAE+ph
         eMjA==
X-Gm-Message-State: AC+VfDz8a5taiOeHQuIlLWza32B3wOZe9KwGeJzIrIiAF1y11jjfE8DI
        ScosvBL1GOTM8pSyttapgCyvSw==
X-Google-Smtp-Source: ACHHUZ5N8xpIBWvNjUIko64UBZMsqLNzVNmlWsaXSYDuzwyjut4I6r+XRV1RCddpqnJHYdIvLcYcqA==
X-Received: by 2002:a19:5f0e:0:b0:4f4:d83e:4141 with SMTP id t14-20020a195f0e000000b004f4d83e4141mr4200387lfb.50.1686569470594;
        Mon, 12 Jun 2023 04:31:10 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w26-20020a19c51a000000b004edb8fac1cesm1399320lfe.215.2023.06.12.04.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:31:10 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] rtc: isl12022: implement RTC_VL_READ and RTC_VL_CLR ioctls
Date:   Mon, 12 Jun 2023 13:30:55 +0200
Message-Id: <20230612113059.247275-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up support for reading the values of the SR_LBAT85 and SR_LBAT75
bits. Translate the former to "battery low", and the latter to
"battery empty or not-present".

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index cb8f1d92e116..1b6659a9b33a 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -203,7 +203,48 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return regmap_bulk_write(regmap, ISL12022_REG_SC, buf, sizeof(buf));
 }
 
+static int isl12022_read_sr(struct regmap *regmap)
+{
+	int ret;
+	u32 val;
+
+	ret = regmap_read(regmap, ISL12022_REG_SR, &val);
+	if (ret < 0)
+		return ret;
+	return val;
+}
+
+static int isl12022_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	u32 user = 0;
+	int ret;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		ret = isl12022_read_sr(regmap);
+		if (ret < 0)
+			return ret;
+
+		if (ret & ISL12022_SR_LBAT85)
+			user |= RTC_VL_BACKUP_LOW;
+
+		if (ret & ISL12022_SR_LBAT75)
+			user |= RTC_VL_BACKUP_EMPTY;
+
+		return put_user(user, (u32 __user *)arg);
+
+	case RTC_VL_CLR:
+		return regmap_clear_bits(regmap, ISL12022_REG_SR,
+					 ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 static const struct rtc_class_ops isl12022_rtc_ops = {
+	.ioctl		= isl12022_rtc_ioctl,
 	.read_time	= isl12022_rtc_read_time,
 	.set_time	= isl12022_rtc_set_time,
 };
-- 
2.37.2

