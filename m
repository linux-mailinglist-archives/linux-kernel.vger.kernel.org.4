Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1915A67A933
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjAYD1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjAYD1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:27:38 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0098353E5B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:34 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id rl14so40876869ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7Y1NMPalpxUqHha/UwoSVK0emmKu+W/+Z588Ntdk2I=;
        b=nLQmn75xC7aFlT12AfAw26byvRV4dfkXnB5rWHF8lYMVc+oJ+8nljixdej51o44EVg
         pfqa1gh5y4p49eExD0etdS6I6urx+Fxto9w3N29GEdW75kewQQ8Hdo5ARMJ2mBbZj64l
         zIgJvusAFgnqmG4SQntKRwqsTFhBRfz5kMvPUbIa1moLixEC/ZlPmbqAdykH0TtpWAal
         tby0GGmf7WqXPxJI43RN6FFol1foBxJ/6kOOM9nU0vFV6CBz4m1Kadpo/u7tMuaO6mQk
         tYoseWmPYKZmieCcNSqOy7Mz2C94q+Svjj3mITqx6kwY5JXVJ6qgANV5UEwunmkKNFDb
         AAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7Y1NMPalpxUqHha/UwoSVK0emmKu+W/+Z588Ntdk2I=;
        b=5XpeOLuchBVtPmeKi71unDcQePZs1Ll8twxdD7ZQt3STJtKhTjAVRc6980zkjYevm+
         yveTrqTD2gsZIL3ViZfS4GGnFNlDyeLnj7/5FIhBCMvYImSU5gMKJ/FxKwy/xZ41kJlg
         Eb5f8pRBVcvA+6y2hpVfUf1N+gA3H+Ibr0kF5jvA/NXGxKVOO7aLLI5vdhwWOCJ1/KhZ
         8QxZpvl7IQWURTQZQBTxfza4gsWu/WXJoxxIt4Yrg1GF3tZXRVquc1Qo0CF0z/NnE05w
         YPdgDFQJW4NnHe750p/V72RORTikx+9LxM6JwCjYJeDkkY3a732fP8dZ6uA2xEh8FgeJ
         4Vdg==
X-Gm-Message-State: AFqh2kpn8sJ614e0RL0fDE6vJGqAV2hEFosSax3ZhuLVhym5dP/z0v4x
        zjBl0Fy89HnIT7JPQzBOBTrJdA==
X-Google-Smtp-Source: AMrXdXus0rbN+EDEcUPL0pdW7cH/PZmvifckAXFciv3l2s2DynOP8nLXeBhBbKpJiUAoATPr6tCf+g==
X-Received: by 2002:a17:906:dfe1:b0:870:e946:7241 with SMTP id lc1-20020a170906dfe100b00870e9467241mr31455389ejc.11.1674617253015;
        Tue, 24 Jan 2023 19:27:33 -0800 (PST)
Received: from localhost.localdomain (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id if10-20020a170906df4a00b00738795e7d9bsm1742913ejc.2.2023.01.24.19.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:27:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] soc: qcom: rpmpd: Add parent PD support
Date:   Wed, 25 Jan 2023 04:27:22 +0100
Message-Id: <20230125032728.611640-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125032728.611640-1-konrad.dybcio@linaro.org>
References: <20230125032728.611640-1-konrad.dybcio@linaro.org>
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

In some cases (like with the GPU core clock on GMU-less SoCs) it's
required that we scale more than one voltage domain. This can be achieved
by linking them in a parent-child relationship. Add support for specifying
a parent PD, similarly to what has been done in the RPMhPD driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 337b1ad1cd3b..0c2d930ab38f 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -99,6 +99,7 @@ struct rpmpd_req {
 
 struct rpmpd {
 	struct generic_pm_domain pd;
+	struct generic_pm_domain *parent;
 	struct rpmpd *peer;
 	const bool active_only;
 	unsigned int corner;
@@ -673,6 +674,15 @@ static int rpmpd_probe(struct platform_device *pdev)
 		data->domains[i] = &rpmpds[i]->pd;
 	}
 
+	/* Add subdomains */
+	for (i = 0; i < num; i++) {
+		if (!rpmpds[i])
+			continue;
+
+		if (rpmpds[i]->parent)
+			pm_genpd_add_subdomain(rpmpds[i]->parent, &rpmpds[i]->pd);
+	}
+
 	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
 }
 
-- 
2.39.1

