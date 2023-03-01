Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0949C6A7508
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCAUQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjCAUQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:16:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3165649884
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:15:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k37so9418268wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=S2RD3t39aOcAjADtvbfn2VOvpvaTF/lJry2CokRv1cbcRY9sR8q2wa0e6ifexfGhVP
         6qDOnbMxuegflcU5lSO2YwYpN5dpXp/qjdWxsHaGVCmw6mJXVvWRnaAuEWvPjPrhLVYy
         g3l984PPao4CAPL7k2m068EP0zrDricnkqPUQ8x6IiHtFFsxICFggHpQTctZKtkK3hgq
         xygC8Q4ak+4aXJHv/W3Q2uKRzysV1hORN6vzHFSoR0klSVjYbxUGEgWgjlIpAj964NNE
         pDTKWfRnBgN4S1d2vRCtB04R5xHGlGbRhQiJNNc15ddBm81kD8Au9fnEIvaokSS/yHxR
         runw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVdgWpAFCojRfEmtrK5jCjMCpct5NgUpVAZqrr++Uhs=;
        b=27SlqVEair2Jtg8sBk0PBBG4bjcBaReYnY31MaicsAu4nA0HHw89Kx0Ykcla7ZoLCJ
         Ox4pp2fX1f5hUyFf+4g/+NlERnYl1JUSTSZVpWJWayDExuTuSlXUD2Sek2BmA3c2qrya
         iZeacSJYdEsJNs0WW0AoaB4YXOPZmEkfPkmH+iAJkYHk7ybFFCpESLFg9DIacTYPnsFh
         azMbLmFNi8y2Tkha6juIupAHpJKhlxu+N03HkVo/x/JWE9hQdB2KNpeBWFu2VIYHSTVq
         0RU9AukKQcDXXuYKXLbgzHnwlF6n9n8MI/vZ1+UrSaMMnjIuBQvaCCW0zVjdk7d0TCGx
         LDqA==
X-Gm-Message-State: AO0yUKX1F8gNEPKR1gHDvwg3M/rCyqdH4FFDSxG1R651mcGjKRwM6ym7
        yAIW4+s2/S+aLykepLRw8ihS3g==
X-Google-Smtp-Source: AK7set9Z1MVQyYdm9AeVnKhEPeO6y7ydvQ4G3I3+bUnrRbQlbWRAA2vhkypDegGjRCb7Ey5Kj+Idcw==
X-Received: by 2002:a05:600c:4fcc:b0:3ea:9530:22a6 with SMTP id o12-20020a05600c4fcc00b003ea953022a6mr12712060wmq.1.1677701740585;
        Wed, 01 Mar 2023 12:15:40 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:40 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v5 11/18] thermal/drivers/spear: Don't use tz->device but pdev->dev
Date:   Wed,  1 Mar 2023 21:14:39 +0100
Message-Id: <20230301201446.3713334-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the spear associated device instead of the thermal zone device
which belongs to the thermal framework internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/spear_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 653439b965c8..6e78616a576e 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -137,7 +137,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spear_thermal);
 
-	dev_info(&spear_thermal->device, "Thermal Sensor Loaded at: 0x%p.\n",
+	dev_info(&pdev->dev, "Thermal Sensor Loaded at: 0x%p.\n",
 			stdev->thermal_base);
 
 	return 0;
-- 
2.34.1

