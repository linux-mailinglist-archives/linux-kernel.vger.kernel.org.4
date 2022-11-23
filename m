Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2105634BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiKWAmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiKWAm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:42:29 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F6360E7;
        Tue, 22 Nov 2022 16:42:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VVU6Gh8_1669164140;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VVU6Gh8_1669164140)
          by smtp.aliyun-inc.com;
          Wed, 23 Nov 2022 08:42:23 +0800
Date:   Wed, 23 Nov 2022 08:42:16 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Zirong Lang <zlang@redhat.com>,
        linux-xfs@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: account extra freespace btree splits for multiple
 allocations
Message-ID: <Y31saO9m0ixZKdkV@B-P7TQMD6M-0146.local>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Zirong Lang <zlang@redhat.com>,
        linux-xfs@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221109034802.40322-1-hsiangkao@linux.alibaba.com>
 <202211220854.48dad6fd-oliver.sang@intel.com>
 <Y3wm8hwPMXcFNjiO@B-P7TQMD6M-0146.local>
 <Y3yeVzzt5WIIHfhm@xsang-OptiPlex-9020>
 <20221122224243.GS3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122224243.GS3600936@dread.disaster.area>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:42:43AM +1100, Dave Chinner wrote:
> On Tue, Nov 22, 2022 at 06:03:03PM +0800, Oliver Sang wrote:
> > hi Gao Xiang,
> > 
> > On Tue, Nov 22, 2022 at 09:33:38AM +0800, Gao Xiang wrote:
> > > On Tue, Nov 22, 2022 at 09:09:34AM +0800, kernel test robot wrote:
> > > > 
> > > > please be noted we noticed Gao Xiang and Dave Chinner have already had lots of
> > > > discussion around this patch, which seems there is maybe new version later.
> > > > we just sent out this report FYI the possible performance impact of this patch.
> > > > 
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed a -15.1% regression of fxmark.ssd_xfs_MWCM_72_directio.works/sec due to commit:
> > > 
> > > Thanks for your report!
> > > 
> > > At a glance, I have no idea why this commit can have performance
> > > impacts.  Is the result stable?
> > 
> > in our tests, the result is quite stable.
> >      45589           -15.1%      38687 ±  2%  fxmark.ssd_xfs_MWCM_72_directio.works/sec
> > 
> > and detail data is as below:
> > for this commit:
> >   "fxmark.ssd_xfs_MWCM_72_directio.works/sec": [
> >     39192.224368,
> >     39665.690567,
> >     38980.680601,
> >     37298.99538,
> >     37483.256377,
> >     39504.606569
> >   ],
> > 
> > for parent:
> >   "fxmark.ssd_xfs_MWCM_72_directio.works/sec": [
> >     45381.458009,
> >     45314.376204,
> >     45724.688965,
> >     45751.955937,
> >     45614.323267,
> >     45747.216475
> >   ],
> 
> This MWCM workload uses a shared directory. Every worker thread (72
> of them) iterates creating a new file, writes 4kB of data to it and
> then closes it. There is no synchronisation between worker threads.
> 
> The worker threads will lockstep on the directory lock for file
> creation, they will all attempt to allocate data in the same AG as
> the file is created. Hence writeback will race with file creation
> for AG locks, too.  Once the first AG is full, they will all attempt
> to allocate in the next AG (file creation and writeback).
> 
> IOWs, this workload will race to fill AGs, will exercise the "AG
> full so skip to next AG" allocator fallbacks, etc.

Glad to know about that.  I didn't look into the MWCM workload before.

> 
> Changing where/how AGs are considered full will impact how the AG
> selection is made. I'm betting that there's a mismatch between the
> code that selects the initial AG for allocation (from
> xfs_bmap_btalloc() via the nullfb case) and the code that selects
> the actual AG for allocation (xfs_alloc_vextent() w/ NEAR_BNO
> policy) as a result of this change. This then results in
> xfs_alloc_vextent() trying to initially allocate from an AG that
> xfs_alloc_fix_freelist() considers to be full, so it skips the
> initial selected AG and starts searching for an AG it can allocate
> into.

I can imagine, but I didn't think out several block reservation could
cause such huge impacts.

> 
> Combine that with AGF lock contention from 70+ tasks all trying to
> allocate in the same location...

Yeah, anyway, I will reconfirm on our side about this workload
as well.

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
