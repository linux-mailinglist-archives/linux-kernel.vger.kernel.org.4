Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48D06B4772
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjCJOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjCJOtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:49:20 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A561241D4;
        Fri, 10 Mar 2023 06:47:45 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id m25-20020a05683026d900b006941a2838caso3033013otu.7;
        Fri, 10 Mar 2023 06:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIsj2WC67R0QYaUVMrSWcmPH0Rz9P/s3jlTMUe0suxA=;
        b=iuH//qZrW7+ys647ooJxkyzJO1n47ThweQHvGk0lKFIWRZcGZh68OlQXw5DkY+OVjK
         mzYDKsjVW35m16jr4Mclg95iKEkmZ6e7B8eqj4i7ECT1NBxjeeVXGTcPFBP9uf5Bcun7
         fw7unTQoFSUC9Zy0QLuEHIbO++Ef2ojv4anYrr/6oWD56c+uGVNdP+bUUekb+bQgRh9X
         M6fEKWX1sh+bERUu+Bg1cxUCr/XogW2eQN8Q6FsipzDDimmFuleozd7M5h/dCtaqkwIa
         YP4zpRcVQtiZZNBLjjGHn8BnM6zNQgtu5wouTmcne72FEVwGtgw/UnGLdnS6i8qnpIuk
         vvgA==
X-Gm-Message-State: AO0yUKVFyVF+61XF8MQkAd5f3Lq9ZFM6UYMlryxt5/aHe6M0Ew6rkshr
        282ISXyVjz6SyHZrBdds+A==
X-Google-Smtp-Source: AK7set/+3mOkl+/k4Rr2TgpNfbxsa/tKL70X0mr92+aJ1X895GYyhQSFEdWZxUbKCxPmwh+UPoJULw==
X-Received: by 2002:a05:6830:35b:b0:693:daa8:ec6f with SMTP id h27-20020a056830035b00b00693daa8ec6fmr12574633ote.1.1678459664381;
        Fri, 10 Mar 2023 06:47:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u25-20020a056830249900b0068be5ad8044sm135876ots.4.2023.03.10.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:43 -0800 (PST)
Received: (nullmailer pid 1543793 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: arasan: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:14 -0600
Message-Id: <20230310144714.1543767-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/mmc/host/sdhci-of-arasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 89c431a34c43..415f44bf5ee6 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1434,7 +1434,7 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 
-	if (!of_find_property(np, "#clock-cells", NULL))
+	if (!of_property_present(np, "#clock-cells"))
 		return;
 
 	of_clk_del_provider(dev->of_node);
-- 
2.39.2

