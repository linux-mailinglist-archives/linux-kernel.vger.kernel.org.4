Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAE262EDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241279AbiKRGxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbiKRGxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:03 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188CD82BD6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so5701457wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPfpVnxGRDYdaZNsulhqiR+vEyqf8cgL7fT2Xi6w1tQ=;
        b=tLstFhQ5eHN6aFHDvAl9QsufcJDB0shPuv5a1rz5feqIvEAY+yyhIihx6oC4bRFTCc
         dlit+95033cTYUVxal076QHmP9z+Xq0zPTtPU7AZ+2f5lqlCsmXCmudvpQMUBcfR0fBH
         R3940COLGrm8Rln5kB9ZDAU1Xjq7GTvT1qEuiLbxH/WzwB7MpESQmo2XiIuEo8vqskXW
         cl0tmub6L8yJ4tgBg8DeY9kSiydj00nrPCtygV9BznVvSJCjZh694RHr/cfqpelBxBry
         GpFFZKf4+25m+EvR0SNh6pAsARQQ/Mjyv1DShm7T3iTau21DEs1AiOxEwlv06Nhp7Jkk
         nBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPfpVnxGRDYdaZNsulhqiR+vEyqf8cgL7fT2Xi6w1tQ=;
        b=SmKA9Bsu63+69QTIoLW6RzentziuhlJI3CUfO0AgoG8IHYOi+hnbiOS6D6NlXwXKJB
         f2K93n6pVzBke/c0mnBeJ0JBQ78IjypU1tQaSu6+PlDPmjz2+7b3oRSkRtHbtiKh+cWx
         En5ZH58LqVfBTK0SQp3SaQg1j5y3mtSzMeYH2+vL4YdZiz6JK0044ZezS62wgVqksNTh
         IkK8r1ztHyBpl90C1bfDGm0e1Nvm5jRG9TN16FQsHGVxKvGd1EyDiHHTBKr/ekMoy20h
         zNDxvbE6K6PLmxM4IdFg2z8LyGlCkX5eo6WTvn/f3OKKJizWcs3P8fTVfBfLdBfm6dzg
         nbug==
X-Gm-Message-State: ANoB5pkHAr78IZQgEF4zyc9R1GS4FUWJfnxcBCL7PCNApfX1GdtapZAs
        R/8aiSimJ/Z3rRqElZriauOax+48r2/r0g==
X-Google-Smtp-Source: AA0mqf70cxB1iDgxwGXaLC57uxSkselxKQSpb+AtuMGOX6coMs5GRLqHR6xlUMMbig7ZblT+li4lVA==
X-Received: by 2002:a1c:cc06:0:b0:3cd:3422:62f3 with SMTP id h6-20020a1ccc06000000b003cd342262f3mr3902335wmb.26.1668754376671;
        Thu, 17 Nov 2022 22:52:56 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:52:56 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/12] slimbus: qcom-ngd-ctrl: drop PM runtime counter on transfer error paths
Date:   Fri, 18 Nov 2022 06:52:36 +0000
Message-Id: <20221118065246.6835-3-srinivas.kandagatla@linaro.org>
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

If transfer in qcom_slim_ngd_xfer_msg_sync() fails, we need to drop the
PM runtime usage counter to have it balanced.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 964adf77b51b..d48e58ca5d58 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -919,21 +919,29 @@ static int qcom_slim_ngd_xfer_msg_sync(struct slim_controller *ctrl,
 	DECLARE_COMPLETION_ONSTACK(done);
 	int ret, timeout;
 
-	pm_runtime_get_sync(ctrl->dev);
+	ret = pm_runtime_get_sync(ctrl->dev);
+	if (ret < 0)
+		goto pm_put;
 
 	txn->comp = &done;
 
 	ret = qcom_slim_ngd_xfer_msg(ctrl, txn);
 	if (ret)
-		return ret;
+		goto pm_put;
 
 	timeout = wait_for_completion_timeout(&done, HZ);
 	if (!timeout) {
 		dev_err(ctrl->dev, "TX timed out:MC:0x%x,mt:0x%x", txn->mc,
 				txn->mt);
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
+		goto pm_put;
 	}
 	return 0;
+
+pm_put:
+	pm_runtime_put(ctrl->dev);
+
+	return ret;
 }
 
 static int qcom_slim_ngd_enable_stream(struct slim_stream_runtime *rt)
-- 
2.25.1

