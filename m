Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C7E7057EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEPTu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEPTuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6715913E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A6262D8A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167C8C433D2;
        Tue, 16 May 2023 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266653;
        bh=vrJbb+thE3XsnqrA0f75v2in+7O7pevNPGynZ++e5hM=;
        h=From:To:Cc:Subject:Date:From;
        b=nh1LnlD0t0THNvDVMhBt7li9Log+fQWxVGvdJw/NtuM/fsAVOhoizufYtKFp70Mv6
         OoME9qlmwvFOZfroTn2r4GWypEvnRlAwMgEH/meA+3CNQl5CD9kubIgjl6K+GqRlBF
         JJCVNjIVvtPOMwOKQ+mHHu7XBX27qnk3gYqKoODkd2tsXwAA5NWSqn5Ya9RSEXCS2f
         tRKQ1aYIduQQmX9VKVJfy5wxQz0gthaWwe0PgijCmxmMNiT6+9zp4bIYroh/NF/z/R
         RHbaUT1SsDDr1M9OM0HbRx01n1wFvhmGyVEjiPJlITKOYHhj/buYg6FCbFMO3KlDMt
         nEog8AHZhFr3Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ALSA: cs46xx: mark snd_cs46xx_download_image as static
Date:   Tue, 16 May 2023 21:50:41 +0200
Message-Id: <20230516195046.550584-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

snd_cs46xx_download_image() was originally called from dsp_spos.c, but
is now local to cs46xx_lib.c. Mark it as 'static' to avoid a warning
about it lacking a declaration, and '__maybe_unused' to avoid a warning
about it being unused when CONFIG_SND_CS46XX_NEW_DSP is disabled:

sound/pci/cs46xx/cs46xx_lib.c:534:5: error: no previous prototype for 'snd_cs46xx_download_image'

Fixes: 89f157d9e6bf ("[ALSA] cs46xx - Fix PM resume")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/cs46xx/cs46xx_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 62f45847b351..7d882b33d45e 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -531,7 +531,7 @@ static int load_firmware(struct snd_cs46xx *chip)
 	return err;
 }
 
-int snd_cs46xx_download_image(struct snd_cs46xx *chip)
+static __maybe_unused int snd_cs46xx_download_image(struct snd_cs46xx *chip)
 {
 	int idx, err;
 	unsigned int offset = 0;
-- 
2.39.2

