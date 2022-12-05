Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEEB643871
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiLEWwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiLEWwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:52:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7B1836A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:52:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cm20so12682340pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9sXSnbWdNQAnXC27FimSsO3a+Mkt026Z0qZcYB1/jaQ=;
        b=26/xMACWOv6955CpCDtanFEHJKpw6gWUS7t5USbxLzdPiJ3REdljdauDmwCXM2xAXm
         lpXDqeJWVyE5PiMp6VPF8XN78ABtEG4oIKSHNTMrWkf6VCvxvmLZ+u6fmSPd4WB07K9J
         jbF+yZ5W+g0h8FfJNYxFRk77ArjffIumkZZAO2d8NjZ49wHuaqpJbHqAC0omklqzcnxJ
         LvPgk2Jf16B0narXKA0g/H0yIHX2foE2ZTS0BvGZ88RRUGybajnjLE7VVLH3f4rZAgrD
         /qePn8cTxMG0gRg6IC9Ba+0sMkl7euHci+DlYJfy7/jBlkPR0frDN8qoSrfRHzrw2qz5
         VYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sXSnbWdNQAnXC27FimSsO3a+Mkt026Z0qZcYB1/jaQ=;
        b=n0EZutf7KmhNUsadN09isA7SvLciZFUHSIAIfGLepAdCAIl0hLVWHxin0brtkykFLT
         m1TZVO1nWVGcIC5noT1uOyzg3MolKmC+x9aNOaMGbNAGNHrc1991UEU7sUwQbtGlLaYj
         sFj9F0mz5hMxORECIvPKxqCvFl5YII/2M0pm9GAUNC3vv3Bv6D412YQFgFXy2vML04Xu
         HJgteQBVZL+S5TScVUft/qliRBDQD1K4sFWXdieWwadYS+g+CuPw6GhUwD3/fftVNaqK
         +mUHuqNmnEbTVQkN3UTXuN7n3ugNsPk16/IQO+DrV23i7V1EMNxYI9olXDUrcpHz+FmH
         8y3g==
X-Gm-Message-State: ANoB5pkUHhstBJDBcQl/6xgzRilFHnqsQ9qTqEENiqpk8IYe3201nFQl
        Rd0e2dM9tQbYdy12H0nUZYBXug==
X-Google-Smtp-Source: AA0mqf5kyQqAYcD1/BryyrQEwg3DX82rVlG47bYBiw/jxWaCNrkN1+CyfhWkmrdS3LDLGOzrpX4l7Q==
X-Received: by 2002:a17:90a:bc48:b0:219:b821:77ad with SMTP id t8-20020a17090abc4800b00219b82177admr11498165pjv.217.1670280769873;
        Mon, 05 Dec 2022 14:52:49 -0800 (PST)
Received: from dread.disaster.area (pa49-181-54-199.pa.nsw.optusnet.com.au. [49.181.54.199])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79849000000b005769ccca18csm4787801pfq.85.2022.12.05.14.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:52:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p2KKM-004xqI-GN; Tue, 06 Dec 2022 09:52:46 +1100
Date:   Tue, 6 Dec 2022 09:52:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>
Cc:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING
Message-ID: <20221205225246.GP3600936@dread.disaster.area>
References: <000000000000abbde005ef113644@google.com>
 <0000000000009a423705ef123f9a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009a423705ef123f9a@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:35:39AM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    0ba09b173387 Revert "mm: align larger anonymous mappings o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15550c47880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=912776840162c13db1a3
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128c9e23880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9758ec2c06f4/disk-0ba09b17.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/06781dbfd581/vmlinux-0ba09b17.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3d44a22d15fa/bzImage-0ba09b17.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/335889b2d730/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+912776840162c13db1a3@syzkaller.appspotmail.com
> 
> XFS (loop1): Quotacheck: Done.
> syz-executor.1 (4657): drop_caches: 2
> ==================================================================
> BUG: KASAN: use-after-free in xfs_dquot_type fs/xfs/xfs_dquot.h:136 [inline]
> BUG: KASAN: use-after-free in xfs_qm_dqfree_one+0x12f/0x170 fs/xfs/xfs_qm.c:1604
> Read of size 1 at addr ffff888079a6aa58 by task syz-executor.1/4657

Looks like we've missed a XFS_DQUOT_FREEING check in
xfs_qm_shrink_scan(), and the dquot purge run by unmount has raced
with the shrinker. Patch below should fix it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING

From: Dave Chinner <dchinner@redhat.com>

Resulting in a UAF if the shrinker races with some other dquot
freeing mechanism that sets XFS_DQFLAG_FREEING before the dquot is
removed from the LRU. This can occur if a dquot purge races with
drop_caches.

Reported-by: syzbot+912776840162c13db1a3@syzkaller.appspotmail.com
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_qm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 18bb4ec4d7c9..ff53d40a2dae 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -422,6 +422,14 @@ xfs_qm_dquot_isolate(
 	if (!xfs_dqlock_nowait(dqp))
 		goto out_miss_busy;
 
+	/*
+	 * If something else is freeing this dquot and hasn't yet removed it
+	 * from the LRU, leave it for the freeing task to complete the freeing
+	 * process rather than risk it being free from under us here.
+	 */
+	if (dqp->q_flags & XFS_DQFLAG_FREEING)
+		goto out_miss_unlock;
+
 	/*
 	 * This dquot has acquired a reference in the meantime remove it from
 	 * the freelist and try again.
@@ -441,10 +449,8 @@ xfs_qm_dquot_isolate(
 	 * skip it so there is time for the IO to complete before we try to
 	 * reclaim it again on the next LRU pass.
 	 */
-	if (!xfs_dqflock_nowait(dqp)) {
-		xfs_dqunlock(dqp);
-		goto out_miss_busy;
-	}
+	if (!xfs_dqflock_nowait(dqp))
+		goto out_miss_unlock;
 
 	if (XFS_DQ_IS_DIRTY(dqp)) {
 		struct xfs_buf	*bp = NULL;
@@ -478,6 +484,8 @@ xfs_qm_dquot_isolate(
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaims);
 	return LRU_REMOVED;
 
+out_miss_unlock:
+	xfs_dqunlock(dqp);
 out_miss_busy:
 	trace_xfs_dqreclaim_busy(dqp);
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
