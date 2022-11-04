Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E17619222
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKDHl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKDHl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:41:56 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33217286E4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:41:53 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id 2A47epYA004466
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 4 Nov 2022 15:40:51 +0800 (CST)
        (envelope-from Zhiguo.Niu@unisoc.com)
Received: from bj08434pcu.spreadtrum.com (10.0.74.109) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 4 Nov 2022 15:40:51 +0800
From:   "zhiguo.niu" <zhiguo.niu@unisoc.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>
Subject: [PATCH] f2fs: fix atgc bug on issue in 32bits platform
Date:   Fri, 4 Nov 2022 15:40:21 +0800
Message-ID: <1667547621-26175-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.109]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 2A47epYA004466
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

There is bug on issue after atgc feature is enabled in
32bits platform as the following log:

F2FS-fs (dm-x): inconsistent rbtree, cur(3470333575168) next(3320009719808)
------------[ cut here ]------------
kernel BUG at fs/f2fs/gc.c:602!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
PC is at get_victim_by_default+0x13c0/0x1498
LR is at f2fs_check_rb_tree_consistence+0xc4/0xd4
....
[<c04d98b0>] (get_victim_by_default) from [<c04d4f44>] (f2fs_gc+0x220/0x6cc)
[<c04d4f44>] (f2fs_gc) from [<c04d4780>] (gc_thread_func+0x2ac/0x708)
[<c04d4780>] (gc_thread_func) from [<c015c774>] (kthread+0x1a8/0x1b4)
[<c015c774>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)

The reason is the 64bits key in struct rb_entry has __packed attibute
but has not in struct victim_entry, so the wrong key value got by
in f2fs_check_rb_tree_consistence, the following are the memory layouts
of struct rb_entry and struct victim_entry in 32bits platform:

struct rb_entry {
   [0] struct rb_node rb_node;
       union {
           struct {...};
  [12]     unsigned long long key;
       };
}
struct victim_entry {
   [0] struct rb_node rb_node;
       union {
           struct {...};
  [16]     struct victim_info vi;
       };
  [32] struct list_head list;
}

This patch fix this inconsistence layout of 64bits key between
struct rb_entry and struct victim_entry.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/gc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 19b956c2d697..9a03c6502b39 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -68,7 +68,7 @@ struct victim_entry {
 			unsigned int segno;		/* segment No. */
 		};
 		struct victim_info vi;	/* victim info */
-	};
+	} __packed;
 	struct list_head list;
 };
 
-- 
2.17.1

