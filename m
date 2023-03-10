Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CF96B5380
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjCJV4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjCJVzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:55:42 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C5060408
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:52:10 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id u9so26171848edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678484762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfueC8Ud+TxsewqPkS/fDVgjDJwxhwka0PgPS2fY1z0=;
        b=K90kT9LAH347IN7aaGanwpD1pGk+lr2nq1GFiAMOUVwmIajNMd6FSgYobHYmDVe9x+
         Xp0RTAY0qIzp8AoHNjDiPlu+3mDAZfq/Vr8asnGZVsr79W36eaRS8WnYAvQX2tbrOEFh
         2DKmocArpikKUh3AylbFB76+tUeJo+Z+ATf1qkC299jJSQxQ0Mp9SyRFgp10jIAgx6zp
         b9IxsffVZrjR4bh4TiWORGRCvFLUvKkZcmN5ATVcoAIeDj0b9lvAAgcLhR26fXw/4hXx
         xLzxw0tUw9i1/U96VbyETa6TnMH543wkwqp7D273J5X3JKQ6uQjUThg6on6eCTDis43o
         Biew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfueC8Ud+TxsewqPkS/fDVgjDJwxhwka0PgPS2fY1z0=;
        b=dcbIqAV0BWUawKe978cj7gBWyfmKT/cEU3UGo4LFExYTEufahqIU4IdLJhSg7SHAWK
         ZSiqWhFKWVTKqej6eImjXEwG/19iU3SGxJfX3JFENu5Y4L7+GEEDEQDe9nViInLHZx8H
         1+mVlmNfWQJkYCpCTgpjJQjouR1SvowXPhU08YtyqWlLaV1n3QVNof+bpLaDiSkyCGjU
         hoXn6DCgNLV1yfAbgo1S44OCtZUBV6LrNrd0KLQSpWd6zd7tOK5AkWW0U+xXIssaEgdS
         D6o2n2+0c9nx67dgcbkU33Ti6IE9zt68Uil9a0yqz0hk2UVOqX7nRTMdbn/1o47HN/XM
         7TDA==
X-Gm-Message-State: AO0yUKX0TLYUH3PTefM7SwWXBazQwT2Fd83ivrEOlt4T5vcRf6ZDZoPl
        zrNXze8IMloP+ggPI6q1fi1+rA==
X-Google-Smtp-Source: AK7set/+NUmIgbATpN/GwzCK7LhiB3l9y1iTqOcCxXGLgQn2rcQCH7j8l4FZmoegGAD3sHE0TVBUJQ==
X-Received: by 2002:a05:6402:128b:b0:4bf:4b5c:1d66 with SMTP id w11-20020a056402128b00b004bf4b5c1d66mr22987359edv.31.1678484761848;
        Fri, 10 Mar 2023 13:46:01 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b004be11e97ca2sm471873edi.90.2023.03.10.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:46:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/9] regulator: qcom_rpm: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 22:45:49 +0100
Message-Id: <20230310214553.275450-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
References: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is specific to ARCH_QCOM which depends on OF thus the driver
is OF-only.  Its of_device_id table is built unconditionally, thus
of_match_ptr() for ID table does not make sense.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/qcom_rpm-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index 3c41b71a1f52..602526669648 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -991,7 +991,7 @@ static struct platform_driver rpm_reg_driver = {
 	.probe          = rpm_reg_probe,
 	.driver  = {
 		.name  = "qcom_rpm_reg",
-		.of_match_table = of_match_ptr(rpm_of_match),
+		.of_match_table = rpm_of_match,
 	},
 };
 
-- 
2.34.1

