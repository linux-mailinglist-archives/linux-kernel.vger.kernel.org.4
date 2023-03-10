Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AA06B477A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjCJOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjCJOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:49:56 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59C2728E;
        Fri, 10 Mar 2023 06:47:57 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id l15-20020a9d7a8f000000b0069447f0db6fso3046757otn.4;
        Fri, 10 Mar 2023 06:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ufsybUkbmkBZT7Reugv4yMUeSADY5agPgq6hpQcf+Q=;
        b=fXOqHEq27q7Nfg5k80wlWgFRkVkHn/HVK/Va/Az8Z5RlwNmSV4A4hwV+4C7fBejmcR
         uUrnulJhFhPL2P0GD4N7/oZGV/A6sahdG4k7MXxbwPJLnpHyNTbZ4cr4XQ0LZBUSKUvu
         ZS2Xo0ZvkwRwUf6qNNQAAbchKRjcZIvo+luBS3iliOqnuVLP36RplzyN/Nn0i7cq6Gyw
         gkqsD4bEjsd9qHbBSWDFD3W7HzZEDTQKRab1+mHaLLNWUyIb9NGcs1kPmeklgLPlo1ff
         j4ZRs9iz8ZlbCSLgA1HSUIiha/IFMc1OAmRs5gtKuWkOUwPh38MfxutQoQ2sJnWRvHzv
         ejcg==
X-Gm-Message-State: AO0yUKWGhDomcyPhxosZulg3+/zC7ytvnnHNWC1WuecbHt0VVGbwcNfZ
        cSlfHNdLpHads/h8tOA5TA==
X-Google-Smtp-Source: AK7set+11VqaTWYpd4ZPjYWm+8tkVPkSW2LDYoZdkK73WN5bvy/yIyRpxroutIcq90hTe1q+HMYn5w==
X-Received: by 2002:a05:6830:449e:b0:690:dbb5:df32 with SMTP id r30-20020a056830449e00b00690dbb5df32mr15274511otv.25.1678459669215;
        Fri, 10 Mar 2023 06:47:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e12-20020a9d730c000000b0068bb7bd2668sm97181otk.73.2023.03.10.06.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:48 -0800 (PST)
Received: (nullmailer pid 1545341 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: xilinx: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:24 -0600
Message-Id: <20230310144725.1545315-1-robh@kernel.org>
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
 drivers/soc/xilinx/zynqmp_power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 78a8a7545d1e..641dcc958911 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -218,7 +218,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	} else if (ret != -EACCES && ret != -ENODEV) {
 		dev_err(&pdev->dev, "Failed to Register with Xilinx Event manager %d\n", ret);
 		return ret;
-	} else if (of_find_property(pdev->dev.of_node, "mboxes", NULL)) {
+	} else if (of_property_present(pdev->dev.of_node, "mboxes")) {
 		zynqmp_pm_init_suspend_work =
 			devm_kzalloc(&pdev->dev,
 				     sizeof(struct zynqmp_pm_work_struct),
@@ -240,7 +240,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Failed to request rx channel\n");
 			return PTR_ERR(rx_chan);
 		}
-	} else if (of_find_property(pdev->dev.of_node, "interrupts", NULL)) {
+	} else if (of_property_present(pdev->dev.of_node, "interrupts")) {
 		irq = platform_get_irq(pdev, 0);
 		if (irq <= 0)
 			return -ENXIO;
-- 
2.39.2

