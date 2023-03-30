Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DABC6D1349
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjC3X0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjC3XZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:25:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665361B0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:25:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g19so13549407lfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680218742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbnKgpdDmdf2EtoeRfnsVRvWlWQl2tvq4ylx1pYZM4M=;
        b=AKrrOLSQYKJQaMXcRrQu0CQl14DrLKp+LUcL/j2RX20kt7z99u9qgo72XeZ83s8bCq
         iw0dXwXm8erHypA0zavOKPM9MlGrGvGF6ne3J/Ou8EfRgem5VonDGWY6WdqaSpU7rxI5
         TzQxd7lwl4g5pU7NPkCgNtkEwjy9trA//15ExGUJleEF+E37+VPdlWZ7H/5/U+vbC4kR
         fV7q3IssukfY8EG2kx10qEMMa4F0jLWZRJbqW+pu+NZ2qP3epMBulekAX4mVS2lekmoe
         v5WGNxi2qNuOrSek7dGDXc9COz+QyfDx/b3t3mWbutnVXVx8g9C+72BrX1Sh7Salt/WN
         L2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680218742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbnKgpdDmdf2EtoeRfnsVRvWlWQl2tvq4ylx1pYZM4M=;
        b=Lo2BiKY+iyXD0kbiuz/D3flmQx2Ihs6lwLvsuWOiwYkRSTQbo6oaDmDR9s9rinOxWN
         i+vFblzUbHl/sTbASUUcGw2yMdtjaD11HlhdiDSL0Xx1dq5xIB/3LxIzrpYlI19KeVj8
         I3h7ObDFkPDmUEnmvs+tZLQgCAiam9EjCjmmUcUUat+ywDxLSYTycLY33ogHXrxKMvDd
         UemtPv9fsmFHSWlzmrJjg0DZt3uhu6UywpweDEJo6GzgW86NPQtFa8rLjou3jbFfo7jy
         x+/Ywgha4QqD0gpCZ173cvGQz4dW7xy8vFfqrtWN8HtJ3G3gIiq31Cxrbq8o7NBaKEkU
         7VyA==
X-Gm-Message-State: AAQBX9esSfNcJVq8jBZph1HwzY4rimX3Tp5T/Vt2mkvsWsknnPkb+Gp/
        MUVU0voSgd+rNVenrypXqFSQaxSLxVcPAnhR9yI=
X-Google-Smtp-Source: AKy350adNUAP6gZPHLubKVf/g3OFBoIYg03qUxkx5oHnGcxYOzgARoLJm967xZ4tPrk4QmkuC1Epcw==
X-Received: by 2002:ac2:5446:0:b0:4dd:a76e:dfff with SMTP id d6-20020ac25446000000b004dda76edfffmr6583602lfn.23.1680218742650;
        Thu, 30 Mar 2023 16:25:42 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id g26-20020ac2539a000000b004dda80cabf0sm127241lfh.172.2023.03.30.16.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:25:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 31 Mar 2023 01:25:28 +0200
Subject: [PATCH v5 14/15] drm/msm/a6xx: Add A619_holi speedbin support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v5-14-bf774b9a902a@linaro.org>
References: <20230223-topic-gmuwrapper-v5-0-bf774b9a902a@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v5-0-bf774b9a902a@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680218720; l=2033;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FcRDjVP6HKQEi6DA2ZuPEYKRXdBx6r/IOHWHLE+VmPg=;
 b=FSpItbK2YTPN5GbTbq1M+JLzFhOzvFHICJuxlu5kd1ZQNz7BQ++PfOJcBCrklW3H2skLcoLX/PxU
 Eud6bXZwBXYsVuhf8xuEnnGEixe5Z5eNrgEHsJRnS/KjOUtNBmz7
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
index 4665a2e8fdde..c61b1c4090c5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2165,6 +2165,34 @@ static u32 a618_get_speed_bin(u32 fuse)
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
@@ -2224,6 +2252,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_gpu *adreno_gpu, u3
 	if (adreno_is_a618(adreno_gpu))
 		val = a618_get_speed_bin(fuse);
 
+	else if (adreno_is_a619_holi(adreno_gpu))
+		val = a619_holi_get_speed_bin(fuse);
+
 	else if (adreno_is_a619(adreno_gpu))
 		val = a619_get_speed_bin(fuse);
 

-- 
2.40.0

