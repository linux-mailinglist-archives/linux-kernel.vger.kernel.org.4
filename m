Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A186B4765
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjCJOuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjCJOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:48:39 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1BD11CBC9;
        Fri, 10 Mar 2023 06:47:37 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-176261d7f45so6035211fac.11;
        Fri, 10 Mar 2023 06:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFM9cFx4I6hD+gj1NVqX4d9hN+nz0rkv2y+gyZLkCvI=;
        b=2Q/ndR0GQm840Esuesq/tw09WxIgoIwO0lzAqRFTZI22Yh8+EFJ1DxOAz6T96wvdbP
         yw7g6Q1WprdBWEAMXQ8d/uEtgEcmHkMU/bhs2CPKTK1kng6RDWs1R1BgeurxGoB4mw5r
         Yzgj6M7qgBRDC7mJozUfTOHB+I5tZ4Zgk8hWia3qYFIs1hFvGUoWVbCfutCtNWkjb24f
         kTKigS4cx+hX4N9bph2Pu0w7vEtE5e93F80fcWpYKoPbnkkeQSuHyD4p0MAKQchlX/Du
         9OuICpMIqyGgqmRH7xC6e0mG2WwB8o8m9q+wceAXNBbpFf1qcAVXKqMEGTcdg0UrxU78
         JBqg==
X-Gm-Message-State: AO0yUKXhHq3QgDz1W0Nx6GZsMkYNTXGIijtOmfWIFeZWJXChYJH5NYmx
        TUDNDeoP2vSffGq7/RfqJrN10iLUwg==
X-Google-Smtp-Source: AK7set/2FSvj4FPCfH+6aDY+mlr2dudvIcv7JOTdVH9knG2sD05y2JX0UW87aup/8BnR7YzAa+Iu+Q==
X-Received: by 2002:a05:6870:c0d5:b0:172:8999:27fb with SMTP id e21-20020a056870c0d500b00172899927fbmr5812691oad.10.1678459656528;
        Fri, 10 Mar 2023 06:47:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t33-20020a4a96e4000000b00525ccc4caadsm11366ooi.4.2023.03.10.06.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:35 -0800 (PST)
Received: (nullmailer pid 1543182 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:10 -0600
Message-Id: <20230310144710.1543139-1-robh@kernel.org>
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
 drivers/mailbox/hi6220-mailbox.c | 5 +----
 drivers/mailbox/omap-mailbox.c   | 3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
index fca61f5312d9..1c73c63598f5 100644
--- a/drivers/mailbox/hi6220-mailbox.c
+++ b/drivers/mailbox/hi6220-mailbox.c
@@ -325,10 +325,7 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
 	writel(~0x0, ACK_INT_CLR_REG(mbox->ipc));
 
 	/* use interrupt for tx's ack */
-	if (of_find_property(node, "hi6220,mbox-tx-noirq", NULL))
-		mbox->tx_irq_mode = false;
-	else
-		mbox->tx_irq_mode = true;
+	mbox->tx_irq_mode = !of_property_read_bool(node, "hi6220,mbox-tx-noirq");
 
 	if (mbox->tx_irq_mode)
 		mbox->controller.txdone_irq = true;
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 098c82d87137..fd28ac2120df 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -763,8 +763,7 @@ static int omap_mbox_probe(struct platform_device *pdev)
 
 		finfo->name = child->name;
 
-		if (of_find_property(child, "ti,mbox-send-noirq", NULL))
-			finfo->send_no_irq = true;
+		finfo->send_no_irq = of_property_read_bool(child, "ti,mbox-send-noirq");
 
 		if (finfo->tx_id >= num_fifos || finfo->rx_id >= num_fifos ||
 		    finfo->tx_usr >= num_users || finfo->rx_usr >= num_users)
-- 
2.39.2

