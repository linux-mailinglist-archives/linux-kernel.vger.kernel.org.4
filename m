Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5877C6A00C8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjBWBrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjBWBro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:47:44 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2F441B7F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:47:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id k14so11480213lfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCGO18fFeWFx1/oqatAOPTvgztN8ex2StTWWkNQew7c=;
        b=UqcUrP62HrsiAt9Q6uCcF6e86j+YbcDvjBn5qnC2A5wInQidrtGebmp12w1PhJijsf
         eyyLLK+0Rm3o/ycFDsAVvXQrUhPkj2xMqrFkW7yEsYmVAlXyab1/4iezenzh/33xuY4f
         qO08D8OrbEZsTLr2Hi+HxZ++iooZdvz9tTCCMeCktzMRjEpCNl2lgAUFHcpQezwWShrh
         bFyLHOsPYMlgsJwEkMRMJKFpeZJSH9PBiPY4/O/dfUl66wOLOhAi0oLCpH6RUurVYfz0
         LBcVg7pdRIZT6JXurlxjAukXhHn9BDVoNUhMytj/JFr2dKZn5z9f7LzE4iEBt8ElWAJ4
         zC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCGO18fFeWFx1/oqatAOPTvgztN8ex2StTWWkNQew7c=;
        b=FFBSEUytH3PuRTo5plchu7uyXMaQku03JyU0ILpauuySHBKxN3ZuqqPwDEnL1UuGTq
         n4RlhPSFd0vViS0FVl4T8Kb7iotAwvAjJp4VXnjmdIAZYW/ldOKRyRdPPUoABamexi9P
         NCGBPAdlUROQxUls3VJzeg8SZt8x0EbCRfzV8dCDIAZfvku3stKLdNVgltQGvsZPPkja
         wXsfNSLcGZShy6BiLyM+NK9VvAK0LBcFQKXFvncwRQgAoS9WFI3tFwQ+S+vcoH0D4v16
         8JQGdqpQGvvjh7crpTZeBBHvVGFwNUQSGEBFFzC7xy32hXRodMF7k9+P6MzMICJg2eG4
         4V0Q==
X-Gm-Message-State: AO0yUKW7V0oIIQEQs2ygR9YaoxSN8CpUMeox8PLDu3vxYMtlpBioWakF
        axo4mC/uKRtXO/DjU+TD/jadeA==
X-Google-Smtp-Source: AK7set8xB6MQPyyJqTPpJqKVNCu8vdvqHdvsXstaNqRHFGhNsyhWgBlzm2zLSO/JTK2EEOF8sAaHlA==
X-Received: by 2002:a05:6512:3988:b0:4a4:68b7:deb7 with SMTP id j8-20020a056512398800b004a468b7deb7mr4160498lfu.19.1677116860797;
        Wed, 22 Feb 2023 17:47:40 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id 12-20020ac2482c000000b004dc807b904bsm427376lft.120.2023.02.22.17.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 17:47:40 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 23 Feb 2023 02:47:37 +0100
Subject: [PATCH v2 1/6] drm/msm/a2xx: Include perf counter reg values in
 XML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-opp-v2-1-24ed24cd7358@linaro.org>
References: <20230223-topic-opp-v2-0-24ed24cd7358@linaro.org>
In-Reply-To: <20230223-topic-opp-v2-0-24ed24cd7358@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677116858; l=830;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mzjSUO+qHIiKaLiyXFVom/GoyNVpw37b+tvLzQHI5RY=;
 b=sOt90zAVghwEBEdFaBDhwOmr+WDEq6xWWtPbhadU8HLedLihLtGPgw3G+utNjj5nKzLKe9UXi7Sp
 /8dBYiuOABV7JJpxXdNZpynZqYX62ZFL3PLs9g7th7h4bt1MOJga
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

