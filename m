Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926B566BFB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjAPNWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjAPNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:22:25 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E11CF68
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y25so42677156lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdsB/Dtp2SmoDR4CMEbLw4wpi1c6sbrU8O+sGAR6VMk=;
        b=TsMPh4NWK3l+1qtViZlV7Cj03vv9URHxALw6ifrSvpJc2eET/CaQMQij5ybzGmEdNR
         LVZUJKjJWMSCRi6WrGkRVO+Wg0YqR/ZXTFsi/oKwue/Kst9alfkZUZOYTmlqkcscecQ+
         xCP2rUraBO53/8h80bVH2iTvMsbaopOwsV53dqnXCWqRV1Nw0bDwXWggJmi9F49BZ9iK
         gSII8r6yXGVhzcFJnYUbhkxWLpA+DQzq7f0E2QgT6Iwogm5LIc0iZhHBQCqlOJNJ80zy
         Y4tjWJkoU2hMUcCkUR0sLhvlvx7jyBFiETn6Rbxt+WZzeM0Z3CsbzEsblVR/Fx/UVlyv
         asBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdsB/Dtp2SmoDR4CMEbLw4wpi1c6sbrU8O+sGAR6VMk=;
        b=IvHAESNp/9Pskq5LuUXsNOPbf4dtnR0ukB7f2VbQV5wkUqTVi2oo5S5wA/r9c7m471
         mYa0BVaeColtkr1HUQwSDQJ1suVdT+N8Y1OoIgpNH7rwOExW/JGpybdJDkbxTYen/E1u
         EFGDby3jjHzCDj3+5eMloLyfm6Du7A0A4lYShbZrIQwWRNSXZltIMTBbU0GkZlfkzhBJ
         9fED4/LQSIm5+dMczCsxwSfvCzdV53Axy6m3XJ3Dq0EgWbo6dxMOsUj9fvk8TKmJDWse
         +m+4HOqInXlpUujUDDJYqySyV/AZdhsCceIpgwBZ/M0Zu7Rw19jX6yVyJRBtl0fE7wZZ
         56Aw==
X-Gm-Message-State: AFqh2ko2JxeqZf9ZE8+h7CsE8uDIUcZL4ge1CqmTVPWInzFiOjteatlX
        i1RVG+6ZMR9t0qLvaS1lqm4fCg==
X-Google-Smtp-Source: AMrXdXt5e51/ix/1tHSNe+Eo6bw/lo4TXuvqYHbRtUJs1whIyXtN3Fmq1Kff98Omb6euKvV+K28kIw==
X-Received: by 2002:a05:6512:46b:b0:4c5:a0b4:336b with SMTP id x11-20020a056512046b00b004c5a0b4336bmr3223793lfd.1.1673875330273;
        Mon, 16 Jan 2023 05:22:10 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id p9-20020a05651212c900b004cc58b91177sm5016653lfg.239.2023.01.16.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 05:22:09 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] interconnect: qcom: rpm: Add a way to always set QoS registers
Date:   Mon, 16 Jan 2023 14:21:51 +0100
Message-Id: <20230116132152.405535-9-konrad.dybcio@linaro.org>
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

On newer SoCs (there's no clear boundary, but probably "new enough"
means every interconnect provider is either BIMC or QNoC and there
are no old-style NoC hosts) we're expected to set QoS registers
regardless of the ap_owned param. Add a bool in the qcom_icc_provider
and make the logic assume it's okay to set the registers when it's
set.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 drivers/interconnect/qcom/icc-rpm.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 509cadf398e9..343e6021a93a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -243,7 +243,7 @@ static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
 	bool vote_ap, vote_rpm;
 	int ret;
 
-	if (qp->type == QCOM_ICC_QNOC) {
+	if (qp->type == QCOM_ICC_QNOC || qp->always_set_qos) {
 		vote_ap = true;
 		vote_rpm = true;
 	} else {
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 729573f0d9fe..3c8888482a39 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -28,6 +28,7 @@ enum qcom_icc_type {
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
+ * @always_set_qos: whether to always set QoS registers regardless of bus type
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @intf_clks: the clk_bulk_data table of interface clocks
@@ -39,6 +40,7 @@ struct qcom_icc_provider {
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;
+	bool always_set_qos;
 	u64 bus_clk_rate[2];
 	struct clk_bulk_data bus_clks[2];
 	struct clk_bulk_data intf_clks[];
-- 
2.39.0

