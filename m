Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5AC6AAA04
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCDN24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCDN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:28:32 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E23CEC46
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:28:00 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id t11so7047295lfr.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VfW1YYdXfqnKLGPvQBkrMfeqGIPI8djYtcQvRbIczk=;
        b=CuHKcE6GIYECPkggTmAyVhXgEZYVjQzqPZ+LEyC/UxyEz7jCvBfGAXnOPSbLoYWgIw
         2mESFZjkWdBVSudqXLXwRMC3uoa7solX/3JTb+57xNK6B7cSfXhXaw3IAIp3MErdW9RB
         K6oO/o05IZlV3ggGGPfBP/XihsKNYpWqtBYJe2MbN+y6QixXAESM4pC0rNqWiMRYlvmH
         hN7BKS89kE5Z8kuXGNAfvPv6GIoSozqQjoVSa8jXOnDJLB1NyYJiqP4YNNfAGKLxRA1L
         XL7bND4/1mm1+N6LLyLrx6QKomhKfKd1SCsGeBIZpFy7B9/iXi0Kzo9scdIoNsIzZPSQ
         SE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VfW1YYdXfqnKLGPvQBkrMfeqGIPI8djYtcQvRbIczk=;
        b=ieQx04ZZcogB6FYyQvfs4VM0eDr/LowBYoT7huoN0DmCSCZxzKtP9Bs6DBvNmNfmxw
         bt24ExRmaXqUSctkG6fUZkjZ2ZS2W8BgKZ6zTfb1AsnsZ3q0iewuKmzBSIS4e1EEwKS/
         tdKOnKn6cJJB2xmweDicVXAyH150WQMOLoVOdBklSH0JoA/fcXgaem7xO4eX4Rxn7aYM
         CUYRGpGpehGv8sVFg/JpLpI/5/7KE8HTtpi+szezX/O6VvOYih4Q0IVWgaIva/eGXwrC
         WY2KXI/A6rN3R6jExbmc08j3KJDs057182ARQTlfaB7EnT2ZQSnxnIS9vGkuATPQuHd+
         YkNQ==
X-Gm-Message-State: AO0yUKU6eLYaa9OMiGb+jwjIAE0q7lCC0hS2+7PXyiYckF6d0sv316U3
        1CXUpnLcqRWmQnuuLofYgsEP4Q==
X-Google-Smtp-Source: AK7set94cwd3u5KJzDpcWgrvHd+K4bvcrd0Nnoh87E/CNhpmfHjn3F0+DoC7G2PqqHUycuXfcbDfTw==
X-Received: by 2002:a05:6512:408:b0:4de:8588:b57b with SMTP id u8-20020a056512040800b004de8588b57bmr1356654lfk.19.1677936479709;
        Sat, 04 Mar 2023 05:27:59 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:27:59 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:50 +0100
Subject: [PATCH RFT 15/20] clk: qcom: smd-rpm: Add keepalive_clks for
 MDM9607
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-15-d9cfaf9b27a7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=784;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1ZJqkfkW4cuOQkRuGuBOVoeDkiqePtVAvw1z0RMFEyM=;
 b=nMrSzvl1dqVIXFXF9GBrlew6CQCWBNkgB10RxnN2SFC7MU/4L4jHAfgX+nRYs6web47uuptxDRDT
 +uRH87KzCXx3FawG8VzHL6yCcy9CI1O4QMO0ipHHfJdm1EZ/LJ91
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MDM9607 requires that the PCNoC clock always gets an active vote.
Guarantee that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 7e1814f606e9..a098327dc851 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -1066,6 +1066,8 @@ static struct clk_smd_rpm *mdm9607_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_mdm9607 = {
 	.clks = mdm9607_clks,
 	.num_clks = ARRAY_SIZE(mdm9607_clks),
+	.keepalive_clks = pnoc_keepalive_clks,
+	.num_keepalive_clks = ARRAY_SIZE(pnoc_keepalive_clks),
 };
 
 static struct clk_smd_rpm *msm8953_clks[] = {

-- 
2.39.2

