Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAA6A3977
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjB0D0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjB0D0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:26:06 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC61B2FF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:26:02 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id h8so2032720plf.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQjgP6xD9SwZtosmKlpC86tRlv5f9ObNbS66GUAaxVc=;
        b=CGkQ0zxIXtJqp7Tctt5suGL0lPfve3yYjTiOlUXqSX/r2QEQf973FYr8hi2xhusYW8
         cj34TaRKzIUFaKiOlKpepE1TDiWpFAi3m5h8K3srK7O4/xpcM1XP8fghYxNDOQNOa+sA
         EHaF/bJPmHCLZTy37xH03vHeP3pRJeNQvrHJy/E/O150fh/dCim+5VO9eaaHTNP47dh3
         BJvnfyucKF7xzHyMm2DL9Ub0xp0DxTVFPRC8fF6kTcblzi9kw5AYstuxKGixmQRoH/5Q
         hHO19rYnyQrgqtoSRluRhrTic8nQ3FadEw2rJ5g0BeVTkGRurBkeWIKJSzZZHr1yjUi+
         kxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQjgP6xD9SwZtosmKlpC86tRlv5f9ObNbS66GUAaxVc=;
        b=5J2eDnSMDy3i4RoHLgIUO3CeZX8XU1x+jeQEPbsjsRI0TBGMHz8mJ12gEOLDnp50NS
         Jf6HU9hUx0S5Faq/SHoMUzMyWNTvMEXct4y2Ga2MZ3zDUUHIXnqomA6VjGvX3/ksMx1U
         pI3nI8z0GtxQfwEAtwWQAdLZAI0bZOJA/3i3Vb5GqQLfMCxPTUgY5gN64ZUXM449R072
         9MR2zN15HxA5ofRH+Hwc+dLyo6mUZHhgzPB0/0Cuxrmkg0g5NnxTKTgwuR0j4V7jOJpq
         0nsRZU6AT9Atx8vhmxv0yncrw2Di2jlK8g1hDZbv88CVHsUSDJSFZqs4N/gI+thSp++X
         s4Cg==
X-Gm-Message-State: AO0yUKVNx7gpbjUUO4zQ9IY4r14eiwCRBBBTSeYfn1bRr74kCsmlKcl3
        zCuiQliZP+KcP0tKH48e3ok=
X-Google-Smtp-Source: AK7set/A1fBsD28xROh2L7g6t5SbmBzKfmCs44JaXQTElMb14SOP8rF3ZD9cIYLbYZe46MEMIH00kQ==
X-Received: by 2002:a17:902:b286:b0:19c:a9b8:4349 with SMTP id u6-20020a170902b28600b0019ca9b84349mr15651897plr.32.1677468361962;
        Sun, 26 Feb 2023 19:26:01 -0800 (PST)
Received: from localhost.localdomain ([103.116.245.58])
        by smtp.gmail.com with ESMTPSA id jc11-20020a17090325cb00b0019682e27995sm3342751plb.223.2023.02.26.19.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 19:26:01 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH] perf/smmuv3: add a check of devm_add_action in smmu_pmu_setup_msi
Date:   Mon, 27 Feb 2023 11:25:57 +0800
Message-Id: <20230227032557.894274-1-void0red@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kang Chen <void0red@gmail.com>

devm_add_action may fails, add a warning when it happens.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 25a269d43..307bac904 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -724,7 +724,11 @@ static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
 	pmu->irq = msi_get_virq(dev, 0);
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, smmu_pmu_free_msis, dev);
+	ret = devm_add_action(dev, smmu_pmu_free_msis, dev);
+	if (ret) {
+		dev_warn(dev, "failed to add callback to free MSIs on teardown\n");
+		return;
+	}
 }
 
 static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
-- 
2.34.1

