Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A314D6AAA12
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCDN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCDN2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:28:45 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E5A1ACD6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:28:05 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id i9so7025693lfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DK+DHJSy2xBUh4Vr8/3y2ODv7He3a8h/4QGwZUApeI=;
        b=mRPq98teuJUqn1DsSyenBZ25dQ+EQZd1E8Jer+5bbm42Z2bV78WQTWozwodo1HtuAX
         LWKwetK7sptG4EBNjfp/NydEtpcVOwb+p4WvdSYnBUQoBj/3kqfJ86kTzdd8rFXEvxwu
         7Jqn58pIcYTA6pkGruymAeh1CGZ6PSo3vx7iLGW56eBWzmERxgRm5Mshu/nfLkUQPx5r
         Y/yiTXoYUmzTCloWM7y5+iasJMbB62ygqrK79O4psOMfV0Bid7O/4uJEursgHBbD32iR
         bT9t+1JRuMcIk82r1LqGj6d89Z5EzX6p9qoJ5ami7xviVt95qk9F75wu08oX7PwDUVFC
         Viww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DK+DHJSy2xBUh4Vr8/3y2ODv7He3a8h/4QGwZUApeI=;
        b=7wQgYe1EuMuBljTByAR+Dm48LPqhTFn3Dnr8NmxqHHAs/TiC8+UzgIfkAS6Xi/wQW1
         cHqWqZAxZGERGiR7hlJE3picEZmZ7hqM5QHqMvf+s/3QWi2uPvX+UI8lfj0zs8wfIfyu
         d1ufUQewNj/rH1ydqZL/vwSUKWQ1KmNpUMGiIU3t04iPkbezOroRjFwuDvyBXNsn/hos
         DlyF9q8Pn/7XTIv9CunUUWyEQHlK5xbx1FjYzJgQ45xJEc9qsnu2c+Iwj0KiQz7iVZN8
         a/6E1pk6Tsrpi1gIjcqs+c2LOdgH/pUUWwHnZAB2ZfVb+rV4D97HvDAVd66KGhU3ksMQ
         k1xg==
X-Gm-Message-State: AO0yUKWDrMoGLkfUFOSWV2urBCtf1nMASd6yT7r4Qt6dzAqAvKGPV/PF
        LqerHfAhqvcb1Do8OmRfQ/kxGA==
X-Google-Smtp-Source: AK7set/JyhYxiRX5lUiA3rM4DZyKptGNxJ+xI5ufLT/+XAGpWkA0q+f621yxtmtT1PCt9NVmCO/7pQ==
X-Received: by 2002:ac2:4a90:0:b0:4cb:d3:3b99 with SMTP id l16-20020ac24a90000000b004cb00d33b99mr1375577lfp.36.1677936484771;
        Sat, 04 Mar 2023 05:28:04 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:28:04 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:55 +0100
Subject: [PATCH RFT 20/20] clk: qcom: smd-rpm: Add keepalive_clks for
 QCS404
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-20-d9cfaf9b27a7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=777;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7QPqo1GGgCEJKo/s3JptnfQVu+vbrWF3+vXEnhyWs3g=;
 b=jtPxDC2HrczqJjFmn93XT4HDRLpY4unqhpYlyqESg494bkZUTgJ0eQCc1+aKQodnCXYW7RUOIBIS
 xychouPNCaltqNJBMf666A4jpGuiqOm2EIBI4T1OM6pMw66XV2q6
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

QCS404 requires that the PCNoC clock always gets an active vote.
Guarantee that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 2d0efe2cb1f5..af8a43394349 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -934,6 +934,8 @@ static struct clk_smd_rpm *qcs404_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_qcs404 = {
 	.clks = qcs404_clks,
 	.num_clks = ARRAY_SIZE(qcs404_clks),
+	.keepalive_clks = pnoc_keepalive_clks,
+	.num_keepalive_clks = ARRAY_SIZE(pnoc_keepalive_clks),
 };
 
 static struct clk_smd_rpm *msm8998_clks[] = {

-- 
2.39.2

