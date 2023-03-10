Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58A6B470E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjCJOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjCJOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:32 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47E812115F;
        Fri, 10 Mar 2023 06:47:15 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id bp19so4405843oib.4;
        Fri, 10 Mar 2023 06:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLqzD8+2CF/pIUdlHHjjrK7T/hMwbjXYhuFmb1oAmEA=;
        b=ggfOf9TUe/BXTPpUQ4T3LmlzGanGvSDcTdTSRRRu3ogPIT9V8ndT0GgA6pF7Vdq6qm
         +d7xdE+HktoAkLPxsDQW9IMj6RK7Xp8bwh4zWsOcQa58lzQl7A/lD4jvyTNdsolWWNZh
         EegtDMYlYQ9I64V1WAXtOHCKqKASvdxIuFjE+TbkEEhHuxylzyJtc9hLLuNDjgk6ZY3q
         FmT0PJ0Unr5N29vqWxOK2g2uPEfaUhIh+ZPbBjhULOo3VDLdQMHzVOQR3VKdWIvbQLVA
         r7RSIjRHeurYtuyW2Drj+rOve7M8pU7JloS4c2p+bTvXd7PyfpskIQUi9HAO0tUNlPUY
         fhlA==
X-Gm-Message-State: AO0yUKXV4NeUx+8TXwMV/8rMvY2NUbpIxuRh6AQdapzXorUBCnkOkEt4
        yjZec97p/3euPGTll4vCnw==
X-Google-Smtp-Source: AK7set8Bdag2GIi+kSg4D6nNSAv+XQoZMwETZaTM9ps5v4efL5Wq9sPuPAr6F34JwgVtxlFdO1tJEg==
X-Received: by 2002:aca:2204:0:b0:35e:d286:232b with SMTP id b4-20020aca2204000000b0035ed286232bmr11451371oic.10.1678459632180;
        Fri, 10 Mar 2023 06:47:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e184-20020acab5c1000000b003847ca255fasm972035oif.30.2023.03.10.06.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:11 -0800 (PST)
Received: (nullmailer pid 1541530 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:01 -0600
Message-Id: <20230310144701.1541504-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/clk.c         | 4 ++--
 drivers/clk/sprd/common.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ae07685c7588..f7528d7f8256 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4880,8 +4880,8 @@ static struct device_node *get_clk_provider_node(struct device *dev)
 	np = dev->of_node;
 	parent_np = dev->parent ? dev->parent->of_node : NULL;
 
-	if (!of_find_property(np, "#clock-cells", NULL))
-		if (of_find_property(parent_np, "#clock-cells", NULL))
+	if (!of_property_present(np, "#clock-cells"))
+		if (of_property_present(parent_np, "#clock-cells"))
 			np = parent_np;
 
 	return np;
diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index ce81e4087a8f..1a3795a61f81 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -44,7 +44,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 	struct device_node *node = dev->of_node, *np;
 	struct regmap *regmap;
 
-	if (of_find_property(node, "sprd,syscon", NULL)) {
+	if (of_property_present(node, "sprd,syscon")) {
 		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
 		if (IS_ERR(regmap)) {
 			pr_err("%s: failed to get syscon regmap\n", __func__);
-- 
2.39.2

