Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AB56387B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKYKlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKYKlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:41:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476063AC07
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:41:15 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id x5so6145713wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppMSaTEj4JL58q2duGJ/6acd9q7ZP86JJkM9tAtSfh0=;
        b=MYDCkD4ZKosaTKM+1ztRC5mZZvCt0jkr5wf0nCrOVjuvqg4ovtP/UKzDKPTzjqrgIu
         0I6ZvI7nHR58nDG6OdvUS9XZdTr8MUh47wFeQ+btM0c09UBCip71sRMow1wFbS3GFvSn
         FXsIg0n5KjU001zbq5Kr3aIMKHqzXXER1H967AJqS091zPfCDO41U1dzjcagNI8l3c4S
         CDS49lbzwf2MkIK+4pKElJlPwfF9JIIEJwQ/Nc+lAEkjHduFpDT0L6tVoTAAQGIxzK/y
         DW6VJqU1PNFrCj1xEinoGR7IBvL0kHiSULoDnU1Sebo1MzhjTjtsd+BUjwvDUxDdHDW4
         sBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppMSaTEj4JL58q2duGJ/6acd9q7ZP86JJkM9tAtSfh0=;
        b=eiaQftZofzgFt0XuPX+KjB480n/UqE/Eg5nU4CrMW3HWqqCTp2D/9oI71QNXdRPm2S
         rahzLTRaUcIlptbC9nJyT6No85tBD1gOfB8qcl43iJ6jZCCsQksARwIG9BlWt6vU1Qwf
         m/FB/u6bxWc5v83GsJbw4pHLowRlaAnhVJjT3i5Y4uO9JKETuArc3gEbA8TFhHMHXMNY
         AfaXxj4e2yBT3Xq8B5KKH6PeiTp6FLjP3H5rWov+IHxNKAPhq1BgPhnwZdGEVT7oOLre
         FaL90XHAl5zA9iVyq9Y6U+941MIO73KvdG72Oe3KYtBnyWU5znT46AXhJsULZgQDjdW9
         ZyHg==
X-Gm-Message-State: ANoB5pmZGXT9BnChbNfMrzKBFKULsN9XmQJvRAi5dDFTMqaBkJqNmgag
        Sc8lDb+3k588Dn2PcHka+Wk6kg==
X-Google-Smtp-Source: AA0mqf7NsPtcSryNW/VkDRJPbLE9ZBSRTkp41ZEr6j8k7tYEXijdlwfhFoMvjr3i3jHW019YC7kLZA==
X-Received: by 2002:a5d:69c4:0:b0:236:c206:b2b1 with SMTP id s4-20020a5d69c4000000b00236c206b2b1mr11995097wrw.624.1669372873824;
        Fri, 25 Nov 2022 02:41:13 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:fdd9:1fe6:bff6:fb20])
        by smtp.gmail.com with ESMTPSA id w5-20020adfde85000000b00241cbb7f15csm3366974wrl.106.2022.11.25.02.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 02:41:13 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v2] arm64: arch_k3: Replace select with imply for TI mailbox and TI SCI
Date:   Fri, 25 Nov 2022 11:41:06 +0100
Message-Id: <20221125104106.488118-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to build TI mailbox and TI SCI as modules, replace
select with imply.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
v1->v2:
Use imply instead of removing select altogether and dropped
patches 2/3 and 3/3 from previous series as using imply makes
them redundant.

 arch/arm64/Kconfig.platforms | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 912529ac58b38..288935638c7ad 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -126,8 +126,8 @@ config ARCH_K3
 	select PM_GENERIC_DOMAINS if PM
 	select MAILBOX
 	select SOC_TI
-	select TI_MESSAGE_MANAGER
-	select TI_SCI_PROTOCOL
+	imply TI_MESSAGE_MANAGER
+	imply TI_SCI_PROTOCOL
 	select TI_SCI_INTR_IRQCHIP
 	select TI_SCI_INTA_IRQCHIP
 	help
-- 
2.25.1

