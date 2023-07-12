Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C337504B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjGLKgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjGLKft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:35:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7222A2699
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:35:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e97fcc60so4665678b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158118; x=1691750118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PtBZ5U/uPeERQpI5byb7Cw2i1LitARzlq3AxNOTl7Y=;
        b=r7WllUK3aizqmTErli8XKT+tdveXXrxsPymKU/mra2cIbrgPXN8MIassa7PByvkKgc
         1mFMXC3ZcEhTC0ZirVNdbEVlT3xSfUoubHkW+qTOzTRBhMGaUSQhdM43T2vy9ez6EqpX
         nhTU6JokNBUpDZC+CyOxHPQ3EWimNHvFA9c8TQN9whsBOocgcCY2qDrKvLJ0nfarNhfB
         4t3HWE5B/OHkjlm+sPOtzF2u5nQv0Gb0ikuvxxuRXVCJNw3AiNFSqjIsUv6DmVrh2R5T
         3QiVve5zBwPGlY4s/esJ2qiY1P28ebmv6nMVvWqBUj226X/0UIuuIqMLZKdPP/GRAhWs
         uGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158118; x=1691750118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PtBZ5U/uPeERQpI5byb7Cw2i1LitARzlq3AxNOTl7Y=;
        b=DwD3+1khofvE6uM2OzGpqD2shExbfXxG0y797I1QxcM7jldZCsRAlql5Pj3Rzpt+rW
         fYUKyHfbglFfHV9hHEcjppt6k8wNW5QGBcgSTv7hgEJHksHYTvvAJ0qBiFAKVKfcHmjx
         NjGdzTwt+4EH68EGJuv75aw0ZS45o+OkRV8wTUclsL/YBEy9wJwb/zcwowMlj9BNVrtC
         BW72E2n7bFaj6AXhQWxy+CDIeJWjt8umg6Yo1qosHcpFIWTb267taD+KD75Wc4t55L3c
         GeVjZtWK+U4Od5SzR1z2Jbv1l1GU+mbkJNJWomT08MP0Yl+yagS8d6SvSfIHiHopfZ0t
         ZvGQ==
X-Gm-Message-State: ABy/qLZNQgyRrHWhCzTlDY3VQFMqGrx55o5bEzPEetpYJ6ujwuyhR00u
        fOc7eeHqgMOuzhyiePfCNU9D
X-Google-Smtp-Source: APBJJlH35o5eipwsIx/Xo58EhFxCs1+N9r6uFY2YfDA+FauTSI8auma2IY2TmzkMMJwMv1hNYrTLGw==
X-Received: by 2002:a05:6a20:12d4:b0:12d:e596:df21 with SMTP id v20-20020a056a2012d400b0012de596df21mr17179274pzg.7.1689158118058;
        Wed, 12 Jul 2023 03:35:18 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:35:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/14] scsi: ufs: host: Add support for parsing OPP
Date:   Wed, 12 Jul 2023 16:02:08 +0530
Message-Id: <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OPP framework can be used to scale the clocks along with other entities
such as regulators, performance state etc... So let's add support for
parsing OPP from devicetree. OPP support in devicetree is added through
the "operating-points-v2" property which accepts the OPP table defining
clock frequency, regulator voltage, power domain performance state etc...

Since the UFS controller requires multiple clocks to be controlled for
proper working, devm_pm_opp_set_config() has been used which supports
scaling multiple clocks through custom ufshcd_opp_config_clks() callback.

It should be noted that the OPP support is not compatible with the old
"freq-table-hz" property. So only one can be used at a time even though
the UFS core supports both.

Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufshcd-pltfrm.c | 116 +++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index 0b7430033047..068c22378c88 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -8,8 +8,10 @@
  *	Vinayak Holikatti <h.vinayak@samsung.com>
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 
@@ -17,6 +19,8 @@
 #include "ufshcd-pltfrm.h"
 #include <ufs/unipro.h>
 
+#include <trace/events/ufs.h>
+
 #define UFSHCD_DEFAULT_LANES_PER_DIRECTION		2
 
 static int ufshcd_parse_clock_info(struct ufs_hba *hba)
@@ -205,6 +209,112 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
 	}
 }
 
+static int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
+				  struct dev_pm_opp *opp, void *data,
+				  bool scaling_down)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	struct list_head *head = &hba->clk_list_head;
+	struct ufs_clk_info *clki;
+	unsigned long freq;
+	u8 idx = 0;
+	int ret;
+
+	list_for_each_entry(clki, head, list) {
+		if (!IS_ERR_OR_NULL(clki->clk)) {
+			freq = dev_pm_opp_get_freq_indexed(opp, idx++);
+
+			/* Do not set rate for clocks having frequency as 0 */
+			if (!freq)
+				continue;
+
+			ret = clk_set_rate(clki->clk, freq);
+			if (ret) {
+				dev_err(dev, "%s: %s clk set rate(%ldHz) failed, %d\n",
+					__func__, clki->name, freq, ret);
+				return ret;
+			}
+
+			trace_ufshcd_clk_scaling(dev_name(dev),
+				(scaling_down ? "scaled down" : "scaled up"),
+				clki->name, hba->clk_scaling.target_freq, freq);
+		}
+	}
+
+	return 0;
+}
+
+static int ufshcd_parse_operating_points(struct ufs_hba *hba)
+{
+	struct device *dev = hba->dev;
+	struct device_node *np = dev->of_node;
+	struct dev_pm_opp_config config = {};
+	struct ufs_clk_info *clki;
+	const char **clk_names;
+	int cnt, i, ret;
+
+	if (!of_find_property(np, "operating-points-v2", NULL))
+		return 0;
+
+	if (of_find_property(np, "freq-table-hz", NULL)) {
+		dev_err(dev, "%s: operating-points and freq-table-hz are incompatible\n",
+			 __func__);
+		return -EINVAL;
+	}
+
+	cnt = of_property_count_strings(np, "clock-names");
+	if (cnt <= 0) {
+		dev_err(dev, "%s: Missing clock-names\n",  __func__);
+		return -ENODEV;
+	}
+
+	/* OPP expects clk_names to be NULL terminated */
+	clk_names = devm_kcalloc(dev, cnt + 1, sizeof(*clk_names), GFP_KERNEL);
+	if (!clk_names)
+		return -ENOMEM;
+
+	/*
+	 * We still need to get reference to all clocks as the UFS core uses
+	 * them separately.
+	 */
+	for (i = 0; i < cnt; i++) {
+		ret = of_property_read_string_index(np, "clock-names", i,
+						    &clk_names[i]);
+		if (ret)
+			return ret;
+
+		clki = devm_kzalloc(dev, sizeof(*clki), GFP_KERNEL);
+		if (!clki)
+			return -ENOMEM;
+
+		clki->name = devm_kstrdup(dev, clk_names[i], GFP_KERNEL);
+		if (!clki->name)
+			return -ENOMEM;
+
+		if (!strcmp(clk_names[i], "ref_clk"))
+			clki->keep_link_active = true;
+
+		list_add_tail(&clki->list, &hba->clk_list_head);
+	}
+
+	config.clk_names = clk_names,
+	config.config_clks = ufshcd_opp_config_clks;
+
+	ret = devm_pm_opp_set_config(dev, &config);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret) {
+		dev_err(dev, "Failed to add OPP table: %d\n", ret);
+		return ret;
+	}
+
+	hba->use_pm_opp = true;
+
+	return 0;
+}
+
 /**
  * ufshcd_get_pwr_dev_param - get finally agreed attributes for
  *                            power mode change
@@ -371,6 +481,12 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 
 	ufshcd_init_lanes_per_dir(hba);
 
+	err = ufshcd_parse_operating_points(hba);
+	if (err) {
+		dev_err(dev, "%s: OPP parse failed %d\n", __func__, err);
+		goto dealloc_host;
+	}
+
 	err = ufshcd_init(hba, mmio_base, irq);
 	if (err) {
 		dev_err(dev, "Initialization failed\n");
-- 
2.25.1

