Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5353F6B476D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjCJOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjCJOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:49:04 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3D51223B9;
        Fri, 10 Mar 2023 06:47:42 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-176261d7f45so6035547fac.11;
        Fri, 10 Mar 2023 06:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2woDhUU8segjfXUK8bCKWWkxeooki4Tiioxihb29omI=;
        b=77sr8Yd32bNJG5E5gvSB/QAYw7sH6uZZYnzRb9vwSvrRpBhHesYo36o5pwes2RUSC3
         d3Bss/p+T5OVt/GFznda7n9ni/f7zW1R20nFfJ6sukfuDbhSwtKgzieznkFi4TCgzxJi
         U6N6ppGWXSgkt/8EzRMCYbWQwmDnlBqufIxfgF2eExzan5c6B0IG6GC2rYWC0Mt89EYU
         laQlBc+iqytku2koO8/VAcrYkt/oEXr2VX+X8TklMaygap09EJMAFwXJ8bO3Zv+aKV0R
         hp+v6SjrzBf30bor5skzvMQA4yb/IKS5rif/2+iIA9XVGOd8f73GvYfyCP5b0t10auar
         1lBg==
X-Gm-Message-State: AO0yUKW8TIAL8Ny+J9gmKvnrH79XLA++G6W2cCO7qYCnyp1a6JwTAmYO
        wF0E/cU6udmuBOX7MtEL0A==
X-Google-Smtp-Source: AK7set8U4wjqUrryELYfSJxMuPVOOd0KXhYQxIgamWtZOI+6GdKcXJrh5sheP103x03+JPriAbk29w==
X-Received: by 2002:a05:6870:b14d:b0:172:80f9:a545 with SMTP id a13-20020a056870b14d00b0017280f9a545mr4220778oal.25.1678459662131;
        Fri, 10 Mar 2023 06:47:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y20-20020a056870429400b00172428894e0sm95296oah.28.2023.03.10.06.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:41 -0800 (PST)
Received: (nullmailer pid 1541915 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] cpuidle: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:03 -0600
Message-Id: <20230310144703.1541888-1-robh@kernel.org>
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
 drivers/cpuidle/cpuidle-psci-domain.c | 2 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 6ad2954948a5..e875ddadc51b 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -165,7 +165,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	 * initialize a genpd/genpd-of-provider pair when it's found.
 	 */
 	for_each_child_of_node(np, node) {
-		if (!of_find_property(node, "#power-domain-cells", NULL))
+		if (!of_property_present(node, "#power-domain-cells"))
 			continue;
 
 		ret = psci_pd_init(node, use_osi);
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index be383f4b6855..1fab1abc6eb6 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -497,7 +497,7 @@ static int sbi_genpd_probe(struct device_node *np)
 	 * initialize a genpd/genpd-of-provider pair when it's found.
 	 */
 	for_each_child_of_node(np, node) {
-		if (!of_find_property(node, "#power-domain-cells", NULL))
+		if (!of_property_present(node, "#power-domain-cells"))
 			continue;
 
 		ret = sbi_pd_init(node);
@@ -548,8 +548,8 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
 	for_each_possible_cpu(cpu) {
 		np = of_cpu_device_node_get(cpu);
 		if (np &&
-		    of_find_property(np, "power-domains", NULL) &&
-		    of_find_property(np, "power-domain-names", NULL)) {
+		    of_property_present(np, "power-domains") &&
+		    of_property_present(np, "power-domain-names")) {
 			continue;
 		} else {
 			sbi_cpuidle_use_osi = false;
-- 
2.39.2

