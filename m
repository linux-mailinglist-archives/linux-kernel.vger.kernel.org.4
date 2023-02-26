Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5715A6A34BB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBZWeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBZWeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:34:08 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B372C65B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:34:07 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id i5so3206651pla.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8jXW9BSxQeu5H3FtDPUOHt3BSC9pPmM4qmXjPn5oifs=;
        b=NhcL37q4IXe3FEeZjlu1T2yFBVx0w4ik3y5RBg2ZUStQ2RhCBG3YejO34gcPJmL12N
         LBYSaaBH58GMZz+XtVvXfTS0ZCU3B4vfI/6Fp5/lFVO55Nelz12jOHI8WNTVR+VXE5B+
         E7ogMnijOxldfydwHs/WDDrrZXeJcmWcigkTFZ4lcX+BDC9ZQsePl+thfa0EONuNfou6
         uMgiW/SXKUu9WXqZ8DGgYGD4m3vMz34r2C5HHItibmyi+Rg+kuYcHzFIDEU996n9bppT
         qruYQRssuQBuTKUcHXxH01rL8vzSw45O1ceXNqDXq31nGAE4RHpdpgMi6KACNSrDYXug
         jOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jXW9BSxQeu5H3FtDPUOHt3BSC9pPmM4qmXjPn5oifs=;
        b=yGK69ih4ZyTNkRd/S4ToTja8pqym9D9LxX5Lf5LDnUbLHfHu+6rFj22nSwvlI0Jc1m
         +AD5x8i4uDYYG1a1a+irprqTwIZ+MlfLAJWtgFGyfBppHVg9GusGEhTNVSV6tFhEvx5k
         8l8tsFTStRezY03/wo4kkguhoJOnHNhOC+yJq9ivBMwkEcVUo89orAaJv8qcPRf6+GSS
         BstzfrFf34ESTro1P8TRAUI7vbu15v4BGviABxdYl8HI5FKHfrIhEvWtEQ+RDyH4MKhE
         y2bk9Iuy0UvrvVtKKncZMdYVfIpfoDbb5x8mI0Frh7Wpz0IKIo3kZyhVUcf1OAhVPBwo
         P1tA==
X-Gm-Message-State: AO0yUKWq9lnoUVZFA41ubhG+HHz68ePm7ijEcGhw30fm9Rz9hSGXDW7H
        A3kI/fvqPAGFKtsff3sIzwI95g==
X-Google-Smtp-Source: AK7set9K3/jJoWi3K41f68WvNtUO1imv8lTBl0mtImktrCs73gZlS82ADyzSFbysgUqzvpDUpi1gsw==
X-Received: by 2002:a17:903:2890:b0:19d:90f:6c2a with SMTP id ku16-20020a170903289000b0019d090f6c2amr2031566plb.6.1677450846542;
        Sun, 26 Feb 2023 14:34:06 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902a51300b0019919b7e5b1sm3104505plq.168.2023.02.26.14.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:34:06 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pWPal-002VP9-Ck; Mon, 27 Feb 2023 09:34:03 +1100
Date:   Mon, 27 Feb 2023 09:34:03 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        linux-xfs <linux-xfs@vger.kernel.org>, asml.silence@gmail.com,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        heng.su@intel.com
Subject: Re: [Syzkaller & bisect] There is "xfs_dquot_alloc" related BUG in
 v6.2 in guest
Message-ID: <20230226223403.GU360264@dread.disaster.area>
References: <Y/g/femUL7jZ9gF3@xpf.sh.intel.com>
 <a39d97c1-2ced-d159-f742-e5c6008f79ee@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39d97c1-2ced-d159-f742-e5c6008f79ee@gmx.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 08:58:25PM +0100, Helge Deller wrote:
> Looping in xfs mailing list as this seems to be a XFS problem...
> On 2/24/23 05:39, Pengfei Xu wrote:
> > [   71.225966] XFS (loop1): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
> > [   71.226310] xfs filesystem being mounted at /root/syzkaller.qCVHXV/0/file0 supports timestamps until 2038 (0x7fffffff)
> > [   71.227591] BUG: kernel NULL pointer dereference, address: 00000000000002a8
> > [   71.227873] #PF: supervisor read access in kernel mode
> > [   71.228077] #PF: error_code(0x0000) - not-present page
> > [   71.228280] PGD c313067 P4D c313067 PUD c1fe067 PMD 0
> > [   71.228494] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [   71.228673] CPU: 0 PID: 161 Comm: kworker/0:4 Not tainted 6.2.0-c9c3395d5e3d #1
> > [   71.228961] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   71.229400] Workqueue: xfs-inodegc/loop1 xfs_inodegc_worker
> > [   71.229626] RIP: 0010:xfs_dquot_alloc+0x95/0x1e0
> > [   71.229820] Code: 80 15 ad 85 48 c7 c6 7c 6b 92 83 e8 75 0f 6b ff 49 8b 8d 60 01 00 00 44 89 e0 31 d2 48 c7 c6 18 ae 8f 83 48 8d bb 18 02 00 00 <f7> b1 a8 02 2
> > [   71.230528] RSP: 0018:ffffc90000babc20 EFLAGS: 00010246
> > [   71.230737] RAX: 0000000000000009 RBX: ffff8880093c98c0 RCX: 0000000000000000
> > [   71.231014] RDX: 0000000000000000 RSI: ffffffff838fae18 RDI: ffff8880093c9ad8
> > [   71.231292] RBP: ffffc90000babc48 R08: 0000000000000002 R09: 0000000000000000
> > [   71.231570] R10: ffffc90000baba80 R11: ffff88800af08d98 R12: 0000000000000009
> > [   71.231850] R13: ffff88800c4bc000 R14: ffff88800c4bc000 R15: 0000000000000004
> > [   71.232129] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> > [   71.232441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   71.232668] CR2: 00000000000002a8 CR3: 000000000a1d2002 CR4: 0000000000770ef0
> > [   71.232949] PKRU: 55555554
> > [   71.233061] Call Trace:
> > [   71.233162]  <TASK>
> > [   71.233254]  xfs_qm_dqread+0x46/0x440
> > [   71.233410]  ? xfs_qm_dqget_inode+0x13e/0x500
> > [   71.233596]  xfs_qm_dqget_inode+0x154/0x500
> > [   71.233774]  xfs_qm_dqattach_one+0x142/0x3c0
> > [   71.233961]  xfs_qm_dqattach_locked+0x14a/0x170
> > [   71.234149]  xfs_qm_dqattach+0x52/0x80
> > [   71.234307]  xfs_inactive+0x186/0x340
> > [   71.234461]  xfs_inodegc_worker+0xd3/0x430
> > [   71.234630]  process_one_work+0x3b1/0x960
> > [   71.234802]  worker_thread+0x52/0x660
> > [   71.234957]  ? __pfx_worker_thread+0x10/0x10
> > [   71.235136]  kthread+0x161/0x1a0
> > [   71.235279]  ? __pfx_kthread+0x10/0x10
> > [   71.235442]  ret_from_fork+0x29/0x50
> > [   71.235602]  </TASK>
> > [   71.235696] Modules linked in:
> > [   71.235826] CR2: 00000000000002a8
> > [   71.235964] ---[ end trace 0000000000000000 ]---

Looks like a quota disable race with background inode inactivation
reading in dquots.

Can you test the patch below?

-Dave.
-- 
Dave Chinner
david@fromorbit.com


xfs: quotacheck failure can race with background inode inactivation

From: Dave Chinner <dchinner@redhat.com>

The background inode inactivation can attached dquots to inodes, but
this can race with a foreground quotacheck failure that leads to
disabling quotas and freeing the mp->m_quotainfo structure. The
background inode inactivation then tries to allocate a quota, tries
to dereference mp->m_quotainfo, and crashes like so:

XFS (loop1): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
xfs filesystem being mounted at /root/syzkaller.qCVHXV/0/file0 supports timestamps until 2038 (0x7fffffff)
BUG: kernel NULL pointer dereference, address: 00000000000002a8
....
CPU: 0 PID: 161 Comm: kworker/0:4 Not tainted 6.2.0-c9c3395d5e3d #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: xfs-inodegc/loop1 xfs_inodegc_worker   
RIP: 0010:xfs_dquot_alloc+0x95/0x1e0
....
Call Trace:
 <TASK>
 xfs_qm_dqread+0x46/0x440
 xfs_qm_dqget_inode+0x154/0x500
 xfs_qm_dqattach_one+0x142/0x3c0
 xfs_qm_dqattach_locked+0x14a/0x170
 xfs_qm_dqattach+0x52/0x80
 xfs_inactive+0x186/0x340
 xfs_inodegc_worker+0xd3/0x430
 process_one_work+0x3b1/0x960
 worker_thread+0x52/0x660
 kthread+0x161/0x1a0
 ret_from_fork+0x29/0x50
 </TASK>
....

Prevent this race by flushing all the queued background inode
inactivations pending before purging all the cached dquots when
quotacheck fails.

Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_qm.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index e2c542f6dcd4..78ca52e55f03 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -1321,15 +1321,14 @@ xfs_qm_quotacheck(
 
 	error = xfs_iwalk_threaded(mp, 0, 0, xfs_qm_dqusage_adjust, 0, true,
 			NULL);
-	if (error) {
-		/*
-		 * The inode walk may have partially populated the dquot
-		 * caches.  We must purge them before disabling quota and
-		 * tearing down the quotainfo, or else the dquots will leak.
-		 */
-		xfs_qm_dqpurge_all(mp);
-		goto error_return;
-	}
+
+	/*
+	 * On error, the inode walk may have partially populated the dquot
+	 * caches.  We must purge them before disabling quota and tearing down
+	 * the quotainfo, or else the dquots will leak.
+	 */
+	if (error)
+		goto error_purge;
 
 	/*
 	 * We've made all the changes that we need to make incore.  Flush them
@@ -1363,10 +1362,8 @@ xfs_qm_quotacheck(
 	 * and turn quotaoff. The dquots won't be attached to any of the inodes
 	 * at this point (because we intentionally didn't in dqget_noattach).
 	 */
-	if (error) {
-		xfs_qm_dqpurge_all(mp);
-		goto error_return;
-	}
+	if (error)
+		goto error_purge;
 
 	/*
 	 * If one type of quotas is off, then it will lose its
@@ -1376,7 +1373,7 @@ xfs_qm_quotacheck(
 	mp->m_qflags &= ~XFS_ALL_QUOTA_CHKD;
 	mp->m_qflags |= flags;
 
- error_return:
+error_return:
 	xfs_buf_delwri_cancel(&buffer_list);
 
 	if (error) {
@@ -1395,6 +1392,21 @@ xfs_qm_quotacheck(
 	} else
 		xfs_notice(mp, "Quotacheck: Done.");
 	return error;
+
+error_purge:
+	/*
+	 * On error, we may have inodes queued for inactivation. This may try
+	 * to attach dquots to the inode before running cleanup operations on
+	 * the inode and this can race with the xfs_qm_destroy_quotainfo() call
+	 * below that frees mp->m_quotainfo. To avoid this race, flush all the
+	 * pending inodegc operations before we purge the dquots from memory,
+	 * ensuring that background inactivation is idle whilst we turn off
+	 * quotas.
+	 */
+	xfs_inodegc_flush(mp);
+	xfs_qm_dqpurge_all(mp);
+	goto error_return;
+
 }
 
 /*
