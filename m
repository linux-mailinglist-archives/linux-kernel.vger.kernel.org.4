Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EC4694826
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBMOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjBMOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:35:35 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8331554C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:34 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id rp23so32343285ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKhIhUE0oR3+5sylAoN6LZ0U0hIcCp0rLf+O/bLFT0w=;
        b=aWMe155AwRogZuqhwLJmxHXC4Nmo0Tm4sZHSxaz1jbsMfy+B637D4oZy/5+K88dXVt
         TusFncqgjzE1OBU3OJGB1t3OZ3iBenVXt2JH0X4qlx218FAVQMWhhIWWKUlq76030LM/
         Q1z8r8AdV6woiRcLB/0Jum2YgC1c29NyNuEcRsLzt26CR56tlAxaDyptahWSKy86c0m3
         5BQECANonPgGaIHYAQ2t7KpiHBrW/GuZU9eJi1xY3Ot5c89jJWLaCS+FSBxFoAi8Gtye
         l0iRfOJ3e3A9aYV7QUqwb5ukxJ8OA9bREV3OUcRhTP1FrgAcOeEuhBvHbZvGP/GZOJdU
         Gqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKhIhUE0oR3+5sylAoN6LZ0U0hIcCp0rLf+O/bLFT0w=;
        b=UaAD/V0NVlfWsansN053GEFX1VFxrsgNKWF5kP3p2pMQzl0bs4u6f6fEbf4C4qkt5R
         7gQRa5yIjFSQz8YGJtCnkllSiV5+P6ZHbiAH9d5Ecwm3Jp6wXbY/W0E/whgzyhZLaw8N
         MYp8NwPw458mRVlfzYKjuqbNqmM+ZqZIeYqihqoDRtP7bQWOCFeLwY1+qtjtkNFaTbjP
         WboRKj3kcRH/WVgQ+thCu1eOoj60q1ylQvN0EkWrFz6z0wgc7qR7SUmpsz0tor+IuQtN
         70JoLlb5jWzfiX1a1da+Icr0PGUH8yxVifWoJksMZYRBenX2fvmBIPvt7syWVJlSGGr3
         IYEQ==
X-Gm-Message-State: AO0yUKV11Y0MR6MYJkXpyJOKTKP2H64qx2B4NrSvS81pH61SQYAby6yD
        ajRbStCdczGfMzbEfLs+AFJ72w==
X-Google-Smtp-Source: AK7set8SC/1Em3oIVASMUaSM29X5LOu7B5V0z6yKikFC7kFDvVe6X4Guwvwf7fyrIy1tu/wqOhZDdA==
X-Received: by 2002:a17:907:a420:b0:8b0:f58d:2da9 with SMTP id sg32-20020a170907a42000b008b0f58d2da9mr6900524ejc.64.1676298933332;
        Mon, 13 Feb 2023 06:35:33 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id uz6-20020a170907118600b0088a2397cb2csm6927186ejb.143.2023.02.13.06.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:35:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] soc: qcom: rpmpd: Unify Low Power Island definitions
Date:   Mon, 13 Feb 2023 15:35:17 +0100
Message-Id: <20230213143524.1943754-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213143524.1943754-1-konrad.dybcio@linaro.org>
References: <20230213143524.1943754-1-konrad.dybcio@linaro.org>
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

Up until now, we had 2 separate entries for VDD_LPI[CM]X and
VDD_LPI_[CM]X which both pointed to the same RPM resource. Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 7d9e762232ea..8ba025c4eca3 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -149,11 +149,9 @@ DEFINE_RPMPD_PAIR(vddmd, vddmd_ao, SMPA, LEVEL, 1);
 DEFINE_RPMPD_VFC(vddmd_vfc, SMPA, 1);
 
 DEFINE_RPMPD_LEVEL(vdd_lpi_cx, RWLC, 0);
-DEFINE_RPMPD_LEVEL(vdd_lpicx, RWLC, 0);
 DEFINE_RPMPD_VFL(vdd_lpicx_vfl, RWLC, 0);
 
 DEFINE_RPMPD_LEVEL(vdd_lpi_mx, RWLM, 0);
-DEFINE_RPMPD_LEVEL(vdd_lpimx, RWLM, 0);
 DEFINE_RPMPD_VFL(vdd_lpimx_vfl, RWLM, 0);
 
 DEFINE_RPMPD_CORNER(vddsscx, LDOA, 26);
@@ -324,9 +322,9 @@ static struct rpmpd *qcs404_rpmpds[] = {
 	[QCS404_VDDMX] = &RWMX0_LEVEL_vddmx,
 	[QCS404_VDDMX_AO] = &RWMX0_LEVEL_vddmx_ao,
 	[QCS404_VDDMX_VFL] = &RWMX0_vddmx_vfl,
-	[QCS404_LPICX] = &RWLC0_vdd_lpicx_lvl,
+	[QCS404_LPICX] = &RWLC0_vdd_lpi_cx_lvl,
 	[QCS404_LPICX_VFL] = &RWLC0_vdd_lpicx_vfl,
-	[QCS404_LPIMX] = &RWLM0_vdd_lpimx_lvl,
+	[QCS404_LPIMX] = &RWLM0_vdd_lpi_mx_lvl,
 	[QCS404_LPIMX_VFL] = &RWLM0_vdd_lpimx_vfl,
 };
 
-- 
2.39.1

