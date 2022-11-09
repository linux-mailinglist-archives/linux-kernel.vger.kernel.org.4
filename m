Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C91622292
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiKID0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKID0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:26:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14FB19294;
        Tue,  8 Nov 2022 19:26:32 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6Vf275CZzpWCw;
        Wed,  9 Nov 2022 11:22:50 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 11:26:31 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 11:26:30 +0800
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in
 nilfs_segctor_prepare_write()
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
References: <20221108022928.497746-1-liushixin2@huawei.com>
 <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
 <5c8dd545-2190-162e-a9de-2323fcad716f@huawei.com>
 <CAKFNMokcSj9YSLeXm=S4rY5nMx6DjQvRHXVaLVu2CbNEia7-2Q@mail.gmail.com>
 <781fc98e-351c-58b0-b0e7-e5080a193d31@huawei.com>
 <CAKFNMomK=C4JY7ftNQs7Zs3dr0m=e_k-vVXTfmR-mpumuGUtDw@mail.gmail.com>
 <CAKFNMokX6wudO+WJbdc4-1gTXLXn59=dvm0CLGeXAFiA+kJXdg@mail.gmail.com>
 <CAKFNMomUYhQOHnKJohN_84ROhaD4TgPD=bsV0SPG992uG-8fCQ@mail.gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-nilfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <3157f29e-5f82-92d3-4ecf-c4fa2b9b13c2@huawei.com>
Date:   Wed, 9 Nov 2022 11:26:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAKFNMomUYhQOHnKJohN_84ROhaD4TgPD=bsV0SPG992uG-8fCQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/9 1:50, Ryusuke Konishi wrote:
> Hi Liu Shixin,
>
> I'm sorry for my repeated emails.
>
> On Wed, Nov 9, 2022 at 12:13 AM Ryusuke Konishi wrote:
>>> I think the most likely cause is metadata corruption.  If so, we
>>> should fix it by adding a proper sanity check, yes.
>>> However, there is still the possibility that the error retry logic
>>> after detecting errors has a flaw. (I believe at least this is not a
>>> problem with normal paths.)
>>> The sufile state inconsistency above is hypothetical for now.
>>> Either way, I'd like to make sure what's actually happening (and where
>>> the anomaly is coming from) so we can decide how to fix it.
>> I noticed that this syzbot report has a disk image "mount_0.gz", so I
>> tried to mount it read-only.
>> The result was as follows:
>>
>> $ sudo mount -t nilfs2 -r ./mount_0 /mnt/test
>> $ lssu
>>               SEGNUM        DATE     TIME STAT     NBLOCKS
>>                    0  26760730-10-29 19:40:00  -de   527958016
>>                    1  26760730-11-01 20:29:04  -de   527958016
>>                    2  1176433641-11-01 02:01:52  -de  2983038235
>>                    3  -1158249729-11-01 04:57:19  a--       25375
>>                    4  1970-01-02 21:24:32  a--           0
>>                    5  -1415215929-01-02 00:19:15  --e  1631451365
>>                    6  841067190-01-02 13:02:59  -d-  3101461260
>>                    7  1495233207-01-02 01:31:11  -de  1697748441
>>                    8  1875753393-01-02 21:54:14  -de   337757600
>>                    9  648878284-01-02 21:06:08  ---  2133388152
>>                   10  2122778986-01-02 17:49:43  --e   874605800
>>                   11  55846197-01-02 09:50:53  -de  4262365368
>>                   12  1872396026-01-02 06:45:18  ---  1051768258
>>                   13  820920473-01-02 19:28:35  --e  2932336675
>>                   14  2128306755-01-02 10:17:45  ---  3568501216
>>                   15  1457063063-01-02 01:24:17  --e  2330511560
>>                   16  586864775-01-02 16:08:15  ---   355283425
>>                   17  -824870041-01-02 22:47:26  -d-  4177999057
>>                   18  1562176264-01-02 08:06:45  ---  1312597355
>>                   19  -392925420-01-02 17:08:27  -d-  3811075948
>>                   20  1927575458-01-02 21:26:51  -de  1384562525
>>                   21  2139923505-01-02 08:16:04  -d-    41861305
>>
>> Here,  we can see that neither segment #3 (= ns_segnum) nor #4 (=
>> ns_nextnum) has the dirty flag
>> ("d" in STAT).   So, as expected, this seems to be the root cause of
>> the duplicate assignments and oops.
>> The proper correction would be, therefore, to check and reject (or
>> fix) this anomaly while outputting an error message
>> (or warning if fix it at the same time).
>> It should be inserted in mount time logic because the segments that
>> nilfs2 itself allocates are always marked dirty with
>> nilfs_sufile_alloc().
> I will change my opinion.
>
> Considering the possibility of sufile corruption at runtime, it seems
> that the sanity check should be done on every nilfs_sufile_alloc()
> call.
>
> I now think nilfs_sufile_alloc() should call nilfs_error() and return
> -EIO if the number of a newly found vacant segment matches
> nilfs->ns_segnum or nilfs->ns_nextnum.
Before we add the first segbuf into sci->sc_segbufs in nilfs_segctor_begin_construction(),
there is no possibility existing duplicate segnum. And the subsequent process should
not be affected by sufile corruption. So I think it's enough to only check for case alloc==0.
I don't find any other possible wrong scenarios.

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 7be632c15f91..7b91c790b798 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1326,7 +1326,13 @@ static int nilfs_segctor_begin_construction(struct nilfs_sc_info *sci,
                err = nilfs_sufile_alloc(nilfs->ns_sufile, &nextnum);
                if (err)
                        goto failed;
+       } else {
+               /* Check the next segment has alreadly been allocated */
+               err = nilfs_sufile_test_allocated(nilfs->ns_sufile, nextnum);
+               if (err)
+                       goto failed;
        }
+
        nilfs_segbuf_set_next_segnum(segbuf, nextnum, nilfs);
 
        BUG_ON(!list_empty(&sci->sc_segbufs));
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 853a8212114f..8dff12c56891 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -399,6 +399,36 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
        return ret;
 }
 
+int nilfs_sufile_test_allocated(struct inode *sufile, __u64 *segnump)
+{
+       struct buffer_head *su_bh;
+       struct nilfs_segment_usage *su;
+       void *kaddr;
+       int ret;
+
+       down_write(&NILFS_MDT(sufile)->mi_sem);
+
+       ret = nilfs_sufile_get_segment_usage_block(sufile, segnump, 1,
+                                                  &su_bh);
+       if (ret < 0)
+               goto out_sem;
+
+       kaddr = kmap_atomic(su_bh->b_page);
+       su = nilfs_sufile_block_get_segment_usage(
+               sufile, segnump, su_bh, kaddr);
+
+       if (nilfs_segment_usage_clean(su))
+               ret = -EIO;
+
+       kunmap_atomic(kaddr);
+
+       brelse(su_bh);
+
+out_sem:
+       up_write(&NILFS_MDT(sufile)->mi_sem);
+       return ret;
+}
+
 void nilfs_sufile_do_cancel_free(struct inode *sufile, __u64 segnum,
                                 struct buffer_head *header_bh,
                                 struct buffer_head *su_bh)
diff --git a/fs/nilfs2/sufile.h b/fs/nilfs2/sufile.h
index 8e8a1a5a0402..02b61ca6f318 100644
--- a/fs/nilfs2/sufile.h
+++ b/fs/nilfs2/sufile.h
@@ -24,6 +24,7 @@ unsigned long nilfs_sufile_get_ncleansegs(struct inode *sufile);
 
 int nilfs_sufile_set_alloc_range(struct inode *sufile, __u64 start, __u64 end);
 int nilfs_sufile_alloc(struct inode *, __u64 *);
+int nilfs_sufile_test_allocated(struct inode *, __u64 *);
 int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum);
 int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
                                   unsigned long nblocks, time64_t modtime);

>
> This test should not need to be done for every segbuf's sb_segnum
> because metadata blocks that contain the information about allocated
> segments are kept in memory because of its dirty state and will not be
> destroyed until they are finally written out.
>
> One correction then.  Just checking the output of the lssu command
> wasn't enough because the following test is done on all flags except
> the active flag "a".  (this flag is not persistent and visible only
> when seeing via ioctl.)
>
>>                         if (!nilfs_segment_usage_clean(su))
>>                                 continue;
>>                         /* found a clean segment */
> We also had to see the invisible flags as well to confirm if that is
> the root cause, but lssu doens't show them all.  So I checked the dump
> data of the mount_0 file.
> As a result, the segment at ns_segnum was not clean, but that of
> ns_nextnum was clean, which means it's the root cause as expected.
Thanks for your confirmation.

Regards,
Liu Shixin
.
>
> Regards,
> Ryusuke Konishi
> .
>

