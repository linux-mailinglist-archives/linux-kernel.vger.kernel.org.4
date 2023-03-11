Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C631A6B5F39
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCKRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCKRih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:38:37 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A543C2698
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j11so33061377edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M5xwpl4H01ebuofJIsmyDXhZifNKbULLaWH0tgMeLQs=;
        b=uHRXvcl4aQRMKSbMkJJVDHQLeJeor/p2qFQVGFmp4HbBcIjyvzBQXOOEOuHg5McWei
         YkEPMsW0vdZEVtKDleHnOWn0qxL8bUYhMoWrRanE2Q2WOI6Ym1g3EC3UmWNyUUjGyR7y
         V1CQmCVvmgjhZNEAg9xJW1pzDAlsnROIIVkXlqZ9BOSVhlPHNFzQPaCiSM4la7NDl4ZN
         LuGw47EWnCQsi7sVTaNLg123uR3NHmj731YlMoLQDWIYnzcOBnmYYzHnWYGAk3vdYvkz
         GAaeaSOr4LaUH1Fj4WcphjEjgnK3vmLSV+Dt51eeykqpi1RCcbC/3ro+zK/leUzQWe2f
         42dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5xwpl4H01ebuofJIsmyDXhZifNKbULLaWH0tgMeLQs=;
        b=sy5UewB2/fkDOpUnfFbom7lbBUCx4d9gBNlZT3BVsubtRRYv15MsNGPNtZqY85ZJ1u
         G8lCBa7heEnDHAEUeMDCpnOKgAlKe7tOjdoObA5R+q3acTVNQcHusPnfotmdmXY02/qA
         iW9pHZe8SMPYMEX3Nw6666IaF0ADU7YhqbhQ/G5v+PPtVJtSWLCTsl9v0fqKmUHBs5Xl
         kW8ZHTtklTRuJGukbiGZggZpjSlmh2bdMtaKGY4/7kPcQosxViCqJejoWOtTv+reMuIv
         cGXK4ImK2XcKjqYEWr7HyCACVBdz4hijlLO/og/9gkIANYztxcC92+ArIf/2rdprMZ19
         AaQA==
X-Gm-Message-State: AO0yUKVr+WMNsdiKudm2Dg8MBNzPhG7o0XD/R7X7MmVfnNhVMXZaDps4
        KVUKHGVeqWNDGSNpBi9lea7QGw==
X-Google-Smtp-Source: AK7set9jGiGyUzTtS/mgdFjFwFwViy1GgJ823I/8lO8D9gRcovvMXzCapYxYjktiKP9R3ILihDBvIg==
X-Received: by 2002:aa7:d58b:0:b0:4ad:7ad3:de18 with SMTP id r11-20020aa7d58b000000b004ad7ad3de18mr26993394edq.28.1678556275117;
        Sat, 11 Mar 2023 09:37:55 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id q4-20020a50cc84000000b004bc15a440f1sm1421975edi.78.2023.03.11.09.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:37:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] devfreq: exyos-bus: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:37:53 +0100
Message-Id: <20230311173753.263390-1-krzysztof.kozlowski@linaro.org>
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

  drivers/devfreq/exynos-bus.c:504:34: error: ‘exynos_bus_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/devfreq/exynos-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 027e8f336acc..f7c554051232 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -513,7 +513,7 @@ static struct platform_driver exynos_bus_platdrv = {
 	.driver = {
 		.name	= "exynos-bus",
 		.pm	= &exynos_bus_pm,
-		.of_match_table = of_match_ptr(exynos_bus_of_match),
+		.of_match_table = exynos_bus_of_match,
 	},
 };
 module_platform_driver(exynos_bus_platdrv);
-- 
2.34.1

