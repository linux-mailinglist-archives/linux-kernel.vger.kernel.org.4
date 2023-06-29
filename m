Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D004C742E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjF2UgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjF2Uf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:35:59 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4DC30F0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:35:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6a16254a4so17775561fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688070955; x=1690662955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEhHQ8qdRfQQVMmnLHDVdeTjikaeU7SDTha8pASydDI=;
        b=m3hhlMn60IL1waEjrx0D33Ti5jOy4qgbY1zwxUHKfKVTEGzhFuNiPbZ7tmI6qrrSH2
         4aOJaC0opR5xQsPOukW/lvTykomgPtkcEXH4CMAed1wt1M7+Pp62YjYMm6zXnL2Heexa
         8cD1jaM/oTvEiUApCdMpYAOlSO+7ylXRRG4xO1/b1ekgyomZP54dv7Ky/rwwocfSSN69
         m6ZrSmUkP5fFNS0t9sf+/fOZozaxQ6UNxQWxbjnRXoMpEgs+V6ev4HEM6Fvly6zpfwwv
         HsOuAh6YnbqYakHg9hITq+Bya04sWPNalfeDX9TndlCdEOU7519XytxyIlR6GlcO2FIK
         24rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688070955; x=1690662955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEhHQ8qdRfQQVMmnLHDVdeTjikaeU7SDTha8pASydDI=;
        b=OG2eKzS/o6QDU+yC27kQP7NcZpjLi27EfBCsbhgkV5wmX5pmAjuJtCeXLnGBOmHuEK
         NnDSQJ8fzKtoFEOGwzoEBS9AxkCl5SN2yYP9/RqJuAWXJVXHdY8J2aaz2ZmCkpIe+Dn8
         PtJGtfoabkaignn0WPXRWqRygO0q4xVJAXxgGK9x4+9x8Zg/wfzUYZKvn25l+fg7iNii
         zoWqs41j+4RkG/PjEWTHoH6OJ1RQnE3MC8529iW0uxkGX2emi4LCYaOT1xAbo4xCT3re
         Q+kxHNvrkNVvG9ewtuNrAYR1vYsS/ARZgenaSEmLfXQBWVaIwOHRteQ5CAS2DQzTTntx
         bqJQ==
X-Gm-Message-State: ABy/qLarAbyqJB5IvgluHPdQ/wF4H0vYgGueu5kaDkfPA4uodhjjhCiY
        tW4g/rpAN6Aw2Mk1w7sKrPsfkQ==
X-Google-Smtp-Source: APBJJlFo0T9+tZTTTTFhfzWS0HOJF58QbYMK9rRBBBCNxiXUoTICAC0SLWQJVYDjsz9BS/wGW/cUSA==
X-Received: by 2002:a2e:494a:0:b0:2b6:c9f9:9f8f with SMTP id b10-20020a2e494a000000b002b6c9f99f8fmr577770ljd.4.1688070955475;
        Thu, 29 Jun 2023 13:35:55 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id k3-20020a2e2403000000b002b6b849c894sm1136008ljk.111.2023.06.29.13.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:35:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 29 Jun 2023 22:35:44 +0200
Subject: [PATCH v2 4/4] drm/msm/dsi: Hook up refgen regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-refgen-v2-4-6136487c78c5@linaro.org>
References: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
In-Reply-To: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688070946; l=1019;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bdVFkIHME+ksW97iOZJH0yeZoPTsVUfCpblAjJVbJjI=;
 b=WWHSrbYLRRkudi8WmumNn/DjTCsjM+ZBe0IDArrKqLIbchE2qvRZwS1cjEwKIOOjoGwojapCH
 lf+swQw2gHODxIICQ93jYJ+yf4+oZOiY1Zo5FrbmyCxLXFFy07oqzBB
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consume the refgen supply on configurations that may use it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 8a5fb6df7210..1f98ff74ceb0 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -160,6 +160,7 @@ static const char * const dsi_v2_4_clk_names[] = {
 
 static const struct regulator_bulk_data dsi_v2_4_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 21800 },	/* 1.2 V */
+	{ .supply = "refgen" },
 };
 
 static const struct msm_dsi_config sdm845_dsi_cfg = {
@@ -191,6 +192,7 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
 
 static const struct regulator_bulk_data sc7280_dsi_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 8350 },	/* 1.2 V */
+	{ .supply = "refgen" },
 };
 
 static const struct msm_dsi_config sc7280_dsi_cfg = {

-- 
2.41.0

