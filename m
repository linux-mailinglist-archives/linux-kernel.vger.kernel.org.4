Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D79F617E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiKCN4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiKCN4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:56:00 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8528515717;
        Thu,  3 Nov 2022 06:55:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VTt9LJG_1667483754;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VTt9LJG_1667483754)
          by smtp.aliyun-inc.com;
          Thu, 03 Nov 2022 21:55:56 +0800
Date:   Thu, 3 Nov 2022 21:55:51 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Zirong Lang <zlang@redhat.com>
Subject: Re: [PATCH v2] xfs: extend the freelist before available space check
Message-ID: <Y2PIZ6AFJoSk+9SQ@B-P7TQMD6M-0146.local>
Mail-Followup-To: linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Zirong Lang <zlang@redhat.com>
References: <20221103094639.39984-1-hsiangkao@linux.alibaba.com>
 <20221103131025.40064-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221103131025.40064-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 03, 2022 at 09:10:25PM +0800, Gao Xiang wrote:
> There is a long standing issue which could cause fs shutdown due to
> inode extent to btree conversion failure right after an extent
> allocation in the same AG, which is absolutely unexpected due to the
> proper minleft reservation in the previous allocation.  Brian once
> addressed one of the root cause [1], however, such symptom can still
> occur after the commit is merged as reported [2], and our cloud
> environment is also suffering from this issue.
> 
> From the description of the commit [1], I found that Zirong has an
> in-house stress test reproducer for this issue, therefore I asked him
> to reproduce again and he confirmed that such issue can still be
> reproducable on RHEL 9.
> 
> Thanks to him, after dumping the transaction log items, I think
> the root cause is as below:
>  1. Allocate space with the following condition:
>     freeblks: 18304 pagf_flcount: 6
>     reservation: 18276 need (min_free): 6
>     args->minleft: 1
>     available = freeblks + agflcount - reservation - need - minleft
>               = 18304 + min(6, 6) - 18276 - 6 - 1 = 27
> 
>     The first allocation check itself is ok;
> 
>  2. At that time, the AG state is
>     AGF Buffer: (XAGF)
>         ver:1  seq#:3  len:2621424
>         root BNO:9  CNT:7
>         level BNO:2  CNT:2
>         1st:64  last:69  cnt:6  freeblks:18277  longest:6395
> 
>     agfl (flfirst = 64, fllast = 69, flcount = 6)
>     64:547 65:167 66:1651 67:2040807 68:783 69:604
> 
>  3. Then, cntbt needs a new btree block (so take one block
>     from agfl), and then the log records a new AGF:
>     blkno 62914177, len 1, map_size 1
>     00000000: 58 41 47 46 00 00 00 01 00 00 00 03 00 27 ff f0  XAGF.........'..
>     00000010: 00 00 00 09 00 00 00 07 00 00 00 00 00 00 00 02  ................
>     00000020: 00 00 00 02 00 00 00 00 00 00 00 41 00 00 00 45  ...........A...E
>     00000030: 00 00 00 05 00 00 47 65 00 00 18 fb 00 00 00 09  ......Ge........
>     00000040: 75 dc c1 b5 1a 45 40 2a 80 50 72 f0 59 6e 62 66  u....E@*.Pr.Ynbf
>     agf 3  flfirst: 65 (0x41) fllast: 69 (0x45) cnt: 5
>     freeblks 18277
> 
>  4. agfl 64 (daddr 62918552) was then written as a cntbt block
>     log item:
>       type#011= 0x123c
>       flags#011= 0x8
>     blkno 62918552, len 8, map_size 1
>     00000000: 41 42 33 43 00 00 00 fd 00 1f 23 e4 ff ff ff ff  AB3C......#.....
>     00000010: 00 00 00 00 03 c0 0f 98 00 00 00 00 00 00 00 00  ................
>     00000020: 75 dc c1 b5 1a 45 40 2a 80 50 72 f0 59 6e 62 66  u....E@*.Pr.Ynbf
> 
>  5. Finally, the following inode extent to btree allocation fails:
>     Nov  1 07:56:09 dell-per750-08 kernel: ------------[ cut here ]------------
>     Nov  1 07:56:09 dell-per750-08 kernel: WARNING: CPU: 15 PID: 49290 at fs/xfs/libxfs/xfs_bmap.c:717 xfs_bmap_extents_to_btree+0xc51/0x1050 [xfs]
>     ...
>     Nov  1 07:56:10 dell-per750-08 kernel: XFS (sda2): agno 3 agflcount 5 freeblks 18277 reservation 18276 6
> 
>     since
> 
>     available = freeblks + agflcount - reservation - need - minleft
>               = 18277 + min(5, 6) - 18276 - 6 - 0 = 0   < 1
>     kaboom.
>

Perhaps it's still not a correct fix since the second conversion
allocation will fail as:

      available = freeblks + agflcount - reservation - need - minleft
                = 18276 + min(6, 6) - 18276 - 6 - 0 = 0   < 1

If we don't want to use the last blocks of the AG, we should shorten
args->maxlen to avoid touch these agfl blocks, thoughts?

2300 static bool
2301 xfs_alloc_space_available(
2302         struct xfs_alloc_arg    *args,
2303         xfs_extlen_t            min_free,
2304         int                     flags)
2305 {

...

2329         available = (int)(pag->pagf_freeblks + agflcount -
2330                           reservation - min_free - args->minleft);

             ^ here available = 27

2331         if (available < (int)max(args->total, alloc_len))
2332                 return false;
2333
2334         /*
2335          * Clamp maxlen to the amount of free space available for the actual
2336          * extent allocation.
2337          */
2338         if (available < (int)args->maxlen && !(flags & XFS_ALLOC_FLAG_CHECK)) {
2339                 args->maxlen = available;

             ^ so args->maxlen = 27 here

and then freeblks from 18304 - 27 = 18277, but with another agfl block
allocated (pagf_flcount from 6 to 5), the inequality will not satisfy:

     available = freeblks + agflcount - reservation - need - minleft
               = 18277 + min(5, 6) - 18276 - 6 - 0 = 0   < 1

I think one of the correct fix is to fix args->maxlen above though, or
some better preferred idea to fix this?

Thanks,
Gao Xiang
