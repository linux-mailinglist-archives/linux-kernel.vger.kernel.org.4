Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6906BABA1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjCOJHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjCOJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:07:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076EA7B499
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:06:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so43166134edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678871185; x=1681463185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mviUQ27/iHZGfwlahjqCZ5wZtdsMAGwoSzooIkgDF+w=;
        b=p4W+PejKtE7ObImdexXA1FMi9bf9soTFJkauE0DTZ7BotV+TTyx3TOWvPkZnIDeqrn
         0ZHscmQF3YQ2yRpdP8TGiSWZ2lmvvS+uquPm5UypqCZGfsSAtlFlJz2pnAV+ZkVXyHJQ
         6JEzwj/8xDAG37aMilglb0eUuSZcvK78rJKxtBqCigIZ3diwHy7x22twUbp2CJ0EU5yr
         RQDtp60Ax+pDCz8JNHC5we5oEYySFibbU0Jg9jjDlRf/3TyAEVBbrlpJlfS/mSyNs4ww
         czEBR7z1dClr2unyVUom2jyqFP7FN888gtV+fqYtl8yBRJ41q5F40tMGby4yn3dqQSyg
         DqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678871185; x=1681463185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mviUQ27/iHZGfwlahjqCZ5wZtdsMAGwoSzooIkgDF+w=;
        b=6eTwjskLysak+3LtUO0WpDqXfTVgA5ivOllWfFIFmGTVitncGa5uEI1d/Z+hWyKXzj
         RvurSZ2oY93mlYTxx4tG8l+2UyVu6rMl7r+PKCeigsp4/qxq+70zAHeS/cGB6WFk0CLV
         4HElFduP/l6JrVvNe6zex4rec3D98T5Ppi1FW8RKy6lw0aiMBMMtixSA3q6REHfL2zGY
         URyVLZKlO9tWXLn60v1c9pdmiJC0esZZ75YwjRFMjJzV4QOqLo0Q2wnu0dnFC0yxECk3
         agUNvqrGn2uQ2I5e44zbhl0jCK74/3ayhhmBlabyKmkuvnKHqVC1+DWxwj1LTa4iRBCu
         oRig==
X-Gm-Message-State: AO0yUKUxg5cQlUEzqN9QKdMoYLBS1DFwA0SO53dTLaOL5c7njf2eEHWR
        nVZ8WZXzcKbFyBkj96bUvTSSGAdr11mPPg==
X-Google-Smtp-Source: AK7set/AvPhKa1Udt5DUEvQlOz5vMHUkIaNtdHxKhdF6BLIGq1ynPteZ9cLjl9xXqUBm0xGnIJANuQ==
X-Received: by 2002:a17:906:4c:b0:92e:f520:7779 with SMTP id 12-20020a170906004c00b0092ef5207779mr1162424ejg.0.1678871184900;
        Wed, 15 Mar 2023 02:06:24 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id ss10-20020a170907038a00b008e36f9b2308sm2264411ejb.43.2023.03.15.02.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 02:06:24 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     rpeterso@redhat.com, agruenba@redhat.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com
Subject: [PATCH] gfs2 FS: Fix UBSAN array-index-out-of-bounds in __gfs2_iomap_get
Date:   Wed, 15 Mar 2023 13:06:20 +0400
Message-Id: <20230315090620.7294-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:

UBSAN: array-index-out-of-bounds in fs/gfs2/bmap.c:901:46
index 11 is out of range for type 'u64 [11]'
CPU: 0 PID: 5067 Comm: syz-executor164 Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xe0/0x110 lib/ubsan.c:282
 __gfs2_iomap_get+0x4a4/0x16e0 fs/gfs2/bmap.c:901
 gfs2_iomap_get fs/gfs2/bmap.c:1399 [inline]
 gfs2_block_map+0x28f/0x7f0 fs/gfs2/bmap.c:1214
 gfs2_write_alloc_required+0x441/0x6e0 fs/gfs2/bmap.c:2322
 gfs2_jdesc_check+0x1b9/0x290 fs/gfs2/super.c:114
 init_journal+0x5a4/0x22c0 fs/gfs2/ops_fstype.c:804
 init_inodes+0xdc/0x340 fs/gfs2/ops_fstype.c:889
 gfs2_fill_super+0x1bb2/0x2700 fs/gfs2/ops_fstype.c:1247
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2c63567aca
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd0e3a28d8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2c63567aca
RDX: 0000000020037f40 RSI: 0000000020037f80 RDI: 00007ffd0e3a28e0
RBP: 00007ffd0e3a28e0 R08: 00007ffd0e3a2920 R09: 0000000000043350
R10: 0000000002000011 R11: 0000000000000282 R12: 0000000000000004
R13: 00005555567192c0 R14: 00007ffd0e3a2920 R15: 0000000000000000
 </TASK>

This issue is caused by the 'while' loop in the '__gfs2_iomap_get' function,
which increments 'height' var until it matches the condition. If height is
larger or equal to 'sdp->sd_heightsize' array size (which is GFS2_MAX_META_HEIGHT
+ 1), the array-index-out-of-bounds issue occurs. Therefore we need to add extra
condition to the while loop, which will prevent this issue.

Additionally, if 'height' var after the while ending is equal to GFS2_MAX_META_HEIGHT,
the 'find_metapath' call right after the loop will break (because it assumes that
'height' parameter will not be larger than the size of metapath's mp_list array length,
which is GFS2_MAX_META_HEIGHT). So, we need to check the 'height' after the loop ending,
and if its value is too big we need to break the execution of the function, and return
a proper error if it is too big.

Tested via syzbot.

Reported-by: syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=42296ea544c870f4dde3b25efa4cc1b89515d38e
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 fs/gfs2/bmap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index eedf6926c652..9b7358165f96 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -895,8 +895,16 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 	iomap->length = len << inode->i_blkbits;
 
 	height = ip->i_height;
-	while ((lblock + 1) * sdp->sd_sb.sb_bsize > sdp->sd_heightsize[height])
+
+	while (height <= GFS2_MAX_META_HEIGHT
+		&& (lblock + 1) * sdp->sd_sb.sb_bsize > sdp->sd_heightsize[height])
 		height++;
+
+	if (height > GFS2_MAX_META_HEIGHT) {
+		ret = -ERANGE;
+		goto unlock;
+	}
+
 	find_metapath(sdp, lblock, mp, height);
 	if (height > ip->i_height || gfs2_is_stuffed(ip))
 		goto do_alloc;
-- 
2.34.1

