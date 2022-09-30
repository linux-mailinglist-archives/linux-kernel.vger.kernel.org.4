Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC55F097B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiI3LGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiI3LGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:06:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F9C1E99
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:43:10 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mf6Bm5rdwz1P74c;
        Fri, 30 Sep 2022 18:38:08 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
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
Subject: [PATCH -next 2/4] ALSA: cs5535audio: Remove unused variable 'loop'
Date:   Fri, 30 Sep 2022 18:38:34 +0800
Message-ID: <20220930103836.104113-3-chenzhongjin@huawei.com>
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

The variable 'loop' is introduced to print log but this commit
'commit a6477134db11 ("ALSA: asihpi: Update debug printing")'
had updated the printing and 'loop' was not printed.

Now the variable is not used by other code. Remove it for code cleaning.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 sound/pci/asihpi/asihpi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 5e1f9f10051b..7041c2cba564 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -725,7 +725,6 @@ static void snd_card_asihpi_timer_function(struct timer_list *t)
 	unsigned int pcm_buf_dma_ofs, min_buf_pos = 0;
 	unsigned int remdata, xfercount, next_jiffies;
 	int first = 1;
-	int loops = 0;
 	u16 state;
 	u32 buffer_size, bytes_avail, samples_played, on_card_bytes;
 	char name[16];
@@ -806,7 +805,6 @@ static void snd_card_asihpi_timer_function(struct timer_list *t)
 			(unsigned long)frames_to_bytes(runtime,
 						runtime->control->appl_ptr)
 		);
-		loops++;
 	}
 	pcm_buf_dma_ofs = min_buf_pos;
 
-- 
2.17.1

