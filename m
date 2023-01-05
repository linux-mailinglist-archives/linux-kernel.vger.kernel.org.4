Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54B65EDB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjAENrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjAENrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A73E0F7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:47:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ADB361A8A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615CDC433EF;
        Thu,  5 Jan 2023 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926438;
        bh=q5fQna0b2+wUwPltDmolUYGF06HuBjRD0D0iAWYomeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OP6AjCLpRBdGcAkjcJuoGvOwpNugnKKQFzn0iNMsnw2NzypoLleV9nENGgeSe29E0
         v0YprYjXsoOHTxZC0shUxalBcXBvaQWxRp3CbtpycvQwoEGCXGZcCwaqpg3zJcBh7M
         JFQC7LMBW5LFEhwt7EE9Yrql7Rz/EaEJY7TTcnhcZnRU7piNOH2twIQywYBkH3snhB
         rQ4KvNMQAMe8Hasyxo4JyuKKI3rSIHnfs9eZkXQtFFymdC7uZDuZDTCG+XQK5WmfC8
         kMiPrPn5+URPRVOTqBkigc6R1jUHUChA5GFKm4RsYhCH8SOn6ONFTOS5FOQ77utabk
         34B2mrnox9Q6w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH 14/27] ASoC: PXA: make SND_PXA2XX_SOC_AC97 user-selectable
Date:   Thu,  5 Jan 2023 14:46:09 +0100
Message-Id: <20230105134622.254560-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When building a PXA kernel without legacy board file support,
the AC97 code is not built, so none of the AC97 drivers
can be used.

Add a Kconfig prompt to let users turn it on, and have it
enabled by default.

Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index a045693d5bc2..2036d368c08d 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -16,7 +16,10 @@ config SND_PXA2XX_AC97
 	tristate
 
 config SND_PXA2XX_SOC_AC97
-	tristate
+	tristate "SoC AC97 support for PXA2xx"
+	depends on SND_PXA2XX_SOC
+	depends on AC97_BUS=n
+	default y
 	select AC97_BUS_NEW
 	select SND_PXA2XX_LIB
 	select SND_PXA2XX_LIB_AC97
-- 
2.39.0

