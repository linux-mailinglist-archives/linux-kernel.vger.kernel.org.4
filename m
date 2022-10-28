Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8833D611C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJ1VPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJ1VO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:14:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27292317C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:14:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v28so5621616pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+RiQTpwuN97JRf0F9V4tVIm2v8ZxHlLZa7P/ilnDGY=;
        b=Yj9XXzuUNOrCtA5zzryZJ10G9E2xQzsOg4wGDQ7XvEREUd7J5u5VTSx/QNQIdwbo24
         Q594O7/zX76xEh9Gc0iNGrU4TqZtcazJZ2+Pt0GrlTPqOU1rG0zSAjw8Ls7Qt1TBcVFR
         Wjei+HXIwy07bZT+qPsUiKi1PlGLFN8O2EUOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+RiQTpwuN97JRf0F9V4tVIm2v8ZxHlLZa7P/ilnDGY=;
        b=0wYZMVY51Aa/raO0IMkr5ihkjl0cZAe7rksty0AmIcR9Y7wPAwdhtAmqsOJAxOeSdH
         hjB5b3GHwLSpsjHXmcJfpwS5Jm4NCNqlOTHTmFwOan2WhodfMseWMqRfhCemZggbYzqz
         7VrQHz0nwj8akg4dWIyw1l+bYa6U6AJgGVwylG6q5Pk01mn7Wer6h7iZb4jKk+qQVFNz
         5QkKR2xxS/+Li+0nVRU5dx+vAd5/7geAmczSAGZxg54RSMcPDep3NFhZ+qM/pftS9vgI
         Y1bFE+UsqW6o/RRfNZOo635gygZvLjgtNupsUvHQuEcxtF6JEH+WD5TySIHcIqy8popo
         Va4A==
X-Gm-Message-State: ACrzQf1h+RnkWUK8otbkFux8A/ras9NfOZrxC206EnnghgFVtNgjMQfV
        H0ynS/YvGN0DhRy2z3l/35d5rjID3Kf9wQ==
X-Google-Smtp-Source: AMsMyM5dm4sViGbezswQdxIY0IxcARdKyR1X9ojMOI/nshFvgxzed7XYfToVM/XmU7i9nWrlmuElEQ==
X-Received: by 2002:a63:6f8a:0:b0:439:36bc:89f9 with SMTP id k132-20020a636f8a000000b0043936bc89f9mr1288835pgc.100.1666991694115;
        Fri, 28 Oct 2022 14:14:54 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id e11-20020a170902784b00b001730a1af0fbsm3488563pln.23.2022.10.28.14.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:14:53 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/5] platform/chrome: cros_ec_lpc: Move mec_init/destroy to device probe/remove
Date:   Fri, 28 Oct 2022 14:14:45 -0700
Message-Id: <20221028141411.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disregarding the weird global state hiding in this cros_ec_lpc_mec_*()
stuff, it belongs in device probe/remove. We shouldn't assume we can
access hardware resources when the device isn't attached to the driver.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/platform/chrome/cros_ec_lpc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7677ab3c0ead..0b6c7c912ec7 100644
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
@@ -456,6 +459,8 @@ static int cros_ec_lpc_remove(struct platform_device *pdev)
 
 	cros_ec_unregister(ec_dev);
 
+	cros_ec_lpc_mec_destroy();
+
 	return 0;
 }
 
@@ -586,9 +591,6 @@ static int __init cros_ec_lpc_init(void)
 		return -ENODEV;
 	}
 
-	cros_ec_lpc_mec_init(EC_HOST_CMD_REGION0,
-			     EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE);
-
 	/* Register the driver */
 	ret = platform_driver_register(&cros_ec_lpc_driver);
 	if (ret) {
@@ -615,7 +617,6 @@ static void __exit cros_ec_lpc_exit(void)
 	if (!cros_ec_lpc_acpi_device_found)
 		platform_device_unregister(&cros_ec_lpc_device);
 	platform_driver_unregister(&cros_ec_lpc_driver);
-	cros_ec_lpc_mec_destroy();
 }
 
 module_init(cros_ec_lpc_init);
-- 
2.38.1.273.g43a17bfeac-goog

