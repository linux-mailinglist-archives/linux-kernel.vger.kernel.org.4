Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538A4632055
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiKULWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiKULVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:21:35 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8EAC1F40
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:16:32 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG4VY4QvJzqSNF;
        Mon, 21 Nov 2022 19:12:37 +0800 (CST)
Received: from huawei.com (10.175.104.82) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 19:16:30 +0800
From:   Baisong Zhong <zhongbaisong@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <zhongbaisong@huawei.com>,
        <tiwai@suse.de>
Subject: [PATCH -next v2] ALSA: seq: fix undefined behavior in bit shift for SNDRV_SEQ_FILTER_USE_EVENT
Date:   Mon, 21 Nov 2022 19:16:30 +0800
Message-ID: <20221121111630.3119259-1-zhongbaisong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

UBSAN: shift-out-of-bounds in sound/core/seq/seq_clientmgr.c:509:22
left shift of 1 by 31 places cannot be represented in type 'int'
...
Call Trace:
 <TASK>
 dump_stack_lvl+0x8d/0xcf
 ubsan_epilogue+0xa/0x44
 __ubsan_handle_shift_out_of_bounds+0x1e7/0x208
 snd_seq_deliver_single_event.constprop.21+0x191/0x2f0
 snd_seq_deliver_event+0x1a2/0x350
 snd_seq_kernel_client_dispatch+0x8b/0xb0
 snd_seq_client_notify_subscription+0x72/0xa0
 snd_seq_ioctl_subscribe_port+0x128/0x160
 snd_seq_kernel_client_ctl+0xce/0xf0
 snd_seq_oss_create_client+0x109/0x15b
 alsa_seq_oss_init+0x11c/0x1aa
 do_one_initcall+0x80/0x440
 kernel_init_freeable+0x370/0x3c3
 kernel_init+0x1b/0x190
 ret_from_fork+0x1f/0x30
 </TASK>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Baisong Zhong <zhongbaisong@huawei.com>
---
v2: update all SNDRV_SEQ_FILTER_* to 1U to keep consistent
---
 include/uapi/sound/asequencer.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index 6d4a2c60808d..00d2703e8fca 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -328,10 +328,10 @@ typedef int __bitwise snd_seq_client_type_t;
 #define	KERNEL_CLIENT	((__force snd_seq_client_type_t) 2)
                         
 	/* event filter flags */
-#define SNDRV_SEQ_FILTER_BROADCAST	(1<<0)	/* accept broadcast messages */
-#define SNDRV_SEQ_FILTER_MULTICAST	(1<<1)	/* accept multicast messages */
-#define SNDRV_SEQ_FILTER_BOUNCE		(1<<2)	/* accept bounce event in error */
-#define SNDRV_SEQ_FILTER_USE_EVENT	(1<<31)	/* use event filter */
+#define SNDRV_SEQ_FILTER_BROADCAST	(1U<<0)	/* accept broadcast messages */
+#define SNDRV_SEQ_FILTER_MULTICAST	(1U<<1)	/* accept multicast messages */
+#define SNDRV_SEQ_FILTER_BOUNCE		(1U<<2)	/* accept bounce event in error */
+#define SNDRV_SEQ_FILTER_USE_EVENT	(1U<<31)	/* use event filter */
 
 struct snd_seq_client_info {
 	int client;			/* client number to inquire */
-- 
2.25.1

