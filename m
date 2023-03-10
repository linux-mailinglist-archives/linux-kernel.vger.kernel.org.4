Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACF6B46EC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjCJOrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjCJOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:22 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45F122090;
        Fri, 10 Mar 2023 06:47:03 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-176261d7f45so6033146fac.11;
        Fri, 10 Mar 2023 06:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGX0FXfNI3dLKikH/musE/uxQbEGTra0C5FWKvnCxVA=;
        b=eyJWdcLB2b//vfOxgUYoiPFVojXp42GbOz9urNsb6qRmd13fsEy/k9kuVtSaT0pp6m
         /cQ7rFjB5dE3YVpWBN551gjSA5CbLvB8k1tBsTdVkyZCWs2RmoM6kVgDtqdVPs+Uui4X
         6pLTV8WsULrPzkByfDbfI8ic+ZUnvsdvNWjxrg7n8mzKGpj6lzm3Dz5RGwte1n6P67dJ
         uO/9jZJV51daOO4RXN7k6S1+t69P3V9XevK+l1XKN1W8989iQJ6zPf1ryjRYmzAhbfE0
         bDwdjZKD8dtwNrwWkfBEdAVerYqi6emeR9Ld/vMg1rqwP03WTKqawaOPysIz0wPEDLlE
         xBhA==
X-Gm-Message-State: AO0yUKVKiY2DgYnPypg3OxGmArl7aa4XSt7u9R9waqOwdy5e1WuLp6NC
        Xcr24MFpt7Hz2yF6Musx0ibJkOShMA==
X-Google-Smtp-Source: AK7set9VN0RJ1wRIetkEXYIdaNM1jjaRix9csyPHcN3ptokbn4vVRTw8IIvPUBkv2JoCus5vftouqA==
X-Received: by 2002:a05:6870:6324:b0:16e:92d2:e810 with SMTP id s36-20020a056870632400b0016e92d2e810mr14171417oao.53.1678459618310;
        Fri, 10 Mar 2023 06:46:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h21-20020a4abb95000000b0051ff746e2b2sm7644oop.8.2023.03.10.06.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:46:57 -0800 (PST)
Received: (nullmailer pid 1540681 invoked by uid 1000);
        Fri, 10 Mar 2023 14:46:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: exynos: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:46:54 -0600
Message-Id: <20230310144655.1540655-1-robh@kernel.org>
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
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-exynos/suspend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 3bf14ca78b62..6d5d7696aaf7 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -667,7 +667,7 @@ void __init exynos_pm_init(void)
 		return;
 	}
 
-	if (WARN_ON(!of_find_property(np, "interrupt-controller", NULL))) {
+	if (WARN_ON(!of_property_read_bool(np, "interrupt-controller"))) {
 		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
 		of_node_put(np);
 		return;
-- 
2.39.2

