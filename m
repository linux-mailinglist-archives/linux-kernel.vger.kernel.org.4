Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8236B4730
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjCJOtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjCJOrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:41 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAD511F62C;
        Fri, 10 Mar 2023 06:47:24 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id be16so4445147oib.0;
        Fri, 10 Mar 2023 06:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdWW9ncgSIHEZEYSb0mkw0NVObO6RbETPoJE1mKPNzo=;
        b=vH3QQbK4G3kihj5VzK4+zFI8DkXsedZFmxTqFQtnHvGFg2SFZ7i4hKL4WvOYA72sK1
         8NTHTK07eg3k4rY+i5gRxzUSx15UG97J4IJjHuJ+3Uwk4u2x1PvR2XZFoHVtqmpkPaKk
         gvPQDj1Nd105BOsjoROBO06kJSfkzoxL2MsQ/IwSoc57cXzzNfL2ykCE6cFRTQEp+fpS
         rKHH4jFZp+PR48SMzisIt01oV4aS/6OoZwrEU8QESlfFQxOLNwNIlE8aUygx898QLUU2
         e3E24SsJ4zECRvVOfmEolnhbW+tKk6OuyN5qQoIP+aCzwM+BsGw6HCV55yKOqkisd0f0
         Ud8g==
X-Gm-Message-State: AO0yUKXeSAeOcuEhMFSGoHvUpHKO0wSC2pBY/wkKfd0eCuzF+/lFq/9b
        DyL7hffgdA7LZapAcQHw/A==
X-Google-Smtp-Source: AK7set/8L4r+XvpMu69vm6S6XFR1r1QKusZrKwJxtRfFGT1XqqIlwZ3+BTC+mAIkluQcKq5JUFaEUQ==
X-Received: by 2002:a05:6808:197:b0:384:311d:5664 with SMTP id w23-20020a056808019700b00384311d5664mr11445048oic.23.1678459638382;
        Fri, 10 Mar 2023 06:47:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s9-20020acac209000000b00383eaf88e75sm943090oif.39.2023.03.10.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:17 -0800 (PST)
Received: (nullmailer pid 1542071 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] firmware: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:04 -0600
Message-Id: <20230310144704.1542045-1-robh@kernel.org>
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
 drivers/firmware/arm_scmi/optee.c | 2 +-
 drivers/firmware/tegra/bpmp.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 929720387102..e123de6e8c67 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -403,7 +403,7 @@ static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 		       struct scmi_optee_channel *channel)
 {
-	if (of_find_property(cinfo->dev->of_node, "shmem", NULL))
+	if (of_property_present(cinfo->dev->of_node, "shmem"))
 		return setup_static_shmem(dev, cinfo, channel);
 	else
 		return setup_dynamic_shmem(dev, channel);
diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 042c2043929d..8b5e5daa9fae 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -764,19 +764,19 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto free_mrq;
 
-	if (of_find_property(pdev->dev.of_node, "#clock-cells", NULL)) {
+	if (of_property_present(pdev->dev.of_node, "#clock-cells")) {
 		err = tegra_bpmp_init_clocks(bpmp);
 		if (err < 0)
 			goto free_mrq;
 	}
 
-	if (of_find_property(pdev->dev.of_node, "#reset-cells", NULL)) {
+	if (of_property_present(pdev->dev.of_node, "#reset-cells")) {
 		err = tegra_bpmp_init_resets(bpmp);
 		if (err < 0)
 			goto free_mrq;
 	}
 
-	if (of_find_property(pdev->dev.of_node, "#power-domain-cells", NULL)) {
+	if (of_property_present(pdev->dev.of_node, "#power-domain-cells")) {
 		err = tegra_bpmp_init_powergates(bpmp);
 		if (err < 0)
 			goto free_mrq;
-- 
2.39.2

