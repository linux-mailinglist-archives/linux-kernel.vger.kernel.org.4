Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4A634BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiKWAir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiKWAip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:38:45 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123B5C6897;
        Tue, 22 Nov 2022 16:38:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VVU41Pr_1669163917;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VVU41Pr_1669163917)
          by smtp.aliyun-inc.com;
          Wed, 23 Nov 2022 08:38:39 +0800
Date:   Wed, 23 Nov 2022 08:38:33 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Zirong Lang <zlang@redhat.com>,
        linux-xfs@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: account extra freespace btree splits for multiple
 allocations
Message-ID: <Y31riSRTC6P11bZt@B-P7TQMD6M-0146.local>
Mail-Followup-To: Oliver Sang <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        Zirong Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221109034802.40322-1-hsiangkao@linux.alibaba.com>
 <202211220854.48dad6fd-oliver.sang@intel.com>
 <Y3wm8hwPMXcFNjiO@B-P7TQMD6M-0146.local>
 <Y3yeVzzt5WIIHfhm@xsang-OptiPlex-9020>
 <Y31qPk6+h80cFGXn@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y31qPk6+h80cFGXn@B-P7TQMD6M-0146.local>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry I sent out a staging reply, please ignore this.

On Wed, Nov 23, 2022 at 08:33:02AM +0800, Gao Xiang wrote:
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
> > 
> > 
> > if you still have concern, we could rerun tests. Thanks!
> 
> According to the report, I can see:
> 	67262           -29.6%      47384 ±  7%  fxmark.ssd_xfs_MWCM_18_directio.works/sec
> 	52786           -15.6%      44567 ±  4%  fxmark.ssd_xfs_MWCM_1_directio.works/sec
> 	63189           -23.3%      48486 ±  5%  fxmark.ssd_xfs_MWCM_2_directio.works/sec

I meant allocation strategy change may cause this, but I didn't think it
could cause such impact.  I will reconfirm on my own side as well.

Thanks,
Gao Xiang

