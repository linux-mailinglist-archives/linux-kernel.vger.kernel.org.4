Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40E063BA62
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiK2HNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiK2HNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:13:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4695D29363
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:13:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so8166367pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysRkZEkG9U0xN7SzDYmSQzz/ndtry1XUYgwVKa5Vc8g=;
        b=TO9HJyFLhIeU1a0DWHT7rRVWewmsL2lA08nBnNx97xhnCsS/ZN5+f67Eudg+2TKFM3
         H3X+fEeo5xFkKvdwloqZ6gl1SP1NUuXccPunv3MHbh2s0c0d5EBt5E8VoHbwxHI5Sefl
         qWuRhmBVEjxF/b+s2zaHW+ggoAaizs3psq1NxbS4VbEXGSfFbsfcOfz5ioI/6OPgcocM
         3U+lc875RkddJh4SGYUAGKQLCzb2dhBYdAy6+ILXKY+vIxGBHLz6OTVaXYII9gA3au7t
         fZTCI5A+k2i7jnXS86uiaGbZ7zw3wBT0BASBHN1oWP9XrVcEwH3uu1o/v6Js0Iy6YvgX
         GJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysRkZEkG9U0xN7SzDYmSQzz/ndtry1XUYgwVKa5Vc8g=;
        b=VISAM9LahfbgGFTLM07eNrIJBKO9Jg9ZXy1hoSH7Isjuyw/5MmnAUqhaP1SZ/MP7E/
         6o5lw2r5OgOQxRUUfMcKUAXLyZUNUZS6WRlJhVH6O793JP6Wt3mSXtuAeIdjOQtimAl6
         Wb3BJ0FhH2vF8qZ/5++nQii8GTzlj56QqvYf1W3BI3eGx4RwLFNnxkqE+XesPSsGBJy4
         qgf5PJchWlhTJNN5sMzWqG+0KdkFZ1luZyLV6AqCIEgKVBKp0tAnBJz2YlDnHQQQTRlO
         uv0AWwLX6djQzs4VqLY++EEmhlrT8d7MYVm2KKjcp7F+7i4wlZS5f30bdtNntAtP19nF
         Dq4A==
X-Gm-Message-State: ANoB5pmbbuzj36+yp0dnCZsQKHEYqzDJCCdyi8FmXzgq4A8EASyOJ0We
        XxwWbktu5PjaSw56sDmlskrV
X-Google-Smtp-Source: AA0mqf474wQjSAwlcJaYYJADBqriNlJxUpsB/+o+xwihY3UPdeDIDfkMG8zT5nnwUOT8BKgrs8s1Hg==
X-Received: by 2002:a17:90a:5298:b0:217:e054:9ac8 with SMTP id w24-20020a17090a529800b00217e0549ac8mr65078004pjh.246.1669705983654;
        Mon, 28 Nov 2022 23:13:03 -0800 (PST)
Received: from localhost.localdomain ([117.248.1.95])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b00188fc6766d6sm10009264plh.219.2022.11.28.23.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 23:13:02 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 2/3] EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
Date:   Tue, 29 Nov 2022 12:42:00 +0530
Message-Id: <20221129071201.30024-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129071201.30024-1-manivannan.sadhasivam@linaro.org>
References: <20221129071201.30024-1-manivannan.sadhasivam@linaro.org>
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

If the ret variable is initialized with -EINVAL, then there is no need to
assign it again in the default case of qcom_llcc_core_setup().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 97a27e42dd61..1403e3d0163f 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -168,7 +168,7 @@ static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
 static int
 qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 {
-	int ret = 0;
+	int ret = -EINVAL;
 
 	switch (err_type) {
 	case LLCC_DRAM_CE:
@@ -196,7 +196,6 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 			return ret;
 		break;
 	default:
-		ret = -EINVAL;
 		edac_printk(KERN_CRIT, EDAC_LLCC, "Unexpected error type: %d\n",
 			    err_type);
 	}
-- 
2.25.1

