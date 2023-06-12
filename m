Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865D172BEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjFLK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjFLK20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:28:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B187E33E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:08:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977e7d6945aso751483766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686564395; x=1689156395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBZGnVp949LqmHfp0hbLm9KUytV5xswsvhn4zf+xDwg=;
        b=dwizF+difYah4cUnx9OIM8t661NXlbYWxPYccBCyt1x7T93DqhpUQw4AvFef+7qwVp
         mZWjzBrTsvERYTxyMFP0zswTgVRGwFD3ro1STtprcZ16S6phFIXrVT+QVGC4v1rIXMus
         dE9/SzZQQUvU7HlkaXWsvhg4nxps6pu2QPvJQvLc6LJKcUYpAyDlCHD9qS47HrAaRs44
         32SBfvRVp21bqpNVn63eVfMQqMydNCy5OaltZ7w7RnRv6e+02Ihxtd566jD9Ls8JC6Yj
         IQ6zfafDMZagrj26lRigbZUBz5097ZolpZfVDx/0hm4LqtxiVjrd4kLYvOYQhOvqUxZS
         58KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564395; x=1689156395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBZGnVp949LqmHfp0hbLm9KUytV5xswsvhn4zf+xDwg=;
        b=OSJORn3U3TzoX0kKZ9ZlqfFSXyVm9Ov8YDWHGwFNhTlfEL/OIQ6AUqAfbKvBvLO1IM
         0j9oXcRVN9SPSSZYUAA1LcYbJGbabRWiDjsc42J9BuAi807o1GHaP0Hw5BVlmvaRc/Lr
         rkSalSKOh1jUhm39NQ6riAi2VHdxqtfQRwuOTixcFAR1Kpg7gLS5d4cQqSpKaYlMGm5S
         +lh7ko2o57RLrzMt8iOWaby1uaSV/f/A3KWNbu2kcu3gXsJ8T+QFFX+zMyMFb+/w6//H
         OsRWmu085WQLKuYxhuyEdHk0ZE9g2khIcHwzM1PvM1SHFVylRFnq627h/0DlP72ldG72
         vNpg==
X-Gm-Message-State: AC+VfDx0wYMure/kdVO3Psp4mMV8eLCHVhSYofTZUTbNI64bBrOiibRr
        FAo0y9i+IhO9VbOOq+tzvdGQG1rA2DlN79ZO2hpzSg==
X-Google-Smtp-Source: ACHHUZ5QWKxhjPP1zIAUQOMIEjesvfvlM1EUinWaGlKYFYB2NYNJgSIadGHmGre+EpTQObgoqQC2eg==
X-Received: by 2002:a7b:ce88:0:b0:3f7:f4bc:ebe7 with SMTP id q8-20020a7bce88000000b003f7f4bcebe7mr5859896wmj.37.1686563855238;
        Mon, 12 Jun 2023 02:57:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:18 +0200
Subject: [PATCH v2 01/19] clk: meson: introduce meson-clkc-utils
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-1-38172d17c27a@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3180;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Sw6cxK6E7HYSGAjhmT4F08djxvQKs7eqg8Xnz1cdvKs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwFcdZeJ2nIN3mmWrU/JcOcDQTAsQkkpsoXJa0m
 m3SJxZaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsBQAKCRB33NvayMhJ0SXGD/
 9+VFokX7cu+g4xvYB8YpyF0mHuycbo0o8ZetwVYr5sftMLzMginwtCTlW5pbNw0zV8m7coKw9ErBGq
 yATAGnX2k0GRkvUignjShZh715IQiMJlD7sn/hb/6YVzfc74KgHSVsLGz0di5S8V4YCddBQjt2tm0M
 eYjXRAd3ntra12XPDNcTxilQY4xJCkCA1znc+qenXyoUJT7/hRsr5ZrudrKBcizikhXb6Hr1UVhEGF
 E3F6sLQi/lVwcP8GErVgBBLX69tnxDKK1NMygDyxSBYdt9nHe0wDbsWXvZ9kGffgw1WDxS5recgEhZ
 e6Rzq4OETGKlU7ZKynMl5SDj/F6BUep3Wri20fObgK2B8KtLd3qQ6JUb+ZnEbg1/4LFLrt5OXcnWSk
 hdOBzuY6k8K9GFBGFzPzm1CZ556qy3eCgmBEzJ+woMOLTcAigPX57joN4OLuROKe+EyVNaq7c0j4u2
 ESObGndfiUTX7DoNVy3oFSnxhhH8C6yhpUpjZ+iJqH4pwsPMD40rUQL+7BcPPRAaG5ybH6sXBjW7CC
 Flw9AkH4Zi/+hZ3j3qleE7Ae6JZwVJ8Aapx1ASAWDvxbC6/Pv+2q2z/XJc37drSVwVvOpAd4+nb0JX
 Rsoiog1Y1MweeqnG8YxOJgwBZquVXKCr1hsqdVVOuS/yzq2bsoPPuJzWJroA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's introduce a new module called meson-clkc-utils that
will contain shared utility functions for all Amlogic clock
controller drivers.

The first utility function is a replacement of of_clk_hw_onecell_get
in order to get rid of the NR_CLKS define in all Amlogic clock
drivers.

The goal is to move all duplicate probe and init code in this module.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/Kconfig            |  3 +++
 drivers/clk/meson/Makefile           |  1 +
 drivers/clk/meson/meson-clkc-utils.c | 25 +++++++++++++++++++++++++
 drivers/clk/meson/meson-clkc-utils.h | 19 +++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 8ce846fdbe43..d03adad31318 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -30,6 +30,9 @@ config COMMON_CLK_MESON_VID_PLL_DIV
 	tristate
 	select COMMON_CLK_MESON_REGMAP
 
+config COMMON_CLK_MESON_CLKC_UTILS
+	tristate
+
 config COMMON_CLK_MESON_AO_CLKC
 	tristate
 	select COMMON_CLK_MESON_REGMAP
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index d5288662881d..cd961cc4f4db 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Amlogic clock drivers
 
+obj-$(CONFIG_COMMON_CLK_MESON_CLKC_UTILS) += meson-clkc-utils.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON_CPU_DYNDIV) += clk-cpu-dyndiv.o
 obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
diff --git a/drivers/clk/meson/meson-clkc-utils.c b/drivers/clk/meson/meson-clkc-utils.c
new file mode 100644
index 000000000000..9a0620bcc161
--- /dev/null
+++ b/drivers/clk/meson/meson-clkc-utils.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include <linux/of_device.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include "meson-clkc-utils.h"
+
+struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data)
+{
+	const struct meson_clk_hw_data *data = clk_hw_data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= data->num) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return data->hws[idx];
+}
+EXPORT_SYMBOL_GPL(meson_clk_hw_get);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/meson-clkc-utils.h b/drivers/clk/meson/meson-clkc-utils.h
new file mode 100644
index 000000000000..fe6f40728949
--- /dev/null
+++ b/drivers/clk/meson/meson-clkc-utils.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#ifndef __MESON_CLKC_UTILS_H__
+#define __MESON_CLKC_UTILS_H__
+
+#include <linux/of_device.h>
+#include <linux/clk-provider.h>
+
+struct meson_clk_hw_data {
+	struct clk_hw	**hws;
+	unsigned int	num;
+};
+
+struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data);
+
+#endif

-- 
2.34.1

