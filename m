Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41944735C50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjFSQog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjFSQo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:44:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53479E66
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:44:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f7677a94d1so4796692e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687193065; x=1689785065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QubfL4PWG3Qkdn7Jup1M3+20t3ogTcgbRp6X+RErkfY=;
        b=izWEN3U+iWd1fPLMrr6/pQrV08vx1rjRIhZarw0N3zMJwbfHE8T7Bj42V+YD92ZJNQ
         gxPcx+GGpqSgFfvpvxf4bZR1gTqH0rXIbkMcUAVk7/2Jo9ekhLHTN1oR6x+lIlqUWs/W
         uGbOD0ZsW4VKmxKWzHOiP0uQjutB5g+CT2PRVxibnF6K0ukgoixLk/AaKtKwptQO2BpS
         8TO6EUzAc3mesxxjaeYfecj5CYyXUgsxyVWKm3wGTXVImpzBxc+lpLrnOyy7XljSh7Vx
         SqFrfgHqURpyRPGBP+8iB+a1ZOyRMdCFGMBP6y73RKpBbYgOj831wAgHVfywJ1yXzHjP
         O4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193065; x=1689785065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QubfL4PWG3Qkdn7Jup1M3+20t3ogTcgbRp6X+RErkfY=;
        b=YUa7lfviclPvgkdf1pCgQxDvb8Eoij4DjzCNYRxze9u9fQtRXECu1OpJtccRBuRU7B
         P/vmreoFEYNPqP+mUGjtUq9oAXhjStGSG01VmaXutdBDdf1PHIrQyupDvBoUQJfRSjki
         PjVLFrTyD+CYassajeqAxtCd/RplJtApcbdUBBKO7ZEFJ4A0H4oSbDYIP/145+T1LoML
         bWOQZqKyIW6X8juqQGhgf9Zo0THE8Ue4zChQsS7BX5c21HtBZ1i3ugJsXeUXEy2uk0ND
         b3R3ZqVN0Ba8nC562Fh9am2Q8F+Zhnn9sKOPHp3WNrBVTms2CR3kcT2MGbe0Be+11Tlt
         6CKQ==
X-Gm-Message-State: AC+VfDwVq6dg1GO63p2ziR7Dn5vNxADqcN1bjCr6cooiBFBjCVhsmoJX
        fbQwfMevolHN59fzg3tXC8wC1w==
X-Google-Smtp-Source: ACHHUZ5gBqo8kgGPJdirliPx8VnBc+MPCiioaohNXndAZNqYATv7iMxJd5nibFi55cXHHNf/bbiYGA==
X-Received: by 2002:a19:6d0c:0:b0:4f8:4245:ed57 with SMTP id i12-20020a196d0c000000b004f84245ed57mr5968981lfc.35.1687193065508;
        Mon, 19 Jun 2023 09:44:25 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id d9-20020ac24c89000000b004f849605be7sm1774293lfl.292.2023.06.19.09.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:44:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 18:44:22 +0200
Subject: [PATCH v3 2/6] drm/msm/a6xx: Use descriptive bitfield names for
 CP_PROTECT_CNTL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v3-2-a3ce3725385b@linaro.org>
References: <20230517-topic-a7xx_prep-v3-0-a3ce3725385b@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v3-0-a3ce3725385b@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687193061; l=1047;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=M+YceCSQbhF8BD7s1Uycd683ewMShr4OUbGYlX/cKSo=;
 b=05fyUeuE1APciTv7RqvirSi20LUa6O3cBKWcbJhiSxYszAu7ZScuRA2/ZzhQT4ETFVRwRshdc
 aMX5IJHfw1pDY7MMvEffcq0+4ZHieGtJKYfUcP6+pwprQZhkceKutxE
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the necessary information, so explain which bit does what.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index b3ada1e7b598..cd0c9bccdc19 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -930,7 +930,10 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 	 * protect violation and select the last span to protect from the start
 	 * address all the way to the end of the register address space
 	 */
-	gpu_write(gpu, REG_A6XX_CP_PROTECT_CNTL, BIT(0) | BIT(1) | BIT(3));
+	gpu_write(gpu, REG_A6XX_CP_PROTECT_CNTL,
+		  A6XX_CP_PROTECT_CNTL_ACCESS_PROT_EN |
+		  A6XX_CP_PROTECT_CNTL_ACCESS_FAULT_ON_VIOL_EN |
+		  A6XX_CP_PROTECT_CNTL_LAST_SPAN_INF_RANGE);
 
 	for (i = 0; i < count - 1; i++)
 		gpu_write(gpu, REG_A6XX_CP_PROTECT(i), regs[i]);

-- 
2.41.0

