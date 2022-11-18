Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C2662EDF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbiKRGxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiKRGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D382BDF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d9so7775390wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFIEMBB2IjM7eCCTHeoI+k1SkTzePnhabISYzYNjNeE=;
        b=ubplKZ3jFHFJNp+2i+zQRxzIlK5HZ8tbmWrLfmUpFZgwx4JFwbQZgeQ77mzxf7yMWq
         eG+aIr3Uy+0Qa/fxn0VJ7rofKMKsw/tBHPQDYU9EERnnpf+LVeNCS1TzZ1Ko9uFe9r2S
         864zTSgBQTPXvcRlmHwhgoFgxsF94tJK0eaXWjxyqyaZA6ObbiZbGbW3TclD5pQJAp2e
         jX0TlkVCbZ4vV/vdB5Qjiqje3RactWpxOr+rz9Bd1oWDhx6HZpmKmM1z2jfOZqnjApQ/
         RL9MljqJ8tH4dQHpDA77BpjRfK0O/UdMBAGssyg9Jr9rtnzfjx9mGU2UjOs9+DUIM5k5
         sVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFIEMBB2IjM7eCCTHeoI+k1SkTzePnhabISYzYNjNeE=;
        b=LWv9W5c6EOHoNrODMYEz/8cWT+e97QNbTN2kzfICPPybWTI4EIG4uNhNBHkIQw5Dvh
         PomBtdQs+e3exLMjBN5J7dRnpEssAAGDIe0agzQcIReEr0CxUGZRZU5e/65cluck8rCz
         wieOXzP5gezWg7IRKrWsngON8HGzumcB4jWFRNCMrOM0Rb/PUUgabXjVrfbK3/0KAwCx
         RbaVz0la3i/pgOTYfEbTvrgwygG+ogoG3FTWmLrou9XI1gHKH8O4uY1kUx/OnX3qJgTn
         BhcLUOxValpYJftCT5cJhRBL1lb33Kgj9bQLZ3ISdEFstycGpzJcSHjAoSIUV9KVHLH7
         k+wA==
X-Gm-Message-State: ANoB5pnzlEtrzSkByIPVX0DSQ4xlj6xSDaCKEg7eTnTynkmXP1xuZdRY
        qm0/QafXzmNW0dvXuNhiW6NHOqxWQB/UKQ==
X-Google-Smtp-Source: AA0mqf6GSQlZ4WXxryzz020UbeSfeki6RjaUPnSYS65B3BbFVrzk4n85v79MWS6gVhgPsnrIpXYULg==
X-Received: by 2002:a05:6000:10c3:b0:241:bee0:c56e with SMTP id b3-20020a05600010c300b00241bee0c56emr1589306wrx.534.1668754379258;
        Thu, 17 Nov 2022 22:52:59 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:52:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Prudhvi Yarlagadda <pyarlaga@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/12] slimbus: qcom-ngd-ctrl: add support for 44.1 Khz frequency
Date:   Fri, 18 Nov 2022 06:52:38 +0000
Message-Id: <20221118065246.6835-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
References: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Add support for 44.1Khz frequency by dynamically calculating the slimbus
parameters instead of statically defining them.

Co-developed-by: Prudhvi Yarlagadda <pyarlaga@codeaurora.org>
Signed-off-by: Prudhvi Yarlagadda <pyarlaga@codeaurora.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 64 ++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index d48e58ca5d58..22720ad4c22d 100644
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
2.25.1

