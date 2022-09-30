Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFFA5F0826
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiI3KAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiI3KA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:00:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEACD5757D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:00:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id s6so6093564lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9KpEUUalWoRI8TdGgOpsCg4Iu1p4euYEEJL3jAX6IA8=;
        b=voc8TJMGolTORHdohzjvuHAb4UaOqMJCdsBpDglcWWDasx3Bh/t4bB1zHsBgXyB/XH
         gvMWUPtHlADr2zsn56C3/uwUm51/k9+SybvXdpWO2dvuE8rZMFV41uj1L0MFso4CHhjZ
         R30v7heDZtcRI7nUwugKeNDVji1gkKjbvTy6nMAANQwgYRbWmSdRjZayLqTXkLPM6DCv
         CWjp/sJZMawQ5yZ+nfePEF+kuPODV9K0dwrvncOqW3ubk4ExxC+h44618XHTeZ8GMujZ
         el1qaFBGZnKf/m7mp1i1RXcPFh4M4qJhygCH051dou0CqHJpsAxXF9u1xIiIEqeBQiPN
         gX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9KpEUUalWoRI8TdGgOpsCg4Iu1p4euYEEJL3jAX6IA8=;
        b=7zvTpU2XA22ZXHubSGu0CdzZJ+fyXnwHEFx+aNZ1EWlM6Bre8Bjwxp5Yt5BpZjz9XZ
         XuKFemVHJb9AjgNsYLL53n0y+FsxsPaS3jF6D9lzpR7I5QMai417WwlELSdWZ8BNOsdg
         24hr8sFWKem5myW1Vg/wnrcth4OnBT87JogvmYIs9IaCTH9Gvr3uuEWf4LcjVz6EBK/4
         h1YGe+Hcb28ewc7Y7b+4jEjcjEBxky/yq3GtKyYcW8VCnbagreXswK570gvAapPFtEKe
         YqMONc3c7ma1FBoRdHKe+g6C5rAN+jwTyBnlm3zRTxbzdLGVPVWB7bNy5NZs6drUNbrI
         S56g==
X-Gm-Message-State: ACrzQf2HHzHLfDOObMgU2aK/or1aPLU69YKeemFOWYL38wQ2K1/olBnk
        g8NGT/RtB7ExxPKaWlBpaw4Kbw==
X-Google-Smtp-Source: AMsMyM5HvS85QSAxGq4Faz53kk6h8+znPOxxIkcAMRbZnP3Zfwji5og6cRVKRepMrNrIc8z33OvEow==
X-Received: by 2002:a05:6512:304d:b0:498:9d7b:43f with SMTP id b13-20020a056512304d00b004989d7b043fmr2984022lfb.48.1664532017997;
        Fri, 30 Sep 2022 03:00:17 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q65-20020a2e2a44000000b0026c3e350682sm113521ljq.14.2022.09.30.03.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:00:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Prudhvi Yarlagadda <pyarlaga@codeaurora.org>
Subject: [PATCH v2 2/2] slimbus: qcom-ngd-ctrl: add support for 44.1 Khz frequency
Date:   Fri, 30 Sep 2022 12:00:15 +0200
Message-Id: <20220930100015.259106-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930100015.259106-1-krzysztof.kozlowski@linaro.org>
References: <20220930100015.259106-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Changes since v1:
1. Rebase (drop development pieces in the context).
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

