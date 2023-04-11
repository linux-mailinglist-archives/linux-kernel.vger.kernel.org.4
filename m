Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B26DE2E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjDKRoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjDKRn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:43:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F75242;
        Tue, 11 Apr 2023 10:43:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g3so9985737pja.2;
        Tue, 11 Apr 2023 10:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681235035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Udcci5NGDZqAtZS2tjutTnyxf3jfbw2OMApdjiJ0PnY=;
        b=juJ3i10ZRnmn5m8i5ZbLUla8EAtSg25xtSgl2qqcj5nOWgM94Yu05IPHcX/Hho+Tyl
         lk0emqBNAZVWNjyf9I0+TEitWMcFNszqPcMpq0kKslJHweVJHmYw2j1eh2j3Er/IMdDx
         vi7RYSXo9NwyClrJPc7wjX5HK4fdo5PFtHSUuYJVDwDmKWFylrx06+xwSUnEI+En3TAw
         saEOt46N9h9SplVgF0/RLLzQrz7wI34CaTiNF7VS88yjuHXxcs6tjOXFtPjP94VX0LtK
         +AneR7INJTvDxVnY8NHiwnR5cuy4H4CD7f/zSHvuHdCdpZp6lzUF/y3IM/6dpfJGUJdj
         vYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Udcci5NGDZqAtZS2tjutTnyxf3jfbw2OMApdjiJ0PnY=;
        b=Q4qd/zTdkDVhhJx4esYmNzmOdkGneluc/NgVyIgiQIAEfYRrelD8W0hJi0/h4vxfPG
         fX0cZOnxLFBXE7hxqMp1/2VBK7BUvlrRc1Wdp/I0v5I+YJNrxUwxwZ0e3w8dkNX4eD83
         JMN5xYN66XAxSjyNOOOsSo+pNHbJavzJEjsmziwfGHCGwPLHgV+bZLQSlp8pGnUXX22N
         XtMnEGQypAq0ZVLNf2jB+51oDFKS3Mr1CNjpQLed99oeSLZOwJQBdCe/LspdR/OXvyov
         Dyb30VjH2bPd3kzGLBaaC1vOkRjKPG/TY2BmdRthnp9YW3nlT7ScofB5d8k/ivgc+2qv
         Z/KQ==
X-Gm-Message-State: AAQBX9d/Bhm2ss05tsRgvCaQyEvF/hUzX9Y1T0+E5Lg+t3fM6MRFsnBe
        fmWa7hhd5kBYN1SQ3vMov3HkPIKum8L/yTLOG3s=
X-Google-Smtp-Source: AKy350aIqTsep6vnRtSegIHX+DIBdfsxQx5yhf1b6xIvRySchsBMlzowkDqTLD9yTPkZYEGSfR4hhQ==
X-Received: by 2002:a17:903:1206:b0:1a6:3737:750d with SMTP id l6-20020a170903120600b001a63737750dmr3972418plh.17.1681235035077;
        Tue, 11 Apr 2023 10:43:55 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001a655738a42sm1900805pll.172.2023.04.11.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:43:54 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/13] clk: hisilicon: Add helper functions for platform driver
Date:   Wed, 12 Apr 2023 01:43:10 +0800
Message-Id: <20230411174329.424763-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411174329.424763-1-mmyangfl@gmail.com>
References: <20230411174329.424763-1-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk.c   | 158 ++++++++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.h   |  46 +++++++++-
 drivers/clk/hisilicon/crg.h   |   5 ++
 drivers/clk/hisilicon/reset.c |  43 +++++++++
 4 files changed, 250 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 54d9fdc93599..074a70d33392 100644
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
@@ -341,3 +360,142 @@ void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+
+static size_t hisi_clocks_get_nr(const struct hisi_clocks *clks)
+{
+	if (clks->nr)
+		return clks->nr;
+
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
+static int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
+			     struct hisi_clock_data *data)
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
index 7a9b42e1b027..73bd54f303e7 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -17,10 +17,12 @@
 #include <linux/spinlock.h>
 
 struct platform_device;
+struct hisi_clocks;
 
 struct hisi_clock_data {
-	struct clk_onecell_data	clk_data;
-	void __iomem		*base;
+	struct clk_onecell_data		clk_data;
+	void __iomem			*base;
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
@@ -154,4 +190,10 @@ hisi_clk_unregister(mux)
 hisi_clk_unregister(divider)
 hisi_clk_unregister(gate)
 
+/* helper functions for platform driver */
+
+int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks);
+int hisi_clk_probe(struct platform_device *pdev);
+int hisi_clk_remove(struct platform_device *pdev);
+
 #endif	/* __HISI_CLK_H */
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

