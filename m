Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922E56ADEC9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCGMcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCGMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:32:08 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62E477C97
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:32:05 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z42so12916779ljq.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678192324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcymAsSfgo0T3+vs1DGeeROeS5a7cMEN49XDIkMpxfg=;
        b=MpcYncKvmfwJI9vzqRxHDqSv5X7Je8evTDWTOx5wvFHZcXomu1VweUaiPNyzlsduEm
         4P1Q1jBSFlnB+gItEhtlEcregtrwdezxyGMZV5GgWfiFA1y4Ij2C+LIIG7hv9BxSRh//
         wlIPD93XE4CKqzxO8zcZ40MEEoXqE2prYPonzjp2277dKoIqCxhxuqec+20N++G/XI8E
         CvnJaEqWl5WYsdozc12OfHWvO/FD6ydGxLe/ZZ8LQ3tBUi5emx9nic8MuwyJB0iJKhmi
         7J+f//sZon4XMK6izt1ffXgPicd6ZR+8xRnOJWEvsjpzgQttiWAULtI8lgkl5CDWsIoD
         OytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678192324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcymAsSfgo0T3+vs1DGeeROeS5a7cMEN49XDIkMpxfg=;
        b=drfMyBPbQPK/y+xdAMwW1kHamRYxj/rAnowEbxtItQNVeNutdYQs49SweZnGCSbrPT
         RsL35FWSwq2Rpw1wfNF04ddhmmgss7Ge1GKrkxS7motEmoElLXJps6rRUY7z7Jg3fT4d
         82Qu76VgdfTJ3paJIr5V84pTFMrtqvpaJl2ee38bcESAOQdLhVjtKyqoG7PFS/R7KR+L
         EPK0AHoQZfGxOFhVdLrox9Aslx0+mo97brYXm2ITHdNejbrdcXXRl7v6gAVFMkV2zkNA
         GmBCG858PTkp/t378lisgCsQl6aM3/yeejbRqRQ0OYWRde4unyTpiAtSLcArbZx+pXWZ
         IYrA==
X-Gm-Message-State: AO0yUKW2c8GItLNRoa+I5YnH1gtegXV/CDFXd7lR1S03ABrKqYYBw/Nn
        PbOV5CjtWoup+Vj5JfYIxTw7+A==
X-Google-Smtp-Source: AK7set8Xluj3z4kdkoAfA+C0uJMMYeVXR25gUn+Ad+6Q6ioHztyMvL9LUJvm9yiW2GZGzgdWngcF/g==
X-Received: by 2002:a05:651c:1682:b0:293:2bf4:d939 with SMTP id bd2-20020a05651c168200b002932bf4d939mr4188139ljb.12.1678192323932;
        Tue, 07 Mar 2023 04:32:03 -0800 (PST)
Received: from localhost.localdomain (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e7814000000b0029462e98c07sm2156501ljc.35.2023.03.07.04.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:32:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] clk: qcom: gcc-msm8996: Update the .pwrsts for usb gdsc
Date:   Tue,  7 Mar 2023 13:31:58 +0100
Message-Id: <20230307123159.3797551-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307123159.3797551-1-konrad.dybcio@linaro.org>
References: <20230307123159.3797551-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB controller on MSM8996 doesn't retain its state when the system
goes into low power state and the GDSCs are turned off.

This can be observed by the USB connection not coming back alive after
putting the device into suspend, essentially breaking USB.

Work around this by updating the .pwrsts for the USB GDSCs so they only
transition to retention state in low power.

This change should be reverted when a proper suspend sequence is
implemented in the USB drivers.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
- Reword "fix" to "work around", mention it should be temporary
- Add TODO:

 drivers/clk/qcom/gcc-msm8996.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index e16163706735..5e44d1bcca9e 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -3455,7 +3455,8 @@ static struct gdsc usb30_gdsc = {
 	.pd = {
 		.name = "usb30",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	/* TODO: Change to OFF_ON when USB drivers get proper suspend support */
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc pcie0_gdsc = {
-- 
2.39.2

