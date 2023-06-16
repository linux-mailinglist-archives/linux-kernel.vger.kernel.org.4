Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE51F732B01
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbjFPJFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343989AbjFPJE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213FE3586
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE1CA60C5E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D68AC433C8;
        Fri, 16 Jun 2023 09:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686906146;
        bh=liQAyMeBABb3jk++u+GcttTTYo2zoQN5sl4L8LiR7W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cb5Wuf4p9yI0VjVK/YaONawmhznz+7Rimp+gudyxGyAWeWkQKoIV3Ip6CHkjYm6ci
         SoqOhzy9/0kwQikK94Y/NhXGchjI9D/CADjiCK4fSaFkOj2fPubcRZfFu8OFPfsnGE
         5OVYVWWXHOJJZOI1rHnQjt4fi4+ddvzhqBadP2kjC8nqcZ201XiMIscymtApauolaI
         930BQ2v4pdm5L8ahRo4W3Kn8zGIpHuRnzdC58fXQopEwSaxmdvNLQ2UeFIib7szHTy
         6fNdEImZcNX8bIvGhBYV6k4ndgW3kayd+X8OmA7gKNjwRIVDL54P5IDvPfQpSStiDa
         uoz1NcWQUx8mg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yingkun Meng <mengyingkun@loongson.cn>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ASoC: loongson: add PCI dependency
Date:   Fri, 16 Jun 2023 11:00:39 +0200
Message-Id: <20230616090156.2347850-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616090156.2347850-1-arnd@kernel.org>
References: <20230616090156.2347850-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new driver fails to build when PCI is disabled:

WARNING: unmet direct dependencies detected for SND_SOC_LOONGSON_I2S_PCI
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (LOONGARCH || COMPILE_TEST [=y]) && PCI [=n]
  Selected by [y]:
  - SND_SOC_LOONGSON_CARD [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (LOONGARCH || COMPILE_TEST [=y])
sound/soc/loongson/loongson_i2s_pci.c:167:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
module_pci_driver(loongson_i2s_driver);

Add the appropriate Kconfig dependency.

Fixes: d24028606e764 ("ASoC: loongson: Add Loongson ASoC Sound Card Support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/loongson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/loongson/Kconfig b/sound/soc/loongson/Kconfig
index c175f9de19a85..b8d7e2bade246 100644
--- a/sound/soc/loongson/Kconfig
+++ b/sound/soc/loongson/Kconfig
@@ -16,6 +16,7 @@ config SND_SOC_LOONGSON_I2S_PCI
 config SND_SOC_LOONGSON_CARD
 	tristate "Loongson Sound Card Driver"
 	select SND_SOC_LOONGSON_I2S_PCI
+	depends on PCI
 	help
 	  Say Y or M if you want to add support for SoC audio using
 	  loongson I2S controller.
-- 
2.39.2

