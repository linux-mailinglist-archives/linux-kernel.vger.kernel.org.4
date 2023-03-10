Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B536B547F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjCJWcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjCJWbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:31:22 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB5012A4C6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:30:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ay14so26383445edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61DvhmsO4xSNuNORHw5ib//2wHgpkfyqFxtOWBFNJmo=;
        b=aAN3J7ps3GBSOD08xvYIioPIS7Z+DyEdXyhKpTgdWiaio98OS+NjpoqRhFy/aa1Uc4
         /nUwOyqfXMQiTIfShuaZAG3QBNVdNYWPfYyg+YUOsYb2MfBIvteHxewDJBSNzNW3JhjP
         tDsj59shgVnWSS3HxDq4UvVOuDTPRbOtrxvz0bnEqka0mFhCpoUEDSJK0D+OK4TY5pWv
         UsV7UX3oh8t+YCHsh8a+qF2tjbg1h8f6HrdkrOm1WKXAsPJCOMjTYTFrNf3ZBtZrGCey
         z4GO9Q08HD9sWTfbEgm8WpzKplUlQOgHnaOsoZkhiIJ7VaBA7fY+sSO5coRF+uL4h2AW
         LMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61DvhmsO4xSNuNORHw5ib//2wHgpkfyqFxtOWBFNJmo=;
        b=x+McKFIV/G5O5IDb1fJS0Lv4qefKk3swVdg65zSbBzetzK0fDPzx3ss7BxATxrFUSE
         OG3krm2HFjQzU2wXbd3lzoSXcjsR/zKoh/87iaDEWYSWBiF2WyuIyMsxEa0pRNh5j7cw
         OuSR3BnCDEr8/4UOCQUge7CSBaKaW1tZlxBU1EClkuFbto5CjgQn38m4kmCSmHhyL2KI
         W14WUyMsdMz7hzS3KQ5g8KtNRULfj4ULiKDFjC44dmjNyG2yq6ppoG0ed+76n/2w0hcE
         SrQ9862xLBQ8HQZuB7EPQr3oodhOpggHIudMzYfvzL09r6XWaIED8N31oEGmSPecxKNw
         BUAQ==
X-Gm-Message-State: AO0yUKWsv6IYOUqeEVy/hwJ0VvCDZXQjeGtCQl7PrgrGBLpsUXdsvzaU
        Y7Tb+s4mKlIaiO/O5LUzxZLSmg==
X-Google-Smtp-Source: AK7set8IwF9MMOqQdMWkdrh2f4Xq9KnkoKxFJPEe/j1hoU2JE80HulHxMpzUaPXGKchFiqU+1e16uQ==
X-Received: by 2002:a17:906:434c:b0:87b:6bbb:11ac with SMTP id z12-20020a170906434c00b0087b6bbb11acmr26776453ejm.60.1678487414349;
        Fri, 10 Mar 2023 14:30:14 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id ht21-20020a170907609500b008d57e796dcbsm375533ejc.25.2023.03.10.14.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:30:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] watchdog: aspeed: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:30:12 +0100
Message-Id: <20230310223012.315897-1-krzysztof.kozlowski@linaro.org>
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

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/watchdog/aspeed_wdt.c:56:34: error: ‘aspeed_wdt_of_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/watchdog/aspeed_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index c1e79874a2bb..b72a858bbac7 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -465,7 +465,7 @@ static struct platform_driver aspeed_watchdog_driver = {
 	.probe = aspeed_wdt_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
-		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
+		.of_match_table = aspeed_wdt_of_table,
 	},
 };
 
-- 
2.34.1

