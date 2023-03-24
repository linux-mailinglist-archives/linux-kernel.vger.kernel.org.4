Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794026C82A5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjCXQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCXQwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:52:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D595A20A04
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:52:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id dw14so1652285pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679676762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yryH7vC/nq+vPaNPZHPoVGq5Z2O/K90ppTi/YYO51JY=;
        b=kIIIpztVKyE5TXz0P71w7WJI5CmZz5r8zbxD43sBhuip0MZ7zB23xN35SkJY+xhzXO
         eyRs/LSQ6MknuWfh1pjW8hABr6NQjdoz3VZd0EDX5xJvzhaBFpK0cCFxbguwNKZmjTXa
         ju50zmTka9Y8mBIIS9sylBwGlI1aGTmctFZOPDoKg2Dq+/ZaiyRyRKR8MrkCbcmRry7L
         y/jjP9f2wRNbFoDD+JG+2avvTMjWpFKaoPi/1y6n/PqBsZcWNHoypqbySXVuMkh1iCbP
         8RDdgVo9+yhglsNlqubZpyBJmvxMymK2kR2hhCb+eW9dGJt+IiSkoeHfV2MjA9Mc33Tn
         6hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679676762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yryH7vC/nq+vPaNPZHPoVGq5Z2O/K90ppTi/YYO51JY=;
        b=Zwmo2+DX7Ym979bb6Jioc94fkyivIoDPnrdAvK3MpOtlSrzbvCBuD3rvRwR6U6Fgbp
         fexRGTJDcNLhViT1D+XIAHUcG2PJCDIh3iEj6YnJ0Foy+nLgPFK+/sLdpVdmJUl4AXv8
         Qw+8g+HWFlJaB8Q6UhQPKPyXVrNKgz/EEdDH8XCsTiMt7jiAmBhkL8d8m4dpPx2RB739
         Eub3/r5R2IlkKN3OZWuLJX/APgrr45xU53M3ayj4UXoZYNVjAXcN5djyIJ7s4qm/xl8/
         +VBWmQ2k+naM/GIBKGi+FUPPDX/8GtlsFv5r7KGr5U22gnewMv1Zy7zsPzWjq07kLkYG
         dh9g==
X-Gm-Message-State: AAQBX9d+KsPzcZGCHoV7cXHx+WdyjGOOWrCTgBzgojxk1DsbQnDhvSQg
        rjKLzV6IavFu6gwEctP0lgWG4JGqBVY=
X-Google-Smtp-Source: AKy350bdZI8qo/VNmxwZDUUT/YjFtDI61i5AdeQRwC50Zb+62VzNZq14Bqjo2Oh6M2OMpgyRifbKFA==
X-Received: by 2002:a62:5254:0:b0:626:286d:b701 with SMTP id g81-20020a625254000000b00626286db701mr3768348pfb.20.1679676761902;
        Fri, 24 Mar 2023 09:52:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020aa780c5000000b0062b5a55835dsm1420289pfn.213.2023.03.24.09.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 09:52:40 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 1/3] memory: brcmstb_memc: Cache configuration register value
Date:   Fri, 24 Mar 2023 09:52:29 -0700
Message-Id: <20230324165231.3468069-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324165231.3468069-1-f.fainelli@gmail.com>
References: <20230324165231.3468069-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The configuration register does not change once the DDR controller is
configured, in preparation for providing more information about the DDR
type/width in subsequent changes, store this value so we can retrieve
it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/memory/brcmstb_memc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/brcmstb_memc.c b/drivers/memory/brcmstb_memc.c
index 233a53f5bce1..67c75e21c95e 100644
--- a/drivers/memory/brcmstb_memc.c
+++ b/drivers/memory/brcmstb_memc.c
@@ -29,18 +29,15 @@ struct brcmstb_memc {
 	struct device *dev;
 	void __iomem *ddr_ctrl;
 	unsigned int timeout_cycles;
+	u32 config_reg;
 	u32 frequency;
 	u32 srpd_offset;
 };
 
 static int brcmstb_memc_uses_lpddr4(struct brcmstb_memc *memc)
 {
-	void __iomem *config = memc->ddr_ctrl + REG_MEMC_CNTRLR_CONFIG;
-	u32 reg;
-
-	reg = readl_relaxed(config) & CNTRLR_CONFIG_MASK;
-
-	return reg == CNTRLR_CONFIG_LPDDR4_SHIFT;
+	return (memc->config_reg & CNTRLR_CONFIG_MASK) ==
+		CNTRLR_CONFIG_LPDDR4_SHIFT;
 }
 
 static int brcmstb_memc_srpd_config(struct brcmstb_memc *memc,
@@ -148,6 +145,9 @@ static int brcmstb_memc_probe(struct platform_device *pdev)
 	of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 			     &memc->frequency);
 
+	memc->config_reg = readl_relaxed(memc->ddr_ctrl +
+					 REG_MEMC_CNTRLR_CONFIG);
+
 	ret = sysfs_create_group(&dev->kobj, &dev_attr_group);
 	if (ret)
 		return ret;
-- 
2.34.1

