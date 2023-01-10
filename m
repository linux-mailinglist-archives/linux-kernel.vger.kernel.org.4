Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68082664185
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjAJNWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjAJNWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:22:11 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6411B9C9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:09 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bt23so18341932lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sagb6kWuJFTf/dHfUUw6MoelC9SM7/rka6Cvy2IV27E=;
        b=dy8Kef2SSJEFEwIVuciP195/cc94gbPbS626tYngI7FrkyBtl9Y1frc2jFyZOV9ItE
         1n7zUBHUXNXnMuwrmmAcbe+3T6m//pg9gFR1xB/AW5XytP/1FPzuuUiamZ1NyALx4NYu
         z4B0N5cB3ITxWCWQqDINjQWxTmV0mtPPSwoIBIGSFgJxVW7LFQWDF9CAoOnuUxjDi1pO
         IVtgaplrRPTEtyTpdyePyH8c6wpxDjHAp9T+Z8QXxu62QSSVW3Y4YnmZFd7chvw8Db5y
         Ni/0dMYPpeygOnIeiPnRkgdOdWIoFyXKLC12gla6ERA07naX0uh3mx/6SJhsSXGDfX3D
         zO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sagb6kWuJFTf/dHfUUw6MoelC9SM7/rka6Cvy2IV27E=;
        b=xPC+hJbYZNl7loNY3strRTLryKhVI+Yx+yhxWD632SGoy9OnxdYckxj7KGRujjHTPj
         lg7VtTciJqrRjMaaKiYNBJNI4L1jWmGrD8zqW2Uaspt31djyQvKQHwK7IrGA6DRJ7cXq
         RGWQQKME7kOnRukLXpTJ1IMsF0gFR6ZdwzXrAi1sczdzslj+4FlNyd5pv2KhG3bZZ71U
         aCRElLb0536Lr59kM3DWxaN9p9EaOQOLxdR3GEbO1BYS6AOmqsa+FatyOD6w5byMgMqx
         a+DrCz4+LZbuh/LWO8AwEsMb1/b3XLR7dzQNckL3L3ok8raJ5XrBXLzh9TXwLapeVW9E
         80zg==
X-Gm-Message-State: AFqh2krsuECXc7kvM1lNKaVIuBO/sOoX4rtAB4ubhO2xcPEP9Fnh1c17
        WnwWLM7m8asRn11oDex6UGIgzg==
X-Google-Smtp-Source: AMrXdXvWG/sgM9lOFCgtXfm+uJXR+UGGzFUwj9G6LYeFR6zq4nWUiEMLOy7sTt/djpnzi7U7gXYv6g==
X-Received: by 2002:a05:6512:32d5:b0:4cc:73ff:579a with SMTP id f21-20020a05651232d500b004cc73ff579amr3553665lfg.38.1673356928164;
        Tue, 10 Jan 2023 05:22:08 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm2183000lfe.201.2023.01.10.05.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:22:07 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] interconnect: qcom: rpm: Don't set QoS params before non-zero bw is requested
Date:   Tue, 10 Jan 2023 14:21:53 +0100
Message-Id: <20230110132202.956619-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132202.956619-1-konrad.dybcio@linaro.org>
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the icc-rpm driver unconditionally set QoS params, even on
empty requests. This is superfluous and the downstream counterpart does
not do it. Follow it by doing the same.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index df3196f72536..361dcbf3386f 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -191,6 +191,12 @@ static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
 	struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
 	struct qcom_icc_node *qn = node->data;
 
+	/* Defer setting QoS until the first non-zero bandwidth request. */
+	if (!(node->avg_bw || node->peak_bw)) {
+		dev_dbg(node->provider->dev, "NOT Setting QoS for %s\n", qn->name);
+		return 0;
+	}
+
 	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
 
 	switch (qp->type) {
-- 
2.39.0

