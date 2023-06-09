Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01D872A23C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjFISbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjFISbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:31:13 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FDA35BE;
        Fri,  9 Jun 2023 11:31:11 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-33e585a0ca6so8761865ab.3;
        Fri, 09 Jun 2023 11:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335471; x=1688927471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDLRPgV5z509cyU5ssYH2N/H4F3/FnPUGl76en455c0=;
        b=EmbGOi/GbLCiGxvtFEK8zQGQ5eAvoIKgXr/+hwaYX1lwyM756lQwSFavMCCMml7VTZ
         vMYVSWDbSsPRuXB/Z1/tDaYJI1L1f2Ef0Tz34Du7z0ss0MLvbH5Ev6ruoUkveHWh/hUS
         HDqYgHA5w2gNX4P1uXIIvqbEi9wCh4Fqy6ZvUQwsNmCjbHSlkbFTMRmBEyUVlmVBz4Vu
         p0xqMOOxBY1CLkH9RmFMWNq/TMZPDj5WNz3ncyjxRxkTgrd++kk/yRUCul5kgDtPs340
         S9Pz6jWRP7RjjRZbAiQKVlZ5cc9SB8ZtvHEOouKDGgIm/A9ehQo8EYcr49tHHoy9D+AQ
         Jtxg==
X-Gm-Message-State: AC+VfDyUPzdb+Yetu43OFq93/bX7+djMEfIWizcox33QJeWrpG1cWhx9
        f4JeDZHu5NrsueIJzq3uIia6wLfGbw==
X-Google-Smtp-Source: ACHHUZ6gs4iUOyrEkbjPXB9yem88PDea/e9/9fQbcxT07lu5mhWFHuK2Ix5E1FnOI4GSSTpjw2qFtw==
X-Received: by 2002:a92:c852:0:b0:33b:1da8:a7d0 with SMTP id b18-20020a92c852000000b0033b1da8a7d0mr2326661ilq.29.1686335470707;
        Fri, 09 Jun 2023 11:31:10 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k1-20020a92c9c1000000b0033c01c407fbsm1239903ilq.31.2023.06.09.11.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:31:09 -0700 (PDT)
Received: (nullmailer pid 1765467 invoked by uid 1000);
        Fri, 09 Jun 2023 18:31:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: n2: Use of_property_read_reg() to parse "reg"
Date:   Fri,  9 Jun 2023 12:31:05 -0600
Message-Id: <20230609183105.1765368-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the recently added of_property_read_reg() helper to get the
untranslated "reg" address value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/crypto/n2_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 20d0dcd50344..4f6ca229ee5e 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/cpumask.h>
 #include <linux/slab.h>
@@ -1795,11 +1796,9 @@ static int grab_mdesc_irq_props(struct mdesc_handle *mdesc,
 				struct spu_mdesc_info *ip,
 				const char *node_name)
 {
-	const unsigned int *reg;
-	u64 node;
+	u64 node, reg;
 
-	reg = of_get_property(dev->dev.of_node, "reg", NULL);
-	if (!reg)
+	if (of_property_read_reg(dev->dev.of_node, 0, &reg, NULL) < 0)
 		return -ENODEV;
 
 	mdesc_for_each_node_by_name(mdesc, node, "virtual-device") {
@@ -1810,7 +1809,7 @@ static int grab_mdesc_irq_props(struct mdesc_handle *mdesc,
 		if (!name || strcmp(name, node_name))
 			continue;
 		chdl = mdesc_get_property(mdesc, node, "cfg-handle", NULL);
-		if (!chdl || (*chdl != *reg))
+		if (!chdl || (*chdl != reg))
 			continue;
 		ip->cfg_handle = *chdl;
 		return get_irq_props(mdesc, node, ip);
-- 
2.39.2

