Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481B062F8E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbiKRPI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241919AbiKRPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:08:23 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0880DFEC;
        Fri, 18 Nov 2022 07:08:23 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so13626372ejb.13;
        Fri, 18 Nov 2022 07:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdqh9YA+MhmY9AWakdlstPc1vjDRWuP7pAaTUtiPxkI=;
        b=fez+aDmJDZYmbs2LqdmHSEtslrHqre28p6iIqEBKm9o3dOhfkeMxq5xxIpJGB5zzmc
         ovu8Xe82seq3l5LDcZKEs2+Np9X2sGfUtxlXRS/7wIkWp1BP0yX/0PUdFX9D5fdNZoNj
         +sb/MPzNUOhwIECZVJwhTIJa9o2T6QWyP7k+F8pT406BXWP79gcxcaoQ+sW8y2Mt2Vab
         jyCk7FWW5SPcwsPQQJJNwQdGS1u+dCp7bDygHT6TaeH7vWZSt1qdnFlY6ek5hh3mlfrc
         rzlTRzbL+q/+uwil4Wts7WkHKB/UI9AxjF2WBQqMdcPlI6YEKF+7qyDMj6yp2ZcPB8ol
         V0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tdqh9YA+MhmY9AWakdlstPc1vjDRWuP7pAaTUtiPxkI=;
        b=J4n16qD0Fvs2/OTauZ92Xr8bgjcdSOWBLoCIR9z8KD7/B0Ros4tgruSkfFRXikzYQm
         WEZDGCLCZeByXNmOb2bz3pk6H/FMGP1j7aTlB9HarPQ7IgDGQ3XyxS3psoeomCHoHa7k
         DOfC8H8Ob22cwSFIQkRw4Y9FMrwO2ouqJ68v8nE4vCjRluOF2Mjy6ZBGoVHLEqPxwGqI
         g5D/wnXUURBu46WyQpaJ76SCazTExBQrc87/xJsDHNuF1QEZYOF2t5lcFX02UCrcNhrp
         YCDd4TMx/WuZcBhYsVmhgqpOt8ycDq2ggLLNCevZmbYrpnzlNtcWA1ZiiJe10+lMMDXc
         OyNA==
X-Gm-Message-State: ANoB5pmTAfnMmecfX2vKjd86XVHiisquPiGggqcCK7BQJvbTCau25+qE
        pfL/ysnepxP/dEiqhZKae48=
X-Google-Smtp-Source: AA0mqf5IPeyHU5PWju6zO5tsVwG7ZTgFYfKRmNhsVpkqdsVMz3M+PoNjepbCkjI1Q/mUoz9ZPxnYQA==
X-Received: by 2002:a17:906:3784:b0:7aa:ffd0:b738 with SMTP id n4-20020a170906378400b007aaffd0b738mr6505908ejc.122.1668784101412;
        Fri, 18 Nov 2022 07:08:21 -0800 (PST)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090631d700b0078d9cd0d2d6sm1816951ejf.11.2022.11.18.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 07:08:21 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH] watchdog: dw_wdt: stop on reboot
Date:   Fri, 18 Nov 2022 17:08:09 +0200
Message-Id: <20221118150809.102505-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HW running watchdogs are just watchdogs that are enabled before the
Linux driver is probed, usually by the bootloader (eg. U-Boot).

When the system is shutting down, the mechanism for keeping a HW running
watchdog pinged is also stopped, but the watchdog itself is not stopped,
causing a reset, and preventing the system from being shut down.

Opt into stopping watchdogs on reboot.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/watchdog/dw_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 52962e8d11a6..462f15bd5ffa 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -663,6 +663,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dw_wdt);
 
 	watchdog_set_restart_priority(wdd, 128);
+	watchdog_stop_on_reboot(wdd);
 
 	ret = watchdog_register_device(wdd);
 	if (ret)
-- 
2.38.1

