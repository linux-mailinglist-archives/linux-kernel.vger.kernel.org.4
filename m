Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FC9696B98
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjBNRcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjBNRcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:32:10 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B9722A1D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:07 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c1so14697825edt.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZAfO7IxAr14EAlhNtiFp5Qcd0YjV1Wu3mwyrUUlhD8=;
        b=Ba+7saktvdPC7xS2+pEh70ok/9U8dm/iKWsOe1jNXabzVeuaHbP4sqVAYuuyXr4Gs1
         U4NLdEa9JojM+btfYFRbqR5/iY0nOJkxZRjm65BPwZmxdu3VN20pvcu28/tVHHtfidvk
         urCoZDHjuyVJAF8eZS582h6ySnE9393qYS9it6ySu5EIA3/TtsGjtkrUdagOnM7e92uP
         mfdnRCIvTFOHUxfmGwWJGJYP7UWMioXin0uj+Bo8WGIll2ppI6XYiNZMPWQphCXsbQSN
         VM0FlBQEAU3w++T6cn7+sHvOY1jE8eFFOSLwpi9Gs4QKxb4sT54UeOG8MORM0jfqfUmI
         Ta2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZAfO7IxAr14EAlhNtiFp5Qcd0YjV1Wu3mwyrUUlhD8=;
        b=mtJ0HilRKZTtT+694YVdMgLgPAu7EYtZtekyaKLm0Eh9Y2LnxpeOgyXroqXshpu7LK
         V1nYeTRdaFsJUdoAgV17wswveWBLtjPrwyx7b+2xRYbo1+0N/ANTf+uRO8O3H3U4kZC9
         PoNbJcuvecwJc0hwfEy+lRY2CxmftSMbzGCwGITBdRgBLL5qdwpQ5RbuvRVvUq+mAaVy
         d+ydJdA63MTiY5AAjNT5SqEGJ92nZWL9t8Hd8XgZOVXCRosUgHrpsy2NnG8jo+b9yJJ+
         VcOz2wZAwkR4YoXSQsN3UlpK3tDUaEsw3pN4bBXT/A+UfEXsGHeewGzQKBe/2g6qXKQ0
         kiaQ==
X-Gm-Message-State: AO0yUKUvjXLFmcAseeCvy6+32h+D6BXrqNdJ7SHSvpjIvNKupFiWs0Uw
        3EYfBJiPdmnM+zOyC7WFNBf0CQQ4DZfN81eV
X-Google-Smtp-Source: AK7set86ET7Xv1SeyeM9KIHwEorieCgRjitv8RDoyP7QxxL0FjI1TF352UebhLfgnANze042g7s42g==
X-Received: by 2002:a50:d49d:0:b0:4ac:c84b:1ddd with SMTP id s29-20020a50d49d000000b004acc84b1dddmr3473276edi.32.1676395915399;
        Tue, 14 Feb 2023 09:31:55 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id w8-20020a50c448000000b0049668426aa6sm8325787edf.24.2023.02.14.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:31:55 -0800 (PST)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] drm/msm/a6xx: De-staticize sptprac en/disable functions
Date:   Tue, 14 Feb 2023 18:31:32 +0100
Message-Id: <20230214173145.2482651-2-konrad.dybcio@linaro.org>
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

These two will be reused by at least A619_holi in the non-gmu
paths. De-staticize them to make it possible.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 4 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index f3c9600221d4..90e636dcdd5b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -354,7 +354,7 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
 }
 
 /* Enable CPU control of SPTP power power collapse */
-static int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
+int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
 {
 	int ret;
 	u32 val;
@@ -376,7 +376,7 @@ static int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
 }
 
 /* Disable CPU control of SPTP power power collapse */
-static void a6xx_sptprac_disable(struct a6xx_gmu *gmu)
+void a6xx_sptprac_disable(struct a6xx_gmu *gmu)
 {
 	u32 val;
 	int ret;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index e034935b3986..ec28abdd327b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -186,5 +186,7 @@ int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index);
 
 bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
 bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
+void a6xx_sptprac_disable(struct a6xx_gmu *gmu);
+int a6xx_sptprac_enable(struct a6xx_gmu *gmu);
 
 #endif
-- 
2.39.1

