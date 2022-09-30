Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD85F076E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiI3JUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiI3JUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:20:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A829C5072A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:20:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bu25so5976158lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7Sv5seCRTWybOOOOludWC1A9KTXxVnMAlKH82j49yng=;
        b=lDdeIh0cWxEkskELtP03Xa8NbQmjyC39cByRE9LguZ7etBFGJO1mMkfoIxIHzsDJQc
         1TW2F3Z9ubFF1rlXTndLb2Xrvz1Fvm0ZVHnCjj+la8YDXH0eDnXmLQiAtZZCXIswyVW0
         +VD3R6ol67HKiwfx1kWAt4HUdjV7Q6lLiAJQznSupBUHmrOsfSc/WxEn7Qb1PvtHlvBn
         PRHnSp3IXcDmflioPwMXVQIX+2Ni801Op1Pe7HI6l1xzhQyz3uzDZGzQW5DIylXPRuXA
         qHUhEXxMEPgdxdmChRdP7LpPXTQ5aNWdk9U9VOEdFQ4INt4ueS5XgRCydwWYxPpvIhga
         5dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7Sv5seCRTWybOOOOludWC1A9KTXxVnMAlKH82j49yng=;
        b=rDZglxiG2fdLhbbL/F0LXn8o4AH3H4hCWGItKc52qxENMW77KglwCL8Ff7I2Hau+2B
         Cjo0XAbdhnSe8tidGb3hh65jkMjCj8lV6h+sArY+hkMGx/53sH/k+Qa9zvaBHzHXbcYl
         GjvhxhQJtpmOBobM7LMxMXk1t7eK/b8Ck1WYSr09Dm1qD93seQQHlTc126a/AQx5pxdW
         2OvV7Ae5gQQhs0RmYm3GnlsqdjCMcF/FzK0Wy1AxaEOQu1DMYK5H0JRedSCJ8Ib1BIRA
         f4t70zfAvrEOkYWYwdVxCiRnCy7EEdUtt2xsjQUYsYybJqhbVXfOFZpZb7zrzCJAsv+J
         N10Q==
X-Gm-Message-State: ACrzQf2O3ElvNfazUWOTJKhOx1db9fhhZ/IB8ceZKe7lAfmodPMc3d/w
        A3T8XoJZbaqTPpae2Unq5W4C+A==
X-Google-Smtp-Source: AMsMyM4auLp3LAPf6h4uJworyb16xNE8RvMv9WwpYX6v09WUHaBQx0ZOYHzJXC16Alv7j/0sl81oqw==
X-Received: by 2002:a05:6512:12c5:b0:49e:5431:45d0 with SMTP id p5-20020a05651212c500b0049e543145d0mr3223201lfg.111.1664529609923;
        Fri, 30 Sep 2022 02:20:09 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i6-20020a2ea226000000b0026aba858fbfsm103461ljm.137.2022.09.30.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:20:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Prudhvi Yarlagadda <pyarlaga@codeaurora.org>
Subject: [PATCH 2/2] slimbus: qcom-ngd-ctrl: add support for 44.1 Khz frequency
Date:   Fri, 30 Sep 2022 11:20:06 +0200
Message-Id: <20220930092006.85982-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930092006.85982-1-krzysztof.kozlowski@linaro.org>
References: <20220930092006.85982-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 44.1Khz frequency by dynamically calculating the slimbus
parameters instead of statically defining them.

Co-developed-by: Prudhvi Yarlagadda <pyarlaga@codeaurora.org>
Signed-off-by: Prudhvi Yarlagadda <pyarlaga@codeaurora.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 64 ++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ac84fdc2822f..051ac5cba207 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -944,6 +944,54 @@ static int qcom_slim_ngd_xfer_msg_sync(struct slim_controller *ctrl,
 	return ret;
 }
 
+static int qcom_slim_calc_coef(struct slim_stream_runtime *rt, int *exp)
+{
+	struct slim_controller *ctrl = rt->dev->ctrl;
+	int coef;
+
+	if (rt->ratem * ctrl->a_framer->superfreq < rt->rate)
+		rt->ratem++;
+
+	coef = rt->ratem;
+	*exp = 0;
+
+	/*
+	 * CRM = Cx(2^E) is the formula we are using.
+	 * Here C is the coffecient and E is the exponent.
+	 * CRM is the Channel Rate Multiplier.
+	 * Coefficeint should be either 1 or 3 and exponenet
+	 * should be an integer between 0 to 9, inclusive.
+	 */
+	while (1) {
+		while ((coef & 0x1) != 0x1) {
+			coef >>= 1;
+			*exp = *exp + 1;
+		}
+
+		if (coef <= 3)
+			break;
+
+		coef++;
+	}
+
+	/*
+	 * we rely on the coef value (1 or 3) to set a bit
+	 * in the slimbus message packet. This bit is
+	 * BIT(5) which is the segment rate coefficient.
+	 */
+	if (coef == 1) {
+		if (*exp > 9)
+			return -EIO;
+		coef = 0;
+	} else {
+		if (*exp > 8)
+			return -EIO;
+		coef = 1;
+	}
+
+	return coef;
+}
+
 static int qcom_slim_ngd_enable_stream(struct slim_stream_runtime *rt)
 {
 	struct slim_device *sdev = rt->dev;
@@ -967,16 +1015,22 @@ static int qcom_slim_ngd_enable_stream(struct slim_stream_runtime *rt)
 		struct slim_port *port = &rt->ports[i];
 
 		if (txn.msg->num_bytes == 0) {
-			int seg_interval = SLIM_SLOTS_PER_SUPERFRAME/rt->ratem;
-			int exp;
+			int exp = 0, coef = 0;
 
 			wbuf[txn.msg->num_bytes++] = sdev->laddr;
 			wbuf[txn.msg->num_bytes] = rt->bps >> 2 |
 						   (port->ch.aux_fmt << 6);
 
-			/* Data channel segment interval not multiple of 3 */
-			exp = seg_interval % 3;
-			if (exp)
+			/* calculate coef dynamically */
+			coef = qcom_slim_calc_coef(rt, &exp);
+			if (coef < 0) {
+				dev_err(&sdev->dev,
+				"%s: error calculating coef %d\n", __func__,
+									coef);
+				return -EIO;
+			}
+
+			if (coef)
 				wbuf[txn.msg->num_bytes] |= BIT(5);
 
 			txn.msg->num_bytes++;
-- 
2.34.1

