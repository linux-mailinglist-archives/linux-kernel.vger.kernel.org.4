Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E672631EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiKULAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKULAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:00:48 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E921FA13E1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:00:46 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NG4971nXczFqTk;
        Mon, 21 Nov 2022 18:57:31 +0800 (CST)
Received: from huawei.com (10.175.104.82) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 19:00:44 +0800
From:   Baisong Zhong <zhongbaisong@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <zhongbaisong@huawei.com>,
        <tiwai@suse.de>
Subject: [PATCH -next v2] ALSA: pcm: fix undefined behavior in bit shift for SNDRV_PCM_RATE_KNOT
Date:   Mon, 21 Nov 2022 19:00:44 +0800
Message-ID: <20221121110044.3115686-1-zhongbaisong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined, so changing
significant bit to unsigned. The UBSAN warning calltrace like below:

UBSAN: shift-out-of-bounds in sound/core/pcm_native.c:2676:21
left shift of 1 by 31 places cannot be represented in type 'int'
...
Call Trace:
 <TASK>
 dump_stack_lvl+0x8d/0xcf
 ubsan_epilogue+0xa/0x44
 __ubsan_handle_shift_out_of_bounds+0x1e7/0x208
 snd_pcm_open_substream+0x9f0/0xa90
 snd_pcm_oss_open.part.26+0x313/0x670
 snd_pcm_oss_open+0x30/0x40
 soundcore_open+0x18b/0x2e0
 chrdev_open+0xe2/0x270
 do_dentry_open+0x2f7/0x620
 path_openat+0xd66/0xe70
 do_filp_open+0xe3/0x170
 do_sys_openat2+0x357/0x4a0
 do_sys_open+0x87/0xd0
 do_syscall_64+0x34/0x80

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Baisong Zhong <zhongbaisong@huawei.com>
---
v2: update all SNDRV_PCM_RATE_* to 1U to keep consistent
--
 include/sound/pcm.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 7b1a022910e8..27040b472a4f 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -106,24 +106,24 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_POS_XRUN		((snd_pcm_uframes_t)-1)
 
 /* If you change this don't forget to change rates[] table in pcm_native.c */
-#define SNDRV_PCM_RATE_5512		(1<<0)		/* 5512Hz */
-#define SNDRV_PCM_RATE_8000		(1<<1)		/* 8000Hz */
-#define SNDRV_PCM_RATE_11025		(1<<2)		/* 11025Hz */
-#define SNDRV_PCM_RATE_16000		(1<<3)		/* 16000Hz */
-#define SNDRV_PCM_RATE_22050		(1<<4)		/* 22050Hz */
-#define SNDRV_PCM_RATE_32000		(1<<5)		/* 32000Hz */
-#define SNDRV_PCM_RATE_44100		(1<<6)		/* 44100Hz */
-#define SNDRV_PCM_RATE_48000		(1<<7)		/* 48000Hz */
-#define SNDRV_PCM_RATE_64000		(1<<8)		/* 64000Hz */
-#define SNDRV_PCM_RATE_88200		(1<<9)		/* 88200Hz */
-#define SNDRV_PCM_RATE_96000		(1<<10)		/* 96000Hz */
-#define SNDRV_PCM_RATE_176400		(1<<11)		/* 176400Hz */
-#define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
-#define SNDRV_PCM_RATE_352800		(1<<13)		/* 352800Hz */
-#define SNDRV_PCM_RATE_384000		(1<<14)		/* 384000Hz */
-
-#define SNDRV_PCM_RATE_CONTINUOUS	(1<<30)		/* continuous range */
-#define SNDRV_PCM_RATE_KNOT		(1<<31)		/* supports more non-continuos rates */
+#define SNDRV_PCM_RATE_5512		(1U<<0)		/* 5512Hz */
+#define SNDRV_PCM_RATE_8000		(1U<<1)		/* 8000Hz */
+#define SNDRV_PCM_RATE_11025		(1U<<2)		/* 11025Hz */
+#define SNDRV_PCM_RATE_16000		(1U<<3)		/* 16000Hz */
+#define SNDRV_PCM_RATE_22050		(1U<<4)		/* 22050Hz */
+#define SNDRV_PCM_RATE_32000		(1U<<5)		/* 32000Hz */
+#define SNDRV_PCM_RATE_44100		(1U<<6)		/* 44100Hz */
+#define SNDRV_PCM_RATE_48000		(1U<<7)		/* 48000Hz */
+#define SNDRV_PCM_RATE_64000		(1U<<8)		/* 64000Hz */
+#define SNDRV_PCM_RATE_88200		(1U<<9)		/* 88200Hz */
+#define SNDRV_PCM_RATE_96000		(1U<<10)	/* 96000Hz */
+#define SNDRV_PCM_RATE_176400		(1U<<11)	/* 176400Hz */
+#define SNDRV_PCM_RATE_192000		(1U<<12)	/* 192000Hz */
+#define SNDRV_PCM_RATE_352800		(1U<<13)	/* 352800Hz */
+#define SNDRV_PCM_RATE_384000		(1U<<14)	/* 384000Hz */
+
+#define SNDRV_PCM_RATE_CONTINUOUS	(1U<<30)	/* continuous range */
+#define SNDRV_PCM_RATE_KNOT		(1U<<31)	/* supports more non-continuos rates */
 
 #define SNDRV_PCM_RATE_8000_44100	(SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_11025|\
 					 SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_22050|\
-- 
2.25.1

