Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D869E5BC9FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiISKwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiISKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:52:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C47C559A;
        Mon, 19 Sep 2022 03:46:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t7so46799050wrm.10;
        Mon, 19 Sep 2022 03:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nYkgf7167and0RA6WgS7T9F/ATxyX9JyRvsn4NiAu+k=;
        b=mdhAoxpAfjgULi4cIuZtoqRNkNbQn0RrM6JNNh7HIrFx9o3gP3Si9/jymROsal3dUP
         HwU2PulazsLKTSFKrXBzZqET37nvUFSD95pCscgkKULAHUFSsW0bkr09dnuPXyXUXYsY
         g09DG5+yN54yOk2X38EpFmXbhQP2dV4muqad8H2R77qkw2wvDw4qx0ylU7XcPChwDlbY
         4nZ/WnwrqYZ3WB0wX45FJEmVDTKw/fK28sPfjhIkrBgiAn0NKmg+lKoIbW5IYicHGAEK
         FNpqmFKp8/IqwZ86qRSY2vpsWskrQE4o9IYZAHdUy6A6R0ZuSSVCC/yv02WDqm1wqofe
         iAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nYkgf7167and0RA6WgS7T9F/ATxyX9JyRvsn4NiAu+k=;
        b=WNG7uDz5UJWjOmgOENLHoTa/E5lChMlhhoj39xGtQtOcDtfq4+MjdALffcnyK6wv5v
         6jcBl9ne3Dy4eNZCacHSyVidoM5rNkL0ORUKuiFFwqKpnXuXHIQ3JwTaAXrM6BgkODg2
         58xpLDodGd+ybdAiv76yiC5JsN6il8+wCf1Qetn3Q2ht7RviNaUFNNS6viybfygU1Wdo
         sXZfmyGXgXOuH2/Cb1uWpjygiBhh0f7gHJ5eK6wOzNyyXUP908tM2uFyW+OjyCcEjxCF
         bsbgr6h7Teg7mgrSkdwM2fF4ZrNurdWHgk8Sz4X67QeD96wzw3GhO2G4h+6LycbZwgC/
         nEBg==
X-Gm-Message-State: ACrzQf3MAn8NoKMdK2cnTuuxK75sRpEg6ZceGjzWAj/LipbHODkU+FlK
        DaKFrj0lfO03Du5Dd18zd8GgXtO9FkTZzw==
X-Google-Smtp-Source: AMsMyM4CtTtPpBEfAfEjyWARnB7GtWGPdIEFw21dBbjjaKoO+IVoC78ZNpOCb9oA+FQ9Fd2H6b128g==
X-Received: by 2002:a05:6000:1a8a:b0:22a:43ef:94f0 with SMTP id f10-20020a0560001a8a00b0022a43ef94f0mr10528556wry.279.1663584410583;
        Mon, 19 Sep 2022 03:46:50 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b0022a2bacabbasm13265094wrm.31.2022.09.19.03.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:46:50 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] soc: renesas: Kconfig: Explicitly select GPIOLIB and PINCTRL config under SOC_RENESAS
Date:   Mon, 19 Sep 2022 11:46:06 +0100
Message-Id: <20220919104606.96553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

GPIOLIB and PINCTRL config options are required by all ARM32/ARM64/RISC-V
Renesas SoCs, so instead of selecting them under ARCH_RENESAS for each
architecture just explicitly select them under SOC_RENESAS config option
which will be visible for all the three architectures (if ARCH_RENESAS is
enabled).

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, only when this patch is merged I'll post the patches to drop GPIOLIB
and PINCTRL from [0] and [1] to avoid bisect build failures.

[0] arch/arm64/Kconfig.platforms
[1] arch/arm/mach-shmobile/Kconfig
---
 drivers/soc/renesas/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index f95a1337450d..660498252ec5 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -2,6 +2,8 @@
 menuconfig SOC_RENESAS
 	bool "Renesas SoC driver support" if COMPILE_TEST && !ARCH_RENESAS
 	default y if ARCH_RENESAS
+	select GPIOLIB
+	select PINCTRL
 	select SOC_BUS
 
 if SOC_RENESAS
-- 
2.25.1

