Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB16A5BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjB1P0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjB1PZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:25:40 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEAD311FF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:25:07 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g17so13713955lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kE5qtocuEKQZmcQnu8pU7d1MvorKMTiIpTuHnp8IGa4=;
        b=RRNTWmHDO9f9TjVnKvzAUhBW18p6cwnxJ10EVuM8khyXpQ+Kd172+fQVK1tC0e8YRl
         FUbODvvXN84ZskjHNFelg8FsL6gviqtAHE8Ng+l7i66+gziandxiRxnpyCYOeaUWxbzx
         6qz0J/4FoTact7/3LDmzbaYv51GsUuMKTcXcMJErpQOOp14Zvw09p8lcPpGbPrO9M5RI
         7kYsAkzKoD4BzzbrMoejgJnO7l0+rSzMMb4VwmKJgJqh8l+YZ/NAmdCYhWrb3qR8PpEr
         1b2Z8nyqUlf6dqbn8ra8TyCJBePAvFGQB3dBqV3vOJO8fkIjWH89Zq8ByyExU2zljsLP
         dn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE5qtocuEKQZmcQnu8pU7d1MvorKMTiIpTuHnp8IGa4=;
        b=ahqmZrL/j0/p9l9HGRIsPCpvneLD9qL39kr7U0Tzo923JtgI9KQxNYb/Eut9gzQM+q
         u4oulsfWlu6iXJogvf+R0tvpnEiYZOcUAl5aRNRmRdNlHT/59tm0tN+cm7LdCHlSr+AT
         ylHtrwie1In4ba9Y/6YNaWng+/eh4Ht0EqKcjwyXjA2+vlUwmWY0P5fvUMiBHq1GdG1N
         qEJOL4ElbjebbQGhVu2r5Cd6bmMWAFKOGuS1+Q//sTI4ucQ4+S4kd/csfxvcT/Kj3N9n
         zZ3T/p31wdrIwJq8NKyLlwuNCFS+cS0ZKnO3n/aBOCf8+8tHSXKnT9LgkCWsFEoDmAr2
         Mwdw==
X-Gm-Message-State: AO0yUKUqdQWdwTdJuzZkGT0ltLq44gwteGKFe/gsCTaAU3NZI7GTB1HS
        JdKDdHwQyPakoy2Eov4ss0R2iA==
X-Google-Smtp-Source: AK7set+FlYasr5pZxVZslOfG11xgRQjPkUPGnKe5ks/4VC8Mu6RGiXXHErfDUrC74z7gaMNOOqvL9A==
X-Received: by 2002:ac2:5544:0:b0:4db:3a92:2c85 with SMTP id l4-20020ac25544000000b004db3a922c85mr986601lfk.67.1677597902650;
        Tue, 28 Feb 2023 07:25:02 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:25:02 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:42 +0100
Subject: [PATCH 18/18] media: venus: hfi_venus: Restrict writing
 SCIACMDARG3 to Venus V1/V2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-18-58c2c88384e9@linaro.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=968;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TA6Y71ujk1J+6LBhrDCzy3CI0cvIyzMJnngRH2CONjk=;
 b=73eGCYgde7y49wr+JZDw9uQEq4HEl69TZbPfizpfeZbAYRX4K4+0qMEOzoJk4g+BHSk19+wmjqKR
 Mrva4271DNcX5bTlY1y4xzXI/+bjdHrPjo+I+/YiXQhvBg+IOKIy
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

This write was last present on msm-3.10, which means before HFI3XX
platforms were introduced. Guard it with an appropriate if condition.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index c2d134e04c30..deeceb86414d 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -463,7 +463,8 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	}
 
 	writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
-	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
+	if (IS_V1(hdev->core))
+		writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
 
 	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
 	while (!ctrl_status && count < max_tries) {

-- 
2.39.2

