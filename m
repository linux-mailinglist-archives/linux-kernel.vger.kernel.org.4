Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9665A74EE30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGKMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjGKMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:19:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E15D19B0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b700e85950so85728631fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077927; x=1691669927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uP9/wP8wqmIso7BaHsibml8SDlG0wOYtAGawQA3OLak=;
        b=iBtgFxYyIUiQuMjz2EnF0q3Pp6pGrvndwUdRTF65DrzPiy2G/rTgyJUnBWv/A4sTEL
         No7B2/6np3FClKeYDbnufHlRMVLE9LlkStkhUTVsx2zJOD0XW5KeFMK/vKZh+OM/o7HI
         /y/c2lUj8PWE8cGbtKV/EQUyy57uR3gpzoZhdsRfOkHSK7fIj7T7Pohf6KGbAYjQ0YcL
         ND/9FjJPEUVEnYh1NPMW2IHQWbOY6WKXsMU4SLnNVDSiQZQ1TVsgu9BjUETJ7G1l0Qf5
         KButK8tUKlAkvDA5PAAVyyfgCAAuAWDz27497qodJah501muOjRaDNdzBHW3imMCeH+p
         iBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077927; x=1691669927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP9/wP8wqmIso7BaHsibml8SDlG0wOYtAGawQA3OLak=;
        b=MpqMGtXkHQvBDvgy9ydKDexp2t7Tw3sA+SSYarYaEfvepmsaHt6eNRbJRTFfvRexnK
         /DzX+wtPiQYkjI2RV/GBAwYDhGS/Ojj+C2ZItY9AbTd7w8eYWFf6aKMacZInQKtklBe1
         KtnHKszeXDK+9j0LhqmV7jLzSKQAt82if1pL6sMBmgmKhsO0IzIfS0kO5TEnsjKn5jm9
         b7WHTa9oi32927Py/a71kK355Ls5wKoqkkOAZlw64od2zS3pXzhtgDYZXdoDy8sdmyau
         L33XnvBuLDp8dlP07mByEDsMTnV6bUinMC8YFvJlK+OncZ++P4iWLcC8UGwLOn5yCCgs
         9WkQ==
X-Gm-Message-State: ABy/qLZyRQNOI3P+nLSG7XbIMbUPBGwCfXtN0fgefbVAEyNIxGoFQZHU
        X+Jhh9WTJUsoEMLJklCOObCmtQ==
X-Google-Smtp-Source: APBJJlGcJ04OJbEIPvzKngfe5KkOY9N80s+kkHlsnqEaRRcpjrqLatAD550nEAwa78UohSkaSWx7+Q==
X-Received: by 2002:a2e:924e:0:b0:2b1:b4e9:4c3 with SMTP id v14-20020a2e924e000000b002b1b4e904c3mr13159892ljg.2.1689077927122;
        Tue, 11 Jul 2023 05:18:47 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:14 +0200
Subject: [PATCH 15/53] interconnect: qcom: icc-rpmh: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-15-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1035;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kHFYhvlY9z4u9L1Ts/vi+fhd70LPx+luqOhBOolka64=;
 b=0xbIo75fo3cNjRAMFxhCFUs4IIy6AMpuo711GhCylZMRRZCFSfXpfzHqG92M16+O4q4Csl5zp
 GbYMrpa22bCAlI/WEeuiq5qaU0YpSMQiIHZ/lORQZ+CHF/PssjbYJ8C
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

This helper has no users anymore. Kill it with heavy fire.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpmh.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 5634d302963a..e0b40e313f08 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -122,16 +122,6 @@ struct qcom_icc_desc {
 	size_t num_bcms;
 };
 
-#define DEFINE_QNODE(_name, _id, _channels, _buswidth, ...)		\
-		static struct qcom_icc_node _name = {			\
-		.id = _id,						\
-		.name = #_name,						\
-		.channels = _channels,					\
-		.buswidth = _buswidth,					\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
-		.links = { __VA_ARGS__ },				\
-	}
-
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 int qcom_icc_set(struct icc_node *src, struct icc_node *dst);

-- 
2.41.0

