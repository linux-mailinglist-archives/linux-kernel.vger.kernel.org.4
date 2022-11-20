Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A416A6314B6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 15:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiKTO7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 09:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKTO7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 09:59:04 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B152494E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 06:59:02 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t17so7721582pjo.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 06:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWEkAKWEbQTLwuPXrEgeQIA4hCG5DE0c8Yygn8Mx6kI=;
        b=kL+cvROStnsz9QbMygqACqZwOBMmeJioyT6Ry3JvcFQWIO/qklUK5FYwVbpf3BtOM6
         o7Bq6tRfxoK3SI2YR18aNKjVsgQmAgPUZme6JTbMYLTkyBzsBu/AXYcRdLN0uq0g7pW1
         AV08adtl4xXFfzgM2ZuuAD2BLlhoverB2us40/PRs9pUui+ZBR3cQEmVp6+RKnGpW1E4
         coP/oK8m9xkwskmST4Cg8qsvW4cDs6+xoNXAs8c+pxw0f6EoF3USK8uJWq19RkgpH3Cz
         5t5M113SjZ/PrSwHc48cwOPZd0rj9k09yykkplLARXCBM2MfWWXrBYIpD1JUtepIgX1A
         Do+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWEkAKWEbQTLwuPXrEgeQIA4hCG5DE0c8Yygn8Mx6kI=;
        b=P0Ksxv5W6oHxL/c/zzMesjSRZdMnpVQGgmMlKZudpFQLnzzTtq7tnmY/Aa2mUSPHps
         6FnLXM0ibqI/gmstSQuWTEUHdlzpRkWoeta/wGWxlaTQHwJeAa0lJ635MXZmsXVNSeLP
         GBqWAijkFUOruVQm9t3nf9ULanSeKl17iON7vILSwv5go5PfEQwoAUCeONMnSt85OpK2
         7eqiSnwlk5+rue0NLAvHWvnNBdvKM37OjEXanGQLgMIPQ94Lr7uA+h/3oTrjGShJh9NF
         2Ptc5ixMLq5kKrt+37D4Ch1YyhtR291t7JwxKSNGt1Km8z6KWsU+ewgWBpF5/lGY+but
         G/ZA==
X-Gm-Message-State: ANoB5pmRQ1ouP7qRvSyH23WfwtHGRLvl7gC5/FbTj+cJk+zw3vf0472y
        yUFrjniVcDDJR2Tz8vy6ArcnL5cqCno=
X-Google-Smtp-Source: AA0mqf4fHMaeM8KyrYO7PCcoyNhpdR4LUjeRDjbP3+LEH9koxyuDYLAQfXMMzavbv/1NOvC1lNJ1Sg==
X-Received: by 2002:a17:90a:2b8c:b0:212:f4f1:96ee with SMTP id u12-20020a17090a2b8c00b00212f4f196eemr23160378pjd.72.1668956342326;
        Sun, 20 Nov 2022 06:59:02 -0800 (PST)
Received: from localhost.localdomain (124244014158.ctinets.com. [124.244.14.158])
        by smtp.gmail.com with ESMTPSA id gq18-20020a17090b105200b0021864cf062dsm6177013pjb.21.2022.11.20.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 06:59:01 -0800 (PST)
From:   Hoi Pok Wu <wuhoipok@gmail.com>
To:     shaggy@kernel.org
Cc:     Hoi Pok Wu <wuhoipok@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+3424c9550a49659f1704@syzkaller.appspotmail.com
Subject: [PATCH] fs: jfs: fix UBSAN in jfs_statfs
Date:   Sun, 20 Nov 2022 22:58:02 +0800
Message-Id: <20221120145802.86777-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.38.1
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

The reason for the following undefined behaviour is the shifting is
larger than the amounts of bit of 's64'. Given that the shifting is the
only use case of the variable im_l2nbperiext, I wonder if it is a good
idea to guard the value thus it is smaller than 64.

I am not sure the actual meaning of the variable, so there maybe better
ways. Still, I would send this patch as a suggestion. Thank you.

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/super.c:140:14
shift exponent 1749508610 is too large for 64-bit type 's64' (aka 'long long')
CPU: 0 PID: 3634 Comm: syz-executor222 Not tainted 6.1.0-rc5-syzkaller-00241-gab290eaddc4c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 jfs_statfs+0x503/0x510 fs/jfs/super.c:140
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x136/0x310 fs/statfs.c:90
 user_statfs fs/statfs.c:105 [inline]
 __do_sys_statfs fs/statfs.c:195 [inline]
 __se_sys_statfs fs/statfs.c:192 [inline]
 __x64_sys_statfs+0x120/0x230 fs/statfs.c:192
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0501ab8f79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffffd945308 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f0501ab8f79
RDX: 00007f0501a77473 RSI: 0000000000000000 RDI: 0000000020004c80
RBP: 00007f0501a78740 R08: 0000555555fe32c0 R09: 0000000000000000
R10: 00007ffffd9451d0 R11: 0000000000000246 R12: 0a0a0a0a0a0a0a0a
R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
 </TASK>
================================================================================

Reported-by: syzbot+3424c9550a49659f1704@syzkaller.appspotmail.com
Signed-off-by: Hoi Pok Wu <wuhoipok@gmail.com>
---
 fs/jfs/jfs_imap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 390cbfce391f..093f2ecd92ac 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -124,6 +124,13 @@ int diMount(struct inode *ipimap)
 	atomic_set(&imap->im_numfree, le32_to_cpu(dinom_le->in_numfree));
 	imap->im_nbperiext = le32_to_cpu(dinom_le->in_nbperiext);
 	imap->im_l2nbperiext = le32_to_cpu(dinom_le->in_l2nbperiext);
+
+	/* 63 is the maximum shift amounts for type s64 */
+	if (imap->im_l2nbperiext >= 64) {
+		release_metapage(mp);
+		return -EINVAL;
+	}
+
 	for (index = 0; index < MAXAG; index++) {
 		imap->im_agctl[index].inofree =
 		    le32_to_cpu(dinom_le->in_agctl[index].inofree);
-- 
2.38.1

