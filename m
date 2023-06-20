Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B2F736A75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjFTLKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjFTLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:10:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1C8101
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:10:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so2755831e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259443; x=1689851443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QubfL4PWG3Qkdn7Jup1M3+20t3ogTcgbRp6X+RErkfY=;
        b=ZvW5wJKlc0ib7KLmbQKG/rVpS9HZS9jYvVSEj8JYRVn4eObHkRHOkkm7crkF6kLM8b
         3SR4fcwtGmnUgO6rOCh6N+vlVj0NSbWMpbPc/GNj9GwlXjKiJ0FA/L/kgsChGliYhdMt
         MZFBBGOL8Byoh/wdNP/CdTYmFU/a7zxS30LiA+yi1PpyavL4BwW7GAtXqCFIB7/WZilg
         PcxSufEtzt57Fb1GiaFrXh59KDCX2lYy0XxhzLDvxUkNQN04g5XeHpAxBzEjXSV5o102
         tZrLrIEdf357gW2sw1Y+vXdTOMTHjl5GroN4pkjXPqXzyylG+gMLVm3ElPGxudkxYY8a
         XYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259443; x=1689851443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QubfL4PWG3Qkdn7Jup1M3+20t3ogTcgbRp6X+RErkfY=;
        b=jk6xaWltD/g0cOcmVXU1IMOgX86qSpLgUdr3NSMyl611eo1zA0bkee4BTKKpfXXpCX
         oPYvln1vsT5rfnLYD5SN4vQrxd9LgDXx9bbA3cf5u/+mCIBqm7GYsFiDL5Ixuks2Ayre
         4ReNV/6h0HQX1CCxCztTrTxPCI/WYyWikvOJF0lbSJ+ztWNFZM9NmpgbHdkG+cuqq28K
         xuCe0hDmx651AAxpKPNdO8qqDqCPMB4Isz1j4TbVfpz5BYqYAhBA/wn+eWTy13TTXlbA
         lfkdox1S4K4wMcdUoxV89mxQMjr/j+5TWUdOjT0txIXU0BA9dxbZAFadsKWQAwGC9T+u
         M7vw==
X-Gm-Message-State: AC+VfDwBhZHmZelkL9CfXxT4IFQA2zO39aBiPgdx0t3AiBgDJ9D4+uJt
        0EXO0FeS2KthTG/xWb/0f3gEHfK6RSyZ+4fVLCE=
X-Google-Smtp-Source: ACHHUZ4cLmiB2n46o0d35DMgPZGWuixYgUZon5/AJjYU5NyBvxkp8RnPYyge3jvjiOeQ6yEOMx05ew==
X-Received: by 2002:a19:4f12:0:b0:4f8:6253:540 with SMTP id d18-20020a194f12000000b004f862530540mr3086610lfb.19.1687259442875;
        Tue, 20 Jun 2023 04:10:42 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id u26-20020a056512041a00b004f764716afdsm314395lfk.257.2023.06.20.04.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:10:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 13:10:37 +0200
Subject: [PATCH v4 2/6] drm/msm/a6xx: Use descriptive bitfield names for
 CP_PROTECT_CNTL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v4-2-b16f273a91d4@linaro.org>
References: <20230517-topic-a7xx_prep-v4-0-b16f273a91d4@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v4-0-b16f273a91d4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687259438; l=1047;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=M+YceCSQbhF8BD7s1Uycd683ewMShr4OUbGYlX/cKSo=;
 b=Xf8hG5l+ir4khCTVmKbLCZnf4B5dK4hruBv6ZR33xJp5az1Bv32pwYt6r/ytPDp6yrEHct+hI
 KhUiDXIjdShDMyyvJymRLqYM0VWGJt1rbRunrDvooo1y6+oYXaH6RDa
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

