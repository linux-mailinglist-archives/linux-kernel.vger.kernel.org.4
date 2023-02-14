Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4FB696711
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjBNOiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjBNOiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:38:14 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353522A6E4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:38:11 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u21so17726519edv.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uFe9M4kMsn6GMCEHF0NJYhKab6cG07IqakVpkwLnQk=;
        b=Ky1AnQ0Su3H7eZkw1IYQgEuEk+ur0WLa84qyoDIo43MqM0raRl3k4PUyr5qLdzNNXU
         M10Duc8jX+ghK36YwMXXARCjBvN7BkdUsLHnQAvCZOi8LurTxKksEcde1rBWpO5jAJ/b
         UuRzUr6IYGobscaHvHZd6z0gFFVD+rufOXBBWvGsT4vs7F79Q987cbm4bgdyWS7L4ptj
         VmePqMvYRItjJVTW6tayPjvcu/Ta+RVeupX0JxTEOi6dAV9weeFKg0o03Sfzm4HtvRiV
         LTaol+ag59KgPpCxOFZJQr8M5FoSgDU8OY1pImBUK3URxgHSWCv/xKR9i8IGCj5n7OXr
         syLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uFe9M4kMsn6GMCEHF0NJYhKab6cG07IqakVpkwLnQk=;
        b=A+r5EkEaylY8vfG7DHaGmxVXYEqedKkC/4JEMgNULB2nOhJzehzydiNQM+bxz6tLDc
         n3Pkl09t3yB5oXgR1l9F7JL1GCohV224EUvT/xeACdTaGYGvlgjq+TR/ZgHFTJd1lo1i
         x2cadkCkykmVtNBRdKMFz4W/0XSaFsLZETtP2Zd9Ji59F+Riww7AiNmKQDPY0R/Pu3WC
         XpIgmLTIIFFxqJHpRRTP8zqX65vXSnlKeMD9I3jURNlRNHfWFHIwjnpLKiDirxVxyny/
         Hj5ly/yZJ2MYvmgvoA3Gj6OBj2KqJ6Di3CGGAcCeCueDp6545tEGbfH84pcv104qyM1O
         Gn5Q==
X-Gm-Message-State: AO0yUKUU9hMe1ZUuHv2DnIPfDFKAszrUWupQ+S7UYIcl6TNeFlakOnA6
        GQsr13QFBJLGbMkYLgtQ0wMiTQ==
X-Google-Smtp-Source: AK7set+Zr31an2n3m3hSLSVlUCmMs2nidMduqpRnuJobYh8854NvhO37l09WP81MNCZ/mo7e0R/Olg==
X-Received: by 2002:a50:ab54:0:b0:4ac:bf55:7d61 with SMTP id t20-20020a50ab54000000b004acbf557d61mr2763935edc.9.1676385490545;
        Tue, 14 Feb 2023 06:38:10 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056402289500b004acb6189693sm5378052edb.83.2023.02.14.06.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:38:10 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/12] interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
Date:   Tue, 14 Feb 2023 15:37:17 +0100
Message-Id: <20230214143720.2416762-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
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
index df907ef01d6a..c1954584d6f0 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -510,7 +510,7 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 
 regmap_done:
-	ret = devm_clk_bulk_get_optional(dev, qp->num_bus_clks, qp->bus_clks);
+	ret = devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
 	if (ret)
 		return ret;
 
-- 
2.39.1

