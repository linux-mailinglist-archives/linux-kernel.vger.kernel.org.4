Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E21B6596E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiL3Jm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiL3JmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:42:24 -0500
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Dec 2022 01:42:23 PST
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7B71A3BB
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:42:23 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id B43AE2F20227; Fri, 30 Dec 2022 09:35:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from nickel-ws.ipa.basealt.ru (unknown [85.140.7.15])
        by air.basealt.ru (Postfix) with ESMTPSA id B0D592F20226;
        Fri, 30 Dec 2022 09:35:55 +0000 (UTC)
From:   nickel@altlinux.org
To:     linux-kernel@vger.kernel.org
Cc:     Nikolai Kostrigin <nickel@altlinux.org>,
        Oleg Obidin <obidinog@basealt.ru>
Subject: [PATCH] Revert "ASoC: soc-pcm: Don't zero TDM masks in __soc_pcm_open()"
Date:   Fri, 30 Dec 2022 12:30:53 +0300
Message-Id: <20221230093454.468857-2-nickel@altlinux.org>
X-Mailer: git-send-email 2.33.5
In-Reply-To: <20221230093454.468857-1-nickel@altlinux.org>
References: <20221230093454.468857-1-nickel@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kostrigin <nickel@altlinux.org>

This reverts commit c34db0d6b88b1da95e7ab3353e674f4f574cccee.

Sudden sound disappearance was reported for some laptops, e.g.
Acer Swift 3 SF314-59-78UR 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz

lspci
0000:00:1f.3 Multimedia audio controller: Intel Corporation Tiger Lake-LP Smart Sound Technology Audio Controller (rev 20)
        Subsystem: Acer Incorporated [ALI] Device 148c
        Flags: bus master, fast devsel, latency 32, IRQ 197, IOMMU group 12
        Memory at 601f270000 (64-bit, non-prefetchable) [size=16K]
        Memory at 601f000000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: [50] Power Management version 3
        Capabilities: [80] Vendor Specific Information: Len=14 <?>
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Kernel driver in use: sof-audio-pci

Bisection revealed the commit being reverted.

Reported-by: Oleg Obidin <obidinog@basealt.ru>
Link: https://bugzilla.altlinux.org/44690
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216861
Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>
---
 sound/soc/soc-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0e2261ee07b67..8b8a9aca2912f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -723,6 +723,11 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		ret = snd_soc_dai_startup(dai, substream);
 		if (ret < 0)
 			goto err;
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			dai->tx_mask = 0;
+		else
+			dai->rx_mask = 0;
 	}
 
 	/* Dynamic PCM DAI links compat checks use dynamic capabilities */
-- 
2.33.5

