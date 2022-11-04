Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB42618D38
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 01:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiKDAbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 20:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiKDAbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:31:11 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E55B2228A;
        Thu,  3 Nov 2022 17:31:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VTuQtrw_1667521864;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VTuQtrw_1667521864)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 08:31:06 +0800
Date:   Fri, 4 Nov 2022 08:31:04 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zirong Lang <zlang@redhat.com>
Subject: Re: [PATCH v2] xfs: extend the freelist before available space check
Message-ID: <Y2RdSCozXhKPeN8V@B-P7TQMD6M-0146.local>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Zirong Lang <zlang@redhat.com>
References: <20221103094639.39984-1-hsiangkao@linux.alibaba.com>
 <20221103131025.40064-1-hsiangkao@linux.alibaba.com>
 <20221103230542.GK3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221103230542.GK3600936@dread.disaster.area>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Fri, Nov 04, 2022 at 10:05:42AM +1100, Dave Chinner wrote:
> On Thu, Nov 03, 2022 at 09:10:25PM +0800, Gao Xiang wrote:
> > There is a long standing issue which could cause fs shutdown due to
> > inode extent to btree conversion failure right after an extent
> > allocation in the same AG, which is absolutely unexpected due to the
> > proper minleft reservation in the previous allocation.  Brian once
> > addressed one of the root cause [1], however, such symptom can still
> > occur after the commit is merged as reported [2], and our cloud
> > environment is also suffering from this issue.
> > 
> > From the description of the commit [1], I found that Zirong has an
> > in-house stress test reproducer for this issue, therefore I asked him
> > to reproduce again and he confirmed that such issue can still be
> > reproducable on RHEL 9.
> > 
> > Thanks to him, after dumping the transaction log items, I think
> > the root cause is as below:
> >  1. Allocate space with the following condition:
> >     freeblks: 18304 pagf_flcount: 6
> >     reservation: 18276 need (min_free): 6
> >     args->minleft: 1
> >     available = freeblks + agflcount - reservation - need - minleft
> >               = 18304 + min(6, 6) - 18276 - 6 - 1 = 27
> > 
> >     The first allocation check itself is ok;
> > 
> >  2. At that time, the AG state is
> >     AGF Buffer: (XAGF)
> >         ver:1  seq#:3  len:2621424
> >         root BNO:9  CNT:7
> >         level BNO:2  CNT:2
> >         1st:64  last:69  cnt:6  freeblks:18277  longest:6395
>                                   ^^^^^^^^^^^^^^
> 
> Hold on - pag->pagf_freeblks != agf->freeblks, and if we start with
> the agf freeblocks:
> 
> 	available = 18277 + 6 - 18276 - 6 - 1 = 0
> 
> IOWs, the allocation should never selected this AG in the first
> place.
> 
> So why is pag->pagf_freeblks not equal to agf->freeblks when this
> allocation was first checked? It's clearly not because the AGFL is
> unpopulated - both the perag and the agf indicate it has the minimum
> 6 blocks already allocated....

Thanks for the reply.

I may mispresent 2) here since there are several AGF agno 3 recording,
the last completed trans printed by "xfs_logprint" is:

============================================================================
TRANS: tid:0xaf57a744  #items:621  trans:0xaf57a744  q:0x56104c44be70
CUD: cnt:1 total:1 a:0x56104c44e320 len:16
CUD:  #regs: 1                   id: 0xff110004e02bc1e8
EFI: cnt:1 total:1 a:0x56104c447b30 len:32
        EFI:  #regs:1   num_extents:1  id:0xff110001bd8c56e0
        (s: 0xe7cc8d, l: 3)
EFD: cnt:1 total:1 a:0x56104c42d1b0 len:32
        EFD:  #regs: 1  num_extents: 1  id: 0xff110001bd8c56e0
BUF: cnt:2 total:2 a:0x56104c42f5c0 len:24 a:0x56104c4712e0 len:128
        BUF:  #regs:2   start blkno:0x3bffe81   len:1   bmap size:1   flags:0x2800
        AGF Buffer: (XAGF)
                ver:1  seq#:3  len:2621424
                root BNO:9  CNT:7
                level BNO:2  CNT:2
                1st:64  last:69  cnt:6  freeblks:18304  longest:6395

So I think freeblks starts from 18304.

18277 is just an intermediate state in my mind (Actually there is also such AGF
record, but that is not the latest one because this is a stress test), sorry
for this.

In short, in order to do the first allocation, I think it allocates from
 freeblks 18304 -> 18276
 agflcount 6->5
And the second one fails,
     available = freeblks + agflcount - reservation - need - minleft
               = 18277 + min(5, 6) - 18276 - 6 - 0 = 0   < 1
I also think it can happen in the current codebase.

Full xfs_logprint is too large to send by email to the mailing list, but
I could send this separately to you if really needed.

My debugging message catched when xfs_trans_cancel() attached in the
following reply of this email.

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
