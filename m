Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30636439B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiLEX6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLEX6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:58:32 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8DB65E5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:58:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p24so12365215plw.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/HXLTVye+YBHgwzsVjQE7IM6Q/B5dkMbda8W38AW5U=;
        b=1VD2+yeaoB56MIKwkZMtD+CBgiolHgSXmTJSsOr/tV472LlQ73j5kvScI62kK8NbAi
         aVmtI6CIeeQOAjd+FXaXzwo3EqBEqvIP44z+9wSz2KAI/UPJWgoPibpt6lyOyF384rJ+
         3JYob4Wb1wWXGsPJsenKlizwLwW6RghQ9/GlhqmKKZeCxASyzFaK3e6JoYsDz37X+/G5
         QuGrU/RZUO9mVY4C3bDZ/p36gB5z8AlLbhox2ewY48LURtH5KY4A+4ch+4f+J1cM9Nyc
         BGM2AO5l1lIbb3WyQPZx6o4USCsOOq2Nw4/BcVVsPV69jZLYibOTjlqbMl9QN9nvIFp/
         En/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/HXLTVye+YBHgwzsVjQE7IM6Q/B5dkMbda8W38AW5U=;
        b=nTV+Xb1cp6TpsokU4Fc+XjzhVjXxwHIm84CarZGtGxoIAxgKC3rsv1d0vSxSsc3mct
         h55ZukknFNGld9iRzc/BBd4zudMLbSmCaTGsWEnd7ngC4KaT5ootFZLOPacLlKblGkgm
         8uULipKIu1nzGOkkSxKcsNMe0063Wn6JgL1DuWHEONYkBzo3VTfQyswqcqEj9g3vs+mj
         Kec2PbOXzP6GSPXnvfZvS/2fUN3On9DmbDLJ1Q+2qSCrJMRr1jwb2HBW2LVXlmHs+Kd5
         5g7tROWGxUGm8duPsqtF3HYDLCG+dxJ1X/YXc48+JdZ9tR+cjhfg2go6BkQW/ufkfPqC
         q5qw==
X-Gm-Message-State: ANoB5plsYRGUrHByCq9M1vcxdrpOZcGzPQHWIRIYexB2ykNk4/Y77xgB
        z6zT0uL+WcpcrCiCKpKXDe8CHQ==
X-Google-Smtp-Source: AA0mqf75pQcKCeUlHim+EYQnMg/KLDWrpiR4pcZDA7OzIc1fg1wmHYfyVg/dUk9hamdjldnFtxbhLA==
X-Received: by 2002:a17:90a:dc18:b0:219:b8f8:9b80 with SMTP id i24-20020a17090adc1800b00219b8f89b80mr11859093pjv.54.1670284711125;
        Mon, 05 Dec 2022 15:58:31 -0800 (PST)
Received: from dread.disaster.area (pa49-181-54-199.pa.nsw.optusnet.com.au. [49.181.54.199])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b00189847cd4acsm11282927pla.237.2022.12.05.15.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:58:30 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p2LLv-004z6x-PA; Tue, 06 Dec 2022 10:58:27 +1100
Date:   Tue, 6 Dec 2022 10:58:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>
Cc:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in xfs_qm_dqfree_one
Message-ID: <20221205235827.GR3600936@dread.disaster.area>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


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
