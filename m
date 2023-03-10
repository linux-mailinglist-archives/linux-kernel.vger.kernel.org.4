Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F16B478F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjCJOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjCJOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:51:06 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6753E3A85C;
        Fri, 10 Mar 2023 06:48:18 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-17638494edbso6035572fac.10;
        Fri, 10 Mar 2023 06:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jcxqo0ngoDPG8sfx3l2EfDlYPoRMEx1f3UACnu8WIP0=;
        b=0lqaUpwXPDQ/UH/1ch27rldKG9EYMJuIBC7iQqdQDKCxMD33ngW/nSQLnfg491bMEj
         dPbZSbw2HJ9+1WlD6fsvp/FCOCYgcqejWu9aZtIMInBpKAztGN7dy7ayewwApNMMzQB0
         XDQ7JYbSEbP3iub8/JrhBU+pHx5mKW6SWoIJorQ4MpUkEJFF7Al/MtlQWL2sWRqw/rXf
         VuqziBveaBbxyQEArefABMTCMi1Ap6NzD7OhTG6epjaRhvHIrNAIV/XTLEVmWJ8mDn6H
         5hrUV2NSPqowIPnhncYxhF382XnhCf0pPY9CNDAytdAeEqUZ156z2WdD0B/jF4X40k+u
         U8fw==
X-Gm-Message-State: AO0yUKUSfGCigVrzN9Y8kWh2Rotuyni+aoBr7JRjQ4D2ae38yrLT6x0K
        ZoFEi+aJqEv39+2ENfZPHtUBlBlSxg==
X-Google-Smtp-Source: AK7set+/NJfKhDjq/US9Zgnj2vnj5ULRkdXtv1anFiXdX/PaEZpHr9aZmeUXkDHFpmVGgwO/W+nGBw==
X-Received: by 2002:a05:6870:20e:b0:172:3a2f:c5ec with SMTP id j14-20020a056870020e00b001723a2fc5ecmr15852389oad.2.1678459698281;
        Fri, 10 Mar 2023 06:48:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zq48-20020a0568718eb000b00172473f9fe0sm118665oab.13.2023.03.10.06.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:17 -0800 (PST)
Received: (nullmailer pid 1545259 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: sunxi: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:24 -0600
Message-Id: <20230310144724.1545223-1-robh@kernel.org>
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
 drivers/soc/sunxi/sunxi_mbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/sunxi/sunxi_mbus.c b/drivers/soc/sunxi/sunxi_mbus.c
index d90e4a264b6f..1734da357ca2 100644
--- a/drivers/soc/sunxi/sunxi_mbus.c
+++ b/drivers/soc/sunxi/sunxi_mbus.c
@@ -82,7 +82,7 @@ static int sunxi_mbus_notifier(struct notifier_block *nb,
 	 * Older DTs or SoCs who are not clearly understood need to set
 	 * that DMA offset though.
 	 */
-	if (of_find_property(dev->of_node, "interconnects", NULL))
+	if (of_property_present(dev->of_node, "interconnects"))
 		return NOTIFY_DONE;
 
 	ret = dma_direct_set_offset(dev, PHYS_OFFSET, 0, SZ_4G);
-- 
2.39.2

