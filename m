Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE5A715BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjE3KWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjE3KVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:21:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF1DE73
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so5729073e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442030; x=1688034030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icKa1TRoM7DxejwPmdVHGrJaHkiX0Km/DDITg5zb2s4=;
        b=YZi+UfbQYz7t48Wol2/Wyu6Qfj80RS0lW7omeRsHrtjNm5tFmQFrPhwLE1ikHHw4xd
         mFelSppQgYgOdjHtJLYtYvMZpeBEcmBCauPZP54E/QsD1IjGmCf+h5kxtVYpJBSq4alM
         ux2TteNF6Mgrzu63KZllpBB8Z0meZkZiLXHkvphipdg+a9Q/B+x1UWiGWO/vD6Tf2fej
         phiYblDBmiP09bUkIkRtZfxTSre51NHPL4BSMsiF5ECKHraNyeriGg77yPDbPl91Mak1
         md5y65S6MDMHxwPt+Iw3804HyoApSmQhrkiPtkVunZ/JyXYNYZcZmnzkzzWPGHpkSMYg
         cdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442030; x=1688034030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icKa1TRoM7DxejwPmdVHGrJaHkiX0Km/DDITg5zb2s4=;
        b=W9WVYa4PJswM5mk/3FC7TOdrRzqGlaTXNZkYyaSa9ylnzkHbg85qvM+vVcDvITaet4
         OEeqqYBxklaIrtB/mzdS/m0vtWgr+9nmQom8mbFkz/Do7K09KNsAwMhkXMp9MjVFcnXL
         vnD8fEbbUatommN886lmD/+UiaVYhYpl94S4VcnXmG71xjOKG3KAJm8vbrdYMeU4nNFL
         3i1d9fF4flNeRd5PatK/y14sP3igKlA5Vu7MYZabaGwlKSjYFcWaX90uVmaU0PygGMyf
         Lwq3oXFPY3dECvHKjdkXJhkaloQJB4hrue5JLRzoThm3+TqXgMnM9OclWIr+kehbzMZL
         C24Q==
X-Gm-Message-State: AC+VfDzzOgQMoX0XFebdKzN6YC5ixcBNpSyx6dCZqHuZQKemvMeH0EEC
        ri/X4npxCKacqMSO8Ne/AXUufQ==
X-Google-Smtp-Source: ACHHUZ7jPScxjpLTKucDXjf+vYaR3gcwVgpOngsLOvc74dQRNDzywoqe0oXy9JGGDR+TUKM77Wj1ww==
X-Received: by 2002:ac2:41c5:0:b0:4f3:b9c8:5da with SMTP id d5-20020ac241c5000000b004f3b9c805damr607469lfi.33.1685442029999;
        Tue, 30 May 2023 03:20:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:19 +0200
Subject: [PATCH 20/20] interconnect: qcom: Divide clk rate by src node bus
 width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-20-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=2453;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=A2xuhtZVawiVfe99Wd1nS5W5Zg3I4zNjmwvGs3s+zi0=;
 b=hkQXVBfrqCLUDeLOKO2rhZ5dD/3o6xqfIHgI3EXCatqQweKw8yTc3FhFffUDySUhf/LCxUByx
 +Yb4EPlILCzAbDncb5Lgpb65iONQ74ZFI9cP48gahIkZsk8/cTTuqBk
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

Ever since the introduction of SMD RPM ICC, we've been dividing the
clock rate by the wrong bus width. This has resulted in:

- setting wrong (mostly too low) rates, affecting performance
  - most often /2 or /4
  - things like DDR never hit their full potential
  - the rates were only correct if src bus width == dst bus width
    for all src, dst pairs on a given bus

- Qualcomm using the same wrong logic in their BSP driver in msm-5.x
  that ships in production devices today

- me losing my sanity trying to find this

Resolve it by using dst_qn, if it exists.

Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 59be704364bb..58e2a8b1b7c3 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -340,7 +340,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_icc_provider *qp;
-	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
+	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL, *qn = NULL;
 	struct icc_provider *provider;
 	u64 active_rate, sleep_rate;
 	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
@@ -353,6 +353,8 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
+	qn = dst_qn ? dst_qn : src_qn;
+
 	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
 
 	ret = qcom_icc_rpm_set(src_qn, agg_avg);
@@ -372,11 +374,11 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	/* Intentionally keep the rates in kHz as that's what RPM accepts */
 	active_rate = max(agg_avg[QCOM_SMD_RPM_ACTIVE_STATE],
 			  agg_peak[QCOM_SMD_RPM_ACTIVE_STATE]);
-	do_div(active_rate, src_qn->buswidth);
+	do_div(active_rate, qn->buswidth);
 
 	sleep_rate = max(agg_avg[QCOM_SMD_RPM_SLEEP_STATE],
 			 agg_peak[QCOM_SMD_RPM_SLEEP_STATE]);
-	do_div(sleep_rate, src_qn->buswidth);
+	do_div(sleep_rate, qn->buswidth);
 
 	/*
 	 * Downstream checks whether the requested rate is zero, but it makes little sense

-- 
2.40.1

