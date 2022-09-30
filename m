Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7025F0976
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiI3LGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiI3LGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:06:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115FFE4D84
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:43:09 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mf6B96s3RzHtqt;
        Fri, 30 Sep 2022 18:37:37 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
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
Subject: [PATCH -next 1/4] ALSA: rawmidi: Remove unused variable 'dest_frames'
Date:   Fri, 30 Sep 2022 18:38:33 +0800
Message-ID: <20220930103836.104113-2-chenzhongjin@huawei.com>
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

'commit 08fdced60ca0 ("ALSA: rawmidi: Add framing mode")'
This commit introduced the variable 'dest_frames'.
However this variable was never used except iterates itself.

It seems that it's some undeleted debug code. Remove it for code
cleaning.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 sound/core/rawmidi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 6963d5a487b3..3cd944386e51 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1050,7 +1050,6 @@ static int receive_with_tstamp_framing(struct snd_rawmidi_substream *substream,
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 	struct snd_rawmidi_framing_tstamp *dest_ptr;
 	struct snd_rawmidi_framing_tstamp frame = { .tv_sec = tstamp->tv_sec, .tv_nsec = tstamp->tv_nsec };
-	int dest_frames = 0;
 	int orig_count = src_count;
 	int frame_size = sizeof(struct snd_rawmidi_framing_tstamp);
 
@@ -1077,7 +1076,6 @@ static int receive_with_tstamp_framing(struct snd_rawmidi_substream *substream,
 		runtime->avail += frame_size;
 		runtime->hw_ptr += frame_size;
 		runtime->hw_ptr %= runtime->buffer_size;
-		dest_frames++;
 	}
 	return orig_count - src_count;
 }
-- 
2.17.1

