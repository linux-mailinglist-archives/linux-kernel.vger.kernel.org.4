Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7918B6154E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKAWWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKAWWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:22:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D2619C13
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:22:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b185so14742229pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R2mYasaks6aptBfsPPyIC9J85cwXhD99E7+c00DwPbA=;
        b=Ajojwm8aTq5a5qEgs5TEi16nesN2y4q0kWSF7HGc3uXuKHbEjEOkTGVewj2Gmoepsc
         8ntCNEufJHV8rY5YDEU3A6r/uN6PFBK/3pq4VVWumLluDO1VWMXbCMBDvfbEPcIn/DOz
         B6idaltMm4ZGPq7Mji80bHMyTPfYZUjClWXWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2mYasaks6aptBfsPPyIC9J85cwXhD99E7+c00DwPbA=;
        b=3XWr5nY9h283iKKL4YlPxKxk6aEX+zdkzNSD4+0eviHm9rYSwfSSy3utO+xwYSgLnK
         uUC2Ax937GMByLqRt4BdJd7SEFmpaA7cqtD5TisXIItGgbR33PzNJvXM38CEopy180F6
         1Jj7AVteMdjFnQLFGj2as+8r66EWNTcYOEUAkfT7plKBShiW2X0bJGRtP4Vx7IBp7Q23
         4AMssknSpBssLH4hn1h+i1rLUePOQ30Ck4e/6/lRD+SwHNTA5KVpZHQJwLL3tRfQbZlw
         Nte2+L3UuujnsvmVigoqd2/pFlUxU5PVISEIl6fSyFBsPCqfMOg9fgOxiFem0blRkzmT
         rUFA==
X-Gm-Message-State: ACrzQf2v5oC6lh67SSYe+RLDy/z/nonMwFR3FECqE1v7mglgj3wQdywY
        r1DuUQrwFyojc7qhS34wQLlJ1w==
X-Google-Smtp-Source: AMsMyM7z44U0WddjC7xZsKVbzAMfSn71Yqn/mU5tK6PR+vCLItR7s0tYh5Xrc+NUSoTYfVDlvmmr0w==
X-Received: by 2002:a05:6a00:1706:b0:56d:3028:23f0 with SMTP id h6-20020a056a00170600b0056d302823f0mr18245554pfc.59.1667341369540;
        Tue, 01 Nov 2022 15:22:49 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:9c5f:7c8e:b8a2:3495])
        by smtp.gmail.com with UTF8SMTPSA id f13-20020a170902f38d00b0017b264a2d4asm6862730ple.44.2022.11.01.15.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 15:22:49 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/5] platform/chrome: cros_ec_lpc: Move mec_init to device probe
Date:   Tue,  1 Nov 2022 15:22:06 -0700
Message-Id: <20221101152132.v2.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disregarding the weird global state hiding in this cros_ec_lpc_mec_*()
stuff, it belongs in device probe. We shouldn't assume we can access
hardware resources when the device isn't attached to the driver.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - drop cros_ec_lpc_mec_destroy() (removed in -next; was done wrong in
   my v1 anyway)

 drivers/platform/chrome/cros_ec_lpc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 6ef5e5d40ba4..48302183d62e 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -354,6 +354,9 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
+	cros_ec_lpc_mec_init(EC_HOST_CMD_REGION0,
+			     EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE);
+
 	/*
 	 * Read the mapped ID twice, the first one is assuming the
 	 * EC is a Microchip Embedded Controller (MEC) variant, if the
@@ -586,9 +589,6 @@ static int __init cros_ec_lpc_init(void)
 		return -ENODEV;
 	}
 
-	cros_ec_lpc_mec_init(EC_HOST_CMD_REGION0,
-			     EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE);
-
 	/* Register the driver */
 	ret = platform_driver_register(&cros_ec_lpc_driver);
 	if (ret) {
-- 
2.38.1.273.g43a17bfeac-goog

