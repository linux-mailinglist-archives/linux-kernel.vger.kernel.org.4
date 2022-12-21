Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16E7652B76
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiLUC27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiLUC25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:28:57 -0500
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393821F9EF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:28:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VXnYyUA_1671589729;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXnYyUA_1671589729)
          by smtp.aliyun-inc.com;
          Wed, 21 Dec 2022 10:28:51 +0800
Date:   Wed, 21 Dec 2022 10:28:49 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        joneslee@google.com, linux-kernel@vger.kernel.org
Subject: Re: BUG: unable to handle kernel paging request in
 z_erofs_decompress_queue
Message-ID: <Y6JvYbFvH1VA6Cd/@B-P7TQMD6M-0146.local>
References: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
 <Y5suEZgZn6JNIKxm@B-P7TQMD6M-0146.local>
 <947527a5-f345-b7c8-6938-9a8d2863fbac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <947527a5-f345-b7c8-6938-9a8d2863fbac@linaro.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 05:42:21PM +0200, Tudor Ambarus wrote:
> Hi, Gao,
> 
> On 15.12.2022 16:24, Gao Xiang wrote:
> > Hi Tudor,
> > 
> > On Thu, Dec 15, 2022 at 02:58:10PM +0200, Tudor Ambarus wrote:
> > > Hi, Gao, Chao, Yue, Jeffle, all,
> > > 
> > > Syzbot reported a bug at [1] that is reproducible in upstream kernel
> > > since
> > >    commit 47e4937a4a7c ("erofs: move erofs out of staging")
> > > 
> > > and up to (inclusively)
> > >    commit 2bfab9c0edac ("erofs: record the longest decompressed size in this
> > > round")
> > > 
> > > The first commit that makes this bug go away is:
> > >    commit 267f2492c8f7 ("erofs: introduce multi-reference pclusters
> > > (fully-referenced)")
> > > Although, this commit looks like new support and not like an explicit
> > > bug fix.
> > > 
> > > I'd like to fix the lts kernels. I'm happy to try any suggestions or do
> > > some tests. Please let me know if the bug rings a bell.
> > 
> > Thanks for your report.  I will try to seek time to look at this this
> > weekend.  But just from your description, I guess that there could be
> > something wrong on several compressed extents pointing to the same
> > blocks (i.e. the same pcluster).  But prior to commit 267f2492c8f7, such
> > image is always considered as corrupted images.
> > 
> > Anyway, I will look into that and see if there could be alternative ways
> > to fix this rather than backport the whole multi-reference pcluster
> > feature.  Yet I think no need to worry since such image is pretty
> > crafted and should be used as normal images.
> 
> I guess to backport the multi-reference pcluster feature is not an
> option for stable - just fixes are accepted. If you think it is worth
> fixing the problem without adding new support, I can dive into it.
> Let me know what you think.

Thanks, I was quite busy these days. Partially due to my main part of
work is not only EROFS.

Even that I have some wild guess, if you have some interests, I
think you could use dump.erofs or filefrag -v to dump out related inode
extents (assuming that is root inode) and see if there are any strange
first.

That would be helpful for me to know where it could lead to this issue.

Thanks,
Gao Xiang
