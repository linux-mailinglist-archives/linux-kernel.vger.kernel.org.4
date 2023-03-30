Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB7D6D0305
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjC3LXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjC3LXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:23:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791A85266;
        Thu, 30 Mar 2023 04:23:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ek18so75076417edb.6;
        Thu, 30 Mar 2023 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680175431; x=1682767431;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1q/JIvVvnmupFRzfcrQka/eftCvRT4KzrIIH6Gs4Go=;
        b=WolzbQtX6W9/wjMZJjhvikqUrkqfgJMq4nU59Bspr6u5PM7Co71h+QL82spZPm9LQI
         XlITU7GDaFgJTm8kW/2VVHaeMWME+C2cF5KfO2qPuCIiUavvJv2B/KcCsN1DphgsR3mD
         iu6DSldPa6WzvfH6Ld3IZSGfX/bbyfMtHuvhywEeYjUNRIbxwevAEWZPVJ89PGwaVuMh
         9eodU0m50W+ORQQalBKG3nC3Rxj0hOn8x7Lb8uSihieaGlyV/aQziL9Jn1w3vEiHlsr3
         pKdxPXLvsUi3JSM+oano77QbKRFbbF6LzDACEqk3FmLG8esbDqwfLutjJ7hibwDwqjt9
         3Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175431; x=1682767431;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1q/JIvVvnmupFRzfcrQka/eftCvRT4KzrIIH6Gs4Go=;
        b=b2rL4SYcyS/Pbez3sUWZtc+YNQ55fC8XVCowGCMFGcylcfCkcTZ8EoAYJuJAG3HQtd
         oFBP0j5q0WhegT5TLt9uFlz3gQVuPxhKlQB2VEJDGSvUEvl29GWNgK4qpKXkQJwX+WSD
         4/suKzfDLTPCBXpEq/HNqquc8VBDtfy17/dztm81/dwXacWaxOrFyChVnPci0SRL+7zw
         HfYQk0r4YWUxr+7yL+lsM5n5bn/vCngvcsu4DzojgOAQFVvAdbit3+Jv8bhFNaWYZfq4
         1xwgahyr2rgNGWFLD/3babjhK/zb1yR/ZSy+rv5hFofBZ6wEFISaLMnY8oomYDfZXWVV
         TcgA==
X-Gm-Message-State: AAQBX9f/JXkYSUIn8OFA7MN1Ov+VN9i9QSjOk84IIEfudCP/1Ybnvd1z
        ySGG8ki6N4TFfVVka0tZPHM=
X-Google-Smtp-Source: AKy350ZH+9AJl1fJcpFJyxjWu+QfD0quf+8pn5RJ7yfM7i9DnNIHLuUpfwoELKVZ09xUbpJBzhrvpw==
X-Received: by 2002:a17:906:254c:b0:930:27c2:6d8d with SMTP id j12-20020a170906254c00b0093027c26d8dmr22301936ejb.61.1680175430868;
        Thu, 30 Mar 2023 04:23:50 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:b46b:e78:a1d5:4082])
        by smtp.gmail.com with ESMTPSA id c14-20020a509f8e000000b005003fd12eafsm17851210edf.63.2023.03.30.04.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:23:50 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] ARM: sti: remove configs SOC_STIH415 and SOC_STIH416
Date:   Thu, 30 Mar 2023 13:23:46 +0200
Message-Id: <20230330112347.31137-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b4bba92dfbe2 ("drm/sti: remove stih415-416 platform support")
removes the reference to configs SOC_STIH415 and SOC_STIH416 in the
config DRM_STI. Commit 64933513e461 ("reset: sti: Remove STiH415/6 reset
support") removes the two configs STIH41{5,6}_RESET.

With those changes, the two configs SOC_STIH415 and SOC_STIH416 has no
remaining effect. Remove them.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-sti/Kconfig | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index b2d45cf10a3c..8c21dccb61b7 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -26,24 +26,6 @@ menuconfig ARCH_STI
 
 if ARCH_STI
 
-config SOC_STIH415
-	bool "STiH415 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH415 parts, primarily targeted at set-top-box
-	  and other digital audio/video applications using Flattned Device
-	  Trees.
-
-config SOC_STIH416
-	bool "STiH416 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH416 parts, primarily targeted at set-top-box
-	  and other digital audio/video applications using Flattened Device
-	  Trees.
-
 config SOC_STIH407
 	bool "STiH407 STMicroelectronics Consumer Electronics family"
 	default y
-- 
2.17.1

