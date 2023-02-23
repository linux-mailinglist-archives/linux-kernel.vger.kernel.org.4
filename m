Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1531F6A082E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjBWMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjBWMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:07:23 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E6572E6F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:07:02 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z5so10624035ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17Sj165m9p2RYNMuvknYM96FiMR5+0g8UyAYd2eSrwY=;
        b=OaVrt9YSvRtla+1dIiygzmlR3nNaVMFpvDn384L0qJWtksmJRQUDKCxaZZWVlQCfEC
         yVY/sTl7Z1my97KQY5cLljkTcCh5Hk1vepRrKpPNCuBfYy/njaK8cpcPLZF6P9k23RrX
         /whd3tqZjOeyigL/Piz4Tme2/HxhqOywVC7eefN9C+o45UMgCemRcIaLx7AjDucI2/fH
         aJRFbudDz7f0F7q2soV1Rqw4nVBnaf9hRuLKPWkq3Ewe+zthtl/V3DZBRagdQ3mC9+un
         yeV1cVpGh+DjODjNWd5768OSzpAJoyKiCx96d9mHeUS9JqOOLKta71LvPW/doxbxhdG2
         THaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17Sj165m9p2RYNMuvknYM96FiMR5+0g8UyAYd2eSrwY=;
        b=UIZSzDysIvAPWm4ElKLMStRQ8ehdYjSPDcB8gve9fOfAyC2xNjvZwK5Sz5QhEaFAeH
         IyBYeZ0ulzmfraaZhKoLDsxebwPgQPXdyX/wLHSA1TQpL8DEL2GTCdNO7GYA9TFFQboo
         4U/SCLy3KXFnbvaLH8WdPrTtim3Av11Vc3COranwEn0FDqW30MPaPPzJaWxFAfUSHuUW
         De862ynlxWuIJkrzLFFh+PT3yiouSaYYW8rEk6PzLvStiJcZDLBH8uyH7JwfBeIPCMyi
         RJD0iODKok+RmtZFjnJvdFs8u/ZWqw4tll2SURuovBsjDUAoV37TGJtvsYaA/sTtdLL6
         Imtw==
X-Gm-Message-State: AO0yUKWTr+9xZGNgMYUxuDLBdMNMsUwkUXX9X3s2CvXmI3qpo5iwpV+G
        OlPhXe7ND5+f+xX+gaLA07IKBA==
X-Google-Smtp-Source: AK7set8MP0MVTI3jKda/9hAxOgPBZ+85qvmspDgfRoXhIC5bbZP+ZlbqQXJvF9pw2sqjfvnn59QQEQ==
X-Received: by 2002:a2e:7d08:0:b0:293:51ba:24b3 with SMTP id y8-20020a2e7d08000000b0029351ba24b3mr4316167ljc.41.1677154020326;
        Thu, 23 Feb 2023 04:07:00 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id h23-20020a2ea497000000b0029599744c02sm414838lji.75.2023.02.23.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:07:00 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 13:06:44 +0100
Subject: [PATCH v3 10/15] drm/msm/a6xx: Fix A680 highest bank bit value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v3-10-5be55a336819@linaro.org>
References: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677154003; l=1043;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XyF/fIhqGhaqw/LSLnLQoZLpoApnz2Tm2KTMjRETKS0=;
 b=KNcnjoD9rWmy5mT4YH7OnatzxLE4iAZRwnM2y6dLWueGTxPwo3uCMS0NPrLwqJpUq5uh442AJSwo
 cgRHrMA2AlIAq7g9yAw9JnDnekIYxgGTePs30xvYuP3cIFpemrAR
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

According to the vendor sources, it's equal to 16, which makes hbb_lo
equal to 3.

Fixes: 840d10b64dad ("drm: msm: Add 680 gpu to the adreno gpu list")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index b5017c56fa1b..2c4afecdd213 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -885,12 +885,18 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 		hbb_lo = 2;
 	}
 
-	if (adreno_is_a640_family(adreno_gpu)) {
+	if (adreno_is_a640(adreno_gpu)) {
 		amsbc = 1;
 		/* HBB = 15 */
 		hbb_lo = 2;
 	}
 
+	if (adreno_is_a680(adreno_gpu)) {
+		amsbc = 1;
+		/* HBB = 16 */
+		hbb_lo = 3;
+	}
+
 	if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu)) {
 		amsbc = 1;
 		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */

-- 
2.39.2

