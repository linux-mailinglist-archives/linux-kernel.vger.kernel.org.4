Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB4D6B5B00
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCKLRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCKLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:16:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C0EEE76D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id er25so2603299edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pASbe7Eu+peWRZx/jNfSYrICtEAfH2gWZkppY6lRpOw=;
        b=ZEpadFepcu6t1hYONd9w1u72jH7xkf7k4RgAzkFFR4NyrJ8KJsHFntmx2Joqb8JYsg
         05vuEu0NfSWW/fNblD7v2dtlW1hwTZd7BqWQGdWLjLNf7svW3BzMMgWY/ZMTT/dZz966
         usURnuYHtb9TRX3rhGjghmcVgI8hHRclpHMg2WFuo0TOam5L6fla60lgXUYujmwszdt0
         pJZ+Mmvj9/FU+jOEr1ff1HliOStWoWmev9Hu8jiUg231R+k7XUMXmCmOK1+8Kp/i7cS/
         bl+1uaC/xbityhNTVnmF+nrAA3uJ1PtTBs6b3ca/WF0CEJBONCPO7HWLtmkaaZ2sYSLK
         Kr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pASbe7Eu+peWRZx/jNfSYrICtEAfH2gWZkppY6lRpOw=;
        b=6RA2kG7YzyVRCBqagQKR13LwsTVOj0X1tZccZlmkCR2Tn9PJvtn8ySmT+WBiGNtefR
         i3CRexFiF0aDajKT08h+XOM+xY8dCYvo+mM6MSWgCdmMJ4M6F/9huZB8xMHKFWCFxtvC
         55m8y/tA1Wdkf5Qqhb7M0KSnYzwmROni7Yd5RCEnSn9spg0Lu/5I6xIt5deeSmmiV4QE
         yEHy1PB7o+6mpoO09xi99E+MGfa8PkPivA7JlT/2uYxJKvWPbfxhWUN4Hby+wpsfEgNX
         P1JSbJ0OVkUCOnG46aC+rLZ7An1+C1ZoYJK2VovGf+zgpFOY2ogdhMQPVPeHOpa7zv2i
         KwAw==
X-Gm-Message-State: AO0yUKWPWUusJoobU5FAHzDU0COMIISSEpAJZnUY2104KVtUZRuRNfS4
        13+ciTOeR+9U6mS1U0KJcN3quw==
X-Google-Smtp-Source: AK7set9KiUEWUKifKlYJkvBws3lJK59ktI8sQVZSH8xHRdG7GNqWFnqvfbtc4Q4y6l8jcz8TAics/Q==
X-Received: by 2002:a17:907:a706:b0:878:78bc:975c with SMTP id vw6-20020a170907a70600b0087878bc975cmr30084611ejc.36.1678533335614;
        Sat, 11 Mar 2023 03:15:35 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id w15-20020a50c44f000000b004bf28bfc9absm1064150edf.11.2023.03.11.03.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] power: supply: twl4030_charger: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:15:28 +0100
Message-Id: <20230311111532.251604-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
References: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
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

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/power/supply/twl4030_charger.c:1129:34: error: ‘twl_bci_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/twl4030_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 53a0ea5a61da..7adfd69fe649 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -1126,7 +1126,7 @@ static int twl4030_bci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id twl_bci_of_match[] = {
+static const struct of_device_id twl_bci_of_match[] __maybe_unused = {
 	{.compatible = "ti,twl4030-bci", },
 	{ }
 };
-- 
2.34.1

