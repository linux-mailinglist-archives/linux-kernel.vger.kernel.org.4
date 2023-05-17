Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8867072DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjEQUTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEQUT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251EE1FE1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE7AA63660
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBD5C433EF;
        Wed, 17 May 2023 20:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684354767;
        bh=EdzQf92843zcKgv2AnlrdWB7ybXMParLomwvT5wdvTA=;
        h=From:To:Cc:Subject:Date:From;
        b=o8RfhU1XwiM4CAiJ0QFug+9ik8R3KZGACA7Wx+uHhMfN39xRyRlqwpjJi89DpSwpO
         VX9j9xoaXhc8yH4Tada7xU5tVfoD6FtPrzaKg44wuGA72Ftmz8HAJF7kD1D7UtS3oq
         raUJ2XTY0FtrhQwZUZm/xjPd8d8vi51p6CR7vtNT13opOO3lfc2yB37eJf7G80dwoc
         T93AJN1xJ1C/5Wu/84SnDlo3xNJUTudwXC4W7bD0AOzY25baHIR0EGkvN79pqLFcgJ
         SBY3OlQJG8emBV+bP9lIYbruMSq340tWyWv7kkvLBo2aLO4xzX915+HY241YC4RzSQ
         7GJ4EeTkIgcOg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: emu10k1: fix 64-bit integer division
Date:   Wed, 17 May 2023 22:19:17 +0200
Message-Id: <20230517201920.592909-1-arnd@kernel.org>
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

Division of 64-bit values causes a link failure on 32-bit targets, depending
on compiler version and target architecture:

ERROR: modpost: "__divdi3" [sound/pci/emu10k1/snd-emu10k1.ko] undefined!
ERROR: modpost: "__udivdi3" [sound/pci/emu10k1/snd-emu10k1.ko] undefined!

Replace these with the safe div_u64() helpers.

Fixes: bb5ceb43b7bf ("ALSA: emu10k1: fix non-zero mixer control defaults in highres mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/emu10k1/emufx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index f64b2b4eb348..7c28789720d1 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1156,7 +1156,7 @@ snd_emu10k1_init_mono_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
 		ctl->max = 0x7fffffff;
 		ctl->tlv = snd_emu10k1_db_linear;
 		ctl->translation = EMU10K1_GPR_TRANSLATION_NEGATE;
-		defval = defval * 0x80000000LL / 100 - 1;
+		defval = div_u64(defval * 0x80000000LL, 100) - 1;
 	} else {
 		ctl->min = 0;
 		ctl->max = 100;
@@ -1178,7 +1178,7 @@ snd_emu10k1_init_stereo_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
 		ctl->max = 0x7fffffff;
 		ctl->tlv = snd_emu10k1_db_linear;
 		ctl->translation = EMU10K1_GPR_TRANSLATION_NEGATE;
-		defval = defval * 0x80000000LL / 100 - 1;
+		defval = div_u64(defval * 0x80000000LL, 100) - 1;
 	} else {
 		ctl->min = 0;
 		ctl->max = 100;
-- 
2.39.2

