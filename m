Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE2C618D44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 01:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKDAhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 20:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiKDAhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:37:22 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEE764FA;
        Thu,  3 Nov 2022 17:37:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VTuGrf9_1667522236;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VTuGrf9_1667522236)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 08:37:18 +0800
Date:   Fri, 4 Nov 2022 08:37:16 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zirong Lang <zlang@redhat.com>
Subject: Re: [PATCH v2] xfs: extend the freelist before available space check
Message-ID: <Y2RevDyoeJZSpiat@B-P7TQMD6M-0146.local>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Zirong Lang <zlang@redhat.com>
References: <20221103094639.39984-1-hsiangkao@linux.alibaba.com>
 <20221103131025.40064-1-hsiangkao@linux.alibaba.com>
 <20221103230542.GK3600936@dread.disaster.area>
 <Y2RdSCozXhKPeN8V@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Fk3+n2Y+wYBbKtFP"
Content-Disposition: inline
In-Reply-To: <Y2RdSCozXhKPeN8V@B-P7TQMD6M-0146.local>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fk3+n2Y+wYBbKtFP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Nov 04, 2022 at 08:31:04AM +0800, Gao Xiang wrote:
> Hi Dave,
> 
> On Fri, Nov 04, 2022 at 10:05:42AM +1100, Dave Chinner wrote:
> > On Thu, Nov 03, 2022 at 09:10:25PM +0800, Gao Xiang wrote:
> > > There is a long standing issue which could cause fs shutdown due to
> > > inode extent to btree conversion failure right after an extent
> > > allocation in the same AG, which is absolutely unexpected due to the
> > > proper minleft reservation in the previous allocation.  Brian once
> > > addressed one of the root cause [1], however, such symptom can still
> > > occur after the commit is merged as reported [2], and our cloud
> > > environment is also suffering from this issue.
> > > 
> > > From the description of the commit [1], I found that Zirong has an
> > > in-house stress test reproducer for this issue, therefore I asked him
> > > to reproduce again and he confirmed that such issue can still be
> > > reproducable on RHEL 9.
> > > 
> > > Thanks to him, after dumping the transaction log items, I think
> > > the root cause is as below:
> > >  1. Allocate space with the following condition:
> > >     freeblks: 18304 pagf_flcount: 6
> > >     reservation: 18276 need (min_free): 6
> > >     args->minleft: 1
> > >     available = freeblks + agflcount - reservation - need - minleft
> > >               = 18304 + min(6, 6) - 18276 - 6 - 1 = 27
> > > 
> > >     The first allocation check itself is ok;
> > > 
> > >  2. At that time, the AG state is
> > >     AGF Buffer: (XAGF)
> > >         ver:1  seq#:3  len:2621424
> > >         root BNO:9  CNT:7
> > >         level BNO:2  CNT:2
> > >         1st:64  last:69  cnt:6  freeblks:18277  longest:6395
> >                                   ^^^^^^^^^^^^^^
> > 
> > Hold on - pag->pagf_freeblks != agf->freeblks, and if we start with
> > the agf freeblocks:
> > 
> > 	available = 18277 + 6 - 18276 - 6 - 1 = 0
> > 
> > IOWs, the allocation should never selected this AG in the first
> > place.
> > 
> > So why is pag->pagf_freeblks not equal to agf->freeblks when this
> > allocation was first checked? It's clearly not because the AGFL is
> > unpopulated - both the perag and the agf indicate it has the minimum
> > 6 blocks already allocated....
> 
> Thanks for the reply.
> 
> I may mispresent 2) here since there are several AGF agno 3 recording,
> the last completed trans printed by "xfs_logprint" is:
> 
> ============================================================================
> TRANS: tid:0xaf57a744  #items:621  trans:0xaf57a744  q:0x56104c44be70
> CUD: cnt:1 total:1 a:0x56104c44e320 len:16
> CUD:  #regs: 1                   id: 0xff110004e02bc1e8
> EFI: cnt:1 total:1 a:0x56104c447b30 len:32
>         EFI:  #regs:1   num_extents:1  id:0xff110001bd8c56e0
>         (s: 0xe7cc8d, l: 3)
> EFD: cnt:1 total:1 a:0x56104c42d1b0 len:32
>         EFD:  #regs: 1  num_extents: 1  id: 0xff110001bd8c56e0
> BUF: cnt:2 total:2 a:0x56104c42f5c0 len:24 a:0x56104c4712e0 len:128
>         BUF:  #regs:2   start blkno:0x3bffe81   len:1   bmap size:1   flags:0x2800
>         AGF Buffer: (XAGF)
>                 ver:1  seq#:3  len:2621424
>                 root BNO:9  CNT:7
>                 level BNO:2  CNT:2
>                 1st:64  last:69  cnt:6  freeblks:18304  longest:6395
> 
> So I think freeblks starts from 18304.
> 
> 18277 is just an intermediate state in my mind (Actually there is also such AGF
> record, but that is not the latest one because this is a stress test), sorry
> for this.
> 
> In short, in order to do the first allocation, I think it allocates from
>  freeblks 18304 -> 18276


                      ^ sorry 18277 here, already too many numbers in my head

I tried to send dmesg.log.xz in this thread, since I'm not sure whether
@vger.kernel.org will drop this email directly or not.

Thanks,
Gao Xiang


>  agflcount 6->5
> And the second one fails,
>      available = freeblks + agflcount - reservation - need - minleft
>                = 18277 + min(5, 6) - 18276 - 6 - 0 = 0   < 1
> I also think it can happen in the current codebase.
> 
> Full xfs_logprint is too large to send by email to the mailing list, but
> I could send this separately to you if really needed.
> 
> My debugging message catched when xfs_trans_cancel() attached in the
> following reply of this email.
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com

--Fk3+n2Y+wYBbKtFP
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmesg.log.xz"
Content-Transfer-Encoding: base64

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
3nTvog4AYxpQLbHEZ/sCAAAAAARZWg==

--Fk3+n2Y+wYBbKtFP--
