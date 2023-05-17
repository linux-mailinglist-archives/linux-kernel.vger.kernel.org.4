Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B55706EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjEQQuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjEQQuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:50:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1778E420B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac8ee9cf7aso10404921fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684342220; x=1686934220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xbg/GarYLH0aFj2Z0GcGyUdxXKd4AWIEjgCUU5KwNKM=;
        b=zMaSSOs9zSEtB4oW2mhF2Q2/mXwdY7jTNC+h1bBoN34mmDx29JN+E/4OdpCeDpjp/v
         E6TrOiDrPwfFRRx/pYbm9kD7BAds9kRPwgy+6JTWZa+Z4gC9SBbo6xl/0nn4m/zUOF0U
         qJFfGb40qFoJL3w/GfllmK5PDlBXDSFslZJDroYHLd/dKTH2LdxIT6RIQAyEDwNFhUie
         /6iQmM0aqaaiKxjCUAEz8ZZOI/Qo6Iy9I6qW6rAktG+oZyibRB5RLuz6a8ccI8/H2UR7
         7tuCVIld7pBvOWWlc1Y1W47Ob/psq38Gjwa8CXy5shBFgUsEETqNHWYth4ADmPTavRlX
         R6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342220; x=1686934220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xbg/GarYLH0aFj2Z0GcGyUdxXKd4AWIEjgCUU5KwNKM=;
        b=lpJe5Ja/aonSCY307WmYNzPvOMGp8BULthb7DY3tEvTyF78nxqZoz/z71nfrd1ultI
         KhbpLi3olX59xuKsmwESrp7LwqHze3owB8AE6dIW24Hofz75Xe03BC4oKXpeTdUeaqy6
         smWvf0StYvvrkwJToB5PvGJTSeNXJy4ibuM7dxk1eKfLj8tK20dCAEKoQNFiV/KSNtsb
         yd65TEYXmiM5GmJv3Qp2y7Er+eyxWnQnRDWmC/shIrsCwR62NC8+e47vC19wd154FWRI
         l1vbJwVXT6l5xveC9G/Be+NRQ22aE8gm+xMiL9tafQhDRmo9Jeh2NrcTcLXz/D0E27aW
         bedQ==
X-Gm-Message-State: AC+VfDxhSfHfTkB3gfgjaw1YCkydkmbe67KTTfSpZAUH6INmt52pknqj
        fdpEXKYimF/sUMrHRHQvDcFvLabUERJhjTjMbgw=
X-Google-Smtp-Source: ACHHUZ68sDc5EhoGFkHKlmYBQ5vHiLc5iApWhRpmEfpf2p+HvoGffqCO3CaUyRlRQjob+m2n7YFuOw==
X-Received: by 2002:a2e:9252:0:b0:2a7:6fee:2503 with SMTP id v18-20020a2e9252000000b002a76fee2503mr10225196ljg.14.1684342220351;
        Wed, 17 May 2023 09:50:20 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id g6-20020a2e9cc6000000b002af0e9abaf6sm159224ljj.131.2023.05.17.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:50:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 18:50:11 +0200
Subject: [PATCH 4/6] drm/msm/a6xx: Improve GMU force shutdown sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v1-4-7a964f2e99c2@linaro.org>
References: <20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684342212; l=999;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tIqOHRwnY5c8M0EJh8c6iF51VO5nfDTSDxvclL4zDow=;
 b=ippU5bfqmqMFyeRemvIfdDfB/dEI0Dag1wtnOk8dtad5ZqSn5m9G/Fn+WuYt4/235ZmGWag1a
 ysNfvVb+q/HCrjjoG85N3/1nkGUPR6jMjj0y9YHWyEaawakOzT8zf10
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

The GMU force shutdown sequence involves some additional register cleanup
which was not implemented previously. Do so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index ea6d671e7c6c..8004b582e45f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -930,6 +930,13 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 	/* Make sure there are no outstanding RPMh votes */
 	a6xx_gmu_rpmh_off(gmu);
 
+	/* Clear the WRITEDROPPED fields and put fence into allow mode */
+	gmu_write(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS_CLR, 0x7);
+	gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
+
+	/* Make sure the above writes go through */
+	wmb();
+
 	/* Halt the gmu cm3 core */
 	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 1);
 

-- 
2.40.1

