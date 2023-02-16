Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D9A699FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBPWca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBPWcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:32:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F748E1B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:32:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r25so236732wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvzIXeBwNjkQ9IcRgD+ojwStnjrbesfxRf+gfVkqoyc=;
        b=VYSoiJSayRXtEYIfR8Hy8SoP+yEE+4aPstU32fxzv5Uv2KYLidAt0mnkgq9qRjhFQH
         N+qYUmdwHlx+cytXSNZOXd+1lhJMUx/5geurMPuUXks4mg2wVSntprJhdqMe/AQhge68
         I3EImvVp+OZO5QFx0cMQuV7OSMZs2EkxYRJNNJJu9WSIc9Dtve/SCyEQN0vScAJ13EPV
         LVQ/8Vcnwvu2PrK5N6twcb83zE14eUX9LKpqtwEOoRYLozYJ05+Xu3UvogLMhy/k4cNu
         VILMMrlcZcnM321b/XzFiShTZlteeHKs0K/4Gve3/xwlAWNt6CwfJDDCkZt18GQTJ8/C
         kbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvzIXeBwNjkQ9IcRgD+ojwStnjrbesfxRf+gfVkqoyc=;
        b=0alU1GKdhZEDN/ELnPG2drz90GWWy34jkxw/jejYfzSzY5iFjBrafIrZnyfiRcqGvr
         +/V9EGNke25V8I64DJE8aHurXlNeB6YduWojXIFenGy7Yl3QJOu4F2TaVoCoAr+WWibi
         f1MJ88ylMD3VkaDjH9oZ6nJWEEgkkuAGfgR+VqEhFpCxPtW33fSfukAuf2qiga5x25FK
         9yLtWGeEVVMzboEuTH3nz2wOYqm5hIyxM7DB9Hdl5sQT6e1kBrxS1NZvFe1P+SSxAU7P
         dm4FckgvrYRTlOyB98n+YG3udVSEYWxGPNHssi1cXmFoNX6EMI6AH4hlbJ5AfZZfbl0r
         xTVA==
X-Gm-Message-State: AO0yUKVUNrOSZrVdn9uGsGvmLTAJXjbUkNnCBFLluLfh7c6HUN+Oxz9Z
        aN/RCAAnU57UeuSrjltPIXsvyiMhrzI=
X-Google-Smtp-Source: AK7set+8GpM/xtLJJsy45Hj1kOPwmVjLmBdpqgGvVT1AXuMCqwPH21RI0FAMt22XnwTlnSDYkizX0A==
X-Received: by 2002:a5d:5502:0:b0:2c3:db4f:f336 with SMTP id b2-20020a5d5502000000b002c3db4ff336mr5456407wrv.39.1676586731996;
        Thu, 16 Feb 2023 14:32:11 -0800 (PST)
Received: from localhost (94.197.187.145.threembb.co.uk. [94.197.187.145])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d4288000000b002c559843748sm2600774wrq.10.2023.02.16.14.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:32:11 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] regmap-irq: Remove unused mask_invert flag
Date:   Thu, 16 Feb 2023 22:32:00 +0000
Message-Id: <20230216223200.150679-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230216223200.150679-1-aidanmacdonald.0x0@gmail.com>
References: <20230216223200.150679-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mask_invert is deprecated and no longer used; it can now be removed.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 14 --------------
 include/linux/regmap.h           |  4 ----
 2 files changed, 18 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index e3092f522107..8c903b8c9714 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -878,20 +878,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		 */
 		dev_warn(map->dev, "mask_base and unmask_base are inverted, please fix it");
 
-		/* Might as well warn about mask_invert while we're at it... */
-		if (chip->mask_invert)
-			dev_warn(map->dev, "mask_invert=true ignored");
-
-		d->mask_base = chip->unmask_base;
-		d->unmask_base = chip->mask_base;
-	} else if (chip->mask_invert) {
-		/*
-		 * Swap the roles of mask_base and unmask_base if the bits are
-		 * inverted. This is deprecated, drivers should use unmask_base
-		 * directly.
-		 */
-		dev_warn(map->dev, "mask_invert=true is deprecated; please switch to unmask_base");
-
 		d->mask_base = chip->unmask_base;
 		d->unmask_base = chip->mask_base;
 	} else {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 2114679729ce..4b9ec1eb5235 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1532,9 +1532,6 @@ struct regmap_irq_chip_data;
  * @config_base: Base address for IRQ type config regs. If null unsupported.
  * @irq_reg_stride:  Stride to use for chips where registers are not contiguous.
  * @init_ack_masked: Ack all masked interrupts once during initalization.
- * @mask_invert: Inverted mask register: cleared bits are masked out.
- *		 Deprecated; prefer describing an inverted mask register as
- *		 an unmask register.
  * @mask_unmask_non_inverted: Controls mask bit inversion for chips that set
  *	both @mask_base and @unmask_base. If false, mask and unmask bits are
  *	inverted (which is deprecated behavior); if true, bits will not be
@@ -1616,7 +1613,6 @@ struct regmap_irq_chip {
 	const unsigned int *config_base;
 	unsigned int irq_reg_stride;
 	unsigned int init_ack_masked:1;
-	unsigned int mask_invert:1;
 	unsigned int mask_unmask_non_inverted:1;
 	unsigned int use_ack:1;
 	unsigned int ack_invert:1;
-- 
2.39.2

