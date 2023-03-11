Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E671A6B5F3E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCKRjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCKRjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:39:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D6113D5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:38:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x3so32975492edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEgoJS3qrsEtaJMFetSvJY9kS8Ao4kP1CN24XfSlZMM=;
        b=gnJTMg/R/DM4MDRV1H/VEF1WdEk7JlqpqKKwv8TemZESQtQv5gycYDmeGOpnhsmw4C
         hjmlJydNmTCujjKEUWGov7jPWyWWmuwht47dZgr2jVN0s/DFbws2FyZK8/hletoEFvCh
         mAvpYsBvdtV++kmwIw4hX7PKnYqMVwAVk2zlc9Ds632IcqnYZel2I0x3cEERhdlKZ0kv
         ISi0EzHweuKng9p4FXYs6o3Ot6sIv14Kvve7CxfJBY1bku8HTJ0zFPeDH5ZScSGCwIDp
         G9HfsyiuiCNPFGtfEbNJ7t2z0NwYSi4JqZyZ/mgydtjDxBEaqPo2Kj1MjELpkMyU8L1H
         GV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEgoJS3qrsEtaJMFetSvJY9kS8Ao4kP1CN24XfSlZMM=;
        b=f+8jPPL+aAPp93+IdosxtowjTzVD7T/KgFcx2mKAVOAq7XWoJ2OLGgchyu8Fc9cKDw
         dIB6hNy0phdHNDUb+Kop+w3Xlif5t0/dOEGvmQwmw2p30BeHeUr31zbvKzeLCFL4xP3M
         GNSaV5TiLQpA8YEgTDh6TutcL757JuQtCiTO6S80h3ZeQVqhPjZLvYzuYW3fN8rLMoL9
         854QSE2DAfxpe/VSx5sOP+8qNF2Terf3nhhki5Xaejiq48Il9lslFHClI9IWDWbHiIIJ
         6fLX5i1F6yHzbiqO8M5wJylJACQPxOg2s+e6DW+HqGtaBotPObBRwYeJEWvuyMXJv/8f
         OgJg==
X-Gm-Message-State: AO0yUKX/iXILz7+GPOSZF4UA+cGCQTgI90fnZBYnhp0tcaQ2tO6iAZWR
        gQw7fQgBhkPtskrKv0VAg7Q6qg==
X-Google-Smtp-Source: AK7set8xmYF6AhvJ6Vqs03dYavXCjrvSUKQ4YnoBkZt3pwgrd+3nGWiiNNmwUu2NnSSirCtELHMrUA==
X-Received: by 2002:a17:907:d02:b0:8b1:7eba:de5 with SMTP id gn2-20020a1709070d0200b008b17eba0de5mr6402947ejc.10.1678556258246;
        Sat, 11 Mar 2023 09:37:38 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b004d8287c775fsm1444903edj.8.2023.03.11.09.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:37:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] pwm: stm32-lp: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:37:35 +0100
Message-Id: <20230311173735.263293-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173735.263293-1-krzysztof.kozlowski@linaro.org>
References: <20230311173735.263293-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/pwm/pwm-stm32-lp.c:245:34: error: ‘stm32_pwm_lp_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pwm/pwm-stm32-lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index f315fa106be8..bb3a045a7334 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -252,7 +252,7 @@ static struct platform_driver stm32_pwm_lp_driver = {
 	.probe	= stm32_pwm_lp_probe,
 	.driver	= {
 		.name = "stm32-pwm-lp",
-		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
+		.of_match_table = stm32_pwm_lp_of_match,
 		.pm = &stm32_pwm_lp_pm_ops,
 	},
 };
-- 
2.34.1

