Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B65D6D3095
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDAL4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 07:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDALz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:55:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F96265A4
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 04:55:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h25so32233699lfv.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680350132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7iaKrmXzAocug0zm1BXOXimd3i27ycjAt6X7axyt1c=;
        b=huSfh3WPWOS2hUfnr6lymatuU4DazhafyQESbHCwz8Ux2BCzKiKR3v5FqeLRU7ZiaG
         lgvVM230rE0+NDVKiljZYLo75J16DwD20JogzRb4tvNyNqXe4Ou4ku0kHLPlnOX1M0ZM
         9qG/mRyuVeib84/v6csmnNde7gUfbYKX4aRuoqas9hSBjUMHDzLR9Pnx3oscWpKSojmW
         XhqVJ87ULKEBcdD+UaCFWSLTlnAm29es/bjn0unZqNZMgXVkT5dXgzWJGf6pt7iQE4/G
         j4v/VZjeXhogtWAVq9cFlfGQVNQqc9cxXxAA9pzpJ5rdI8VUqvy65zPSnoO5nwEwkkir
         kppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680350132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7iaKrmXzAocug0zm1BXOXimd3i27ycjAt6X7axyt1c=;
        b=AbPKvbhT1EZvSNXLqaQ0txqDUBxNsgKQCSuEJHXb5967H6i3S9LHPa0hPSEHdfhHqh
         fm7RA7/ZYVrlv0v23KBxLxUPMkLGuo638gnjQ5nA1vDNTVwGdl9HagCzb2+SCz7K+7PH
         kr7LhpX30Ui4aJkP13MhhZF22s9Igtcqz11haQmb6oaWWcjXSkhhb39ixBt0IGUczm8C
         /blzkRNE5bJ/ns7/OUISXx3z/yqeTqlbj0CLaS5uIieLJiHPEtqdgBq5qzOlIuB/LLHQ
         XlbqBwM96vzQeXFdpCzRwGYMSUfvMoSpTFQpn1+RafKmPxhK71JW8yDiR37G3y7RSm1M
         sW3w==
X-Gm-Message-State: AAQBX9fd/89Dlqzb/9KoTliIaS8rKQO1nrWlJyf77Yur1eNEE5PwtR8h
        PO8uMWtbSnS4XxXhZDI0wi2f8g==
X-Google-Smtp-Source: AKy350azx5qjLTJIYLCDCfdeM/z+nx8o5HVz0WcrmXuRcb964FuH1R/r2IAXFnphdVUg7ElZbC7SXg==
X-Received: by 2002:ac2:43a4:0:b0:4ea:f526:5bee with SMTP id t4-20020ac243a4000000b004eaf5265beemr7893904lfl.11.1680350132632;
        Sat, 01 Apr 2023 04:55:32 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id w8-20020ac254a8000000b004e83f386878sm786737lfk.153.2023.04.01.04.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 04:55:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 01 Apr 2023 13:54:52 +0200
Subject: [PATCH v6 15/15] drm/msm/a6xx: Add A610 speedbin support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v6-15-2034115bb60c@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680350084; l=1852;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/AkqnGngmcLmZe0/0dqCMVNhVeDNpUZqOtTS2j9nX1Q=;
 b=usbd75h1G/MzZMxQHI2wq6t4BEKTNhpk+Isjf6v/HYYNAGutNoR1I0u4FRvYOZtYxNIEFB5z0ccu
 bEdbYbPfDgPxI6HxpJwVMuOz7DB944fAMB/nw7uB9a+8Ff7nuHQO
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

A610 is implemented on at least three SoCs: SM6115 (bengal), SM6125
(trinket) and SM6225 (khaje). Trinket does not support speed binning
(only a single SKU exists) and we don't yet support khaje upstream.
Hence, add a fuse mapping table for bengal to allow for per-chip
frequency limiting.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f692f540c13c..e3be878afbb0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2100,6 +2100,30 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return progress;
 }
 
+static u32 a610_get_speed_bin(u32 fuse)
+{
+	/*
+	 * There are (at least) three SoCs implementing A610: SM6125 (trinket),
+	 * SM6115 (bengal) and SM6225 (khaje). Trinket does not have speedbinning,
+	 * as only a single SKU exists and we don't support khaje upstream yet.
+	 * Hence, this matching table is only valid for bengal and can be easily
+	 * expanded if need be.
+	 */
+
+	if (fuse == 0)
+		return 0;
+	else if (fuse == 206)
+		return 1;
+	else if (fuse == 200)
+		return 2;
+	else if (fuse == 157)
+		return 3;
+	else if (fuse == 127)
+		return 4;
+
+	return UINT_MAX;
+}
+
 static u32 a618_get_speed_bin(u32 fuse)
 {
 	if (fuse == 0)
@@ -2196,6 +2220,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_gpu *adreno_gpu, u3
 {
 	u32 val = UINT_MAX;
 
+	if (adreno_is_a610(adreno_gpu))
+		val = a610_get_speed_bin(fuse);
+
 	if (adreno_is_a618(adreno_gpu))
 		val = a618_get_speed_bin(fuse);
 

-- 
2.40.0

