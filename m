Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C9F6537FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiLUVHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiLUVHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:07:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9101D2654D;
        Wed, 21 Dec 2022 13:07:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso2480446wms.4;
        Wed, 21 Dec 2022 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVXE/tLR92m2sGWA4Ap2iyUSciCN0CAi8jf/sNy+hqY=;
        b=J45PmuQV/HLwZbSRa1zjfv/tsrzWpuonlqZd6yTp1A6jaZbjVPWCZaZyTqYveMq9q6
         264D8JUg9gWkj+4GOjbq1x1wf5vhTjg3Bda9/RFAqyqh6YuA5hVG0vQv5Qdcf+Z/CA/b
         Qrq+qb2hYkgBCKmGnrWWK2wBqCOzkJAZ3M53R0I4abbQXs3CxH9o+PdQXpuS/5rYyGeH
         moF9ehwTKu/HeN84sg+yA4VEy8SyhYJEp5909w3wSb/3ZI7p6RnK+Y2ZDbLHq8Ojlwzm
         WCBTheS1nGU9FTTxS1uMeP42pkjFNxvK2lkUJjInGvxJuOL0+K7V5HZYAzlUGEnf4iPT
         BMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVXE/tLR92m2sGWA4Ap2iyUSciCN0CAi8jf/sNy+hqY=;
        b=arQ8k18JMCWNIEL1yBdR6rg5VJnEM6RfvDhsWcdtM/ixqaYJXWhjlx1NqW9ycAllFp
         ieTnUazFdgS8k7K7fQpiwdpBLMwN1QkdwCcivfcY+ptPc38tZ+NDL1yJDfH+bfhr4JKt
         KVD1lnkhlZbpKCXKvf18KCa+PD8n7iDDyQnOYicUjUNrmAyuJIRMle42dq6LvYm7rMI5
         5Hnz6m5pibvOFSLpE8VOjQsOvjghy+hcSehvEJcE0KcMd4u09eKl2yK/l7Dm5lcrN7j/
         WDQTPs3vcm6cqeXozMsn2+n5D33J+9V+ktxnoQ3uZBhlSCgIYqXm/+4jEXXAP328Jsjx
         pOzg==
X-Gm-Message-State: AFqh2krNhzgVlC8r1XkLKE0s0uKtjVphahX+CaAXa0ZhYh2pgJeOQqmF
        xKvlVZs/P1txRn63fJUAGPUxC9ADnNXrhA==
X-Google-Smtp-Source: AMrXdXvfbPVNSKTMpgu1wbKyL0z1Y/4/DV/Eb7PMOIvGuhk7PEFn9XlRuloouZwAEemucsMt6AaFMw==
X-Received: by 2002:a7b:c3c6:0:b0:3d2:3376:6f37 with SMTP id t6-20020a7bc3c6000000b003d233766f37mr2633965wmj.10.1671656833130;
        Wed, 21 Dec 2022 13:07:13 -0800 (PST)
Received: from localhost ([176.234.10.188])
        by smtp.gmail.com with UTF8SMTPSA id r9-20020a05600c35c900b003d6b71c0c92sm4911025wmq.45.2022.12.21.13.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 13:07:12 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v5 4/4] MAINTAINERS: Add entries for Apple PWM driver
Date:   Thu, 22 Dec 2022 00:06:48 +0300
Message-Id: <20221221210648.2735-5-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221221210648.2735-1-fnkl.kernel@gmail.com>
References: <20221221210648.2735-1-fnkl.kernel@gmail.com>
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

Add the MAINTAINERS entries for the driver

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 886d3f69ee64..cf773aa53210 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1908,6 +1908,7 @@ F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
+F:	Documentation/devicetree/bindings/pwm/pwm-apple.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/clk/clk-apple-nco.c
@@ -1921,6 +1922,7 @@ F:	drivers/mailbox/apple-mailbox.c
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
+F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
-- 
2.37.1 (Apple Git-137.1)

