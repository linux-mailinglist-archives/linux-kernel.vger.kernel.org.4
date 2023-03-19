Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097526C0317
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCSQb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjCSQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:31:58 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACDB1DBBD;
        Sun, 19 Mar 2023 09:31:52 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id 4so5404847ilz.6;
        Sun, 19 Mar 2023 09:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EQSyzI7MgV/qlvM+G7O4ieYCis2QmU8ihYTAlTrHxY=;
        b=FuI1RKnkyYiSEwyzLUnhJC+2ZFOf/O/cFgO2iz0T+caS6hLiJiJOa4T4BIuWnwfD7B
         zG2mMreGBeOu/e3fHteFKUjXf7Tu8juy3F27qalz0ykwFJRNxWvFE1VdPuS+kb85v5ra
         ly8gE4M122ufASyY5PM6dg1ENWhGIkT5/gu89dCYOdzt8uh1QaIOHMgF5n796rJ2SEO6
         xMishxQb0aYfWHq5o4spSenrI8iT5MRuNQb7lA3HbQCCPICuZJHXvi3pfLMm1XZm2Vxi
         pYAi3ICVu9rJPbnKmnLK11AwTbz4M1r3XppPNIpx+oHV0t74RSugEPzp70PjClaUL7vr
         aAtw==
X-Gm-Message-State: AO0yUKWHFxs5eYIDl8WjjdResK1ry32Xu8UoKn8b3gIUYbd45pRsxZZW
        +exSYOKStHgAI0TcSIPLXw==
X-Google-Smtp-Source: AK7set/+yuOD3dKYXirTdLdiJjU8SCoUSacR/p2E9DZyzb5uV3QIZUpRLRHEtHvv+Jmu6PjInoUWeQ==
X-Received: by 2002:a92:d944:0:b0:324:5861:afd8 with SMTP id l4-20020a92d944000000b003245861afd8mr3623634ilq.11.1679243511083;
        Sun, 19 Mar 2023 09:31:51 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id w188-20020a025dc5000000b003a951542b10sm2527702jaa.60.2023.03.19.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:31:50 -0700 (PDT)
Received: (nullmailer pid 225400 invoked by uid 1000);
        Sun, 19 Mar 2023 16:31:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: EXYNOS: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:31:44 -0500
Message-Id: <20230319163145.225323-1-robh@kernel.org>
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

Replace of_get_address() and of_translate_address() with single call
to of_address_to_resource(). With this, use ioremap() instead of
of_iomap() which would parse "reg" a second time.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-exynos/exynos.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 51a247ca4da8..966a0995e047 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -50,11 +50,13 @@ void __init exynos_sysram_init(void)
 	struct device_node *node;
 
 	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram") {
+		struct resource res;
 		if (!of_device_is_available(node))
 			continue;
-		sysram_base_addr = of_iomap(node, 0);
-		sysram_base_phys = of_translate_address(node,
-					   of_get_address(node, 0, NULL, NULL));
+
+		of_address_to_resource(node, 0, &res);
+		sysram_base_addr = ioremap(res.start, resource_size(&res));
+		sysram_base_phys = res.start;
 		of_node_put(node);
 		break;
 	}
-- 
2.39.2

