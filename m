Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB7F5FE5AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJMWzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJMWz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:55:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E6FC895A;
        Thu, 13 Oct 2022 15:55:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k9so2706310pll.11;
        Thu, 13 Oct 2022 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZPNZ3VLE0Hgex87FN0OkV1DekcEt1bf70+VW9u0u5I=;
        b=XR4pOh/xQyh1rFhshT6o+clCP1DO1ClDFqI7cfZDk7kMzC3yec7YYkEYOChszeCWGr
         wAQvsbjAKyigjj2ez4ReqZ2Y7Cn40BHbeMfpeCluilMs33cFWOUoLnTpltyDzST1Et51
         pUMeyHwOnpRh5N7/mnLAlFO+8FxRM6LnOld79xUj7kA+o2sYaEom0MTPTc8+FeLiBhm0
         wwUXnkun4WKBcKd8XzEkxNTepq8zllGyVRnDhHc4uYQJ5EphYdlgjjjgA5xzBAlA+DXg
         jPd+FKWfFoe6WIoZ95vGLOMs/0a6UxmT8X6bfT6XiJHyF7RT45ALIWGIDgJDoBuNgH72
         nPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZPNZ3VLE0Hgex87FN0OkV1DekcEt1bf70+VW9u0u5I=;
        b=ksztETRY4bEjxPU8ZEB1vBBmdwoZ8CupwkOOZkFqtt2JXkbfRTOFabWBiL269ue6l/
         9BIQgyC3g1xXc9yiGTRt4Wfotj5X4Xm+4c5DHe1DSozkxvx/ScAlqDugYdFDhktBNL7t
         xw16y8Tpq5qvA3O0bn1/hA56su+VaeXRn2rxOaEa08bWt4tDe0wz8WLEFPnCdFKnjhGV
         PEua/YO/aX4Fi8oUgVfR5fW2p5IsbqmFjjJ0DmbI8uu42twVB4iWQxpiRLTfTSCs5zef
         cXEC8rDKRPqhbUFYNehQb5dGhrLeThU3sLLPrWdvj/xyQgiiqIwdEoGjfsx/HVJvPxxP
         y+ow==
X-Gm-Message-State: ACrzQf19AblrwKPmEHU/dVgTBhIGXijRT9tJWZLrijXVgkBejWgQKQUI
        WegOrmR13Kab7EvUlxgbByw=
X-Google-Smtp-Source: AMsMyM5SeaxGSOFjUEc1amD9PN0v9n6v+ZxTXU3WfxZU7s4Bd2Hpy5ww3QAawc27sjg9tF94dvu3JA==
X-Received: by 2002:a17:902:cf03:b0:17e:c7a:678e with SMTP id i3-20020a170902cf0300b0017e0c7a678emr2034151plg.10.1665701720262;
        Thu, 13 Oct 2022 15:55:20 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id h3-20020aa796c3000000b0055fc0a132aasm221198pfq.92.2022.10.13.15.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:55:19 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/msm/a6xx: Remove state objects from list before freeing
Date:   Thu, 13 Oct 2022 15:55:15 -0700
Message-Id: <20221013225520.371226-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221013225520.371226-1-robdclark@gmail.com>
References: <20221013225520.371226-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Technically it worked as it was before, only because it was using the
_safe version of the iterator.  But it is sloppy practice to leave
dangling pointers.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index b0124d0f286c..a5c3d1ed255a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1046,8 +1046,10 @@ static void a6xx_gpu_state_destroy(struct kref *kref)
 	if (a6xx_state->gmu_debug)
 		kvfree(a6xx_state->gmu_debug->data);
 
-	list_for_each_entry_safe(obj, tmp, &a6xx_state->objs, node)
+	list_for_each_entry_safe(obj, tmp, &a6xx_state->objs, node) {
+		list_del(&obj->node);
 		kvfree(obj);
+	}
 
 	adreno_gpu_state_destroy(state);
 	kfree(a6xx_state);
-- 
2.37.3

