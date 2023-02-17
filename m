Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F669A948
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBQKqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjBQKqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:46:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40443635A6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:37 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p19so1039507lfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rjG/3ow1ZOTG1eHHIqytTbppYsh/DRQVP8JWOKWwcE=;
        b=DHtsw9VBjVWeKrjyOHza14P3gG53yefORmaq1x059bl8olMt8wLzAz4KOH+bWWqpCa
         Hj0NjEZjaZwWwVdYWO5ffFgphidabkXcHrOROJSuHXP9YPDGBGTV8tnw6/f2250rqWKS
         TVzDlRL8Ogo96tZqTMPu1H40Gmv8t4ZgAozl8UWeE07ZyGMgeROznsTQYRirWDb+6bNB
         83VyPK4r4RRfddzBgIIoXUD0gG/7RXK1JK12AHhtiCq4HDTD2oIvYrKoVGEX1YJinleN
         nBJrvSmNv/yb0rVQb2cbh1qHkRwZEikEcPO7/PzaIx+qptIqtG3+f5YxGvWejVjCvWVP
         ADow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rjG/3ow1ZOTG1eHHIqytTbppYsh/DRQVP8JWOKWwcE=;
        b=pszt0etTAZVDZ7Npg4Q4KdMo8xHtzaaGcH1605m9M0uRzFzQIybp6T9zj+4zKHNVtS
         pa7GH2FY1oUWs29llL11vIGkHk0vRjUxw1AyrA01w2a938i2yxzKOHhtuqi2eoJhuZZi
         C7g264xpoe6e9fME0AqxwiWLw5SNOKZ38eIBsYLnXE7UGBzpOhPhjDqoaRK17DlOs6Te
         /gNn2yGS2/WDrewgzpSFcYDMDWLWPuSvkLOUolgAs3oQKB0PVqy5sVFoFQqZtOSeTfei
         4NUHRBosI1EzYN0uhko+Sw6kPI81GP8tDMAUkKmhpJZQtWGOSKloLvdwRxZFGhjOSjrU
         4xVA==
X-Gm-Message-State: AO0yUKVaJQTiGmspDD4HfQEBqKYlJV3W10n01JFx2DTTlseuNL9OLXsZ
        DEtn54+Fu5e9Bv3eYEwuD6HvtA==
X-Google-Smtp-Source: AK7set+Y1pfHXR2h3/1ZVtNtlCLzVk2iFx+zdkUyTFwRjXOQwQOHlAXlV6oxvtd7meL6IULWLyylwA==
X-Received: by 2002:ac2:4474:0:b0:4db:25f0:a159 with SMTP id y20-20020ac24474000000b004db25f0a159mr94874lfl.51.1676630795521;
        Fri, 17 Feb 2023 02:46:35 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651221ad00b004b53eb60e3csm645940lft.256.2023.02.17.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:46:35 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 11:46:23 +0100
Subject: [PATCH v5 02/10] interconnect: qcom: rpm: Add support for
 specifying channel num
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-icc-fixes-v5-v5-2-c9a550f9fdb9@linaro.org>
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
In-Reply-To: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676630791; l=2390;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=owy+HTbDiqD53bbeRzW7lMPyKDJvsQwv0VsM/tqOHBQ=;
 b=0wO3Kb2K2bNGrwgjHl+MB1VQsq1MjB8wGaF78Q/vMoe0wPvHb6brtdYreCFZmdJJzbIiqktjBaHP
 0gnspTheC6/VF6pZ1rKlrLh+NcxWRKpNnF8d8gldzkL3cbKQXlZr
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
2.39.1

