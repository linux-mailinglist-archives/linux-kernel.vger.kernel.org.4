Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10776B483B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjCJPAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjCJPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:00:17 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE7411CD61;
        Fri, 10 Mar 2023 06:54:17 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17711f56136so6031026fac.12;
        Fri, 10 Mar 2023 06:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pED2hE/yKSIdpGB1fgEVNvATFJQwXMVTZnzZvUvbxCg=;
        b=s/81O7qwVRWlvY1ZZrsu4OWGVXgPM6pUNzKIQnYyGK5dhSTiLs58JHglM/weHFaWPw
         hjJt5y7nmAJPrmy4nsT+tT13i5mdio2U6XxKeO/0728FbphljirT9psDTHMULdINqS5v
         2O9Vxp3dfgSwdm/IOyoL1d+QI9kjxdpXyNG1l2DJ1xbhfKVZJJSnIxizcXK/qqwkgL7z
         Saj7RAeKERmrLXcPWvfagaAccoAi+1F7bKedA3fUWQiZY7mGhWXYqtDXyNOJAlV6Xtiw
         NwDsZge0whAlkmrWjwDyFeQIAoGkQxNKLoFipB8hvb0O8NimoMlXpj5lBBjcFgKivvji
         G2/Q==
X-Gm-Message-State: AO0yUKVI/IwO5vt0YFuGl+oZRGjeUpKGURhts7U+9Yej1E9v+7vYKhMi
        vn7piAzJsOsY5hpWPnEZzg==
X-Google-Smtp-Source: AK7set/Hm9aC04epmTh3ilh/9NcDNxIApzetfeqMJFBuTYkxKPIem48QMaFDunttnQXTPu6yfagEtg==
X-Received: by 2002:a05:6870:4195:b0:176:4a1f:4f87 with SMTP id y21-20020a056870419500b001764a1f4f87mr16562974oac.50.1678459694895;
        Fri, 10 Mar 2023 06:48:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zq48-20020a0568718eb000b00172473f9fe0sm118604oab.13.2023.03.10.06.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:14 -0800 (PST)
Received: (nullmailer pid 1545410 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:25 -0600
Message-Id: <20230310144725.1545384-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 drivers/soc/ti/omap_prm.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 8fb76908be70..48de98560093 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1267,7 +1267,7 @@ static int knav_setup_queue_range(struct knav_device *kdev,
 	if (of_get_property(node, "qalloc-by-id", NULL))
 		range->flags |= RANGE_RESERVED;
 
-	if (of_get_property(node, "accumulator", NULL)) {
+	if (of_property_present(node, "accumulator")) {
 		ret = knav_init_acc_range(kdev, node, range);
 		if (ret < 0) {
 			devm_kfree(dev, range);
diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index 913b964374a4..ecd9a8bdd7c0 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -684,7 +684,7 @@ static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
 	const char *name;
 	int error;
 
-	if (!of_find_property(dev->of_node, "#power-domain-cells", NULL))
+	if (!of_property_present(dev->of_node, "#power-domain-cells"))
 		return 0;
 
 	of_node_put(dev->of_node);
-- 
2.39.2

