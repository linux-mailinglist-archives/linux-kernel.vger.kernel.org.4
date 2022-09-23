Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B455E784A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiIWK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiIWK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:27:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BD1128883
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:27:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t70so11856831pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/w7UwzbnmRu6xEONdwmcsNTVMZbCIcvKyFDV77tAiGg=;
        b=mehSYMeQH8vOgqAOnwXfGbYx+IpqCu5xdiL89kkg46DrWR8EVIhDqlVLrMK84WfLBB
         EHRTcIyurlarGnPmFcwDx8g577B7xFhNLIciS6F3ctrEJNt5dnDTSB7nX47utcyLCLGb
         H5+diuZ6d+2QxalKWw8jC8ohSt5uMVqaJMdRtv3q//TFHgVub4QkReED8S1/BQcmjRdk
         9/WclkM2Nft0LF2S4C5Kal3Rx2P8kXhTJYCEUHrYmfTm9NgMzD0/cnJ+tYTAcmOedKmS
         aco1p239ISkaZXkLq5qNtemNoaM6VjC6WJ5PQUQi10Kd+BEtqsHjhcckZkAyem8aFq8Y
         3mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/w7UwzbnmRu6xEONdwmcsNTVMZbCIcvKyFDV77tAiGg=;
        b=oyCrPjynH8qCrnxps4Nk5zhyHWBM5EYZhltISdW7d+sMrMTP8ze39y+/MVq4sArNKO
         uy85OMpuGueby+b8rMtamiFil8I1LjABfJQKf6mUvBY/6+klqDcnZ+G6uykis6YgMkJk
         DjFuVS8xUaFdPhB7P8oHVSkUgsToru9s2PzIFk/Sz4AzDkJmQBIOsqlmYko60qJrQTLa
         sYrDmCjuS5YOe7HcAEGPMNjD4JrijsAEAjdDssV/J5xcZdss3MIuKPLK9L9w6s4clCvO
         ycIGZZ1OxRXCRDfy4gd/t9pBIAt25WvtoIvB2F+kAseI2nzaAT9j4hhF3UnWlMWPtnZZ
         xIfQ==
X-Gm-Message-State: ACrzQf2gIJ13SOc2qDAuYl4A5yJpKP5LIzjXAh2wCjKZsVc2+hamZvM+
        /HIW+fSFbqIvLu1ta67UJvk=
X-Google-Smtp-Source: AMsMyM56YedmD5V4tFh9GW+U5G0/uzoj2JAE4AJoZh+GDlKD73vrBZx+LRvm/XOrqzuRLehduaT9KQ==
X-Received: by 2002:a63:cc4a:0:b0:439:1c48:2fed with SMTP id q10-20020a63cc4a000000b004391c482fedmr7158359pgi.618.1663928849810;
        Fri, 23 Sep 2022 03:27:29 -0700 (PDT)
Received: from localhost ([223.104.44.30])
        by smtp.gmail.com with ESMTPSA id ij29-20020a170902ab5d00b00172e19c5f8bsm5669042plb.168.2022.09.23.03.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 03:27:29 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com
Cc:     18801353760@163.com, almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzbot+8d6fbb27a6aded64b25b@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/ntfs3: fix slab-out-of-bounds Read in run_unpack
Date:   Fri, 23 Sep 2022 18:27:21 +0800
Message-Id: <20220923102721.32425-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923084917.17666-1-yin31149@gmail.com>
References: <20220923084917.17666-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sept 2022 at 16:51, Hawkins Jiawei <yin31149@gmail.com> wrote:
>
> Syzkaller reports slab-out-of-bounds bug as follows:
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in run_unpack+0x8b7/0x970 fs/ntfs3/run.c:944
> Read of size 1 at addr ffff88801bbdff02 by task syz-executor131/3611
>
> [...]
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:317 [inline]
>  print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
>  kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
>  run_unpack+0x8b7/0x970 fs/ntfs3/run.c:944
>  run_unpack_ex+0xb0/0x7c0 fs/ntfs3/run.c:1057
>  ntfs_read_mft fs/ntfs3/inode.c:368 [inline]
>  ntfs_iget5+0xc20/0x3280 fs/ntfs3/inode.c:501
>  ntfs_loadlog_and_replay+0x124/0x5d0 fs/ntfs3/fsntfs.c:272
>  ntfs_fill_super+0x1eff/0x37f0 fs/ntfs3/super.c:1018
>  get_tree_bdev+0x440/0x760 fs/super.c:1323
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1530
>  do_new_mount fs/namespace.c:3040 [inline]
>  path_mount+0x1326/0x1e20 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  [...]
>  </TASK>
>
> The buggy address belongs to the physical page:
> page:ffffea00006ef600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1bbd8
> head:ffffea00006ef600 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff88801bbdfe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88801bbdfe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88801bbdff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                    ^
>  ffff88801bbdff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88801bbe0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
> Kernel will tries to read record and parse MFT from disk in
> ntfs_read_mft().
>
> Yet the problem is that during enumerating attributes in record,
> kernel doesn't check whether run_off field loading from the disk
> is a valid value.
>
> To be more specific, if attr->nres.run_off is larger than attr->size,
> kernel will passes an invalid argument run_buf_size in
> run_unpack_ex(), which having an integer overflow. Then this invalid
> argument will triggers the slab-out-of-bounds Read bug as above.
>
> This patch solves it by adding the sanity check between
> the offset to packed runs and attribute size.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  fs/ntfs3/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 51363d4e8636..443a32f789ff 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -365,6 +365,11 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>         roff = le16_to_cpu(attr->nres.run_off);
>
>         t64 = le64_to_cpu(attr->nres.svcn);
> +
> +       /* offset to packed runs is out-of-bounds */
> +       if (roff > asize)
> +               goto out;
> +
>         err = run_unpack_ex(run, sbi, ino, t64, le64_to_cpu(attr->nres.evcn),
>                             t64, Add2Ptr(attr, roff), asize - roff);
>         if (err < 0)
> --
> 2.25.1
>
return -EINVAL when roff is out-of-bounds

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 51363d4e8636..10723231e482 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -365,6 +365,13 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	roff = le16_to_cpu(attr->nres.run_off);
 
 	t64 = le64_to_cpu(attr->nres.svcn);
+
+	/* offset to packed runs is out-of-bounds */
+	if (roff > asize) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = run_unpack_ex(run, sbi, ino, t64, le64_to_cpu(attr->nres.evcn),
 			    t64, Add2Ptr(attr, roff), asize - roff);
 	if (err < 0)
