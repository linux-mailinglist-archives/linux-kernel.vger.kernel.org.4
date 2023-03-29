Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF886CD384
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjC2Hnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2Hns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:43:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F083B1BF0;
        Wed, 29 Mar 2023 00:43:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so59639907edd.5;
        Wed, 29 Mar 2023 00:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680075825;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zen1b21DPAgiDb/JdV+I5PElPjjV3TtfJQRRpDix7ow=;
        b=VWcBQHDq5zsfv16n5zzKQK2Bb9jbHg9fWpBYN+m5ZTpdgnEr1dSDnghFpxYBlR86YR
         Z0nIqNe2KbzrRsnzL4RTCOx8Nu6dDkCTrYXUp7Ax3dXVtjSOK97d9M62bUl1a1d/Ritd
         FuBiHB0fU3X3SnmMEIdq0rHldhdm6Xa/fP7DpyhK9erg8Ll2BFijTKRYSIEJgbOqbi+W
         msnPuQOWDTbsHcE/FMUbKqIXo4KTq2UgDAMw7Z8Pnxat727yTfV7JzzZJ+YaKMmOzyXG
         naFQvNaqxKnh3hdLCT3zF3ibFWYUQUd58MnUOYqeveuVTq2031gCtunCZTPGlZjYjDdp
         Llnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680075825;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zen1b21DPAgiDb/JdV+I5PElPjjV3TtfJQRRpDix7ow=;
        b=hMKWhtnXVwe4H549lo5Ctv8icMI5CZ+FuNlhc1tBK1V/8BvWmXOlc19GG+T/SRSvTF
         apKdH1qNtwqv9qALi/AJH76ExuAMjuA0n46dZAz8uBefQmBVTKuF+TnVd/UH+uFV80er
         l7iJSOy1carN8HpcDKoicqwW4+u7RRwOB3kSnWr7RcGqh/AniU+Af3ajG2uiFJPUTXGY
         lriKQCwGUBlfyc5uP6E9j23XQ9qGvExoLn+5M+77VKrqHKjn/+RAqV2LJmWbc8oZjY7G
         OtV9+kKhoDnMi8dUX7+TNuoSB/aKW5yKtyTFo6rDwa3yUqIoitkP+GUJEoecU0dXTqtB
         qMJA==
X-Gm-Message-State: AAQBX9fX501/ET7ssNk2244IPGHoi0FCeKyIDqgIuTqjZJiv+nnZ+lxi
        O6Av31x7/4uJswidqC0DajDyHq6OYgqOtA==
X-Google-Smtp-Source: AKy350aAeHiFEjneLz2C3Z9n2ta/6jYIS3jFLR+7PWfmWLf42OYc8VTUgL1n1frOQb8xXiyywsfVcA==
X-Received: by 2002:aa7:dcca:0:b0:4fe:97a2:4b86 with SMTP id w10-20020aa7dcca000000b004fe97a24b86mr18390243edu.8.1680075825090;
        Wed, 29 Mar 2023 00:43:45 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:d1ab:705f:18f7:3e0a])
        by smtp.gmail.com with ESMTPSA id f11-20020a50a6cb000000b00501c96564b5sm12816618edc.93.2023.03.29.00.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:43:44 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] staging: vme: clean up duplicate definitions of dependencies
Date:   Wed, 29 Mar 2023 09:43:42 +0200
Message-Id: <20230329074342.27595-1-lukas.bulwahn@gmail.com>
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

The file staging/vme_user/Kconfig is only included by the top-level
staging/Kconfig if STAGING is enabled. So, there is no need to mention the
dependency on STAGING within the vme_user Kconfig file. Further, the config
VME_USER is already within the "if VME_BUS" block, so there is no need to
mention the dependency on VME_BUS.

Clean up these duplications of dependencies. No semantic change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/staging/vme_user/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/Kconfig b/drivers/staging/vme_user/Kconfig
index c8eabf8f40f1..d65cc5510649 100644
--- a/drivers/staging/vme_user/Kconfig
+++ b/drivers/staging/vme_user/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig VME_BUS
 	bool "VME bridge support"
-	depends on STAGING && PCI
+	depends on PCI
 	help
 	  If you say Y here you get support for the VME bridge Framework.
 
@@ -28,7 +28,6 @@ comment "VME Device Drivers"
 
 config VME_USER
 	tristate "VME user space access driver"
-	depends on STAGING && VME_BUS
 	help
 	  If you say Y here you want to be able to access a limited number of
 	  VME windows in a manner at least semi-compatible with the interface
-- 
2.17.1

