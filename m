Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF7E6AD89C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCGH7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCGH7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:59:34 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64AA1C320;
        Mon,  6 Mar 2023 23:59:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cw28so48839441edb.5;
        Mon, 06 Mar 2023 23:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678175966;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+Y9Z52YiPHnaSorJ0ShCLIJPs0/GkEOaNK/EAR3Yo0=;
        b=kfP3Rb7jwMSeepkzwLSlqbIHw6NvoVCLnUZEj9i3ABxBHxeH7nPFkqc/sk0L9ohVD/
         apKnEUITJaAJxdpk1MM+csnlAWsFWxfjzmUpa3/6QnVz8+h+eiEUXesXP68NmAQFusl1
         yebhjMfN6PRXRi7rB7rtZZtBqt+j6k3pbLvU4yJnW00A+ulcMEiUOiYMKDOI+3jX/3Lt
         TVdMMQjxvdYIj1cNc5mDVnx+wcRAW5aIvjQOVC1f+7ALqwzEkns/gX2KKF9TFIt0yNg3
         sBUzExrMxx/c/c393OkZR/ZMcBjVXZiuCfG7Ud+3mdiTxkuc1wy6t0R30yXim0YUIozd
         sB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678175966;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+Y9Z52YiPHnaSorJ0ShCLIJPs0/GkEOaNK/EAR3Yo0=;
        b=cs+tjv6CtWiSPHQDevOPnmIIzAH3NcbQT1lPZHS0rQDWUMSmUB74f3PjpnO5nk40Mx
         BYVQK4TSgePuxoJB3ENpE9MgbnnIsAI550PFZVw46iaM8XQ4ts/LCMhHOlV14JEYzsyG
         huNvDDIN+a7m7OyTnhjrm5FKWYEbVyANTB5QxHKpxn+oUCE4izhfIsNInGrO1MirJHNb
         eV0Gy84xYcQp0ABaxSkgYCj4uAX2o3//zi6klCj7YbckrIhM31wfSRPs9qEfgXwjIGw3
         vuGPrbBUgRORYFd6ewi069Ge3DUMYjqkJnlZ/jZOt7hXYZJlXXGcQezx5bnmLVcXo0kL
         lchQ==
X-Gm-Message-State: AO0yUKUykXuQmtRAQGBfy/tFnQjVq7458XZdi9L11YOxcWEA9lYjWHFj
        wg5D9+eD0x9TlCVdFvoka/8=
X-Google-Smtp-Source: AK7set/sXv/zV9qT2hF9VPf56TvLOgp4HGqw2pwweMqDEu47UlQbBID2n63AUU3k/X3C+jVz8gBY9A==
X-Received: by 2002:a05:6402:7d3:b0:4b0:87ec:2b98 with SMTP id u19-20020a05640207d300b004b087ec2b98mr14050342edy.16.1678175966185;
        Mon, 06 Mar 2023 23:59:26 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a517:a52e:cdbc:e30d])
        by smtp.gmail.com with ESMTPSA id i24-20020a50d758000000b004ad15d5ef08sm6346045edj.58.2023.03.06.23.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 23:59:25 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arch: sh: remove references to config USB_OHCI_SH
Date:   Tue,  7 Mar 2023 08:59:23 +0100
Message-Id: <20230307075923.28821-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option") left some
references to the config USB_OHCI_SH in ./arch/sh/ around, expecting those
to be removed with the whole SH architecture deletion.

As that did not happen, do minor clean-up instead and remove the references
to the removed config USB_OHCI_SH instead.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Christoph, please ack.

SH architecture maintainers, please pick this minor clean-up patch.

 arch/sh/Kconfig                     | 4 ----
 arch/sh/configs/sh7757lcr_defconfig | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 0665ac0add0b..b95a5ed604d6 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -326,7 +326,6 @@ config CPU_SUBTYPE_SH7720
 	select CPU_SH3
 	select CPU_HAS_DSP
 	select SYS_SUPPORTS_SH_CMT
-	select USB_OHCI_SH if USB_OHCI_HCD
 	select PINCTRL
 	help
 	  Select SH7720 if you have a SH3-DSP SH7720 CPU.
@@ -336,7 +335,6 @@ config CPU_SUBTYPE_SH7721
 	select CPU_SH3
 	select CPU_HAS_DSP
 	select SYS_SUPPORTS_SH_CMT
-	select USB_OHCI_SH if USB_OHCI_HCD
 	help
 	  Select SH7721 if you have a SH3-DSP SH7721 CPU.
 
@@ -425,7 +423,6 @@ config CPU_SUBTYPE_SH7757
 config CPU_SUBTYPE_SH7763
 	bool "Support SH7763 processor"
 	select CPU_SH4A
-	select USB_OHCI_SH if USB_OHCI_HCD
 	help
 	  Select SH7763 if you have a SH4A SH7763(R5S77631) CPU.
 
@@ -451,7 +448,6 @@ config CPU_SUBTYPE_SH7786
 	select CPU_SHX3
 	select CPU_HAS_PTEAEX
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-	select USB_OHCI_SH if USB_OHCI_HCD
 	select USB_EHCI_SH if USB_EHCI_HCD
 	select PINCTRL
 
diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index f10fb730b6f4..cd404818e33f 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -58,7 +58,6 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_SH=y
 CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_SH=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
-- 
2.17.1

