Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3616067E2F3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjA0LSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjA0LSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8154C26A7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m7so4653020wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yih36DUTKHT+LMXkgGyjPXAz+nin4ZdW7iSqMcxFtIs=;
        b=upDdyxb4DH4gqlG6+VPCvhbg99cUFdjm0GnXZOFDAsU55BLLhSYaU7xREglvFV2tcK
         Jo/P26FJ2Y5sR7HvkXR++BofjroQdOUBhQe1YuK7Hb1NvEf02HY9z/+wBZEvaN2gPQHe
         15TrFUjX+iUaV7D8D2gt+99pDT6TZaxUdUvisMrwOcdl36PGf1jGw2lHapfNn+iumu/x
         mK4ume5XpvjnNX8e3ho7wQvluNOeyIRvsJZaUOJPq40LSVf6tasyqfaqbtlQfiaHKIQl
         3PRTYJVreWR+Jh241CPYkBXNFR96wsujXy+zivtgzt12jI38++LwWxBMUwHlaPX205dH
         B6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yih36DUTKHT+LMXkgGyjPXAz+nin4ZdW7iSqMcxFtIs=;
        b=icg/zKnRgiTLvdc0b2qUkhyqu/huQiHp24T5M5faiOnKrV41Xcv2COXw6L+wpJ2jZM
         2Kgfz08Z7a3NKusAuo3n6XwwPGWwi19W6B8QCcSAY/mqcf5Tu+joZqdJEx8l1JY4gWx6
         GV04GK4fhjIGb1HxN7OFIPGnir57T+Ub3/xCJs/UJ0b/d9/bLCzIM6N29XotRJK+2HcZ
         l+c4s5KB9WgI6mHIqm2WEUdkAnB431KOteSPuWG9iiIj2yWS87kYHR5yqwBOeUJ+aDSc
         LBAWknb+DGVAxu+ldOkMh4TDgtbVABSnHPf8qOUJrR2sZCKEBwzoKwU8A6UPAJZar58h
         FfvQ==
X-Gm-Message-State: AO0yUKUVmZTKENJA6wrXIlSpYbppgb+sli0dJ/DtxVScTQEOIm5A1jl6
        T+eysQxXzPh8n22BSHMuiuKPKw==
X-Google-Smtp-Source: AK7set/I6mFacH2U0lbwM1vADNwo0nUON6ImGQaiRjmvCphneev4pRCV8iDLOEccREHmdg3pFTco7w==
X-Received: by 2002:adf:ea08:0:b0:2bf:c403:c485 with SMTP id q8-20020adfea08000000b002bfc403c485mr5603510wrm.22.1674818275496;
        Fri, 27 Jan 2023 03:17:55 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/37] of: property: add #nvmem-cell-cells property
Date:   Fri, 27 Jan 2023 11:15:39 +0000
Message-Id: <20230127111605.25958-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Bindings describe the new '#nvmem-cell-cells' property. Now that the
arguments count property is optional, we just add this property to the
nvmem-cells.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 3043ca7735db..8d9ba20a8f90 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1307,7 +1307,7 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
 DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
 DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
-DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
+DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", "#nvmem-cell-cells")
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
 DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
-- 
2.25.1

