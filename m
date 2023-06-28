Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4462741338
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjF1OA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjF1OAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:00:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441652947
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:00:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so6403355e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687960846; x=1690552846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DpQvDzvuH0Xp0AMTMNqHsvMg7iKZVuGSaKcWrlJnAE=;
        b=G3q5Teif93C8ne/ojK7nfQFEznfIrUrYbQGo4q3+UgouYHEGj8yHk2GVYfJZfXKN9b
         psOZ82P7THTQlbAnOdDEpdSSBfHJHRUVHW3w4V/M0lfV7OnQha4t+867x5JVN2Io9zYJ
         QTdLkEOzGjScKJYZtxdxY1pBngCqkey4ov7w76AjBU7MneM+gjpWpXP75ikvmxIQ7v39
         6ZammyiVyXyO97ZIN0lA3rjMraErrKJJHbcod1jAlaV9M9lw+tIU5cr3324ipwqiVIzb
         DQq5Ta9dYXk10Jjby76OOpeU5s86iwweel9N+0a8f1QnNSyGqlUt2kK9BY2RrhN/NuBd
         7BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960846; x=1690552846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DpQvDzvuH0Xp0AMTMNqHsvMg7iKZVuGSaKcWrlJnAE=;
        b=RSdab2DFWFiEOXfpeHEGPKtW+Rem/9BnpipJPayGeKVqXehtkT8VDj+/2Yrw1uARvJ
         Vtv8JnssPXuajqjvGspvNNbajdJB/0oSKIGgioCLx8B863bzUjzUlqaQvScbqg+kYFV9
         WDD7UAaOXLTFMqinR/ZFGNFvjMdBb0drEIjSnlY9LUOd4yR3yEis2JayuZPZKaz0XuwO
         aAzaJSAvS7Eyq1f3Ft8QXTdiXNaTiNr/avh0f6fZf+Te3etB35QJVLW558/mb9JpzHex
         OssF4Ie2Ni0xOQUUFFdZZAQz+6lQSOkYqVbHy5YFpqWu599zSKNIM1EabUV/TBdhhSUU
         xrQw==
X-Gm-Message-State: AC+VfDwwSCn7mIkDg0xWCo6y4yAbVj+TBWI+tLrYJKxtbzCYQhcP1gEv
        QblF6vYYe2zK4kOqE9qs99UF3g==
X-Google-Smtp-Source: ACHHUZ70CBtljPfPmAwbHHNJ9eo7HT0dwGzBnCX9/S9qo/y5bh9cdOOdxX3XoeZQp1rQo/KpE4S0Ww==
X-Received: by 2002:a05:6512:3244:b0:4fb:8ff3:1f72 with SMTP id c4-20020a056512324400b004fb8ff31f72mr1312994lfr.1.1687960846367;
        Wed, 28 Jun 2023 07:00:46 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651204c200b004f8586ab633sm1941359lfq.279.2023.06.28.07.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:00:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 16:00:40 +0200
Subject: [PATCH v12 01/10] cpufreq: blacklist MSM8998 in cpufreq-dt-platdev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v12-1-1a4d050e1e67@linaro.org>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687960842; l=855;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FetjBqwyZiiZA33u+YRzjkX1LSPicSQMKKdZJvWwu44=;
 b=OHfcT+AKpFDpo67H/3dS4QYFlN1mIkNeaTwlXJzOUd3gWJdKt9nIYv7+5SdkCfVQmUgTzmDwO
 5L/Ngk2Ru0oBreAIWws0NVM5CLgTAfYUeXjng/jvSchaPo6a7pYC24C
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add the MSM8998 to the blacklist since the CPU scaling is handled
out of this.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index e2b20080de3a..adb3579a1fee 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -143,6 +143,7 @@ static const struct of_device_id blocklist[] __initconst = {
 
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
+	{ .compatible = "qcom,msm8998", },
 	{ .compatible = "qcom,qcs404", },
 	{ .compatible = "qcom,sa8155p" },
 	{ .compatible = "qcom,sa8540p" },

-- 
2.41.0

