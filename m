Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671A65B3276
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIII5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiIII4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:56:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9036113463F;
        Fri,  9 Sep 2022 01:55:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b5so1593277wrr.5;
        Fri, 09 Sep 2022 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fPvofaEf+BM4TxtIyhxZC/zjNI9R8E3LUT46F136ga4=;
        b=LNhiywTDLLHnBcl6OCNDZJVmYpUQQBo5Ipo/XFJKAg6DVnp+YKgrbAyDhqMhVredgr
         pbVU/XS09EffKtsWs1yStnLABtBlZ5Wlyz2RhLmxam/PBYt/Nuc5A2gokC2fC2AK/zyK
         GJgQQoPnfC8xEXFcZ4UzPAJfx3QnYZ57ZID05n1RakRRuMU9Jz+WokxBI+RNcnTGE8fG
         fmk+GehVrfLCf7lLWPA0kgxEaupDmAPyvW/I+shS8facJ9KFNgEnws23ygoNAdnWqFfs
         a4zGMDHcPYVtZjbQtvwCcywmh4+UT6CaUgF5X5P5yOlJ53YYRkcGs+jPMIZvv64lwJOI
         k1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fPvofaEf+BM4TxtIyhxZC/zjNI9R8E3LUT46F136ga4=;
        b=2uCzGuhtvvdrZUmGYbAB/Phpi1i1XUi2c+ROc+uODdDFIZhUffYeXysMEgO8bPCn9X
         hNWDFQWjieY3mF/zRyaux5CDAvG9/WQGsCN2nTR+UJwuDMh4m0gEPxku2ur/pV8bOZ7+
         UsCVDWYW5UI0jKwcBc21/dYYQJkfRS7O6J0W7PCIg+3fzetz29Z1+lAMljEN220JnSAQ
         8SNY57E1/9LULGnVeB8CFCHpjbQzn4L2JDpMwLSHUE/b/u0j4njyGm+WK3xeIW1OAxbs
         zfPumk9Y+c5NSTqOijaeKyYeEtDxgRNRDIC0aQoCXT3wTbEmBfNFv1fvShOYR6Ks6z+a
         673w==
X-Gm-Message-State: ACgBeo3awYN6PPzSl2jw0s0fezuHw+YcLQSpmT39tN3bch+FXZ4mErng
        1PGq/zCTEAG3OAnFeYGFy6I=
X-Google-Smtp-Source: AA6agR5ExbaE+aBChdxYVSD7wVDn3HYcvadDzcUXC1aJvwytLqqWjrNZI76Fxl1SHY9jife9qSYwXA==
X-Received: by 2002:adf:fb0a:0:b0:225:265d:493 with SMTP id c10-20020adffb0a000000b00225265d0493mr7368942wrr.394.1662713720977;
        Fri, 09 Sep 2022 01:55:20 -0700 (PDT)
Received: from felia.fritz.box (200116b8261bf1004cd87416af9987ea.dip.versatel-1u1.de. [2001:16b8:261b:f100:4cd8:7416:af99:87ea])
        by smtp.gmail.com with ESMTPSA id bt9-20020a056000080900b00228e071baadsm1586493wrb.36.2022.09.09.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 01:55:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ppc: select HAVE_PATA_PLATFORM in PPC instead of creating a PPC dependency
Date:   Fri,  9 Sep 2022 10:55:05 +0200
Message-Id: <20220909085505.15536-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cc18e0fea790 ("LIBATA: Add HAVE_PATA_PLATFORM to select
PATA_PLATFORM driver") introduces config HAVE_PATA_PLATFORM, and expects
that all architectures simply select this config when the architecture
supports using the PATA_PLATFORM driver.

This is properly implemented already for all architectures except for the
powerpc architecture. Implement this for powerpc now.

Adjust the config of the powerpc architecture to use the config
HAVE_PATA_PLATFORM and simplify the config PATA_PLATFORM to not mention
any specific architecture anymore.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 drivers/ata/Kconfig  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 39d71d7701bd..2575e21b6e6b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -237,6 +237,7 @@ config PPC
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
 	select HAVE_OPTPROBES
+	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1c9f4fb2595d..ed3547165528 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1103,7 +1103,7 @@ config PATA_PCMCIA
 
 config PATA_PLATFORM
 	tristate "Generic platform device PATA support"
-	depends on EXPERT || PPC || HAVE_PATA_PLATFORM
+	depends on EXPERT || HAVE_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.
-- 
2.17.1

