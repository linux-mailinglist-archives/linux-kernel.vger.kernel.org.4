Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB46E7D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjDSOmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjDSOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:42:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5DC6E80
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:42:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id he13so22242061wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681915321; x=1684507321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNjgEw1XFUwnMr96e+2CQ6Lo6q2FDtNyKhqD3dmTUrE=;
        b=4LuBgs9yLJSinqw8HSRzEzngPmX5hzcqhMf7QTeuslRyOioxSoXH7W1tHLPFVxL8Dc
         LKPzpPKd7dgx+TNyX9PyRaBjvqPW0nmct4PZ7GltxoAb0fWMBgWEgvBl5vVBVuxGQFYv
         MJ6vDW/SShPCy0/rw1wLYMJiDyk5Hvf5QbaefGOwazZPNGr0ynmOWszW+eNNydmSaXGT
         xzllUv1g1NPH9oFVmm7w/81fjtbJfJd3lm7gT735eTSwdtHtsdwJmk8Qfra9H4une67D
         W8BbPPVyYV6YT2A/mFNcFiRECiJ1eO4/AV/hWJYIKltcABnR4VBLce1ghxewvHpjG9cw
         +iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915321; x=1684507321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNjgEw1XFUwnMr96e+2CQ6Lo6q2FDtNyKhqD3dmTUrE=;
        b=cWLGsAQ3GBWNj7PWYD/9MUH4XjROtAg2faS1dTQWgdWwJoiY3i3vEkQIAhmT+niSWA
         A8ZoDr3FEXaHhjAWFJI1pIxW4zw3u22/zSVygaBN0osMQUhLdZ8i4RsW4D7vygwqId4V
         bLID0f6/XHIXF6lLH9pyfpdW4404sSK2THu5/SmWuqTLplG7iS8wxGazTQK+97QqWcAE
         Kb9GwA/O7zvv40x8CX6qEt072pWTI0mUkrz8YAlnCkLEoOF1nEYTAmnEzn+tVM1UiAVZ
         jcJDDF/8ei/XVuMFhmNZv8qsI9EZRK9NclqDbWUMuePFhm+enC9zvmkWcjqQgHghH1Qk
         3gdw==
X-Gm-Message-State: AAQBX9eylXadnqLUKg8HVnLx8LqKoWpRs9E4rouBvq/LLSHJ1whe4EbX
        nV65vIWqMekjT5t9x+nGpr18
X-Google-Smtp-Source: AKy350YIZQJc5mHrOF4rjTE+t8DJKPx3mv8uZ6JW80wdo5VzHFNPb+JI8VMqvJYSCsJjOCkMBCPsCA==
X-Received: by 2002:a7b:c7d4:0:b0:3ed:418a:ec06 with SMTP id z20-20020a7bc7d4000000b003ed418aec06mr15495212wmk.28.1681915321030;
        Wed, 19 Apr 2023 07:42:01 -0700 (PDT)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003f17131952fsm2388519wmi.29.2023.04.19.07.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:42:00 -0700 (PDT)
From:   Arnaud Vrac <avrac@freebox.fr>
Date:   Wed, 19 Apr 2023 16:41:18 +0200
Subject: [PATCH 11/11] drm/msm/dpu: do not use mixer that supports dspp
 when not required
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dpu-tweaks-v1-11-d1bac46db075@freebox.fr>
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
In-Reply-To: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnaud Vrac <avrac@freebox.fr>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=774; i=avrac@freebox.fr;
 h=from:subject:message-id; bh=eCHzSh6ygzKMrynLk5I85+wK8ZD9bT9L4MBgozHvN38=;
 b=owEBbQKS/ZANAwAIAXED/9m7NDSrAcsmYgBkP/2wtV1Bh/RNv/ZG/8M0oZScFy8jinYXpQd0Z
 l2D8Gf954aJAjMEAAEIAB0WIQSUwb/ndwkXHdZ/QQZxA//ZuzQ0qwUCZD/9sAAKCRBxA//ZuzQ0
 q1UJD/46OiGy56oZou1FdqKU/7l7QduKNHg/kGvjVQ6ejPCZbi3rN1/KsuGcpsfBDYnC9kEplxb
 uvdYGoJX7RbyRfP0M3er/R6d7fMOk7+uwCXDmsyGn5VfJ7qpkCgEutRG5O4KWV1oeiMna21h5F+
 DxVJuA2pBpUFw7JjL6fGQh1Sng8FWO8Uzcf391FHb3cK0xFZv0KXlAZAx4c6OpodRauIXYXkNd1
 Jcu5WViknxy5Ftn5+rJxEstwF7C63jyhlPLrZhjTyKqiCWVfyFXjEWAjGFdr/TkXh5WAEjbhSSt
 mU7nNxVjPtdxR6ie2B698VBZj3If5GylQw0/7BVI1Lq5qUA8eqzENzlcX+r6s3G0Lliqr3Zzl6F
 Sb1WxTjhcgQTYWU2Lotuy1lRuydJoEpSDSBpTnF4/agODy2JryUMyueEMDsy45r/1JSHkLKGNWY
 Pxle7Moqu1T+SjaNR7FQcs0TaLpSNvLGdjSregG/hZjCAWYtx8IIfLuuMKYRUTNLJ8X7jpS3E4t
 if08fYjYLSdG8uEyrg8/r7C4/A8NbcuuGuppH+nYYs/fnrfZguQQ/b9w9ZqLB08fs+zi0Ofy6Q7
 BWH5IzsYUYPdCf1/YN9bRJVoomXeRs5JSezRgMaF+ItDKS+kvI7o55nypbz0Ktlkt/IdxqkEhso
 yRJYDH3EDrznDuw==
X-Developer-Key: i=avrac@freebox.fr; a=openpgp;
 fpr=6225092072BB58E3CEEC091E75392A176D952DB4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids using lm blocks that support DSPP when not needed, to
keep those resources available.

Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index f4dda88a73f7d..4b393d46c743f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -362,7 +362,7 @@ static bool _dpu_rm_check_lm_and_get_connected_blks(struct dpu_rm *rm,
 	*pp_idx = idx;
 
 	if (!reqs->topology.num_dspp)
-		return true;
+		return !lm_cfg->dspp;
 
 	idx = lm_cfg->dspp - DSPP_0;
 	if (idx < 0 || idx >= ARRAY_SIZE(rm->dspp_blks)) {

-- 
2.40.0

