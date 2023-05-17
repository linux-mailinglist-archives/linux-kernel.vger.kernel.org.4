Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B018706EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjEQQuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjEQQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:50:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19547420B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac79d4858dso9939081fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684342217; x=1686934217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doFIHuCbi1YVLGjN4vxnw9b75i10GnebCx9q/QOL15k=;
        b=q84ua9/uG5SVyYtD81DuUZPTSxq5rhYzcSzZz6Qn6Ngk9gihmN3MjBpoHK9+tMergQ
         3XUqLY8nIz05QUbzpms6NXtlOrAQM7FwLZdCXGN5GZSepqzpPomm1wqOh67elqjS+KA2
         UKugEONlZsdGZoak6/XSNZRHALjPEc/nvk6h0VP7oU4ZtCCip48PrHB5hbgLA8A9qiH5
         kj4w5e0CM4UdCZH/IA8pIELaIkQ3BsXvPaF4Wx/99I5Qd/1k7gU+TGO7qodJUisEiUUG
         9+SFNiwrHY7QbhnASmhZ/NhUvDENzHLB/e85in5sbxC+auy8Fc6ObAac6eFbeoYYqTcn
         tD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342217; x=1686934217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doFIHuCbi1YVLGjN4vxnw9b75i10GnebCx9q/QOL15k=;
        b=HmqBLTZ3cf9OqaKaTQr4KXzvYfLq0IuKalkl2u4/8llE1e7MuCqQCWr9psyXnj4AQE
         X1fIRJfg6/vFZlXzlW++O8wuFUskd9CbMYzXwUPjWBkRwj8L7ehcXeuyc//CuZWEPvuL
         d3VdKhintI3sV3XvocfP5wYXDyMXgtTM3tXufsfZLhwY8L6R5qJXTO5hAQyRCJ1RekUf
         pLjWFCUE3uaTlam/KYiHSHD8L7JTxm/GnPjUAjelKiJhYwRLzRNx/sDPv+BwO5/IFfmC
         1r+5rKBXA+VefGilwXQPDwKLKv7BWu+6tA+HG1qCp3aUeP8pIawU9/WJZAnrKAFm44fV
         Ne3w==
X-Gm-Message-State: AC+VfDwW2BSISBkYFchYIW4S8bFRIWWtfi9/X5s2sXM9Z2tTILYJrX8p
        rxh3NWD5cZ3Tg7acQnGlsNwXCw==
X-Google-Smtp-Source: ACHHUZ7e1U1bUzU4tY8e7QVk7/FKiRfI0hj0BYVrry6UsUx67+Ea9YcPxgwDeXC34t5tE2dl04gMnA==
X-Received: by 2002:a2e:9e0f:0:b0:29c:3f18:57a7 with SMTP id e15-20020a2e9e0f000000b0029c3f1857a7mr9570078ljk.35.1684342217227;
        Wed, 17 May 2023 09:50:17 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id g6-20020a2e9cc6000000b002af0e9abaf6sm159224ljj.131.2023.05.17.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:50:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 18:50:09 +0200
Subject: [PATCH 2/6] drm/msm/a6xx: Skip empty protection ranges entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v1-2-7a964f2e99c2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684342212; l=1049;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3GlljK/1BVjiAo5f22OuFyyc96OvFEAFjCCjuTjlQ3o=;
 b=JDAk6fXSs/PfJosLcj5uyuRhiKpGLFyoGp8A7FuUirGZ0Z6GNIin23Zlc9OKACT9KDP3GHh55
 fa1FCvSNzO3CwCD12p1MakhpVpfc+wIbLCFNIwFpMakrwwqxNaXyaMm
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

Some specific SKUs leave certain protection range registers empty.
Allow for that behavior.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index deed42675fe2..8707e8b6ac7e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -778,8 +778,11 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 	 */
 	gpu_write(gpu, REG_A6XX_CP_PROTECT_CNTL, BIT(0) | BIT(1) | BIT(3));
 
-	for (i = 0; i < count - 1; i++)
-		gpu_write(gpu, REG_A6XX_CP_PROTECT(i), regs[i]);
+	for (i = 0; i < count - 1; i++) {
+		/* Intentionally skip writing to some registers */
+		if (regs[i])
+			gpu_write(gpu, REG_A6XX_CP_PROTECT(i), regs[i]);
+	}
 	/* last CP_PROTECT to have "infinite" length on the last entry */
 	gpu_write(gpu, REG_A6XX_CP_PROTECT(count_max - 1), regs[i]);
 }

-- 
2.40.1

