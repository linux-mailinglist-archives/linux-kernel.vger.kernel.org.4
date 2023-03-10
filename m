Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF556B4789
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjCJOv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjCJOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:50:20 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F1F24BD4;
        Fri, 10 Mar 2023 06:48:08 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso3046490otr.5;
        Fri, 10 Mar 2023 06:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXCHY+LeASHjqbWZkrXOiJ6Ihxp14Y6fs7ARyvepk6w=;
        b=lbADqtoDjG1vUgrydqXvmgbkX2j2Exd74H7qPjrbSCNJA6jfupSoC7oIXQv32iFiPz
         EXXgcClRCp0YeOGgZ1bEU5nu9bWYinun7RwRsV7/X1Ych44r37vi09Po083aK1txVBIn
         fSOjwqyVmx/S1uR3+juJ20bHtD3c0J8BDVn4Ke0j97RzN7bPEP1KA+RQSqJJOiiFHpwO
         ZUIMVGQtcsDFORMq9RZwyRbp+Or/eXWuIoJ7k1pQYSE6r8RysKn56Iymqd2tveDipx2r
         lWAJQjSBvBa8hxAGibvJmi/IHqkn8Q9LYM/lefoNuu01iD9VBotJsUMiSiRTYuAF2uFX
         hHtg==
X-Gm-Message-State: AO0yUKWOCJcrptpxNSOzg9E9JSaHauwgwWQ5YYRHdoUnpavLkPN0jF6+
        L3oblloSweQT2ez5+mj87g==
X-Google-Smtp-Source: AK7set/X9oDJj8zIPyN/fV9iVrP8EOyGBouWKOZ8OH+87CK5qFHWqvBAWbWCp0iheSUuh+c/+gundA==
X-Received: by 2002:a05:6830:1d91:b0:693:d999:431a with SMTP id y17-20020a0568301d9100b00693d999431amr1039223oti.13.1678459672835;
        Fri, 10 Mar 2023 06:47:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j16-20020a9d7690000000b006863ccbf067sm96181otl.74.2023.03.10.06.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:52 -0800 (PST)
Received: (nullmailer pid 1546774 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: exynos: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:34 -0600
Message-Id: <20230310144734.1546726-1-robh@kernel.org>
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
 drivers/devfreq/exynos-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 027e8f336acc..d341876e7b62 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -432,7 +432,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err;
 
 	/* Create child platform device for the interconnect provider */
-	if (of_get_property(dev->of_node, "#interconnect-cells", NULL)) {
+	if (of_property_present(dev->of_node, "#interconnect-cells")) {
 		bus->icc_pdev = platform_device_register_data(
 						dev, "exynos-generic-icc",
 						PLATFORM_DEVID_AUTO, NULL, 0);
-- 
2.39.2

