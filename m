Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CF866BFB7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjAPNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjAPNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:22:26 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53095193D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:13 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so42674869lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6b0TwGgzkpcqXdb/NMeqpUwn36E7G6fTsEYVsv4xJ4=;
        b=qdJwWxPcd0u+wekOpipC4vGGjkJSdRnwl7C0Nl3y/tT81k9opLLsYd+Aej4asu8BDp
         8T7pq+pnjp97vfhVumc1TgJSnN4G2Xx1bUfgbjcKzfxaTgrxaLqnD8sshewFadWjZOXu
         TrJ32YbOv0L/t+MM3HvI6uROKmi3GFv4iD6Qv8wIKMqOOBOq/hHKf/mD8kY5qaKpIn0D
         uU6oOOkgLW7XqGUKyBuOBGuGuGlYix8ecJ4aeQKLFRHtrPuOE8j+F+DneLu9qluZmqLb
         fbacTbfOPReHBQkJ+8eyYo1bQsxJednSqVSKdrFwjlbYNJTXSR0nfTyev3BvD5g9pH1N
         6nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6b0TwGgzkpcqXdb/NMeqpUwn36E7G6fTsEYVsv4xJ4=;
        b=fv5pye1rHSIKapOLZ5qtfth+11qm0g/05nC9Ph9BDZpirYdKdjYgwv4kOvF/WS4jMI
         VKwtVpz3REslltfdiT8Q8kLd7ExaqPq4ahupGUHicx7BAQMRAcU850uDjJ2Ze9qfyCrO
         hqHT3poStYvk9Q7lyEDGOCI0nROVPWn1F1gVesy4VOz6D5R2/sD7r/5U4XNCdZJCGZpk
         GnJh5Qez4uetCYb09eCLG2xI1JBaqnn2BTVbuAz20ac5wFYjSYbX+TWaeIm/BmLwugkL
         CjFRHN/bpls9MTNvJT0Eg5gUN5Lgdo6ioMcjmgxUkobIBYVNQAegeaJRWb2KmywtpNrf
         lj+A==
X-Gm-Message-State: AFqh2koa1yxnEwzP/5AbMqveDzDz2/SA2dtt7OZGbnfl6NGDg6bjtudE
        XT2gv91dj2iaAcp0MW8Bwh6QDg==
X-Google-Smtp-Source: AMrXdXt0B1JhS8wmN3eSrHIp72RTHYzZVdVGNRTRSzck9D6zF7N+W6eN+EqYbaHFgDajziYzd1U9LA==
X-Received: by 2002:a05:6512:1111:b0:4cc:7e0e:8d5c with SMTP id l17-20020a056512111100b004cc7e0e8d5cmr11874928lfg.37.1673875331697;
        Mon, 16 Jan 2023 05:22:11 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id p9-20020a05651212c900b004cc58b91177sm5016653lfg.239.2023.01.16.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 05:22:11 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
Date:   Mon, 16 Jan 2023 14:21:52 +0100
Message-Id: <20230116132152.405535-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116132152.405535-1-konrad.dybcio@linaro.org>
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for provider clocks")
relaxed the requirements around probing bus clocks. This was a decent
solution for making sure MSM8996 would still boot with old DTs, but
now that there's a proper fix in place that both old and new DTs
will be happy about, revert back to the safer variant of the
function.

Fixes: dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for provider clocks")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 343e6021a93a..8cff724661f2 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -522,7 +522,7 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 
 regmap_done:
-	ret = devm_clk_bulk_get_optional(dev, qp->num_bus_clks, qp->bus_clks);
+	ret = devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
 	if (ret)
 		return ret;
 
-- 
2.39.0

