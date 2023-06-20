Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9E736B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjFTLnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjFTLnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:43:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A321717
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:43:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f841b7a697so5593682e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687261408; x=1689853408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FQGGkAc9RxTjTrS8MIbdtUiqKpEsk3KUOOFA9RhmnQ=;
        b=UBGl3xSqm1baAnA97pS7lBBrNA4ONxeaCJa+M413+97WO1aQ0VW99QzpXFl7Sieghl
         jmqWghz03MUDY3j6YwlU7qmAcxOrwgVAFzXyY/UGF3IdayyKZDNLQmrw4coRsBsoXhqO
         ffko/DlMu4McGyaKZmiEpNH4ytqMR+Fb28HnnBTyVsNWc38WjKbLVuBZgzR5LrGjna3t
         SS0V1ekAJD63spTAl1SCypaK/oUeZwVzBEbrRzB3lw2tKWY/Zz1b59gdVZv7ja1FZB+u
         VOD9x0u62SEEf/tU3PD7Ms8ekw3sSd2QHc3JCNtFhDJI6FBKOylY8o9kOQGFxTu/C93A
         PE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261408; x=1689853408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FQGGkAc9RxTjTrS8MIbdtUiqKpEsk3KUOOFA9RhmnQ=;
        b=Z7J/EKs2wop0R2KiXBm1RG4XBOpyFN/2ddop5diJLXd089WJ4k8CmTrdfmN8sDIJKy
         xQfbRbLQNk/3FIYdk44+MA2pA+Sfd8E84t08V0Rv+CbtWOnLy2VPVkMeCm6ZxB0zbjTf
         X0XaPqyXOXidbEi9SMWKJLpMVKAtpzt5zCwxx3NOMmzmatyxCvNOrO0kGsa+BEOVLoXr
         XrAlGGnzEVtSju5d7qKqxNS4YWkPErhkDTbqpab0ywxkXouUT3VY0q3DCQSWmKL+yW4n
         PmUi0Fr2wz1pgVQCh663lCAukTvT7VhP2RaJ2mwfz+lISXU0ctT4tKpNJx5rNhiS56pd
         +F9Q==
X-Gm-Message-State: AC+VfDzFD7L231Q4Sh+HE/Flf0EYs1XB8eAXFdVFiTndHEAKO4rUgytw
        j6bvBLM08dPnN1AAf3Spcx+6FA==
X-Google-Smtp-Source: ACHHUZ6TnekcsLa2wNSkMKjz2BwqGb90LgHv+cwbK+WYjf0k2LYG1JqoXMGbp84Q5l4knz5sIbcHtQ==
X-Received: by 2002:a05:6512:3109:b0:4f8:6534:9a5f with SMTP id n9-20020a056512310900b004f865349a5fmr5445370lfb.36.1687261408408;
        Tue, 20 Jun 2023 04:43:28 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id v17-20020ac25591000000b004f640b0fb04sm324158lfg.212.2023.06.20.04.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:43:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 13:43:20 +0200
Subject: [PATCH v2 1/2] drm/msm/dsi: Use pm_runtime_resume_and_get to
 prevent refcnt leaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-dsiphy_rpm-v2-1-a11a751f34f0@linaro.org>
References: <20230620-topic-dsiphy_rpm-v2-0-a11a751f34f0@linaro.org>
In-Reply-To: <20230620-topic-dsiphy_rpm-v2-0-a11a751f34f0@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687261406; l=890;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=buVQjKrJgv7wbUnC7ZgzaKf+8COn6Ol+mrW/ngymkWo=;
 b=/85q0mWQJ5T3oFFwScs4/F3tDkZu+UWJLiVNpaitT9ghjNJivTGYrvtDPlQA8FRkDIregMkuD
 0uOuTGShsmHBq/dKjr5gKhHVyS6+UPlN8aV2qZqbHD0Rypalbpc56MS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper has been introduced to avoid programmer errors (missing
_put calls leading to dangling refcnt) when using pm_runtime_get, use it.

While at it, start checking the return value.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 9d5795c58a98..2f319e0eb74f 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -516,7 +516,9 @@ static int dsi_phy_enable_resource(struct msm_dsi_phy *phy)
 	struct device *dev = &phy->pdev->dev;
 	int ret;
 
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(phy->ahb_clk);
 	if (ret) {

-- 
2.41.0

