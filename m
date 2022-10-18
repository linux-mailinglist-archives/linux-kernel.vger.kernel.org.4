Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC0B602FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiJRP3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiJRP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:29:06 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9E6BC62D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:29:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c22so17075808lja.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPjX8YygxtCcRrbYn3FxymvJ8EWixkz9W2za1oHEXVo=;
        b=wHWBloqiiwx1jqX9ysI/sEnSimM+LufKG+jyIximgCy4KFyv9/5FcYTEmQqzYo+BtF
         I7iAYnHfUOHyxFQJHD8JnD0vtZHDXCZuI7bMNPz9hzlE1zhXONBPzoZxS0SSW2h79IfV
         CG4uuKU90clSzh0UOUBaRoRQIkgovBbeqIc7ONuqcm8cfQLl1cOc4onShQdMWeLXvyK/
         xr3mbBOVG1XS0UrP+vtSuy003lxBekgP8qUpJpmgG0SZ4d8+tStH0MqLqIRUhpc2JVlf
         +HyAs2qFzkyYoiatPzCjN5fGZisvRDzdpSo2WGqgp93USKxPoJuhcD8Abn3uVlJAVswo
         9QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPjX8YygxtCcRrbYn3FxymvJ8EWixkz9W2za1oHEXVo=;
        b=DkCChkRwIReyQ5DVczKUC0n7ujJqlaqCr6UkBxwIpToHAZDuGOGslTV4qJsnsI0hfi
         VyvLlgCG9QqX8cXQ5lUWeV6FKC0xvX1bbIUjI9mytktH0RZvB1ad1o8Wc3HmxxiM6lOR
         j4VpuE8oo7GO2COu4l0udmOZyo4GuC4pa2K9V4CsSR4DG7DvLknZy5ZXi8KR/9oU5RoM
         HMp/k2hyRo+kGrpg+lobR4RS5CyoMqpliCVkOO4+T/0XD64yehaCTsnYGDHVQC/zLHBm
         GnloojUABfe2uxa1mFS8XjvidSEclMNtaLkCESeu3h/1f/U17QhZqAO+px22TbQ6c0QL
         psXA==
X-Gm-Message-State: ACrzQf0mZpp5OooJvoYHSNs+csyXJ4vMSUMqqaCP66mkjzFVRE8i/ZN1
        VUfZTg0oCTfKFH9Nz1K3/+5HEw==
X-Google-Smtp-Source: AMsMyM52trZr4FJMtWZGitOXzfgzOVv49rz01lrNXx/LS1mXYApz1KWw1IBEEeRhZ35OioJQYDBLuQ==
X-Received: by 2002:a05:651c:98a:b0:26d:fd1f:10 with SMTP id b10-20020a05651c098a00b0026dfd1f0010mr1287534ljq.323.1666106943060;
        Tue, 18 Oct 2022 08:29:03 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a9-20020a05651c030900b0026ddd41aecasm1998617ljp.135.2022.10.18.08.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:29:02 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] soc: qcom: rpmh-rsc: Save base address of drv
Date:   Tue, 18 Oct 2022 17:28:36 +0200
Message-Id: <20221018152837.619426-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018152837.619426-1-ulf.hansson@linaro.org>
References: <20221018152837.619426-1-ulf.hansson@linaro.org>
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

From: Maulik Shah <quic_mkshah@quicinc.com>

Add changes to save drv's base address for rsc. This is
used to read drv's configuration such as solver mode is
supported or to write into CONTROL_TCS registers.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8450
---
 drivers/soc/qcom/rpmh-internal.h |  2 ++
 drivers/soc/qcom/rpmh-rsc.c      | 18 ++++++++----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index cd3d6ce137e3..7866bb1e5361 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -91,6 +91,7 @@ struct rpmh_ctrlr {
  * Resource State Coordinator controller (RSC)
  *
  * @name:               Controller identifier.
+ * @base:               Start address of the DRV registers in this controller.
  * @tcs_base:           Start address of the TCS registers in this controller.
  * @id:                 Instance id in the controller (Direct Resource Voter).
  * @num_tcs:            Number of TCSes in this DRV.
@@ -114,6 +115,7 @@ struct rpmh_ctrlr {
  */
 struct rsc_drv {
 	const char *name;
+	void __iomem *base;
 	void __iomem *tcs_base;
 	int id;
 	int num_tcs;
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 050b5f5c9f62..8e01697f59af 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -881,8 +881,7 @@ static int rpmh_rsc_pd_attach(struct rsc_drv *drv, struct device *dev)
 	return ret;
 }
 
-static int rpmh_probe_tcs_config(struct platform_device *pdev,
-				 struct rsc_drv *drv, void __iomem *base)
+static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *drv)
 {
 	struct tcs_type_config {
 		u32 type;
@@ -896,9 +895,9 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 	ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
 	if (ret)
 		return ret;
-	drv->tcs_base = base + offset;
+	drv->tcs_base = drv->base + offset;
 
-	config = readl_relaxed(base + DRV_PRNT_CHLD_CONFIG);
+	config = readl_relaxed(drv->base + DRV_PRNT_CHLD_CONFIG);
 
 	max_tcs = config;
 	max_tcs &= DRV_NUM_TCS_MASK << (DRV_NUM_TCS_SHIFT * drv->id);
@@ -960,7 +959,6 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	char drv_id[10] = {0};
 	int ret, irq;
 	u32 solver_config;
-	void __iomem *base;
 
 	/*
 	 * Even though RPMh doesn't directly use cmd-db, all of its children
@@ -987,11 +985,11 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 		drv->name = dev_name(&pdev->dev);
 
 	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
-	base = devm_platform_ioremap_resource_byname(pdev, drv_id);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	drv->base = devm_platform_ioremap_resource_byname(pdev, drv_id);
+	if (IS_ERR(drv->base))
+		return PTR_ERR(drv->base);
 
-	ret = rpmh_probe_tcs_config(pdev, drv, base);
+	ret = rpmh_probe_tcs_config(pdev, drv);
 	if (ret)
 		return ret;
 
@@ -1014,7 +1012,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	 * 'HW solver' mode where they can be in autonomous mode executing low
 	 * power mode to power down.
 	 */
-	solver_config = readl_relaxed(base + DRV_SOLVER_CONFIG);
+	solver_config = readl_relaxed(drv->base + DRV_SOLVER_CONFIG);
 	solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
 	solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
 	if (!solver_config) {
-- 
2.34.1

