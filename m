Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF78696BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjBNRdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjBNRcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:32:45 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE712F79B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a10so18464781edu.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1VnqaeSXrO+gCHDWuaerBua6k+Y5bwVYRUkuUYOrlE=;
        b=YeeydWfoX2xfVh03xRn1ywPqXFmedWgX1EOrwzb3sUM0wWK8I6R8NL20s9kLEsC7Pt
         dII5UE0fby2W2wTs5fQKq5QNNLUZM2OgnezieqWsn9CTlG4JDeNEfxLOtNfVu/spvMbh
         BICjgaTIAzY87jk8CI1v3ZKWz695+D6jvea7jvz3PYjzuki+fvLevr2HCvcyT25cny28
         fSLFV3UX3VvCU9Xfgfu/216qdMVeQ3lXFcP/UCNfvJv+uhfM7Mp+GHw6kweh9DM+c6/R
         jVXBjr6SPlVCIK2pHwss49m4QatVKSFwZTHdRtAVT34Y6u6f+7BuoPShldWw9q+ImBmz
         Ruwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1VnqaeSXrO+gCHDWuaerBua6k+Y5bwVYRUkuUYOrlE=;
        b=uqsvZb6W/fc9JK1G11f5TvWJkklctVFwlTZDbG1VK/DDW2umrjgZlkn6+hMzmO507g
         2dG+YxaP75olV8DJIxlzDrkvg0B5MZpS679rfCiOjjNcKNFcPHoQGy5GZasuhnTZbNEI
         0mhpRPPWfaSwJYotwdrsn98mkzyI6YnTo7Os5E9/85Q2tIhzPVKVCsdCSf9qbY92lYAt
         m7jN8A3usuLn6Gp20zuu7zoBnTKje8X6J0FOabF8WsHmWOkACpDlcxMANON7bBZ3TXES
         pfiDYHBuHhhlNpUtygBRzBC3D0Vf0LlEwAHlBcP9/A3xSTakf2SXvWzQLLyaMvCZzXod
         9LXA==
X-Gm-Message-State: AO0yUKUb3qChMPSmNXfmhqJmY0zO6oHb5j3qLb/DobRIoRBany/zQiQj
        xml4w/MqinfXV3l+NKA3+ja4NA==
X-Google-Smtp-Source: AK7set8YiZfP/xwaOzQhPzlA/7gYfk6dMCXFLDqoEk9YJK72ZblW4knHYFjE0YxrGl+/HlIxgI5c9g==
X-Received: by 2002:a50:c304:0:b0:4ac:b2dc:8d51 with SMTP id a4-20020a50c304000000b004acb2dc8d51mr4339498edb.38.1676395944230;
        Tue, 14 Feb 2023 09:32:24 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id w8-20020a50c448000000b0049668426aa6sm8325787edf.24.2023.02.14.09.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:32:23 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/14] drm/msm/a6xx: Fix up A6XX protected registers
Date:   Tue, 14 Feb 2023 18:31:41 +0100
Message-Id: <20230214173145.2482651-11-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
References: <20230214173145.2482651-1-konrad.dybcio@linaro.org>
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

One of the protected ranges was too small (compared to the data we
have downstream). Fix it.

Fixes: 408434036958 ("drm/msm/a6xx: update/fix CP_PROTECT initialization")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 503c750216e6..d6b38bfdb3b4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -690,7 +690,7 @@ static const u32 a6xx_protect[] = {
 	A6XX_PROTECT_NORDWR(0x00800, 0x0082),
 	A6XX_PROTECT_NORDWR(0x008a0, 0x0008),
 	A6XX_PROTECT_NORDWR(0x008ab, 0x0024),
-	A6XX_PROTECT_RDONLY(0x008de, 0x00ae),
+	A6XX_PROTECT_RDONLY(0x008d0, 0x00bc),
 	A6XX_PROTECT_NORDWR(0x00900, 0x004d),
 	A6XX_PROTECT_NORDWR(0x0098d, 0x0272),
 	A6XX_PROTECT_NORDWR(0x00e00, 0x0001),
-- 
2.39.1

