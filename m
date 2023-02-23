Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDCC6A069F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjBWKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjBWKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:52:08 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020ED5A38D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:07 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i9so13106120lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCGO18fFeWFx1/oqatAOPTvgztN8ex2StTWWkNQew7c=;
        b=Gr2oUgyKPIbZVCgDw3OjK4657+IOYDWhm+oQKM3odBWpq0XiFp1ojiZuUqSa0VLPcN
         1CsQgfpq83Rf7EikYFfnRxzc4c2iSwxyQ77Sh6FKsqtOKlvH68JfniDMK8ncIy+rX3Wj
         aYphvXLHcHlykfD24pQXNQl9s51sxSebGMPkJ+TMWQLjPHw8GVlv3FNR8j/xRO/8jlCO
         AjT6tJFbq5NekeMccUk3ddZFe22h0KtW6kQURLcWO+4m1/aCDIitML1CGVK755QbAg34
         YNnlJqbDa/Y9t/62rM4AceIhLfWHdrnkEqrSxJEPODLyqbNB+5qlDuCXSOzPQ6x3im6y
         Xv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCGO18fFeWFx1/oqatAOPTvgztN8ex2StTWWkNQew7c=;
        b=zBQqOrZa6JPT2bx8Y8hG05nxL5wQKEvo5iKA7nxHVxMGeHecE+bTE2v6QZ3vX5x8QX
         sR6dYjalgVcyAu77uXiiZdLtbmk3US6ukrShU1z/BAhO5MmPy/gYRb3OS6mq2WJqK4n5
         NoKBuSdu9/TD83YQlyG59mNYjXG9quK1FROi3pRnCRMjAvRCfMuS3ky41TQ9bHBLecxS
         wXB82PUnvSVDCGNFISGGT7xaruTrh0iyyofG18hoapNPPHKv3N4OwwCihL5xgpSyNgLC
         JTHu/jS4sf63AyBR0f3fMSr6mF9bxe4v8V7b/uTkuPiuBzKV9fzSLVRqKjrXWBC2JOaF
         j+UA==
X-Gm-Message-State: AO0yUKVBB9PEXCntaLclusbijWroIsfz94EQkFVELxdbkrMtcuTdzYYl
        JNVbEBeN2VeP3mhsCVQ62YBnZg==
X-Google-Smtp-Source: AK7set/fY4xrMOUyr8wCGpG1Mb/jr0YHmW1t/sH2sMdYGbLotN+fJHkCYobA1PzBYnb/aZeqZQkvqQ==
X-Received: by 2002:ac2:5456:0:b0:4c0:91d0:e7ab with SMTP id d22-20020ac25456000000b004c091d0e7abmr4169027lfn.28.1677149525281;
        Thu, 23 Feb 2023 02:52:05 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b004cf07a0051csm262304lfp.228.2023.02.23.02.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:52:04 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 11:51:57 +0100
Subject: [PATCH v3 1/7] drm/msm/a2xx: Include perf counter reg values in
 XML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-opp-v3-1-5f22163cd1df@linaro.org>
References: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
In-Reply-To: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677149522; l=830;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mzjSUO+qHIiKaLiyXFVom/GoyNVpw37b+tvLzQHI5RY=;
 b=Brq/xe9nTTlSzXWpTd9q4AEiAPA/i+F2rPcpTI/RHWye8OlGMO/u1xixuJxZpsRGzai7/0/FTHLf
 UJmGc0t/AfG08cffcQLz4JK8ezQYgkxA6VOOcAcN82FMb+GJubR7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a partial merge of [1], subject to be dropped if a header
update is executed.

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21480/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a2xx.xml.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx.xml.h b/drivers/gpu/drm/msm/adreno/a2xx.xml.h
index afa6023346c4..b85fdc082bc1 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a2xx.xml.h
@@ -1060,6 +1060,12 @@ enum a2xx_mh_perfcnt_select {
 	AXI_TOTAL_READ_REQUEST_DATA_BEATS = 181,
 };
 
+enum perf_mode_cnt {
+	PERF_STATE_RESET = 0,
+	PERF_STATE_ENABLE = 1,
+	PERF_STATE_FREEZE = 2,
+};
+
 enum adreno_mmu_clnt_beh {
 	BEH_NEVR = 0,
 	BEH_TRAN_RNG = 1,

-- 
2.39.2

