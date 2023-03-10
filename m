Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1656B4768
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjCJOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjCJOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:48:20 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F2A10A12D;
        Fri, 10 Mar 2023 06:47:33 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-176d1a112bfso6058966fac.5;
        Fri, 10 Mar 2023 06:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2lTtjWUMnJBmccOD7sA1r/lC9FUen1jFS0i++9lx7Q=;
        b=UkIKxn4M53jXCHs42yJQx2FU1sA+NF1K9WoA9fbF2wYFsXubnlNZzWUoumlDGIOw7R
         ahhr2zXE+KuCxAoOxN2+GIwbSdcoWwO8Uhldk4hERbAlv+HoxQKgwK9Ca18uTJ2ZOZjJ
         iNGcCV9+tgQGlNT2vrRZwi0dxKPy0SdyB5iFbystR7eJBU9QAyQYErHCBqL3jQLDUEZb
         xoXS595knYz2UqkDoaQ5AitqixLE24e02IDJzJ4lbRM0KCRmvfWP5LqD8E9MJd5g5XmS
         70a4VvDoOrVLPIhdf/XsS4fMDRN/LiN6UrZ1pRQ6SpDQSe/RFWMYnTSrdthfnafvadjt
         XJAQ==
X-Gm-Message-State: AO0yUKWB8zqkaLUthpaLDO/0vuOvwZnNN0eY4fz5/VkLawlr+AdrQ3fk
        XtuWkaH3tniPVHIeLkdUCQ==
X-Google-Smtp-Source: AK7set8QdGWW9Ap+0QPRi0nLe9hGsHW1DfpJIT8al6u/OSLp22lw3dj34v105XOmPR2CdhO8nZ8RnA==
X-Received: by 2002:a05:6870:819d:b0:172:21e9:21c7 with SMTP id k29-20020a056870819d00b0017221e921c7mr16014357oae.40.1678459652873;
        Fri, 10 Mar 2023 06:47:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z13-20020a056870e14d00b00172721f6cd5sm114767oaa.16.2023.03.10.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:32 -0800 (PST)
Received: (nullmailer pid 1542798 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] Input: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:08 -0600
Message-Id: <20230310144708.1542751-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/input/keyboard/matrix_keypad.c  | 6 ++----
 drivers/input/keyboard/omap4-keypad.c   | 3 +--
 drivers/input/keyboard/samsung-keypad.c | 3 +--
 drivers/input/keyboard/tegra-kbc.c      | 3 +--
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 203310727d88..a1b037891af2 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -425,14 +425,12 @@ matrix_keypad_parse_dt(struct device *dev)
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (of_get_property(np, "linux,no-autorepeat", NULL))
-		pdata->no_autorepeat = true;
+	pdata->no_autorepeat = of_property_read_bool(np, "linux,no-autorepeat");
 
 	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
 			of_property_read_bool(np, "linux,wakeup"); /* legacy */
 
-	if (of_get_property(np, "gpio-activelow", NULL))
-		pdata->active_low = true;
+	pdata->active_low = of_property_read_bool(np, "gpio-activelow");
 
 	pdata->drive_inactive_cols =
 		of_property_read_bool(np, "drive-inactive-cols");
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 4426120398b0..9f085d5679db 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -274,8 +274,7 @@ static int omap4_keypad_parse_dt(struct device *dev,
 	if (err)
 		return err;
 
-	if (of_get_property(np, "linux,input-no-autorepeat", NULL))
-		keypad_data->no_autorepeat = true;
+	keypad_data->no_autorepeat = of_property_read_bool(np, "linux,input-no-autorepeat");
 
 	return 0;
 }
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 09e883ea1352..d85dd2489293 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -291,8 +291,7 @@ samsung_keypad_parse_dt(struct device *dev)
 		*keymap++ = KEY(row, col, key_code);
 	}
 
-	if (of_get_property(np, "linux,input-no-autorepeat", NULL))
-		pdata->no_autorepeat = true;
+	pdata->no_autorepeat = of_property_read_bool(np, "linux,input-no-autorepeat");
 
 	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
 			/* legacy name */
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index da4019cf0c83..d5a6c7d8eb25 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -504,8 +504,7 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
 	if (!of_property_read_u32(np, "nvidia,repeat-delay-ms", &prop))
 		kbc->repeat_cnt = prop;
 
-	if (of_find_property(np, "nvidia,needs-ghost-filter", NULL))
-		kbc->use_ghost_filter = true;
+	kbc->use_ghost_filter = of_property_present(np, "nvidia,needs-ghost-filter");
 
 	if (of_property_read_bool(np, "wakeup-source") ||
 	    of_property_read_bool(np, "nvidia,wakeup-source")) /* legacy */
-- 
2.39.2

