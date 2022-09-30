Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E5A5F097C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiI3LGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiI3LGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:06:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5510C10EEE0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:43:10 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mf6DK3j4kzpVML;
        Fri, 30 Sep 2022 18:39:29 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:42:27 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:42:27 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <jayakumar.alsa@gmail.com>,
        <chenzhongjin@huawei.com>, <wangjianli@cdjrlc.com>
Subject: [PATCH -next 4/4] ALSA: cs5535audio: Remove unused variable 'desc_addr'
Date:   Fri, 30 Sep 2022 18:38:36 +0800
Message-ID: <20220930103836.104113-5-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930103836.104113-1-chenzhongjin@huawei.com>
References: <20220930103836.104113-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by Clang [-Wunused-but-set-variable]

The variable 'desc_addr' is introduced in this commit
'commit 9b4ffa48ae85 ("[ALSA] Add support for the CS5535 Audio device")'

However, since introduced it was just iterated and never been used.
Remove it for code cleaning.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
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
2.17.1

