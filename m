Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E921C72E3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjFMNBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242477AbjFMNBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:01:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E798184
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:01:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so6694434e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686661268; x=1689253268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur6n0qRjGzRHDGudKm3FuB0Bjxk6aZigQtAmr4SnRcc=;
        b=TfQ+si9zfMC1c2VVHNiGoJFdzNbiFiqOhy0k/qv87c7AZskvHQZAcsGE75D7fsI6UT
         xpU3MM8/fRLVZ8Z4hxL2fRx2LCGrN0vo2xp2CM84wCAUrxlpYIzH/Tb3e54Dvr5T6XOQ
         uPMvUj+0EbrFgQNI6pinpXztygCPyyh95V7HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686661268; x=1689253268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ur6n0qRjGzRHDGudKm3FuB0Bjxk6aZigQtAmr4SnRcc=;
        b=ZIupDFnjBJ+f9rhIE1+E4B2Qd+cebDilVj+TrXWVVRP3KMQxtXJImWD1UmEDIAH/ue
         MaMQn7JYU2ZidnvhjzKpmxTIWhRATaqOcN3OKmGW0NdV+kBrs1qCnxlyYc/6QdIvrKIG
         0Ya7mtXfU9EokGMs2Q35OVAgyyI9nMSEW4sDmRgCJGLuWyhKH9bsYNANPWKqqcQSGnm6
         LEXnIDSF5F9zKyrrxHP6s1Tdm36dRFc1F8L42tM/i28GEeI8bRm1u3zA2glZS8Fz9rSk
         rNdRACxTpOhtDktWW59Z+AlQA2X6KqX6MfHAtJDN6EcL2Jl7SUD3cW8AClNDkVxt8Hz2
         yJTw==
X-Gm-Message-State: AC+VfDyaZ7XQrBf8SFsIQyDhjg4Q7wIDQQEHDA79ENIBj6rSN4iAQ/J+
        KTOKtMATff1poJnh7vkG7Pvqth8+cxl7WwQVWLQsVg==
X-Google-Smtp-Source: ACHHUZ4M1sqvyhut3MbQtjYadzTdq+vm2CkSD8F5AYlwgvuUBEzp0EwJZ1aB9EY22TAAOoHDSgMVOA==
X-Received: by 2002:a19:6756:0:b0:4f1:26f5:77fb with SMTP id e22-20020a196756000000b004f126f577fbmr6027137lfj.28.1686661268430;
        Tue, 13 Jun 2023 06:01:08 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1793786lfl.28.2023.06.13.06.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:01:08 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] rtc: isl12022: implement RTC_VL_READ ioctl
Date:   Tue, 13 Jun 2023 15:00:07 +0200
Message-Id: <20230613130011.305589-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230613130011.305589-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/rtc/rtc-isl12022.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 50bbd1fefad8..bf0d65643897 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -204,7 +204,33 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return regmap_bulk_write(regmap, ISL12022_REG_SC, buf, sizeof(buf));
 }
 
+static int isl12022_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	u32 user = 0, val;
+	int ret;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		ret = regmap_read(regmap, ISL12022_REG_SR, &val);
+		if (ret < 0)
+			return ret;
+
+		if (val & ISL12022_SR_LBAT85)
+			user |= RTC_VL_BACKUP_LOW;
+
+		if (val & ISL12022_SR_LBAT75)
+			user |= RTC_VL_BACKUP_EMPTY;
+
+		return put_user(user, (u32 __user *)arg);
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

