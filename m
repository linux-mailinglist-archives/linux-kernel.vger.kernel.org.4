Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3363A70A81B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjETMVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjETMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:20:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918291722
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:20:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so4755884e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684585214; x=1687177214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGVJDUVzLD/MSS0RtIw1KV+SoY/TdXx+81YSilsEy4I=;
        b=hxrpeuCSCHVlpA+2MThbj6OBvovY9fnTj/JGHkFH3cfAA4nmLGW4mXSf6YAwE26wmf
         oLpt9v6z6MKePbU4M3H6Fr+oiB5E53NoQXlDmAIfcXrCi2UEBO3QLL0YGnrpH/0agsI7
         43KIquRD6tK+h7ATC/Ym+/htnr4y1yvXEmpCJ0ql3J4+6JM5v8v5fK864zrSk69/cz1G
         tAlEDkgIe+UKHoUFuK0uPXCqC/377FNnA9hR7ThuI4rtjeLySm6DBBHNyswliDG6Vqq4
         9GZ4cd4+cgrZ1VwOqyIbpUqSlefXZ9q/mwZklolvbt7nPCRTlNjd1Eu2+9kUGtdlYN82
         2hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684585214; x=1687177214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGVJDUVzLD/MSS0RtIw1KV+SoY/TdXx+81YSilsEy4I=;
        b=NfX81Jb9Flc3RUrUvtcE3eM6A0DdpnmVWX3cwZrLKcXvC49U4RC/i/WceSyH7ocoZj
         WKNPQI8zJqaNYGXkVDtHwsnpxU4V6ZRdcdBIrrVxXZx0u0vNLYOgcvYmiiWODqVr3K7H
         ESfzkhwJy+LXwgVNL3wpRbTBbGCqPhzhNTy5PzKfG7zMMWoOoBsJYn/tsiRWDzKtM+Ub
         VuG6CsQTUv1kYIUaezHqIyC1+V296OBC3o/e1ImbdY2FSnm9pah3H4IYm5n6rIR2IgCq
         N5TSRuw7rtxcseqyux5kGPEzOwYJFovEmsHySXA6hrOjTU0LmIhKsSk+bI6mhNzK8Cmn
         b2fA==
X-Gm-Message-State: AC+VfDyM1Iddfv4x8MEz1PQel59ik4kzwuRa/CDlXeAtNwZnIsmmhFf+
        zZsribwKciIZ7dCugBPxDq/Mgw==
X-Google-Smtp-Source: ACHHUZ7/LQp5mmYM41FBE98hULfDEX7wBaKm3z5ceNFfarB94+1UiTOxpx+XZTkD3KmXrmdkxdxiFQ==
X-Received: by 2002:ac2:539a:0:b0:4f2:769a:120e with SMTP id g26-20020ac2539a000000b004f2769a120emr1581950lfh.2.1684585214408;
        Sat, 20 May 2023 05:20:14 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id y6-20020ac24466000000b004f37bd02a89sm244766lfl.287.2023.05.20.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:20:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 20 May 2023 14:19:57 +0200
Subject: [PATCH v7 17/18] drm/msm/a6xx: Add A619_holi speedbin support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v7-17-ecc7aab83556@linaro.org>
References: <20230223-topic-gmuwrapper-v7-0-ecc7aab83556@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v7-0-ecc7aab83556@linaro.org>
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
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684585186; l=2033;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JE+me8wGwvbnigS+vGj1riDnfhLDy9pbL1Nubu9j+Dc=;
 b=dT0oolqAVMMfgO9v3OoI1L7wZfY6VcvoXmE+KZnvpMRRrSkLeeK/PGZdVcbjn4ZCPycmZ21nx
 xGdZfeBZUmFCKCLxETbmTMGf8f1a8qxk/0opUNcKMwsqX6hphWypB3w
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

A619_holi is implemented on at least two SoCs: SM4350 (holi) and SM6375
(blair). This is what seems to be a first occurrence of this happening,
but it's easy to overcome by guarding the SoC-specific fuse values with
of_machine_is_compatible(). Do just that to enable frequency limiting
on these SoCs.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 5ad19978390c..c07b25fc2bd9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2114,6 +2114,34 @@ static u32 a618_get_speed_bin(u32 fuse)
 	return UINT_MAX;
 }
 
+static u32 a619_holi_get_speed_bin(u32 fuse)
+{
+	/*
+	 * There are (at least) two SoCs implementing A619_holi: SM4350 (holi)
+	 * and SM6375 (blair). Limit the fuse matching to the corresponding
+	 * SoC to prevent bogus frequency setting (as improbable as it may be,
+	 * given unexpected fuse values are.. unexpected! But still possible.)
+	 */
+
+	if (fuse == 0)
+		return 0;
+
+	if (of_machine_is_compatible("qcom,sm4350")) {
+		if (fuse == 138)
+			return 1;
+		else if (fuse == 92)
+			return 2;
+	} else if (of_machine_is_compatible("qcom,sm6375")) {
+		if (fuse == 190)
+			return 1;
+		else if (fuse == 177)
+			return 2;
+	} else
+		pr_warn("Unknown SoC implementing A619_holi!\n");
+
+	return UINT_MAX;
+}
+
 static u32 a619_get_speed_bin(u32 fuse)
 {
 	if (fuse == 0)
@@ -2174,6 +2202,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_gpu *adreno_gpu, u3
 	if (adreno_is_a618(adreno_gpu))
 		val = a618_get_speed_bin(fuse);
 
+	else if (adreno_is_a619_holi(adreno_gpu))
+		val = a619_holi_get_speed_bin(fuse);
+
 	else if (adreno_is_a619(adreno_gpu))
 		val = a619_get_speed_bin(fuse);
 

-- 
2.40.1

