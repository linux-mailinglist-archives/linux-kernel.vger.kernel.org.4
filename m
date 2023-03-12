Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A246B6684
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCLNRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCLNRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:17:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735AD4A1CB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:15:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id k10so38414273edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4NIviSFBdopEf8zQTdl2J1MRzQXgxaliBaSLt4RpAk=;
        b=H0gAYKteJZspYXhBQb75omimqMlU/3ICKO865cyDwNVHcSV9El2GPK8iBANJpw4WTf
         uSlYknNPoNxmPDr1cayhoMMjioXKbh4JISMQSYYm50XfVL2OKtKt3ELm4uC+ufpuY/Pz
         gV8aFkz2EZowNSm/luHBng1oXIHab6hjItQRMnAuD4l/bXp8VooAIhXV+R2EQbZlhZRz
         yMz6nQ7cZxqoa4ZD77/BpLScxsDjqOyUnep1ya6MNgVSBFInP5yZwunhFzyx+2g9Sy2v
         A3JwbUJBRAAt6rAsKIaqTLYEbHiCCWi641dSnbv4jP8NE3eeKhAU6dR0Rfz/Yxju+0cc
         sgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4NIviSFBdopEf8zQTdl2J1MRzQXgxaliBaSLt4RpAk=;
        b=04LxbqBZDFrtRAbUpnqm5nm+8ijZN9S8aL52KPUHefW8roFhPX0L30uFAUsB1QYhAl
         PD9TAf/a9wqdffdgNG6Oolx4rhUOzAbpSPKvbM2Jzbdufg+ohJvDBD+Z27Slx7RK+BvJ
         x7MyAsPN1F2ptRihoXtUm+MUWp7xoA56wDAfhPIOEhJ5qIunlLM9VCiKQSWwdZD8gAAh
         F6HQbjg7RTNoP8clTB25Y+dp9bYonRTrgWt2n8nfWaKfHwcibcjaiMdxUd2ZeuJy1WKQ
         dE1dXpOfSt8hiXvhKuCucO5bqRLRq7yeG1Svpu3Japb6tyBNP6NkchzpbTYIzdHiBtCX
         e2Ng==
X-Gm-Message-State: AO0yUKV0YTRt/+yB7zIuWrReTnUOyBqwuyD44Vlepd81NJQz7HkLS8ZA
        twSLelUZ5q3TiA3jXpDRXtObSg==
X-Google-Smtp-Source: AK7set8I4cqRQbCnoLL6lvvu0JefPsaKOI2DGJq/GhcEpkC6BmWIDdihxL2/gFsjsKFFEZdmBfNu3g==
X-Received: by 2002:a17:906:8d86:b0:8f9:ed75:f962 with SMTP id ry6-20020a1709068d8600b008f9ed75f962mr33585228ejc.18.1678626916875;
        Sun, 12 Mar 2023 06:15:16 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906399a00b00915d58e56f0sm2223493eje.77.2023.03.12.06.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:15:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] Input: st-keyscan: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:15:11 +0100
Message-Id: <20230312131514.351603-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/input/keyboard/st-keyscan.c:251:34: error: ‘keyscan_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/input/keyboard/st-keyscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index b6e83324f97a..0d27324af809 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -259,7 +259,7 @@ static struct platform_driver keyscan_device_driver = {
 	.driver		= {
 		.name	= "st-keyscan",
 		.pm	= pm_sleep_ptr(&keyscan_dev_pm_ops),
-		.of_match_table = of_match_ptr(keyscan_of_match),
+		.of_match_table = keyscan_of_match,
 	}
 };
 
-- 
2.34.1

