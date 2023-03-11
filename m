Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B146B5ACB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCKLMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCKLMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:12:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB47138443
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:12:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j11so30723634edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtoSadEYa8Ss/aLG2RB4W5+eHjvVyH51L/bxtSrvPMA=;
        b=Nuwpg9/ECvGlnZViVbgeVL56DNY24+RGeMn76jRHFMkBgxNCWgtU1mkNx+kP2kSD2F
         bsVkGDEyG/e/e4kFaB4ukrBLKSquN3fGXh5Sb7E64ED8miiw99LeYeRhBlZvg6QofQm9
         qKhoiyPLDgP7E2YhPV4YJ3gRplSJViLvnEfFMZ2klmykaYqsbLi5a0MYk3o8MefX0ed3
         mBFaa6dybsxiLvuMKcm4vQ5WXr45KQaK39WazXdxnEFDVFkNx4uuq5VhK7Zj8xQcm4KG
         XUsw0SyosEFOdw2W817tmi8fvGCf9WC7SWlHz5QOAIKanfl6AJRCHp4pk+8k3n6t56yn
         k0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtoSadEYa8Ss/aLG2RB4W5+eHjvVyH51L/bxtSrvPMA=;
        b=DhnHQz1xdzEMsbWXXREyk3lJjkhgUBMFPb/gGY5+o6fNJ0cfKOra971qiLEvi2QO0Z
         gSkZNeUc4oBQoZYmLewLbWrHyDkz3xAFwMczyGja4LStApp4NAoayGRMohCmE0pLB/3I
         2slh7zw6c8Hdu6qa4gv/Yfir2YfoXYnODaAC2U6illZ6bwWfCNf9rsr8WVPPX1lzdI2x
         eok9vAasYdveREPyjhHET6f1gi4R0ikaFNoAr6BHczALvFCfQ2onUeOVuiG4ciJdaH3N
         6oOnAQvrUFLf1X9qkXkPe3hmHQRbjcr7dRiFnOXlGoo3dAasf5jzDTpYXqMxWUi9PM39
         ICvw==
X-Gm-Message-State: AO0yUKWhF7gOgXahnUoxHzugk5cd9Bzog1pMnzkN+24B0RPlEJk/6u2q
        0N0VI6F4vjaWTKHGwJpPaS6NNw==
X-Google-Smtp-Source: AK7set8B/eLT6NjOMWrhe2BBeVH13qrTXez8NyanZsqG0kQ35nJOv6OOlb3cez7x9QZOJsYmos/qKQ==
X-Received: by 2002:a05:6402:1854:b0:4ac:b614:dd00 with SMTP id v20-20020a056402185400b004acb614dd00mr23528925edy.30.1678533160796;
        Sat, 11 Mar 2023 03:12:40 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id a70-20020a509ecc000000b004c09f0ba24dsm1043803edf.48.2023.03.11.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:12:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] mmc: sdhci: add static to !OF stub
Date:   Sat, 11 Mar 2023 12:12:38 +0100
Message-Id: <20230311111238.251000-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdhci_get_compatibility() is not used outside of the unit:

  drivers/mmc/host/sdhci-pltfm.c:76:6: error: no previous prototype for ‘sdhci_get_compatibility’ [-Werror=missing-prototypes]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mmc/host/sdhci-pltfm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 328b132bbe57..245e56324dff 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -73,7 +73,7 @@ static void sdhci_get_compatibility(struct platform_device *pdev)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 }
 #else
-void sdhci_get_compatibility(struct platform_device *pdev) {}
+static void sdhci_get_compatibility(struct platform_device *pdev) {}
 #endif /* CONFIG_OF */
 
 void sdhci_get_property(struct platform_device *pdev)
-- 
2.34.1

