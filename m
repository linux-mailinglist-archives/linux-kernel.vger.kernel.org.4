Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B9672A24C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjFISc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjFIScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:32:25 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CBF3A81
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:32:13 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33b0cae115bso9025345ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335533; x=1688927533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlNAADpNJF/mKBUJMXBQL19JyS5QP2eSc/1ncOiaJgo=;
        b=V31akDlWsyjIT7xBpjF3AeacnnttBI1toyF5AH+hGg2zQc1FiWUUvETztskHLQYlVJ
         z+edPBSmzIGN5ntMoPRB15yKM8QPj95kbjddpOX+yBmuEV12Ap4QwBVV+7ZUk+1FTfx7
         iVmKhhg/NMKUe+IPiWG/BODYKakCVvGo01S75whu/T9w0Bm/kmuN2jUfhFFnaiZt3wUg
         eRXrLsAXkysVuhk0jhbwIl71yRQojIQoj5PYsCR+2KjCfLqe6XpF0ftSTBvOk8oKToFj
         rgpsAU07bAYZZcVj2eKBuImCzwqkOoQ5/BPc8r416EHtFEOz/gFK0OwbdCDKFq/doGRi
         bWvQ==
X-Gm-Message-State: AC+VfDw6MhwMF58OFd7dshiqkz7pkZL0ibJvznnQKgGzvsGDVCtCjx0a
        dQlE5oTl7Mivgz6qwlFKrLE0OwaSQA==
X-Google-Smtp-Source: ACHHUZ65nio3oOXF55j2/m6pG2gB5Au1As9k+nXqcSl6Ga7kabOjC/bC5dTKzky/kBa7DkVQ2HKChg==
X-Received: by 2002:a92:cc4a:0:b0:328:6412:df0e with SMTP id t10-20020a92cc4a000000b003286412df0emr2361677ilq.29.1686335533009;
        Fri, 09 Jun 2023 11:32:13 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n6-20020a02a906000000b0041407c67451sm1091090jam.165.2023.06.09.11.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:32:12 -0700 (PDT)
Received: (nullmailer pid 1766640 invoked by uid 1000);
        Fri, 09 Jun 2023 18:32:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: Use of_property_read_reg() to parse "reg"
Date:   Fri,  9 Jun 2023 12:31:59 -0600
Message-Id: <20230609183159.1766429-1-robh@kernel.org>
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
 drivers/mfd/mfd-core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 695d50b3bac6..0ed7c0d7784e 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -102,7 +102,6 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 {
 #if IS_ENABLED(CONFIG_OF)
 	struct mfd_of_node_entry *of_entry;
-	const __be32 *reg;
 	u64 of_node_addr;
 
 	/* Skip if OF node has previously been allocated to a device */
@@ -115,13 +114,10 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 		goto allocate_of_node;
 
 	/* We only care about each node's first defined address */
-	reg = of_get_address(np, 0, NULL, NULL);
-	if (!reg)
+	if (of_property_read_reg(np, 0, &of_node_addr, NULL))
 		/* OF node does not contatin a 'reg' property to match to */
 		return -EAGAIN;
 
-	of_node_addr = of_read_number(reg, of_n_addr_cells(np));
-
 	if (cell->of_reg != of_node_addr)
 		/* No match */
 		return -EAGAIN;
-- 
2.39.2

