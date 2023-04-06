Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679866D9B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbjDFO7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjDFO66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:58:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F479037
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:58:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h17so39793180wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680793134; x=1683385134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNY1WgFE5W0+EDCsEQWZ33KMDgDEFiFDJkuxdC14U6c=;
        b=lsMZ/tmQGh0+Gqb95YSagOXlgovDFj8+1loUBZniBPTntn/h5IVkYuQn7ILSUiUVYq
         aYG9W1n2NKs2RptvcozWQPSf7ZiDwxLfvfzk9UiJw/4tHPRk21e260kkMA/jnzZBPjfN
         Gr1plOLPrjpPSR0yFk6Z9QNGTRVpkWqLhnZ5Vm0GN/LuZ6WsYtGrUpFFzHamAhcbP87e
         3RvCX7bxDIB/qxO3F1sgfYMCRb/6l9ygjdBvhYUwzHTy9HYG0+SS4BsOfB+47W4hrlhQ
         yOTzP4LrDo7vULF8GRQ+uS04+C8AOlUZ5dpWBOexEQRaejsNhuHOFUDwU6oQEmdmu5xY
         z0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793134; x=1683385134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNY1WgFE5W0+EDCsEQWZ33KMDgDEFiFDJkuxdC14U6c=;
        b=oXVSPrh8AuIrPVSsVuybwR3SEyViNkBucZT9fDJ6dBVd6lly0ZVy/8N8vIuXlDZ9v8
         5ud/qhl3WgVupHNpC7MJDPhYfJu/TK19FJZvI2mQp4b7kndufXYT2L0QWnyCLc/FELji
         FMYnuS/9conNqXqnkZ8H32EWCKLX2XvgVMQj4rPx4df6zqjUskD4QGIDtGgDxK+mxeTE
         BV/FG7wEfv5yksUK6lSuZDvjHyrmak6eEZ9R1npjromHSszVFv1YcwU+/GrnkadtcFvT
         /jbNrpVm2SbBVptOv066FKj/D3UaBCWTwcIuHliJ02Hr5nw7sQTUrANb4C2BV/WYByWM
         ONLw==
X-Gm-Message-State: AAQBX9cYYD0A2YxgzpqTyeXhh46c56YroSk1N5osVixxb2AzB7vbHxJb
        Hj0/pEtj3voXvlU6eXdSjTY8qg==
X-Google-Smtp-Source: AKy350Y5/8nzIFtA5GLno7AkNOE83NgVqaQKljVOSMfIXaK0nWcT0TmjC4AnNwjBHz1+YX5CvUKlMw==
X-Received: by 2002:a5d:440d:0:b0:2d8:cacd:797e with SMTP id z13-20020a5d440d000000b002d8cacd797emr7051511wrq.10.1680793133951;
        Thu, 06 Apr 2023 07:58:53 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d10-20020a1c730a000000b003f0373d077csm1768160wmb.47.2023.04.06.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:58:53 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        dmitry.baryshkov@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 1/3] thermal/drivers/tsens: Add error/debug prints to calibration read
Date:   Thu,  6 Apr 2023 15:58:48 +0100
Message-Id: <20230406145850.357296-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
References: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
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

Add in some dev_dbg() to aid in viewing of raw calibration data extracted.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d3218127e617d..7165b0bfe8b9f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -115,8 +115,12 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
 			return ret;
 
 		ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p1[i]);
-		if (ret)
+		if (ret) {
+			dev_err(priv->dev, "Failed to read %s\n", name);
 			return ret;
+		}
+
+		dev_dbg(priv->dev, "%s 0x%x\n", name, p1[i]);
 
 		ret = snprintf(name, sizeof(name), "s%d_p2%s", priv->sensor[i].hw_id,
 			       backup ? "_backup" : "");
@@ -124,8 +128,12 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
 			return ret;
 
 		ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p2[i]);
-		if (ret)
+		if (ret) {
+			dev_err(priv->dev, "Failed to read %s\n", name);
 			return ret;
+		}
+
+		dev_dbg(priv->dev, "%s 0x%x\n", name, p2[i]);
 	}
 
 	switch (mode) {
-- 
2.39.2

