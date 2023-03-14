Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705ED6BA0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCNUji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjCNUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:39:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E120C4609C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:39:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so11314812edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678826344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gAVzGC5admqQWUbt0SvNwXRFrLei9CHekAmYZ2wD2pE=;
        b=iEGaDl55qfyDycFXah/KYYvnNFfJlhE8QFNkKfpu+UkuOIJFyUAr/jtuFroupg2M0d
         5qZj+7snyHp7ocmSIRrghLGPxxS2RTBF6VaxOY286yXYU15gNWOrTv2hGrhl0ccUfCOE
         N4wWiN5NIF+aHTNM6/9zwDQrnlOdKLya9+rScVcdNLd4KdpEoqU2qjp2R+USlRqrMyKT
         rsib9f6bfzGEz7logItZ5Ex9QjD6Zbbp0BQbQYrqJw2zx5D93eqHp/emSwumSO12bXkn
         TdCsYjCxXB0qhEluMT78xtIjyOGVZswdIBGPXQ43qEnxPTbO/Cyg/qtCpIrpH9lpYCaM
         Pitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678826344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAVzGC5admqQWUbt0SvNwXRFrLei9CHekAmYZ2wD2pE=;
        b=TnuOSDVN/iO1DQLR8NG9qrb7qbH3p8VUohR0QykZTU7k32ZFziZ/dOqbmy2y3KvVay
         PyDbya5irf/Pygix8XRcq5MrBclFzTVGZ5U9zxp/pKggj9uTav0/3pxEnpjkJljs9ruZ
         1Zol9+NDnZnCpwuitNHaeoVq0sQhi6fGKkngTfTtpTjbJCA/y57bbhlvaKx6wFCV22Uu
         5zzSHgYV+96oy83saf/hjoUlWWuRmRi7K1cXCplpVQtRorZDfqgGxV0y6UU5e5ufW4eW
         mfsoHnosGXw/c6Jj5VEVJhnOriwQ8PDpeAU2kiYS7HRtWn3z4bXaiIpUAHZguLDir6iD
         V5NQ==
X-Gm-Message-State: AO0yUKX1hyU7VX4Og0MTVTWqb/WZbmDUNDSCg7q4lthoKyCX6vk0gO+9
        0Gw4mQQmgO0tSxToi3CG8geftQ==
X-Google-Smtp-Source: AK7set/1OFHFkb6DeEBisNYiLT9XArde2HBH9EOoHkExhOFJLozQUwbO2W6CA+VjNaQYQNt6+Kqkow==
X-Received: by 2002:a17:906:e093:b0:8b1:7e88:c20f with SMTP id gh19-20020a170906e09300b008b17e88c20fmr4486277ejb.15.1678826344267;
        Tue, 14 Mar 2023 13:39:04 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:642b:87c2:1efc:c8af])
        by smtp.gmail.com with ESMTPSA id k18-20020a1709060cb200b008d68d018153sm1579768ejh.23.2023.03.14.13.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:39:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] mmc: sdhci: drop useless sdhci_get_compatibility() !OF stub
Date:   Tue, 14 Mar 2023 21:39:01 +0100
Message-Id: <20230314203901.20803-1-krzysztof.kozlowski@linaro.org>
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

The sdhci_get_compatibility() uses OF functions which have stubs for !OF
case, thus entire CONFIG_OF ifdef can be dropped.  This also fixes
!CONFIG_OF W=1 warning:

  drivers/mmc/host/sdhci-pltfm.c:76:6: error: no previous prototype for ‘sdhci_get_compatibility’ [-Werror=missing-prototypes]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Drop the stub (Ulf)
---
 drivers/mmc/host/sdhci-pltfm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 328b132bbe57..673e750a8490 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -54,7 +54,6 @@ static bool sdhci_wp_inverted(struct device *dev)
 #endif /* CONFIG_PPC */
 }
 
-#ifdef CONFIG_OF
 static void sdhci_get_compatibility(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -72,9 +71,6 @@ static void sdhci_get_compatibility(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 }
-#else
-void sdhci_get_compatibility(struct platform_device *pdev) {}
-#endif /* CONFIG_OF */
 
 void sdhci_get_property(struct platform_device *pdev)
 {
-- 
2.34.1

