Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90883698789
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBOVzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBOVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:55:09 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9901252B2;
        Wed, 15 Feb 2023 13:55:08 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-169ba826189so454281fac.2;
        Wed, 15 Feb 2023 13:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mtXNvEp83b2ZUicdPVTw8RsVdCkCykFAdFcuP5Rz1c=;
        b=AF4b6ZxEcDl4ydPUlWtDT7GwqpwjCVkDPl8e+dpOFbOt2dqWsWWipjrzJWVak9pfTQ
         R9O1isV6iejSC4cfC63u61ku6U1Jn4TxU7MGuXtMrGLcwSMW3bkOUECyiA5LBZ84pYgy
         lgz77g/nnk9AWwVM7LXoSpi8BDiqo7U7Dc5umAH3QTF0qPphupIWgaITmuTnSPtJfgBk
         rPCQ2X97t0ALGyaakPUWim9ankQUdyedH+O3u/lT4HH66WsSXCnF57HS+71PHdUPQD5z
         F7wQHzRnycSuaOEWLGEmahkjh2fcxJzgQmlpJ+vcobbhBChDXAonS+YlmHJ+L7WvMLjm
         EvYA==
X-Gm-Message-State: AO0yUKU1aHY3mENXvEHTLzD2Bjrk56Ts7DBA0zhsU2GmB6Qd7edH95+0
        0IQxDqzatCLimmswyaIMtfwpxZEzaA==
X-Google-Smtp-Source: AK7set8vtUqCcHDF3nfG17b3fs4oaqIKxgTPCK8WopWdnmnQ0UjQTn6bxClabvQEYW/h07ETINUH7Q==
X-Received: by 2002:a05:6870:56ab:b0:16d:ed64:8026 with SMTP id p43-20020a05687056ab00b0016ded648026mr2179227oao.38.1676498108066;
        Wed, 15 Feb 2023 13:55:08 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 26-20020a056870111a00b0016a37572d17sm1201256oaf.2.2023.02.15.13.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:55:07 -0800 (PST)
Received: (nullmailer pid 690829 invoked by uid 1000);
        Wed, 15 Feb 2023 21:55:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: Use preferred of_property_read_* functions
Date:   Wed, 15 Feb 2023 15:55:02 -0600
Message-Id: <20230215215502.690716-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace instances of of_get_property/of_find_property() with appropriate
typed of_property_read_*() functions.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/platform.c | 4 +---
 drivers/of/property.c | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 284379e67649..472e1706983d 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -250,9 +250,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		of_device_make_bus_id(&dev->dev);
 
 	/* Allow the HW Peripheral ID to be overridden */
-	prop = of_get_property(node, "arm,primecell-periphid", NULL);
-	if (prop)
-		dev->periphid = of_read_ulong(prop, 1);
+	of_property_read_u32(node, "arm,primecell-periphid", &dev->periphid);
 
 	ret = of_address_to_resource(node, 0, &dev->res);
 	if (ret) {
diff --git a/drivers/of/property.c b/drivers/of/property.c
index ff71d2ac26cb..a229536f7564 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1358,7 +1358,7 @@ static struct device_node *parse_gpio_compat(struct device_node *np,
 	 * Ignore node with gpio-hog property since its gpios are all provided
 	 * by its parent.
 	 */
-	if (of_find_property(np, "gpio-hog", NULL))
+	if (of_property_read_bool(np, "gpio-hog"))
 		return NULL;
 
 	if (of_parse_phandle_with_args(np, prop_name, "#gpio-cells", index,
-- 
2.39.1

