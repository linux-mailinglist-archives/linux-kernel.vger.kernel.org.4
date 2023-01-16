Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930CB66BFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjAPNWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjAPNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:22:05 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A7415555
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:04 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d30so37779482lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCjth92iDA0+CEUYPpg2kXGSHQ36Fyihe/QHRf50rDs=;
        b=aYathcyuoUy7oj9IYCkQT0LIpFsJ46/2P5MRwrf5u1JDioTfkleVJyRSV/OkcFhMiu
         dJbIDlON0QKMoJ/ygkL9GnmAUE7YRB/HeA2G+BCDGBKU7K07GJbwnMUYA+9jRE+Y/KGU
         8kNFgcbd/b2KZiJxRUPd0WmJg8rWD1LMT8dQKIYLg7ISSf7M/BxlsbwmBBdcQ4/kAqr1
         92iMEsoxDYzQmRJ0AXG3tF/38xngjrrnNFkIcjDr96xYoXYhWXoCPTXvhQiEroy6pRlA
         cC8rOG+PuzhrbEHppu1UVLJUXwLXTaXnYxS3xsQtTeyqPuWlluyXV+1hfMp706genGyn
         zTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCjth92iDA0+CEUYPpg2kXGSHQ36Fyihe/QHRf50rDs=;
        b=AWBiMe+VglkxXRA1+4XnHud0s+3E67bWdKJCClve9yKXLgd+vKTyiCTP5dBn7VoRvE
         IvCM2YX9VHAQE7l0adRQw+txibKT2NVBJycGd1UyxcQL010AS9TNd9nvoe1BlldRMl0o
         1/fhIvVSWvJ5eMo5gHrzUNoXhOwv6k+3sj3DBA+HIgMK0O7uQBQ3M+lnxGG/lMnyQJu+
         FIADDUtdlRDXJKv/j+nZmB3C3Dl9wCKCVWy8YM0TsU+wjDGYFBNAUApydVJxQY2Vy8CL
         uPZgde/GZbRBhPJC7rDtm2EH8cPHs9tto5bHzsC/vDWe5UtuJOlfrWm2qE6gKdq/25f6
         5WEw==
X-Gm-Message-State: AFqh2kqJsO9AmroToHgqoYuHPSMUCvc/dFNCSegp3LdN5UAUZcKg1YkK
        B/lVyd8yy6a+McdJ1S2FezKRyA==
X-Google-Smtp-Source: AMrXdXtdozWwbcCzV7ZqSlygOcghacwBpKAtl9SxI6IVUKnsLjSpcoykbnpjVU92pqzsHvQbexcXvw==
X-Received: by 2002:a05:6512:238c:b0:4b5:2cf4:cc1d with SMTP id c12-20020a056512238c00b004b52cf4cc1dmr29364284lfv.68.1673875323011;
        Mon, 16 Jan 2023 05:22:03 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id p9-20020a05651212c900b004cc58b91177sm5016653lfg.239.2023.01.16.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 05:22:02 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] interconnect: qcom: rpm: Add support for specifying channel num
Date:   Mon, 16 Jan 2023 14:21:46 +0100
Message-Id: <20230116132152.405535-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116132152.405535-1-konrad.dybcio@linaro.org>
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
index b1337f90c975..41a6dd40c38a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -329,6 +329,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 {
 	struct icc_node *node;
 	struct qcom_icc_node *qn;
+	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
 	int i;
 
 	/* Initialise aggregate values */
@@ -346,7 +347,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
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
2.39.0

