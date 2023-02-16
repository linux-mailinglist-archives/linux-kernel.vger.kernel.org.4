Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A5669945B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBPMa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjBPMaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:30:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D721B2B0AC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:30:18 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso4034997wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4HpK3cjUVPs02UtjGQEhBq3wtY5D4vf0Bk162oyCpw=;
        b=FFhdQDlfID6RCMnrwS+WdPOUkO2Q9eD6wGx4D4o3fxTBwo7l/rVY4dErohjDJ7jum7
         /WL9jo2GSlkFepo8JT256xI3EK1r2fnxZhicPgAd1wT7rGNWJOnFXPg07lg/Ro+kVvob
         l2jelsx8lSF7EEoOGJPEDdIOzs5QMYFJ3UUkrIt85oBNfPb/IVOHM5xPI52pgdHjsZxL
         zMMhiCwXYsWGT9+/CGoFuCSnpVaNbwvm8de3Pq2HC3pRCGY+vCqqCppeH85WmvLbL4Zq
         RjuHNDvb9icCl5/5k7stcPWhR6oAZ/rtxFjVYwZQh9DNn65/35Tm3aUFjbzUMMXB6mYC
         41aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4HpK3cjUVPs02UtjGQEhBq3wtY5D4vf0Bk162oyCpw=;
        b=0tUDX2R9k4LGESSBfSFb1ogmmE4Vs874hTeMyBpc5QNlEx5KkivvKu90NRSGZiwob/
         UIKDhVbEy++DpF4qpDCoSF5mnxxl1e6v7MR2WJPUyGhvWGKj7IA3xPIogJwlc60D1QZX
         +vjoBH2WfURhR0kAwBIAWB711GPcDU4xfJEegXCFB2U3c8QS6X7FoaUUHtPy3oxN5WCm
         QJi4+4U/D/8GslyUv1ot1TcH6YKrIpnfQlNP9EGv2TjpbJPv/u4PIII4NpzSLeUt7e6t
         GJAzxO322cM/I+x8THvZFpf8vNf5c7GISFy1sK4JCrpuwiyekQPbCFkgVXkPikXICcqo
         PAQw==
X-Gm-Message-State: AO0yUKUz1uOlJHR3elw/UfspRzWBhrSqdAxwDwtcxBhXSQNKGLcav3Hh
        dgCP+v5Hf2qqA4RzD3cidAY/2tEg1Ag1Tse8
X-Google-Smtp-Source: AK7set9qAKB6cOlrTi4kiYnTrQ5aJrcyakUvHs+g9QJ6iS0wpxXElr2KKcnCqc0QLVWRF+qh9FYdIQ==
X-Received: by 2002:a05:600c:997:b0:3dc:5b88:e6dd with SMTP id w23-20020a05600c099700b003dc5b88e6ddmr5280342wmp.10.1676550617367;
        Thu, 16 Feb 2023 04:30:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id u1-20020a7bc041000000b003d1d5a83b2esm5237739wmc.35.2023.02.16.04.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:30:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] spi: spidev: drop the incorrect notice from Kconfig
Date:   Thu, 16 Feb 2023 13:30:14 +0100
Message-Id: <20230216123014.110541-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The spidev interface has been de-facto stable for many years. This notice
has been unchanged since 2007 and is incorrect so remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3b1c0878bb85..2a2ac3aa13c9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1166,9 +1166,6 @@ config SPI_SPIDEV
 	help
 	  This supports user mode SPI protocol drivers.
 
-	  Note that this application programming interface is EXPERIMENTAL
-	  and hence SUBJECT TO CHANGE WITHOUT NOTICE while it stabilizes.
-
 config SPI_LOOPBACK_TEST
 	tristate "spi loopback test framework support"
 	depends on m
-- 
2.37.2

