Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973F76A5A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjB1Noe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1No2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:44:28 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D22B624
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:26 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h3so10255097lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677591865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ym8bk2djHTFvMcICEA5unUHh3z2W5J7DD0DkD41HCss=;
        b=yssCFdpsLgyjb2tkqo3BjA8G+KiKKYIylSMDQZ80Af9WxH5saFLpuzegkR0G6tO3UD
         bPnk08MPwstL9cfBE0zoklO+uNZCzWNrrAdCVTVkOcz1Hg6NfcJqR4VlUX0xBryrVX4X
         9MD5jbg0ahMnfRC6QeLogjkaZHovmjV2QRN3JmxMBi6BfbMD0KxOkVm1oX0SlLpWQvnJ
         KGf24QSFy90vp8r+PweJc6XysOfko10URZQaROkroXSMqxDMkX0bhkXwBuX4NLntV4Vs
         wi6jg8TV/ZEVo5XZniR5d8BFSeuM5fXiHZv3cuPIztxQ5ewrOvJ8TEB5wT6UeQnxXMOr
         VqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677591865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym8bk2djHTFvMcICEA5unUHh3z2W5J7DD0DkD41HCss=;
        b=OrD+heF94n9Gu1M9rucyoyqqCCEMNTfBDpUHKdN+45JKx8pLWTFvRj7p5tvSC3j4hq
         aJwcwpLv4fzBlt8qhakwqUpgSrpaGO94RV8Xoh3EAkrovEtaV3rlepTHGXCKIOD/zy0Y
         /gdhGVtBXv2s0ltGaXSwEB2PyeVB2by0BFCAXJ4Dy7jtmZuX2XeB+UMmDoR/l6S5Rdgt
         ENLoL9lzoHeAQjqzYFQ2X7i6nKr5Or78b51dEl+Cwm6BeFtizGZbo7IK5BPvWqEF6ieE
         RSQK3GzgXITJf0U6+pMz0Fc9Bs+G1vp9zzuui7OWNaUg8Ew1mnTGDKhJWg+nA2EpqYUf
         9rbw==
X-Gm-Message-State: AO0yUKXl1J0XwIeKI8BoRmCtjKh5yT3ZVFE95FHBLPZfYmzkocyZtsyc
        JjDwiONAMBx2AvF2blfiA1G1/g==
X-Google-Smtp-Source: AK7set/PgzJ80pdegYRmYQh3SLh0C8P27Gqp/NaaGXh1EBZ2AmEattSd6HRthdpcobRhkx4yLOBLGA==
X-Received: by 2002:a2e:3807:0:b0:293:4b62:a763 with SMTP id f7-20020a2e3807000000b002934b62a763mr671454lja.25.1677591864749;
        Tue, 28 Feb 2023 05:44:24 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e3c14000000b00295a583a20bsm1203975lja.74.2023.02.28.05.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 05:44:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 14:43:59 +0100
Subject: [PATCH v6 2/9] interconnect: qcom: rpm: Add support for specifying
 channel num
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v6-2-3c37a349656f@linaro.org>
References: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
In-Reply-To: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677591861; l=2390;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kQApzOtp5XG97FXu8eGnUnr0dwRtenzwoSY2YN1AJto=;
 b=dL+SU7TK7JpouJMAVZmIKPd5sVj0XEMsFR3zzjO4P0ucnyOJrqVbdeNqCraHKKVyFAgSkETy0TNl
 n5LZn4qrCNaunz97U8qioBs/Chv1/n4vkqUWnYZASsFJYarncO2e
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
index ffbeeca8c2b0..6bd20f62f8ed 100644
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

