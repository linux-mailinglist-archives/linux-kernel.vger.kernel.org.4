Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2398261EB0D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKGGgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKGGgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:36:16 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35C860EC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:36:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VU7DbWG_1667802962;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VU7DbWG_1667802962)
          by smtp.aliyun-inc.com;
          Mon, 07 Nov 2022 14:36:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jayakumar.alsa@gmail.com
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ALSA: cs5535audio: Remove the redundant assignment
Date:   Mon,  7 Nov 2022 14:35:54 +0800
Message-Id: <20221107063554.17933-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'desc_addr' set but not used.

sound/pci/cs5535audio/cs5535audio_pcm.c:113:12: warning: variable 'desc_addr' set but not used.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2739
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/pci/cs5535audio/cs5535audio_pcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index 0db24cc4d916..9c88e99e3750 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -110,7 +110,7 @@ static int cs5535audio_build_dma_packets(struct cs5535audio *cs5535au,
 					 unsigned int period_bytes)
 {
 	unsigned int i;
-	u32 addr, desc_addr, jmpprd_addr;
+	u32 addr, jmpprd_addr;
 	struct cs5535audio_dma_desc *lastdesc;
 
 	if (periods > CS5535AUDIO_MAX_DESCRIPTORS)
@@ -131,14 +131,12 @@ static int cs5535audio_build_dma_packets(struct cs5535audio *cs5535au,
 	/* the u32 cast is okay because in snd*create we successfully told
 	   pci alloc that we're only 32 bit capable so the upper will be 0 */
 	addr = (u32) substream->runtime->dma_addr;
-	desc_addr = (u32) dma->desc_buf.addr;
 	for (i = 0; i < periods; i++) {
 		struct cs5535audio_dma_desc *desc =
 			&((struct cs5535audio_dma_desc *) dma->desc_buf.area)[i];
 		desc->addr = cpu_to_le32(addr);
 		desc->size = cpu_to_le16(period_bytes);
 		desc->ctlreserved = cpu_to_le16(PRD_EOP);
-		desc_addr += sizeof(struct cs5535audio_dma_desc);
 		addr += period_bytes;
 	}
 	/* we reserved one dummy descriptor at the end to do the PRD jump */
-- 
2.20.1.7.g153144c

