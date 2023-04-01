Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA2C6D3091
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDAL4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjDALzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:55:51 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D024AFD
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 04:55:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j11so32196105lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680350129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvltTppQ4ytNI2iYvcugGpbwqcOyX8AShb2FaDucEqw=;
        b=ihi5GmzEWv+VcAzvHfPcBqkwlEsowoxk6+WHE7CwZQS+/SHgEFgKpnHsdQnG+Ab7PT
         5qo+R699O5MLKGhG9k3gW4dxJlNkeBQU5KlgcYobFXhkgCXV5Y9kCaqm1YZ9DqHEC9EY
         kf9VdX/TJSOsEnl7KbjrH+liuFucia+1jgHaN9ZJssfYYDaz2wibtce+7dOLK/0jmFrS
         eekaC3fa6d1TeizoG6IHfoHO1fE6RDhr817M4iLG9GEqHHgEYcELJrybFC/Hzu5VZeU0
         XQH121nP4g1Fr/Hje2FbVL5lbPH+pQZLxoqKV4zlmnny+9jWxBkm4mYqUBXB1tOEc0uu
         QUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680350129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvltTppQ4ytNI2iYvcugGpbwqcOyX8AShb2FaDucEqw=;
        b=s6El+Ck00jsGuvi5GEV0tsrNRqVvkBCHALWjEXr+DlBCFnHiULPikRefYjjoyYsNgq
         5osnN0wUMpM/G5AbwTU8KXVOkOFpmJYcPFNG2/Kp1cb1+sr2ZJR9YyAAh2XhpcvRl57s
         csoHBiO4ICQeDrl6TZbRXTaTN+p5/DrT5g6dhXAyvvKqdg0AG9pP6CrU1EQu8i/OiUue
         1VsXmAue+5hCkI/TzJHpxd9GmsVbKRZThrYW+mX4Vq0nTTa/nw9d0GvdHCTK77BDU0aN
         KNuK34dlNzTJh5HlokIvPt+Hc1aaS1ab+njPlPhXC5ePqL6MyikM2jzfVMzFkOkUd4+U
         Hybg==
X-Gm-Message-State: AAQBX9eK+935rNrLB5H0D8W5v/sET0N9ruw3ws5w5JM53V9S8JQ3U9jZ
        kS3gczU8Dxd8+lCbxXtgfzbjxw==
X-Google-Smtp-Source: AKy350bJy2z6I4BDJI2gEIHuz15iK1SircE7jIxlPTzfn2dkBmRMrb9deM8+GqUIMVCMMJxe4oLn1Q==
X-Received: by 2002:ac2:5288:0:b0:4eb:2d47:602 with SMTP id q8-20020ac25288000000b004eb2d470602mr2203727lfm.59.1680350129586;
        Sat, 01 Apr 2023 04:55:29 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id w8-20020ac254a8000000b004e83f386878sm786737lfk.153.2023.04.01.04.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 04:55:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 01 Apr 2023 13:54:51 +0200
Subject: [PATCH v6 14/15] drm/msm/a6xx: Add A619_holi speedbin support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v6-14-2034115bb60c@linaro.org>
References: <20230223-topic-gmuwrapper-v6-0-2034115bb60c@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v6-0-2034115bb60c@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680350084; l=2033;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TnC1uZLteG174FfRp1Tk1pi+iYNuA1vsyt7TElivWgM=;
 b=q0RiUq5vPj5sHbjyimWm1HIHMcjymEkY+z2mS91KK5DtNd2pLzHtIBFkJ00F2F6/yBV5FQvHu5NK
 ov4d3OHFDf9jaPJPJhJTc4/u4Ra63DzEiU/mtPGdDoZWZk5zJc4/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 6c84ef82e504..f692f540c13c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2112,6 +2112,34 @@ static u32 a618_get_speed_bin(u32 fuse)
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
@@ -2171,6 +2199,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_gpu *adreno_gpu, u3
 	if (adreno_is_a618(adreno_gpu))
 		val = a618_get_speed_bin(fuse);
 
+	else if (adreno_is_a619_holi(adreno_gpu))
+		val = a619_holi_get_speed_bin(fuse);
+
 	else if (adreno_is_a619(adreno_gpu))
 		val = a619_get_speed_bin(fuse);
 

-- 
2.40.0

