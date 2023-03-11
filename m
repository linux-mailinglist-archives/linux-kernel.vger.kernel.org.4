Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BC66B5F42
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCKRji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCKRjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:39:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAF83A844
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:38:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j11so33062382edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ADvKOM9mwPGgDKNtE5dHDUeEeCiEDQjXCHZYcW8EzbA=;
        b=CfgPKp92BDxt/iJ36GZbumEkQyrTaHn83Rgu02Fy64E+0eT2AdQkqJa9PkPQJ1sscS
         D35vUWnyMAAeE01nc02vSGHXBFWR6KLslM0C2fs3XrJYDWqzrn8jALpfbKFk3lQSMY/T
         HYdKEE01VjHy2oy2Wlk868ULw7d6hYJm2kOe5nxTArNqJ2ZRlgrzJHxAXOxj0rkz2L3/
         YnF9iDRdFr7S/6/EPaE1Ydrh32BTeLVe8rTxVanE2aZ4z6FJcg5JgQVReOx+Y4rLw+SI
         nRyM4BGzV+6g900B2nNRHVepwruQJgGYKn9MvXi1Dcw7lQy2cgJHjycyG7YWAjnIbV56
         tPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADvKOM9mwPGgDKNtE5dHDUeEeCiEDQjXCHZYcW8EzbA=;
        b=YPlUGv6NlC/3xE8uswNb8+r4w4lwXMiiuiSfZuijnj2KIwrehkFdZHGw0pGY/n/esY
         6gdtI8gdIUXHqB22H6BZz/YtSWBs+e4nt5Ccp8IODRf9oooQlzOFK2OBkaA/FWGCAxWw
         6SZpP3bRBFctDx5cex2NtqbBW2XQJZjHHrOBg5odHUGNgOcM6JOQfatF2nSJ/knzMrs/
         TJI0qfNm5CffKE3wg7MYTng6PUoW5hO87Xw5EA0WtF6uhR9ApxevrTPlsOdRFfTdmRbf
         HWt5GKEGsxjtQNvAc6BbiUJ9ZQrEmhftFblh7RHAuzsLROidyj9+9O0B/OBQkMIMXP30
         erwQ==
X-Gm-Message-State: AO0yUKUUONKooIFHnfOjWYdybqnYozMopGl4ItCl9+OaGAXsCLYaUdkR
        m07uVLqzM76F+2jjHaKVKwxRCg==
X-Google-Smtp-Source: AK7set9QxtYe1KQEiI0JGd+JCQrlJIVoCYHDahDGxoaZhvwxYbQmCI120IdIT+4Rxw+dOw2QsBQqrQ==
X-Received: by 2002:a50:ff0a:0:b0:4fa:fa6a:1a with SMTP id a10-20020a50ff0a000000b004fafa6a001amr1170089edu.12.1678556285634;
        Sat, 11 Mar 2023 09:38:05 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id b4-20020a50ccc4000000b004c09527d62dsm1444082edj.30.2023.03.11.09.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:38:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] clocksource: stm32-lp: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:38:03 +0100
Message-Id: <20230311173803.263446-1-krzysztof.kozlowski@linaro.org>
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
matching via PRP0001, even though it might not be relevant here).

  drivers/clocksource/timer-stm32-lp.c:203:34: error: ‘stm32_clkevent_lp_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clocksource/timer-stm32-lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index db2841d0beb8..646bb90f5e92 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -211,7 +211,7 @@ static struct platform_driver stm32_clkevent_lp_driver = {
 	.remove = stm32_clkevent_lp_remove,
 	.driver	= {
 		.name = "stm32-lptimer-timer",
-		.of_match_table = of_match_ptr(stm32_clkevent_lp_of_match),
+		.of_match_table = stm32_clkevent_lp_of_match,
 	},
 };
 module_platform_driver(stm32_clkevent_lp_driver);
-- 
2.34.1

