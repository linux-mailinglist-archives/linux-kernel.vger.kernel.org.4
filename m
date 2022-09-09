Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895A25B32D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiIIJEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiIIJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:04:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AF3135D40;
        Fri,  9 Sep 2022 02:03:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 29so1539644edv.2;
        Fri, 09 Sep 2022 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fPvofaEf+BM4TxtIyhxZC/zjNI9R8E3LUT46F136ga4=;
        b=gCi4wThsDw2SiO9HtZ66oTW9uZhXcdn97NW5t0PaoJA3ywVSt/1jNG/dK9WECFY7nV
         ZVkcs573BdAeVmp88LpIA6tUQOI4Rny21x1CQ/ZHE7IzIE5psixmp1I6xEWoRO4+r6qm
         ZnYxwYCtxzVOc5q90LlglqbO5gBz+48WtGuuzN3A7GlrPjoE5vDQMV5D4/jeI/qKBpjF
         hN6TmkwcRGMWAr3Abn1th5TSWCJ6FRMvrhyd+Upeg8KZch5AgcWGc1D+ejqdpDrSWp9e
         0hMu0RMPbFQ3p/YcLfOrd+yOxifHraoD7p7WjuYQAw5epldUhjlFaE+sdZ8GZuld62jv
         LpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fPvofaEf+BM4TxtIyhxZC/zjNI9R8E3LUT46F136ga4=;
        b=iFVK6S9skbGy7hPi87wVhmjjU4xcD2tQpqc8O30VVcFYj48AHADsi7nXvNYN8mXIEw
         dWhpvYaf52gXOKxUOw03k+36DkmzwOrsa2dXrd7bqTGlGJU0Xxq6IEdcy6ixH6oS0mo2
         feN7/JY5ldGaygqFyjPx+gJmKeHJuP88CSkWBnTQLeF894/tEk65BEwA2Eu+ZXKEEk0K
         OQ9hF63Y2UvvBH3M7rew1RNe4s+pPIuNz5qbV+0xjX8pLGqymJy2dampVSB2MMlTBxQH
         Ra1o9031eVdRtbh9822QSyZepKR7ZER/s8gwRUvjEw3OsfVg1s/D8WDpwAuwVicU5aNA
         8x9Q==
X-Gm-Message-State: ACgBeo1VPpAlwOaLJjBV7Oeu70ZqvlUhW8MAVUN8zrLiGJqIMQ166yNU
        f4cZaGYECSdqz0J1w5jkkNc=
X-Google-Smtp-Source: AA6agR68k43p1C9q+JY9fKXpGyzpa5QMGfmsPE3cdpyJf67DgjNwPcmF5UhGm3vXivDmWFaeVEOIJw==
X-Received: by 2002:a05:6402:450c:b0:443:6279:774f with SMTP id ez12-20020a056402450c00b004436279774fmr10702921edb.11.1662714231621;
        Fri, 09 Sep 2022 02:03:51 -0700 (PDT)
Received: from felia.fritz.box (200116b8261bf1004cd87416af9987ea.dip.versatel-1u1.de. [2001:16b8:261b:f100:4cd8:7416:af99:87ea])
        by smtp.gmail.com with ESMTPSA id nb3-20020a1709071c8300b007303fe58eb2sm659797ejc.154.2022.09.09.02.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:03:50 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] powerpc: select HAVE_PATA_PLATFORM in PPC instead of creating a PPC dependency
Date:   Fri,  9 Sep 2022 11:03:42 +0200
Message-Id: <20220909090343.21886-1-lukas.bulwahn@gmail.com>
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

