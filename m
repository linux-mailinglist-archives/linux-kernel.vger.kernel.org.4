Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9783A6DC60B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjDJLIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjDJLID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:08:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6E30F0;
        Mon, 10 Apr 2023 04:08:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ik20so4260981plb.3;
        Mon, 10 Apr 2023 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681124880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGYltMygM2Avg7sOhC73hhQt4KoPWEHqx0AmFedwBwI=;
        b=kjqgIfK/yuNK3wgV3HdeL9NBcPafQXEb61GuA3Lf8BVJ0yHSaiaVZ72WEkAlJnk/L3
         SbzxLNt/RCR7F20iBsCwgtsuPT4Muy1wP5aK5C3/lqx8YpANOj4ekTIzaXFCDM5rZ7wA
         ZmcvFk2m2QdHRfTQJHp8AXbCQQzDxfCPQBaZhyjFZAmN9spoa1hepHvtTUBdY3Efuctk
         n6zXBd/9dbCymrYL4ReDCAvfdSrB3DzMehPQZHsI8W6+uw1M6wx9/GGM1X8phE95YD2v
         j1af2GhvtTNdnJ3x5nc2Z7e9Wt8e/SNvJJpzb/0swNfK27Pd3nAKUZZ4LKq1sWdETRt7
         NyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681124880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGYltMygM2Avg7sOhC73hhQt4KoPWEHqx0AmFedwBwI=;
        b=YC/0dXOTKHId7lkk43iS+jktmUtv6B31GVHps1k29k6vtwI3CzsrgDs8kRxzdiCCJh
         V/tLhrvdf+mC0uddwZkbAQnKT9BcZg8Slv5A5ycvqhc3+Rh+NnmBwxhGFw++3dru/+Y6
         AxQKXVOyZth0K/ZRqfuesPRHJc9kx2kuQKLwdClI4tNHHFXe10yy3B9WK4JFO2tCspCC
         8v+vITz6m94EHjAoFCgX81vW3PH1sMbvr9rogXEwfhrqIlHChhXS7tTAO9etYmyg8V/9
         0LklD8Dq+iXkEhwWaTnAVRsFeZln6yHFN5wVuE/9bceY50vCA5lu9vW9THeS+qU61+xA
         1GEg==
X-Gm-Message-State: AAQBX9cHkydulAR4K2Yz6qD5PUs/QJlwq0KIO4UDcEFxmjqExZQN/I1s
        d6ppb+YewhQqdSURCm1vy9wp187eWRsoxxwT91A=
X-Google-Smtp-Source: AKy350bTpGsFLJWFhlqeJelbbQ0yY8uV6z19yHKbooeD3vZnDnkhUVIBMLKTD4T84nIC2BxuZhX0UA==
X-Received: by 2002:a17:902:f947:b0:1a1:ca37:5257 with SMTP id kx7-20020a170902f94700b001a1ca375257mr8343304plb.7.1681124880512;
        Mon, 10 Apr 2023 04:08:00 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm7464728pls.216.2023.04.10.04.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:08:00 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/14] clk: hisilicon: Add helper functions for platform driver
Date:   Mon, 10 Apr 2023 19:07:13 +0800
Message-Id: <20230410110733.192151-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410110733.192151-1-mmyangfl@gmail.com>
References: <20230410110733.192151-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helper functions extract common operations on platform drivers.

During migration to devm APIs, (virtual) fixed clocks were found hard on
devm APIs, since they often depended by crucial peripherals, thus require
early initialization before device probing, and cannot use devm APIs.

One solution to this problem is to add a "fixed-clock" node to device tree,
independent to clock device, and make those peripherals depend on that.
However, there is also some devices that do use fixed clocks provided by
drivers, for example clk-hi3660.c .

To simplify codes, we migrate clocks of other types to devm APIs, while
keep fixed clocks self-managed, alongside with struct hisi_clock_data, and
remove devm-managed hisi_clock_data.

`hisi_clk_alloc` will be removed in the following patch.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk.c   | 156 ++++++++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.h   |  45 ++++++++++
 drivers/clk/hisilicon/crg.h   |   5 ++
 drivers/clk/hisilicon/reset.c |  43 ++++++++++
 4 files changed, 249 insertions(+)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 54d9fdc93599..cb4444bba2c0 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -88,6 +88,25 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(hisi_clk_init);
 
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data)
+{
+	if (data->clks) {
+		if (data->clks->fixed_rate_clks_num)
+			hisi_clk_unregister_fixed_rate(data->clks->fixed_rate_clks,
+						       data->clks->fixed_rate_clks_num,
+						       data);
+		if (data->clks->fixed_factor_clks_num)
+			hisi_clk_unregister_fixed_factor(data->clks->fixed_factor_clks,
+							 data->clks->fixed_factor_clks_num,
+							 data);
+	}
+
+	of_clk_del_provider(np);
+	kfree(data->clk_data.clks);
+	kfree(data);
+}
+EXPORT_SYMBOL_GPL(hisi_clk_free);
+
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
 					 int nums, struct hisi_clock_data *data)
 {
@@ -341,3 +360,140 @@ void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+
+int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
+		      struct hisi_clock_data *data)
+{
+	int ret;
+
+	if (clks->mux_clks_num) {
+		ret = hisi_clk_register_mux(clks->mux_clks,
+					    clks->mux_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->phase_clks_num) {
+		ret = hisi_clk_register_phase(dev, clks->phase_clks,
+					      clks->phase_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->divider_clks_num) {
+		ret = hisi_clk_register_divider(clks->divider_clks,
+						clks->divider_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->gate_clks_num) {
+		ret = hisi_clk_register_gate(clks->gate_clks,
+					     clks->gate_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->gate_sep_clks_num) {
+		hisi_clk_register_gate_sep(clks->gate_sep_clks,
+					   clks->gate_sep_clks_num, data);
+	}
+
+	if (clks->clk_register_customized && clks->customized_clks_num) {
+		ret = clks->clk_register_customized(dev, clks->customized_clks,
+						    clks->customized_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_register);
+
+static size_t hisi_clocks_get_nr(const struct hisi_clocks *clks)
+{
+	return clks->fixed_rate_clks_num + clks->fixed_factor_clks_num +
+		clks->mux_clks_num + clks->phase_clks_num +
+		clks->divider_clks_num + clks->gate_clks_num +
+		clks->gate_sep_clks_num + clks->customized_clks_num;
+}
+
+int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks)
+{
+	struct hisi_clock_data *data;
+	int ret;
+
+	data = hisi_clk_init(np, hisi_clocks_get_nr(clks));
+	if (!data)
+		return -ENOMEM;
+	data->clks = clks;
+
+	ret = hisi_clk_register_fixed_rate(clks->fixed_rate_clks,
+					   clks->fixed_rate_clks_num, data);
+	if (ret)
+		goto err;
+
+	ret = hisi_clk_register_fixed_factor(clks->fixed_factor_clks,
+					     clks->fixed_factor_clks_num, data);
+	if (ret)
+		goto err;
+
+	np->data = data;
+	return 0;
+
+err:
+	hisi_clk_free(np, data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_early_init);
+
+int hisi_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct hisi_clocks *clks;
+	struct hisi_clock_data *data;
+	int ret;
+
+	clks = of_device_get_match_data(dev);
+	if (!clks)
+		return -ENOENT;
+
+	if (!np->data) {
+		ret = hisi_clk_early_init(np, clks);
+		if (ret)
+			return ret;
+	}
+
+	data = np->data;
+	np->data = NULL;
+
+	if (clks->prologue) {
+		ret = clks->prologue(dev, data);
+		if (ret)
+			goto err;
+	}
+
+	ret = hisi_clk_register(dev, clks, data);
+	if (ret)
+		goto err;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+
+err:
+	hisi_clk_free(np, data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_probe);
+
+int hisi_clk_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct hisi_clock_data *data = platform_get_drvdata(pdev);
+
+	hisi_clk_free(np, data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_remove);
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 7a9b42e1b027..c373d7c14ed5 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -17,10 +17,12 @@
 #include <linux/spinlock.h>
 
 struct platform_device;
+struct hisi_clocks;
 
 struct hisi_clock_data {
 	struct clk_onecell_data	clk_data;
 	void __iomem		*base;
+	const struct hisi_clocks	*clks;
 };
 
 struct hisi_fixed_rate_clock {
@@ -103,6 +105,39 @@ struct hisi_gate_clock {
 	const char		*alias;
 };
 
+struct hisi_clocks {
+	/* if 0, sum all *_num */
+	size_t nr;
+
+	int (*prologue)(struct device *dev, struct hisi_clock_data *data);
+
+	const struct hisi_fixed_rate_clock *fixed_rate_clks;
+	size_t fixed_rate_clks_num;
+
+	const struct hisi_fixed_factor_clock *fixed_factor_clks;
+	size_t fixed_factor_clks_num;
+
+	const struct hisi_mux_clock *mux_clks;
+	size_t mux_clks_num;
+
+	const struct hisi_phase_clock *phase_clks;
+	size_t phase_clks_num;
+
+	const struct hisi_divider_clock *divider_clks;
+	size_t divider_clks_num;
+
+	const struct hisi_gate_clock *gate_clks;
+	size_t gate_clks_num;
+
+	const struct hisi_gate_clock *gate_sep_clks;
+	size_t gate_sep_clks_num;
+
+	const void *customized_clks;
+	size_t customized_clks_num;
+	int (*clk_register_customized)(struct device *dev, const void *clks,
+				       size_t num, struct hisi_clock_data *data);
+};
+
 struct clk *hisi_register_clkgate_sep(struct device *, const char *,
 				const char *, unsigned long,
 				void __iomem *, u8,
@@ -113,6 +148,7 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
 
 struct hisi_clock_data *hisi_clk_alloc(struct platform_device *, int);
 struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data);
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
 				int, struct hisi_clock_data *);
 int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
@@ -134,6 +170,15 @@ void hisi_clk_register_gate_sep(const struct hisi_gate_clock *,
 void hi6220_clk_register_divider(const struct hi6220_divider_clock *,
 				int, struct hisi_clock_data *);
 
+int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
+		      struct hisi_clock_data *data);
+
+/* helper functions for platform driver */
+
+int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks);
+int hisi_clk_probe(struct platform_device *pdev);
+int hisi_clk_remove(struct platform_device *pdev);
+
 #define hisi_clk_unregister(type) \
 static inline \
 void hisi_clk_unregister_##type(const struct hisi_##type##_clock *clks, \
diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
index 803f6ba6d7a2..d9544f1f2625 100644
--- a/drivers/clk/hisilicon/crg.h
+++ b/drivers/clk/hisilicon/crg.h
@@ -22,4 +22,9 @@ struct hisi_crg_dev {
 	const struct hisi_crg_funcs *funcs;
 };
 
+/* helper functions for platform driver */
+
+int hisi_crg_probe(struct platform_device *pdev);
+int hisi_crg_remove(struct platform_device *pdev);
+
 #endif	/* __HISI_CRG_H */
diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 93cee17db8b1..19918cd717fd 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -6,11 +6,15 @@
  */
 
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+
+#include "clk.h"
+#include "crg.h"
 #include "reset.h"
 
 #define	HISI_RESET_BIT_MASK	0x1f
@@ -116,3 +120,42 @@ void hisi_reset_exit(struct hisi_reset_controller *rstc)
 	reset_controller_unregister(&rstc->rcdev);
 }
 EXPORT_SYMBOL_GPL(hisi_reset_exit);
+
+int hisi_crg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hisi_crg_dev *crg;
+	int ret;
+
+	crg = devm_kmalloc(dev, sizeof(*crg), GFP_KERNEL);
+	if (!crg)
+		return -ENOMEM;
+
+	ret = hisi_clk_probe(pdev);
+	if (ret)
+		return ret;
+
+	crg->rstc = hisi_reset_init(pdev);
+	if (!crg->rstc) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, crg);
+	return 0;
+
+err:
+	hisi_clk_remove(pdev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_crg_probe);
+
+int hisi_crg_remove(struct platform_device *pdev)
+{
+	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
+
+	hisi_reset_exit(crg->rstc);
+	hisi_clk_remove(pdev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_crg_remove);
-- 
2.39.2

