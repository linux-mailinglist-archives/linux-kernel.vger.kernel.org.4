Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6CD60EF22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiJ0EnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiJ0EnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:43:15 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEEF156244;
        Wed, 26 Oct 2022 21:43:14 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 20so170692pgc.5;
        Wed, 26 Oct 2022 21:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LB7crV5gM2qTmv7VZNeS5/4LGIFO9jNjOWnpFO7wtac=;
        b=MgpVCINkHxKB7/menORJwejXUiGJwdC2JXo8hMo6mW1qut2VPVo2AW2VQ2deWPDqCd
         sJ/Xf4YHd5Q+ec9+dSFBrfb0oYLQm9RAXVhAZ86KREK+jmoJRpZdORxNR+iRJEPUeHgP
         PhS/CcVfXw7GejWN3QfdlHN/JQIm2PJHKWvid8dbrq0pBxt6x/b/JV6ZHT0C6/v3X9iH
         krDS7k1HXFXEdMErUVCeTawOJU40NxXJ1TQ+NI6KKrfE6yNVs3CtpGYREajrc2NVnZjb
         mlue2VjrlbwtLsNOXDqXgsDZG6uw7ReBB+XrYthTxWvQtwGorkesKTjSeZ6pD3D2DIM+
         c6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LB7crV5gM2qTmv7VZNeS5/4LGIFO9jNjOWnpFO7wtac=;
        b=NIGCfmMklIlvOlcRhMzIkee509kVTkH5GoxC+JWJ8K0cbcQu8AUwr6Ic9rpgUl9aTj
         m//mjToV5tCCD7CFJPt9tOB9OOvjUc0a5+8DY9eoeNpkNsGzgHf+1Gnml/Ygop0aTsmh
         YLLIyDuFDUs3rndddKFOnbib49Q99kz+PaWsc48bcuH4alxXbOwfP8oubfg6YzlouHSz
         K0t4QJ0pjYZz2/E2dGurU66xWSQibjJEyXhjHgoH/NfzFgyq9ooppCe/R6MvaeaLKrom
         JTOy0jEt06nkzR71z5lX/fI0ASh4LMqqZXgqUyNioN7svE6qd5epuPGRaKJGnbcy1F95
         nGHQ==
X-Gm-Message-State: ACrzQf1pzOipu9T8j57jUjuXBOgqFTOMxkmoxJ5TrshFyDfjb92h0fgq
        zb2oqgcXsY17sgvEgq12ktk=
X-Google-Smtp-Source: AMsMyM4aGJkSr2mcmDNzwbMAHXqaOdBdlDP8xugw2xTCzoj/QADD53GbavKtEFKPENPKo2pv8rZYpA==
X-Received: by 2002:a63:4f09:0:b0:440:4706:2299 with SMTP id d9-20020a634f09000000b0044047062299mr41088846pgb.115.1666845793691;
        Wed, 26 Oct 2022 21:43:13 -0700 (PDT)
Received: from carrot.. (i220-108-44-211.s42.a014.ap.plala.or.jp. [220.108.44.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b00186a2274382sm186929plx.76.2022.10.26.21.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:43:12 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+e91619dd4c11c4960706@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] nilfs2: fix shift-out-of-bounds/overflow in nilfs_sb2_bad_offset()
Date:   Thu, 27 Oct 2022 13:43:05 +0900
Message-Id: <20221027044306.42774-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027044306.42774-1-konishi.ryusuke@gmail.com>
References: <20221027044306.42774-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the block size exponent information written in an on-disk
superblock is corrupted, nilfs_sb2_bad_offset helper function can
trigger shift-out-of-bounds warning followed by a kernel panic (if
panic_on_warn is set):

 shift exponent 38983 is too large for 64-bit type 'unsigned long long'
 Call Trace:
  <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
  ubsan_epilogue lib/ubsan.c:151 [inline]
  __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
  nilfs_sb2_bad_offset fs/nilfs2/the_nilfs.c:449 [inline]
  nilfs_load_super_block+0xdf5/0xe00 fs/nilfs2/the_nilfs.c:523
  init_nilfs+0xb7/0x7d0 fs/nilfs2/the_nilfs.c:577
  nilfs_fill_super+0xb1/0x5d0 fs/nilfs2/super.c:1047
  nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
  ...

In addition, since nilfs_sb2_bad_offset() performs multiplication
without considering the upper bound, the computation may overflow if
the disk layout parameters are not normal.

This fixes these issues by inserting preliminary sanity checks for
those parameters and by converting the comparison from one involving
multiplication and left bit-shifting to one using division and right
bit-shifting.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+e91619dd4c11c4960706@syzkaller.appspotmail.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/the_nilfs.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 3b4a079c9617..d588816fdf2f 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/random.h>
+#include <linux/log2.h>
 #include <linux/crc32.h>
 #include "nilfs.h"
 #include "segment.h"
@@ -443,11 +444,33 @@ static int nilfs_valid_sb(struct nilfs_super_block *sbp)
 	return crc == le32_to_cpu(sbp->s_sum);
 }
 
-static int nilfs_sb2_bad_offset(struct nilfs_super_block *sbp, u64 offset)
+/**
+ * nilfs_sb2_bad_offset - check the location of the second superblock
+ * @sbp: superblock raw data buffer
+ * @offset: byte offset of second superblock calculated from device size
+ *
+ * nilfs_sb2_bad_offset() checks if the position on the second
+ * superblock is valid or not based on the filesystem parameters
+ * stored in @sbp.  If @offset points to a location within the segment
+ * area, or if the parameters themselves are not normal, it is
+ * determined to be invalid.
+ *
+ * Return Value: true if invalid, false if valid.
+ */
+static bool nilfs_sb2_bad_offset(struct nilfs_super_block *sbp, u64 offset)
 {
-	return offset < ((le64_to_cpu(sbp->s_nsegments) *
-			  le32_to_cpu(sbp->s_blocks_per_segment)) <<
-			 (le32_to_cpu(sbp->s_log_block_size) + 10));
+	unsigned int shift_bits = le32_to_cpu(sbp->s_log_block_size);
+	u32 blocks_per_segment = le32_to_cpu(sbp->s_blocks_per_segment);
+	u64 nsegments = le64_to_cpu(sbp->s_nsegments);
+	u64 index;
+
+	if (blocks_per_segment < NILFS_SEG_MIN_BLOCKS ||
+	    shift_bits > ilog2(NILFS_MAX_BLOCK_SIZE) - BLOCK_SIZE_BITS)
+		return true;
+
+	index = offset >> (shift_bits + BLOCK_SIZE_BITS);
+	do_div(index, blocks_per_segment);
+	return index < nsegments;
 }
 
 static void nilfs_release_super_block(struct the_nilfs *nilfs)
-- 
2.34.1

