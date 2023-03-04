Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5093D6AAA09
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCDN27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCDN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:28:32 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890817EEF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:28:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s22so6999371lfi.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4W0qLZoGn/Gqn60OVKnf/AngNaZtJaEGiMe1FryGsU=;
        b=t7GDasSGmRW6/G6++NRMQTEai0gAR1Tr/HKAP410D3++4lhe2qTFz/0Js921sgPE86
         oC8LkReLaXxo4D/7hBZdIAT1VojKs6GYqpq17hEwV/mcocn/0Vb9M0WImBWciUBoshG3
         /k6k1kxobJeBjKTKFtUXPrh+vAck42t/YD1fuSdQ2chnx/CMvdIQOMDdSoKvh6z1vjOD
         x1vVjKX5Fy/1fCgB2pYbcOUESNPaY1cK6ooVmurMx4q6foNTuVcL2SXVL2IqVYcZTbCY
         3Oe8vdRezkx5ZUvHqz929Ldq+vt1dbTwNpmuXBD42eKYVqvzujMR21Rp71MCwKN9kncg
         9Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4W0qLZoGn/Gqn60OVKnf/AngNaZtJaEGiMe1FryGsU=;
        b=u8iPsPEN0/EfMsWNdZ1hV5dB0tOWZGzyyJh3Xq9FzaJI8f563ZcqqULqUnpbH0rW2R
         I7+bgIFDhJC2axIfE7bFxFVFRyxMH8+CJUim1s8AQP+IL22D13NgHrhpOZuWYWzFLBEm
         GC6gt2E6OxMlOtRgaPI3uiCqtl5lFXPV8YLIPvL1T0Rsu7sNyPI88q5dK7kCZnNr7bmp
         KRZk9Alks8ZDumL9nVztyz3QZpJFRI1+N2CPtnEjI6fJGqv7MsOAnei3qAJbycTMUCMx
         vhUSTCxTQ8dKGPGd2UPOmcxPFO5hLmAww4/qUIr7I0cOdqKXOkpW28ZzWj5cr5UHqPUt
         FhNw==
X-Gm-Message-State: AO0yUKUG9UShBpnercTAxu0c5OdbTr0/IN2znx3Knu0ERWg6nJDWjtLb
        aSiV9xQ3urKyBp5qBrOkJb5TQg==
X-Google-Smtp-Source: AK7set81KDr49TE95jE4yCGm0fSPxTPiQN2l3n2N907xh/jES2VsuKaVu3ZA9eyQrqcu0Ns0wVtpcw==
X-Received: by 2002:ac2:4ac3:0:b0:4b5:3505:d7f9 with SMTP id m3-20020ac24ac3000000b004b53505d7f9mr1549589lfp.35.1677936480693;
        Sat, 04 Mar 2023 05:28:00 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:28:00 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 14:27:51 +0100
Subject: [PATCH RFT 16/20] clk: qcom: smd-rpm: Add keepalive_clks for
 MSM8953
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v1-16-d9cfaf9b27a7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=783;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VYT274DWBTR4U05l1ygfBxvGIehUAolvPL5f0i6UxzU=;
 b=ME5iN2KCMx7f1jQnQ2cjWFVyYIXX7qjnWt3zmxT2ptfnWHFEcMZ5d4Lm5AjRC2WozwYUZifqxaMp
 8FKc2cFFCTafSw/z8TtWgclbL6Uo1z0xCyW2/1rih3UpzElMYMDe
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

MSM8953 requires that the PCNoC clock always gets an active vote.
Guarantee that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index a098327dc851..dfcb2020b7b1 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -1104,6 +1104,8 @@ static struct clk_smd_rpm *msm8953_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8953 = {
 	.clks = msm8953_clks,
 	.num_clks = ARRAY_SIZE(msm8953_clks),
+	.keepalive_clks = pnoc_keepalive_clks,
+	.num_keepalive_clks = ARRAY_SIZE(pnoc_keepalive_clks),
 };
 
 static struct clk_smd_rpm *sm6125_clks[] = {

-- 
2.39.2

