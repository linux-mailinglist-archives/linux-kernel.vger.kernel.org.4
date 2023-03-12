Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101F96B66A8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCLN1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCLN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:26:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF05B2130
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn21so8390423edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678627599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OhPNKp+h/JhTZv2AR+GWTk1z9+pF/E/xoiUrabbBl5E=;
        b=r0zGlJwdbieCHEHGgPRlybtntCda4+R6XxU1ew2HJtN++FQgDaXxRor3iSCYAUz6cd
         j52mWCZdomS06Kz38Wte+mo8YRs5UT1sofzFBifTwVKxYki85wotRs4sdq0Qz6l5OZDm
         vw15pI/3rOKFE+VxhZrhemWd/CZAt9c74EI4vTLnX6FwUpYHa/uTuKq2gfmLzOi/KNaC
         KW763+SHvh6w3NZ1zsLHR0B7XT3v0NP91VS5/BbLcGn2hfrkA4VK0n+quVg4R/5DVdTP
         KvmcY3AYBRoOGvKfgYs35xf5Y/hjjse2xsgbeZoUGgK3S+ZQIAFSKB4WINpGubThw6r1
         7MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678627599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhPNKp+h/JhTZv2AR+GWTk1z9+pF/E/xoiUrabbBl5E=;
        b=LbVteUw8tUOEeEV87uhfzPT0nCRIDATZUqQUed4X28yS91qoMtLWtfjC5cMJQ1N82z
         5J1iK+BD1uCbG9o2Ep+sEkq0jDv7D/cJVSmWfVVad6PdqC1MaAEsiihdDQAmEr2Sxi7W
         w2RVw/BK3QNFeqFoNQVwAfDEZd7SbxezMc1aq4RX2eHrwEU3BKcqlGHJQl8TfsEztyHm
         g+pOW1SIgHUHB/gAMNl/Bb0eg/+HRCpR+UOP6BD5fLRqEdsx6/VjaffACAG/8yZRt2cC
         RIafDbhuXEqweWa79JcTWi+wk3aTL3QrLiiD3W6CAwbFMlk+kIERp880CQxuAQWGTWzC
         Fz3Q==
X-Gm-Message-State: AO0yUKV2hlsIYTwNV2Ap7sRQKN690ZLWcYpNZAHKWPG2ldUbzPPVaFcC
        367lXEouqfoRH8yESLw91GGDDg==
X-Google-Smtp-Source: AK7set+xy8EaABJuRWSfHzt+0Cu6wNhfn4lU3X5a19yJpOY4ODpGNX1PNLtyh6KyLgL1zGnC13HF9A==
X-Received: by 2002:a17:906:1c0a:b0:8b1:79ce:a629 with SMTP id k10-20020a1709061c0a00b008b179cea629mr32465380ejg.18.1678627599113;
        Sun, 12 Mar 2023 06:26:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id bg25-20020a170906a05900b00905a1abecbfsm2219473ejb.47.2023.03.12.06.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:26:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ptp: ines: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:26:37 +0100
Message-Id: <20230312132637.352755-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/ptp/ptp_ines.c:783:34: error: ‘ines_ptp_ctrl_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/ptp/ptp_ines.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
index 61f47fb9d997..ed215b458183 100644
--- a/drivers/ptp/ptp_ines.c
+++ b/drivers/ptp/ptp_ines.c
@@ -792,7 +792,7 @@ static struct platform_driver ines_ptp_ctrl_driver = {
 	.remove = ines_ptp_ctrl_remove,
 	.driver = {
 		.name = "ines_ptp_ctrl",
-		.of_match_table = of_match_ptr(ines_ptp_ctrl_of_match),
+		.of_match_table = ines_ptp_ctrl_of_match,
 	},
 };
 module_platform_driver(ines_ptp_ctrl_driver);
-- 
2.34.1

