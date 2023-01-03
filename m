Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60E65C50B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbjACRbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbjACRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:31:14 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350402647
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:31:13 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id y25so46598292lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 09:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKKn2ob5FVX8E1rKj4RwcuOoKO8R4a0VcIQiC+ia4Vo=;
        b=pdrf8zkVnAuKKS88V/P2hnBeJ536mptQCQFvKs/0m0XX28JdGErm+2R6xDRRo8nOdO
         NUvH/jfxH2EJOapvv1mjbYQGFxk1iroh6ObhWuCNQv0PqFGOboeDGM388KwWEijFDJja
         aKORv829TVWoB6jP+Sos8OeHcNVlhQ3C3zZtvNFH58Kb3R3dtqst2xO/FONQ3t7DPiIJ
         0bEbOq6WAMLPoOwC1LeY2N9TqYGjR2I0fjWZmTMnjOep2yQWA/RCRdGldUWrnCOGmHUB
         IlrflF8+5ukPAC+uHxMhVuqkwC5pCXdDOFjgIx7hnzMyTPlMKCzowQahXiXEKjhtPv4t
         WO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKKn2ob5FVX8E1rKj4RwcuOoKO8R4a0VcIQiC+ia4Vo=;
        b=Y+Hug5DE3eKE9uAZZrPdJE7Z4+8B2QYfJjxBgC4fI9QxdxdbUflgNWY1IYZMa5RQMK
         dYcg9Y3e0O93Ab7Klv9NcJXmtVyn+7gjVXhC/0wrcFeJxaT2tmRVsByoB1MX/mvPrrqT
         /jL2W4erllSANANXAzLADpyuvq9zmWOcggMtdaTKfSpcyA1FVCvG7qqw7Kby2x9LRjEu
         95a87ziQjkMtJpSpy3ZpS88hVJAkQig3mMZz0mNLy3ap5/Ofo8eAtzyukh98eiGRI4en
         nWQbYPVmdn0m2p3Tx6ahL1RO0WOo4+Vnw+SZFpygEd1lWnJA3JhKF4NOstYQIRitzUYs
         d5xA==
X-Gm-Message-State: AFqh2koPWRO/hr2sSGXKJuv9NkewaMLvJL0HNGCWw95BzjrcgTBT7Jgq
        Ne5YoBVOiYclp7t32nfNhQm5zQ==
X-Google-Smtp-Source: AMrXdXuk7EWv52SdG4bHxuow0TiS3P1sIt6t7Gulg1PYNBcGdWIs8EkXD8f0fC0lidu1hmp2netW7g==
X-Received: by 2002:a05:6512:3681:b0:4b5:83ba:11ad with SMTP id d1-20020a056512368100b004b583ba11admr10479300lfs.35.1672767071579;
        Tue, 03 Jan 2023 09:31:11 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o9-20020ac25e29000000b004b4b5da5f80sm4916818lfg.219.2023.01.03.09.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:31:11 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] interconnect: qcom: rpm: Add support for specifying channel num
Date:   Tue,  3 Jan 2023 18:30:59 +0100
Message-Id: <20230103173059.265856-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103173059.265856-1-konrad.dybcio@linaro.org>
References: <20230103173059.265856-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some nodes, like EBI0 (DDR) or L3/LLCC, may be connected over more than
one channel. This should be taken into account in bandwidth calcualtion,
as we're supposed to feed msmbus with the per-channel bandwidth. Add
support for specifying that and use it during bandwidth aggregation.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
 drivers/interconnect/qcom/icc-rpm.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 8ec1ca17816a..04fe742c25a3 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -328,6 +328,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 {
 	struct icc_node *node;
 	struct qcom_icc_node *qn;
+	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
 	int i;
 
 	/* Initialise aggregate values */
@@ -345,7 +346,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
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

