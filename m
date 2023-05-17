Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA6706716
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjEQLqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEQLqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:46:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FBF30C1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:46:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24e5d5782edso786830a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684324008; x=1686916008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwNQCA9ozgCFKqQivomJuANGu4rucg7HtzAq9d/gM0o=;
        b=z3+Ugw4k7EP8q1WKGKC5FCv+BJdDqyFA7a+iyE7kIv60S8X4NnTL1Wo4zmHQ/dGUwG
         TBWUWU5jKvFKU5DmR+vGOBtGJe9qBeGnJ2g6Ce94WiTplmmHuj/ifJLa5xmJ5u7ivgbJ
         3nFXw2G8RwvmuSTyPx3PlwEXpkkoCA4Q0e+wI+yx9EZeWLweViqZ68PPtDH8fFchEuai
         V2uDi3SsrX5bTmaCj+eX5hLHlzxSJ5E9Xuvy1P0i0jkvTogyi7DosRcGQFHAg4+MSAiO
         H/0Nm6oqYo5HKLExVW5ekrChA7JT+AwuqwTXeEB5r6+GzfFyMC0P9Jdu4kB58FoYASKD
         LJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684324008; x=1686916008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwNQCA9ozgCFKqQivomJuANGu4rucg7HtzAq9d/gM0o=;
        b=Ykl/uikIu5eQ90B5WFpGEIUdvH0AyL+WfEp2tFak4Ww9DS9VnJ3SftvyHlTAXY4Xaq
         Bh6F7Bqo0IwWGFICgl3L3DuGXs32U9KwK8wUVwaZAZzcE6Rt/H8clgHuT2mnPijMNJIr
         s5lwiFzZdSBIkwboxIUC5XaQtu+rkpMRRKzhP5eWa8qL1bi+W9AQsQ1MOSs601ssoCuA
         Rko5xbWbTpPoN//3PhEu3pd+tgJ4AHeCoElS5A0JV39pcSe0hg8O+YSRQ1mpnfkONhwV
         PZy4DLwPlBwPh2k+++fvAhphBnMiIkC95HTPE3GDAEX1g8KEeeCj9ujI4K0vwnTY3ehQ
         lNlw==
X-Gm-Message-State: AC+VfDz7jF2yViLf8fmJge1RCdvzmQpL1gxefuY2PnPDiNhJMO1pLfbb
        +QWM39g/xJSY/OwBp5Wa3gAt
X-Google-Smtp-Source: ACHHUZ5EYEW/ICrZAuG6MA7oFcdnFAe59sZovawyPXM++2NcP0NFH11weDO7HnaNwSy6kGXljjWi6g==
X-Received: by 2002:a17:90b:33c7:b0:250:69c7:a95e with SMTP id lk7-20020a17090b33c700b0025069c7a95emr33058167pjb.48.1684324008246;
        Wed, 17 May 2023 04:46:48 -0700 (PDT)
Received: from localhost.localdomain ([117.207.26.28])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090aba0c00b0025289bc1ce4sm1366971pjr.17.2023.05.17.04.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:46:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 1/2] EDAC/qcom: Remove superfluous return variable assignment in qcom_llcc_core_setup()
Date:   Wed, 17 May 2023 17:16:34 +0530
Message-Id: <20230517114635.76358-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517114635.76358-1-manivannan.sadhasivam@linaro.org>
References: <20230517114635.76358-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ret" variable will be assigned on both success and failure cases. So there
is no need to initialize it during start of qcom_llcc_core_setup().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 265e0fb39bc7..6140001f21c4 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -170,7 +170,7 @@ static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
 static int
 qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 {
-	int ret = 0;
+	int ret;
 
 	switch (err_type) {
 	case LLCC_DRAM_CE:
-- 
2.25.1

