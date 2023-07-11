Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EA374EE08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGKMSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGKMSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:18:32 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776FE77
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso92061381fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077909; x=1691669909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSu7bVlPwYBvi/ntXbyQWTTKyDKoXG99g+rzhXkYTYg=;
        b=LW9axz5hH/6bh8N+psR9V8Oy8DQwB7jeXpHwqSe8DjtDtIPYdh88QbvoX+5ic7fU+Z
         SqrD8HwYBnDTd7xylQQfz7M0PTypGdZuC8lP5KtLRFy3qU7Pt52unmTMQXw8qAHt8vCL
         9L3yTXsSRjwFtk3x74W0i7ptTXFHS2D51PU8+FPA9sBv3k+Z9zYQ57q82NkflvcjPHGI
         ElRaRoy1R9cAv7AoxQwmQwtGF7jAmgbIaiKBvvBahTOrNgV4WI8Nfr37Y6r3qlP9AAVJ
         pRzPkPqq6JH8YjkrQamvyf02datxWUqYCK81HjWN0lVG1JurV8efPPsjtOTw7zSZqxYI
         K+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077909; x=1691669909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSu7bVlPwYBvi/ntXbyQWTTKyDKoXG99g+rzhXkYTYg=;
        b=SeY0vGX/IVEgvpQTL65SV+/fiGDiJKJTvGH1pJhNc0G31AbIqKzh1P+WKOglC4V5g4
         FTCGTjEaH94/xyhrDx5tTP6OF/GlI6ksiXei74ST0cgNuvhzgfsHKJMD/c4aPraEiJUY
         DWcGvJXzvsBSyRXtgFQhQuLM557WqIvkp0Nl+d7pCfT0qt8lyfCwh6VessUDDB8wU9dz
         TxvEg4EJZqjE+sTNsare/wGjId6Atm3IItvf/doUdXq6e+qdEpk5/QwbWTjyepVGk9OB
         cB/QDkEscDFESl8oGw9VFnDdYXd/Z1tqonkdo6M3IvooC1cxLSWUcsM0SMk5sLD/EiPQ
         inXw==
X-Gm-Message-State: ABy/qLYow8XQMXA1WqhWSx/FkyfbjfAEdDAvOnZoF+WFau7pJTA4XCwr
        sp18IbVXEZ+ju/QUWA6D4VifBA==
X-Google-Smtp-Source: APBJJlFoVqC9Hyia0lxUD3pXku6F21REr7sikSpzwEQHlkY9zcN4C2DAGefdaFpk2r2ivKtXESmZAg==
X-Received: by 2002:a2e:8782:0:b0:2b7:243e:a2 with SMTP id n2-20020a2e8782000000b002b7243e00a2mr3522971lji.48.1689077909599;
        Tue, 11 Jul 2023 05:18:29 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:02 +0200
Subject: [PATCH 03/53] interconnect: qcom: icc-rpmh: Store direct BCM voter
 references
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-3-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=5806;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=op0OvwRNT/rufglepzjHxJNouLHRuZ5bBbm7iZd+W3A=;
 b=hcbnLTk5GYW1/XfQr0MsnVa4AHorgH8tXJFov6Rx8PUHIkGm+fyj0WYFcLKB912rf5F+bG2kV
 HPnsL3Qld0lClgPC5l+H31c8ICbLpQz4v/6Qt2Ur+dwKu8pQbc9h0YH
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

It makes zero (or less) sense to consume BCM voters per interconnect
provider. They are shared throughout the entire system and it's enough
to keep a single reference to each of them.

Since the list of these voters is common across SoCs and across buses
on them, turn to caching a pointer to each voter at a dt-bindings-defined
index in a shared array to make accesses O(1) (instead of a clunky
loop-based lookup) and vastly save on redefining & referencing the same
set over and over again.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 29 ++++++++++++++++++++++++++++-
 drivers/interconnect/qcom/icc-rpmh.c  | 16 +++++++++-------
 drivers/interconnect/qcom/icc-rpmh.h  |  4 ++++
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index d5f2a6b5376b..f8fbddb87e6b 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -19,6 +19,17 @@
 static LIST_HEAD(bcm_voters);
 static DEFINE_MUTEX(bcm_voter_lock);
 
+struct bcm_voter *qcom_icc_bcm_voters[ICC_BCM_VOTER_MAX] = { };
+EXPORT_SYMBOL_GPL(qcom_icc_bcm_voters);
+
+static const char * const bcm_voter_names[ICC_BCM_VOTER_MAX] = {
+	[ICC_BCM_VOTER_APPS] = "APPS",
+	[ICC_BCM_VOTER_DISP] = "DISP",
+	[ICC_BCM_VOTER_CAM0] = "CAM0",
+	[ICC_BCM_VOTER_CAM1] = "CAM1",
+	[ICC_BCM_VOTER_CAM2] = "CAM2",
+};
+
 /**
  * struct bcm_voter - Bus Clock Manager voter
  * @dev: reference to the device that communicates with the BCM
@@ -37,6 +48,7 @@ struct bcm_voter {
 	struct list_head ws_list;
 	struct list_head voter_node;
 	u32 tcs_wait;
+	u32 voter_idx;
 };
 
 static int cmp_vcd(void *priv, const struct list_head *a, const struct list_head *b)
@@ -353,12 +365,27 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
 	if (of_property_read_u32(np, "qcom,tcs-wait", &voter->tcs_wait))
 		voter->tcs_wait = QCOM_ICC_TAG_ACTIVE_ONLY;
 
+	/*
+	 * This is the best guess we can make..
+	 * Not registering BCMs correctly would be gamebreaking anyway!
+	 */
+	if (of_property_read_u32(np, "qcom,bcm-voter-idx", &voter->voter_idx))
+		voter->voter_idx = ICC_BCM_VOTER_APPS;
+
 	mutex_init(&voter->lock);
 	INIT_LIST_HEAD(&voter->commit_list);
 	INIT_LIST_HEAD(&voter->ws_list);
 
 	mutex_lock(&bcm_voter_lock);
-	list_add_tail(&voter->voter_node, &bcm_voters);
+	/* Do not attempt to register BCMs with the same ID twice! */
+	if (qcom_icc_bcm_voters[voter->voter_idx]) {
+		mutex_unlock(&bcm_voter_lock);
+		dev_err(&pdev->dev, "Attempted to overwrite %s BCM voter!\n",
+			bcm_voter_names[voter->voter_idx]);
+		return -EINVAL;
+	}
+
+	qcom_icc_bcm_voters[voter->voter_idx] = voter;
 	mutex_unlock(&bcm_voter_lock);
 
 	return 0;
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index fdb5e58e408b..53298148f24b 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -20,9 +20,9 @@
  */
 void qcom_icc_pre_aggregate(struct icc_node *node)
 {
-	size_t i;
-	struct qcom_icc_node *qn;
 	struct qcom_icc_provider *qp;
+	struct qcom_icc_node *qn;
+	int i;
 
 	qn = node->data;
 	qp = to_qcom_provider(node->provider);
@@ -33,7 +33,7 @@ void qcom_icc_pre_aggregate(struct icc_node *node)
 	}
 
 	for (i = 0; i < qn->num_bcms; i++)
-		qcom_icc_bcm_voter_add(qp->voter, qn->bcms[i]);
+		qcom_icc_bcm_voter_add(qcom_icc_bcm_voters[ICC_BCM_VOTER_APPS], qn->bcms[i]);
 }
 EXPORT_SYMBOL_GPL(qcom_icc_pre_aggregate);
 
@@ -95,7 +95,7 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
 	qp = to_qcom_provider(node->provider);
 
-	qcom_icc_bcm_voter_commit(qp->voter);
+	qcom_icc_bcm_voter_commit(qcom_icc_bcm_voters[ICC_BCM_VOTER_APPS]);
 
 	return 0;
 }
@@ -167,6 +167,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	struct icc_provider *provider;
 	struct qcom_icc_node * const *qnodes, *qn;
 	struct qcom_icc_provider *qp;
+	struct device_node *bcm_node;
 	struct icc_node *node;
 	size_t num_nodes, i, j;
 	int ret;
@@ -200,9 +201,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	qp->bcms = desc->bcms;
 	qp->num_bcms = desc->num_bcms;
 
-	qp->voter = of_bcm_voter_get(qp->dev, NULL);
-	if (IS_ERR(qp->voter))
-		return PTR_ERR(qp->voter);
+	/* Ensure the BCM voter is reachable (unless we don't have any) */
+	qp->voter = qcom_icc_bcm_voters[ICC_BCM_VOTER_APPS];
+	if (qp->num_bcms && !qp->voter)
+		return -EPROBE_DEFER;
 
 	for (i = 0; i < qp->num_bcms; i++)
 		qcom_icc_bcm_init(qp->bcms[i], dev);
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 7843d8864d6b..5634d302963a 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -88,6 +88,7 @@ struct qcom_icc_node {
  * communicating with RPMh
  * @list: used to link to other bcms when compiling lists for commit
  * @ws_list: used to keep track of bcms that may transition between wake/sleep
+ * @voter_idx: index of the BCM voter used to convey votes to AOSS
  * @num_nodes: total number of @num_nodes
  * @nodes: list of qcom_icc_nodes that this BCM encapsulates
  */
@@ -104,6 +105,7 @@ struct qcom_icc_bcm {
 	struct bcm_db aux_data;
 	struct list_head list;
 	struct list_head ws_list;
+	u8 voter_idx;
 	size_t num_nodes;
 	struct qcom_icc_node *nodes[];
 };
@@ -138,4 +140,6 @@ void qcom_icc_pre_aggregate(struct icc_node *node);
 int qcom_icc_rpmh_probe(struct platform_device *pdev);
 int qcom_icc_rpmh_remove(struct platform_device *pdev);
 
+extern struct bcm_voter *qcom_icc_bcm_voters[ICC_BCM_VOTER_MAX];
+
 #endif

-- 
2.41.0

