Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF726B1450
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCHVl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCHVlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:41:18 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B659809
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:40:49 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id z42so17988257ljq.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWvxJATtCZZKMC5qHkete+t4P5fdMAJTPULnzyt/6uA=;
        b=W9PP/8O9SYqsWLA6zBO6fbbCJiFwk6mzgCSowoIN17jpLCCBd+KKmvM8lF8EZVS2zJ
         2oSBmB4NLqCh8D3cyfe0sc7Ei0oQZp88NajFo7m1BvPYdgu2FxOAIJtBhP+pGzH/wEoA
         k+7ChYSIhPF71D2nx2V8RmuyX6Ji/5Q6t4I9RJqVC2wCtwREC1njlJFV/w/c9QKDMVgb
         JtSWPSZEQeVia9h/hJYyVbQnIfVtwhjhfDrWRaS8LJhYSqIsOViSO0GDBzCjm/O0ZyXV
         r5fqWmfdDnSZiSbPDRWt9S0+UyiH9ck2lJwZeevtJDiMUzCrAXCm9pJh8BCz2g2ONCSd
         D1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWvxJATtCZZKMC5qHkete+t4P5fdMAJTPULnzyt/6uA=;
        b=GGC6CZbLrmvh8sPxS4SlbpBfGzqRcOCuGVrQlWpyV+4BOUO5SAjljWMZgIQDC2w51T
         r2UKO68tlcCrv0uBBzdVXcI3zbJZKodB54zHd0YK6payrLWQMXtz93M0duj/7zFKyDWl
         AiXBK13D7H3OuEVFOhATZLfW84q4GYUCf3uq5mvvgloFsm5sGvQgjiuiK6vh18aC3qmX
         caexAuxonkGuBV8ElwhdALhGpNcFnwASQsxwPGOUTKFQMGMEV9KWh0BmMYkYcj5cBxut
         zES+jFSsodrvuPGBIUrUcWgub7KbxiO1gtTTP0eFnO7uN7MJUtV7bdradOJxiiYkjF68
         zRsg==
X-Gm-Message-State: AO0yUKUVr1GMpE3IC0BbMJRoFBmCGko+I060xN+k+KWq++zhy93Q7/YW
        4ApcWVEa/VWVCSVIrL7LEryJX5slvuVctEElnr0=
X-Google-Smtp-Source: AK7set/xtt3kHV/tvNHmhuo5ey16iaIcSx3JnWxjtw9uC/sB+v3Tw9K7YzAriSrIMepeyf9GFVC4/A==
X-Received: by 2002:a05:651c:104a:b0:294:716d:8d5 with SMTP id x10-20020a05651c104a00b00294716d08d5mr6254374ljm.1.1678311613729;
        Wed, 08 Mar 2023 13:40:13 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a6-20020a2e8606000000b00295a2a608e9sm2688844lji.111.2023.03.08.13.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:40:13 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:40:08 +0100
Subject: [PATCH v7 2/9] interconnect: qcom: rpm: Add support for specifying
 channel num
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v7-2-815606092fff@linaro.org>
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
In-Reply-To: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311609; l=2390;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mgGX39iPtIfm1zsmEzmtm3Z/menbT73VBLNzExJPqt4=;
 b=lQrFaeMU78TFU1DAP//yDiIt4f1Jg5NB7EcRVWfLHFISeAPTGj7MD3IOj8B9GG7Fx/5Vn21g1NTm
 D3VP+W1eATugu0NF9GHr9lF59gigQKAexO/bHDQyT8vS/P4MBSGv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some nodes, like EBI0 (DDR) or L3/LLCC, may be connected over more than
one channel. This should be taken into account in bandwidth calcualtion,
as we're supposed to feed msmbus with the per-channel bandwidth. Add
support for specifying that and use it during bandwidth aggregation.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
 drivers/interconnect/qcom/icc-rpm.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 35fd75ae70e3..27c4c6497994 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -317,6 +317,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 {
 	struct icc_node *node;
 	struct qcom_icc_node *qn;
+	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
 	int i;
 
 	/* Initialise aggregate values */
@@ -334,7 +335,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 	list_for_each_entry(node, &provider->nodes, node_list) {
 		qn = node->data;
 		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
-			agg_avg[i] += qn->sum_avg[i];
+			if (qn->channels)
+				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
+			else
+				sum_avg[i] = qn->sum_avg[i];
+			agg_avg[i] += sum_avg[i];
 			agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
 		}
 	}
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 8ba1918d7997..8aed5400afda 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -66,6 +66,7 @@ struct qcom_icc_qos {
  * @id: a unique node identifier
  * @links: an array of nodes where we can go next while traversing
  * @num_links: the total number of @links
+ * @channels: number of channels at this node (e.g. DDR channels)
  * @buswidth: width of the interconnect between a node and the bus (bytes)
  * @sum_avg: current sum aggregate value of all avg bw requests
  * @max_peak: current max aggregate value of all peak bw requests
@@ -78,6 +79,7 @@ struct qcom_icc_node {
 	u16 id;
 	const u16 *links;
 	u16 num_links;
+	u16 channels;
 	u16 buswidth;
 	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
 	u64 max_peak[QCOM_ICC_NUM_BUCKETS];

-- 
2.39.2

