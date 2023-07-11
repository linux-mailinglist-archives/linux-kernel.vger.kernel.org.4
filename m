Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B6474EE02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGKMS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGKMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:18:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854E4E67
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b703c900e3so87380261fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077911; x=1691669911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faHQYvRA6dB51H+b9tyyGHRVQXd132zqJVmf3cqbbls=;
        b=brq9ju23RQDGjfkhEyoXhKY+P8VySGW00DIGULzYnHAAI+I48EOu4YpnO5WhOCuKz7
         h5L8KvxPVmdv2t2QxlyNyC7EhGnV7JvN/DSmG5Aa+G3zGEkkDguxhxZFtnzIe4VvjjjZ
         1tlUDoTAmweBrYNGvZCGDH5Ejs7xSPRsBZjNVo5tfu5FQe6iGbTQKUVu2EK1l1Ut+jl+
         RCuvqdSuOapROklyZaznNj4HDQzr3x+shVvGRON8fyilGYwF141OPl6rzmHIr/LHgwAM
         8red/2zW5isBkUY7ekKEhFkauRrPurTza8WY1sVA+sakkh/ruS7ne8izjS0wetcQQsVM
         uoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077911; x=1691669911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faHQYvRA6dB51H+b9tyyGHRVQXd132zqJVmf3cqbbls=;
        b=UwLYJ49rhtcGtEoPNKj+fX+8z7PcGFZrMAVVKi5g3GTcIbHW842fmbPFRCe3+kFi+L
         iKbMHfJajSS/04FnTElmYzJaGlxDlQVzpQdQCjvjWELXN2HNV8rPl4MjOemHmCIl7TgG
         gITlbLWA4ufvyjwjRg5bZpFzww3+1CdxgteBWccS5V54nP8xTf4gbi15nig0chPSnh7n
         Gts6eUBH7rQ/Z1474Q1qhBzIvfHfw22NcGi4KOLNNwNjfPncmFZipOjXoB4jA6yxxduI
         HrnH7iJBtfptK/k510zLjjxNXrF0NoLbaBOtnEo8hGXJ23fWjJsg2UwHNcUcfKprSv+q
         3PQw==
X-Gm-Message-State: ABy/qLaJz5D6iarhJ75W6wq9SA3qua0HN5PMZFqj0+TC1WZDtjS5pYVO
        +87COZzV6l1AAZWId3bEDbZbkw==
X-Google-Smtp-Source: APBJJlE45x3XxwQUe9r/v4a2VECOkUhVOEpocZ3fhx/SWa4yjJt84PjPj5lJ3ehQVS19lkg1mvNg/Q==
X-Received: by 2002:a2e:2e17:0:b0:2b6:df00:b3d1 with SMTP id u23-20020a2e2e17000000b002b6df00b3d1mr12295023lju.51.1689077910800;
        Tue, 11 Jul 2023 05:18:30 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:18:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:03 +0200
Subject: [PATCH 04/53] interconnect: qcom: icc-rpmh: Retire dead code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-4-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=2754;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6mcS5eZovBnK2nwqFQIK7RBsbNQhwBhsQk+oBWRxNK4=;
 b=3ESDmMghTA6TIXl1ds/z4EpMEk5yAVv8VC1Tp1dLP/zINjykK+fbVDiJIiARIDeqq+KEQrt8B
 nrdFX/8/EnIALZGZh9DZJCTIFG3oUiASEHts3K8O46uCivUgJ4qPqU7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_bcm_voter_get is no longer necessary. Remove its ugly remnants.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 46 -----------------------------------
 drivers/interconnect/qcom/bcm-voter.h |  1 -
 2 files changed, 47 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index f8fbddb87e6b..0ce3874f60d2 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -16,7 +16,6 @@
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
 
-static LIST_HEAD(bcm_voters);
 static DEFINE_MUTEX(bcm_voter_lock);
 
 struct bcm_voter *qcom_icc_bcm_voters[ICC_BCM_VOTER_MAX] = { };
@@ -182,51 +181,6 @@ static void tcs_list_gen(struct bcm_voter *voter, int bucket,
 	}
 }
 
-/**
- * of_bcm_voter_get - gets a bcm voter handle from DT node
- * @dev: device pointer for the consumer device
- * @name: name for the bcm voter device
- *
- * This function will match a device_node pointer for the phandle
- * specified in the device DT and return a bcm_voter handle on success.
- *
- * Returns bcm_voter pointer or ERR_PTR() on error. EPROBE_DEFER is returned
- * when matching bcm voter is yet to be found.
- */
-struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name)
-{
-	struct bcm_voter *voter = ERR_PTR(-EPROBE_DEFER);
-	struct bcm_voter *temp;
-	struct device_node *np, *node;
-	int idx = 0;
-
-	if (!dev || !dev->of_node)
-		return ERR_PTR(-ENODEV);
-
-	np = dev->of_node;
-
-	if (name) {
-		idx = of_property_match_string(np, "qcom,bcm-voter-names", name);
-		if (idx < 0)
-			return ERR_PTR(idx);
-	}
-
-	node = of_parse_phandle(np, "qcom,bcm-voters", idx);
-
-	mutex_lock(&bcm_voter_lock);
-	list_for_each_entry(temp, &bcm_voters, voter_node) {
-		if (temp->np == node) {
-			voter = temp;
-			break;
-		}
-	}
-	mutex_unlock(&bcm_voter_lock);
-
-	of_node_put(node);
-	return voter;
-}
-EXPORT_SYMBOL_GPL(of_bcm_voter_get);
-
 /**
  * qcom_icc_bcm_voter_add - queues up the bcm nodes that require updates
  * @voter: voter that the bcms are being added to
diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
index 0f64c0bab2c0..30b324fcb2ee 100644
--- a/drivers/interconnect/qcom/bcm-voter.h
+++ b/drivers/interconnect/qcom/bcm-voter.h
@@ -20,7 +20,6 @@ static struct qcom_icc_bcm _name = {					       \
 	.nodes = { __VA_ARGS__ },					       \
 }
 
-struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name);
 void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
 int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
 

-- 
2.41.0

