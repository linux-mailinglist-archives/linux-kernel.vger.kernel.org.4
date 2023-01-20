Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7057B675F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjATVBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjATVBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:01:16 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0DC8BA8F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:01:14 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mg12so17003117ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9zrT9/RXPPXhnEVoW0aJsCVkHusFjlZ161d+oX04STE=;
        b=VhpZPNA/QWJFVRprlhHEdvq+/+4H7v3FVGVD04GyVD/EUEJFdD8RyMe84kgUEPUhWd
         CSPM+LH1fCURhYgTQa64yUSi3WnWL6zjKgNrnJwZnLqsAmscVxGSMUxPpNSJBAWPLAR6
         lUsuDtnasVrrYyhkGq9VB/ZHvxzTw2o3nc/q6OBvDQRT+WN28CE+7zlbdJTO/DrtdM9P
         kAx4wx9IGN1sWaBT2h3CHNexWt7VBNhIZ3a/7+uxHYWSNjz8Z+AJSA1c4l4/oVMG9q+R
         ZHPNZRWukpuWZCcns72TNlvqN2y/UGD3CjG94LU1GCQloe+M1+8iPwj7GTWVCD3mPjBg
         2frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zrT9/RXPPXhnEVoW0aJsCVkHusFjlZ161d+oX04STE=;
        b=7DWliJsvjCzzEGTxRPCWoI94cVb8mgmpC6c7se/4rRozzslTtYYvqOJrrD8JAvjm/n
         +BoZJukxK9/IQommxGg1ySa/Pz37T3hnhrjw3p9OX8I2XbGKux/hmh2nuS0rmwPHBCIR
         oxzsajesxzT64azDPgWESy3lNuBfmWOXLVnRpe3UoD/2lffxvAYm3A1EbFj0q+/1ZJmk
         uSqO6dcSX0qY2dXNGcxPL6PjyueCHy9d9vbGuW+KitjOkmfoAN8dUO3MttPsas5WsI4+
         1uFV2XMJCnjDaF0FB+s1iszA+3gtbMWpD0G1uIY2IdzPsQwDcSTIct9w+PbJzb7+Cu9O
         UbNA==
X-Gm-Message-State: AFqh2koaO5dvEB3tHm+sUtK81tPVgKSlkWQ+qHGJf9Wa2Tf8LgxWcTwz
        Vbc6MIFuG44e0Ozk+j8l20e2iQ==
X-Google-Smtp-Source: AMrXdXuKJBPk9bfYe2DX44R2Ihfk454JoHlIi3euiHm+P/rLKqXOFKfrzF2JNOubZZ/RoJp5TRlvPg==
X-Received: by 2002:a17:906:3741:b0:861:eb6e:8019 with SMTP id e1-20020a170906374100b00861eb6e8019mr14749113ejc.69.1674248472796;
        Fri, 20 Jan 2023 13:01:12 -0800 (PST)
Received: from localhost.localdomain (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906595600b0087221268e49sm6581229ejr.186.2023.01.20.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 13:01:12 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] drm/msm/dsi: Allow 2 CTRLs on v2.5.0
Date:   Fri, 20 Jan 2023 22:00:53 +0100
Message-Id: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

v2.5.0 support was originally added for SC7280, but this hw is also
present on SM8350, which has one more DSI host. Bump up the dsi count
and fill in the register of the secondary host to allow it to probe.

This should not have any adverse effects on SC7280, as the secondary
CTRL will only be touched if it's defined, anyway.

Fixes: 65c391b31994 ("drm/msm/dsi: Add DSI support for SC7280")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 33884ebd2f86..6d21f0b33411 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -223,8 +223,8 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
 	.num_regulators = ARRAY_SIZE(sc7280_dsi_regulators),
 	.bus_clk_names = dsi_sc7280_bus_clk_names,
 	.num_bus_clks = ARRAY_SIZE(dsi_sc7280_bus_clk_names),
-	.io_start = { 0xae94000 },
-	.num_dsi = 1,
+	.io_start = { 0xae94000, 0xae96000 },
+	.num_dsi = 2,
 };
 
 static const char * const dsi_qcm2290_bus_clk_names[] = {
-- 
2.39.1

