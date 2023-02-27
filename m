Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86026A3962
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjB0DOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjB0DOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:14:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B050712868;
        Sun, 26 Feb 2023 19:14:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so8704716pjh.0;
        Sun, 26 Feb 2023 19:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gR/wbqkWELBvn+JMlhT/1Wwy2lqKc5lu0UUAT54M4Rc=;
        b=GYQ3Ms8rjd2jErfhgiWiEr/dJxgV5z8L+TIrPo3Ew4DocOtfJADVUoqZ9d4u9a2XTL
         VWxa0EF3CH5erbyF3v4luEYbX/tkyY7QtKswpwU55z0gtW1rqxC1cN/H54mChZNNM6hY
         eslkxgj/Tb92yvS2VvKvpkTt+pbFW+UFGrS8iUr6aTxw6Pq1Nm71fxHfI+K93L3j91wD
         zaFMrPewTRZ3kU/tp587eYeSFMuHyeyiT1QsQXtoVJOQo8w6PB3nKsOrth88Gg5qNXhU
         YVn5N9trWAnrY3JjixezzmFjnBNaPF/Vt8OBFzFh9ies0e+xRIH5SjlrPVon+5Puah/H
         tPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gR/wbqkWELBvn+JMlhT/1Wwy2lqKc5lu0UUAT54M4Rc=;
        b=48jXiEfvZx5a0iT2yQU90+pj6QzQwrNa6exzeAGhmKENBiFBFPTHUPAIS0l5gfMXSI
         wpoZOP2Frdnoxvnbo67LgejKUiJGTtQ4RUZJSCv/VKu9bCqiXaPFr5CLHPBNDGt+/MZ2
         qdXMEYXdjqGWtAb3i/YL65vxWPtOwG8Kwj8C1mIkmD8gjU3QDcw3VkRb8U5Mfj+6un8b
         zmgh+lVdoNyGM5oCBeCm2mBHxn6ayv5Ag028Qe9GB01Yequ3YFDYZkGM8YlvW3hEhlVs
         evbwOnpnl+HQ9V/v+8eE5QOXjTOZK1rSdHvSL7w3ntz8K69cTg1iZl+Ccw8/EZd4hGUy
         gn1A==
X-Gm-Message-State: AO0yUKUX5y/T92QK9siefN8n5skf3YH17Odn+EixlHrXLHqubkGPgING
        yxWTuO6LO6UTGG7M1l2cOVY=
X-Google-Smtp-Source: AK7set8cIYQP+miBC0tMU5JIugoMFJN1vsUND7dRn31QdsukPLIUZzlVly0ruAvbjyhrgN9JO/Cp0w==
X-Received: by 2002:a05:6a20:cf60:b0:cd:363d:b27c with SMTP id hz32-20020a056a20cf6000b000cd363db27cmr2294371pzb.16.1677467655103;
        Sun, 26 Feb 2023 19:14:15 -0800 (PST)
Received: from localhost.localdomain ([103.116.245.58])
        by smtp.gmail.com with ESMTPSA id d19-20020aa78693000000b005dae7d1b61asm3088362pfo.154.2023.02.26.19.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 19:14:14 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     angelogioacchino.delregno@collabora.com
Cc:     sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH] power: supply: mt6360: add a check of devm_work_autocancel in mt6360_charger_probe
Date:   Mon, 27 Feb 2023 11:14:10 +0800
Message-Id: <20230227031410.893593-1-void0red@gmail.com>
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

devm_work_autocancel may fails, add a check and return early.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/power/supply/mt6360_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index 92e48e3a4..1305cba61 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -796,7 +796,9 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	mci->vinovp = 6500000;
 	mutex_init(&mci->chgdet_lock);
 	platform_set_drvdata(pdev, mci);
-	devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
 
 	ret = device_property_read_u32(&pdev->dev, "richtek,vinovp-microvolt", &mci->vinovp);
 	if (ret)
-- 
2.34.1

