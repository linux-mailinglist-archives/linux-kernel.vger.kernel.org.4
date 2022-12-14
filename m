Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6164364C1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 02:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiLNBi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 20:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiLNBi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 20:38:26 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A29A1B1C4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 17:38:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p24so1833763plw.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 17:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+X+IlnDqYuFPQTAvWtr2QazQA6Soh/VIDkNFnd7BDc=;
        b=eFgVwWxRnFPSv+O1XkeQ4RrcC1gUB9yJwdiEj/nYAmAbztlHeE3RDrgYcFF59+uSEm
         eT9Uw3XGt6Xz/eanAEkbYsny/stwxcG/O+FV0HUri7P/cscnxNgWAtLZZj2DXTy374a+
         UwM8xWJbTDDWGVEcrSOtHAPcNIJXDN9nplMshnZ1cbuEHUilJNi4tDIdy6YvJMqxzLol
         md6FVrgmv9JhtfiGf/VPtVjTCfg6bnLg6+4W1sj5CJzjPef3JkDBl9c9gcQCeJ3yK+Sm
         qm6RWp+AqUgFKGoSin4rAuP3o2UzWrwsiL7VTjP/NGYLu1qRMxExH1kTgoUQ8k4o6jCB
         u8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+X+IlnDqYuFPQTAvWtr2QazQA6Soh/VIDkNFnd7BDc=;
        b=LWxJQoVOYtSjdCwEg2QjmCDsa0kk9To6EnoNTRQVNfhXN6DqDNLDlW59/Y3neW5sHx
         NgMAYh08c+L0lCD8JGLfj+XqnlZ1+JHmS0LzsKhU++tx4q9tA1qyf9+HC2sgvQMu0ZuO
         FMUFohOWGnSrM4Zrd6zJqdi37H+dkkE+zhtUa6jsaM3D2zShTRu+fzJs1pP26bgmrknL
         lxwieSJXMcEiRGp1QbOA7LbhBVJBzy5+MBaGMw1Je3LbO6/01BI12lMZDlXnhxQA1Xwi
         EvFHha17fZCwzvsi99SmsZE15T0pkAHSZt9JQCFe4B/aTBpKi5XXmb13A6YEqV1lWIfB
         hqZA==
X-Gm-Message-State: ANoB5pmSP6jhXWTNd/XrSIBsyeVxl602DWgUOoymIzxFDAH3Hfzu/Aqp
        23ml/1pfYA4EQ8U5FlXChyViUgb54rI=
X-Google-Smtp-Source: AA0mqf4UEsAM9v1lIylewMhtwxoNlUndWQGkxqGJ2m5kVKLY0V63D+ApmAujN8LX2Qe1otOydEaa7w==
X-Received: by 2002:a17:902:6a8c:b0:185:441e:4cef with SMTP id n12-20020a1709026a8c00b00185441e4cefmr21583269plk.31.1670981904609;
        Tue, 13 Dec 2022 17:38:24 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:487:c29a:45bc:c5bc:b838:9a0b])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b00187033cac81sm518486ple.145.2022.12.13.17.38.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2022 17:38:24 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     m.szyprowski@samsung.com, cy_huang@richtek.com,
        chiaen_wu@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Fix resolve supply lookup issue
Date:   Wed, 14 Dec 2022 09:37:11 +0800
Message-Id: <1670981831-12583-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

From Marek's log, the previous change modify the parent of rdev.
https://lore.kernel.org/all/58b92e75-f373-dae7-7031-8abd465bb874@samsung.com/

In 'regulator_resolve_supply', it uses the parent DT node of rdev as the
DT-lookup starting node. But the parent DT node may not exist. This will
cause the NULL supply issue.

This patch modify the parent of rdev back to the device that provides
from 'regulator_config' in 'regulator_register'.

Fixes: 8f3cbcd6b440 ("regulator: core: Use different devices for resource allocation and DT lookup")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ace4ecc..729c453 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5540,7 +5540,7 @@ regulator_register(struct device *dev,
 
 	/* register with sysfs */
 	rdev->dev.class = &regulator_class;
-	rdev->dev.parent = dev;
+	rdev->dev.parent = config->dev;
 	dev_set_name(&rdev->dev, "regulator.%lu",
 		    (unsigned long) atomic_inc_return(&regulator_no));
 	dev_set_drvdata(&rdev->dev, rdev);
-- 
2.7.4

