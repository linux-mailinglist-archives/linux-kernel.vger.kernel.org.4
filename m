Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028EA6AA9ED
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCDN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCDN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:28:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A8120059
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:27:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d36so3868031lfv.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWlVTXk7WYZu7J2Or6ZWmESRrvvRWeXEPReJ0SD6qlY=;
        b=RhL48itR43fFjXaTuvf9G3JUWZOElaWgeZDnLM9DJSygljD4PNeFkO3YDOqqt9BBBU
         9f8gW6rN/PEnt6bHkohRsYg7ANs82SpW4i5UwYLyNLjqEK8lfmQtN74lkBFgDRP6NpiR
         Sy1oTMadRN6LbXdIcWuYZ0zmqHcz64HTKo4aw8Fn5HuDKHfMdlI4gB3sT/+U9ohJeRet
         P2D99QUahcDo08cEFsfybtB0WvNqhM/XfMNuIW9BriIWT/iRaiW8Egy1H8ZERAUGsjpY
         ywakDf4z0XEPj+r5D6Q5HyePy79qoQKsIffn7cwuUnJayItJbIs59Am4aaV4bfUumN/S
         0L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWlVTXk7WYZu7J2Or6ZWmESRrvvRWeXEPReJ0SD6qlY=;
        b=gpYrKO7OhjNMqXkv0So0z2Aa6YUTDoJUzVuIMXizBmUeWdkO/BsSrs2uxGbwfIHvKa
         Tlr76S1w6tQgLcBQc9/9XCk2vRHWZ4OtHWkvlndFJjYWw450XS4jce/ZxSnZuldfWVal
         U/gnFY0lY1zz7ZDXY1BUD84tFzHgPVSyBcEmPKjEM0DhH/79Vuko2hCxuD/xMdoWsW/g
         WykyzqhVrllOtC3d4rhCEmhZOwEOSOlCBCTpP03YKZAjes/gnLG7kdI3f13P1fjI/pk+
         ZF84/gWXKdgScZ5qSReR4Wx8rK6FXrQVi0ZqI7z4onXhFoqb90BIgR/7nj+qidYWC3Fh
         N/RA==
X-Gm-Message-State: AO0yUKXQNip180ByB5XrFpmoKsykD9aI68fBb7XPN2Y/WrhPeJDnOGpl
        WKyiNGqRR5jvKZOQRKSmB3VgatpwloGhn8vPoiE=
X-Google-Smtp-Source: AK7set+pAeXIBpSaR7RrWnLwuNr9xay+jAiWwaq4uSm4u+GC8qYsYJOuYmOtSZBQ3BWIWHzr/q9f8A==
X-Received: by 2002:ac2:598b:0:b0:4db:513b:6ef4 with SMTP id w11-20020ac2598b000000b004db513b6ef4mr1477599lfn.11.1677936472091;
        Sat, 04 Mar 2023 05:27:52 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:27:51 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:43 +0100
Subject: [PATCH RFT 08/20] clk: qcom: smd-rpm: Add keepalive_clks for
 MSM8936
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-8-d9cfaf9b27a7@linaro.org>
References: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=879;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/gM/F7jwDcMoS4RSi8rE2q3Rtn0GWlhQfGL+90g8EhM=;
 b=0p4SS5CTVLe/gjtZJEtMJqFtlkA7PUIjV3mvn83ek41q9qUjO+OwrkYmarrbNyu9M+VmmFe9D/3V
 kxwdaDQ5CYXsJIPEnxCc0lc6AnuSfkUFRNzuvwaOuUW1TAJHpUCt
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8936 requires that the PCNoC clock always gets an active vote.
Guarantee that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index a93b4575f44f..6db78aeae9dd 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -632,8 +632,10 @@ static struct clk_smd_rpm *msm8936_clks[] = {
 };
 
 static const struct rpm_smd_clk_desc rpm_clk_msm8936 = {
-		.clks = msm8936_clks,
-		.num_clks = ARRAY_SIZE(msm8936_clks),
+	.clks = msm8936_clks,
+	.num_clks = ARRAY_SIZE(msm8936_clks),
+	.keepalive_clks = pnoc_keepalive_clks,
+	.num_keepalive_clks = ARRAY_SIZE(pnoc_keepalive_clks),
 };
 
 static struct clk_smd_rpm *msm8974_clks[] = {

-- 
2.39.2

