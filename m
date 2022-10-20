Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432F0605619
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJTDuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJTDug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:50:36 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA9210F886
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:50:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSdLuJ5_1666237829;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSdLuJ5_1666237829)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 11:50:31 +0800
Date:   Thu, 20 Oct 2022 11:50:28 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y1DFhKvOWvJacTIk@B-P7TQMD6M-0146.local>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <2019477.yKVeVyVuyW@mypc>
 <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
 <12077010.O9o76ZdvQC@mypc>
 <Y1Cv/LuiGpVdO5im@B-P7TQMD6M-0146.local>
 <Y1C9y2y/87tIgfia@iweiny-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1C9y2y/87tIgfia@iweiny-mobl>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:17:31PM -0700, Ira Weiny wrote:
> On Thu, Oct 20, 2022 at 10:18:36AM +0800, Gao Xiang wrote:
> > On Wed, Oct 19, 2022 at 08:17:05PM +0200, Fabio M. De Francesco wrote:
> > > On Wednesday, October 19, 2022 1:36:55 AM CEST Gao Xiang wrote:
> > > > On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> > > > > On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:
> 
> [snip]
> 
> > 
> > That is not the simple nested unmapped case as you said above, I could take
> > a very brief example:
> 
> Building on this.  The uncompressed pages always outnumber the compressed
> pages, right?

Yes, it's always true for EROFS case.

I think if the locking order is reversed I could unmap and remap the
pages in the correct order.  But as you said below, it just could work
but complex the code (I think if you have extra time you could check
the code first.)

So as I said before, I don't really care HIGHMEM performance so here
kmap_local() cannot benefit such case.  Anyway, it'd be much better
if kmap() is kept on my side anyway.

Thanks,
Gao Xiang

> 
> > 
> > 1. map a decompresed page
> > 2. map a compressed page
> 
> First reverse these because you are going to need to map a new decompressed
> page before another compressed page.  So:
> 
> 1. map compressed
> 2. map decompressed
> 
> Then 4/5 and 7/8 become unmap/map new without issue.
> 
> > 3. working
> > 4. decompressed page is all consumed, unmap the current decompressed page
> > 5. map the next decompressed page
> > 6. working
> > 7. decompressed page is all consumed, unmap the current decompressed page
> > 8. map the next decompressed page
> > 9. working
> 
> This is more complicated but not overly so.
> 
> Simply
> 
> 9.1 unmap decompressed
> 
> > 10. compressed page is all consumed, unmap the current compressed page
> > 11. map the next compressed page
> 
> 11.1 remap decompressed
> 
> > 12. working
> > 13. ... (anyway, unmap and remap a compressed page or a decompressed page
> >          in any order.)
> > 
> > until all process is finished.  by using kmap(), it's much simple to
> > implement this, but kmap_local(), it only complexes the code.
> 
> Agreed kmap() is easier but I think this could work.
> 
> Basically you keep the compressed mapped first.
> 
> I also assume there is also a reverse of this so reverse the pages in that
> case.
> 
> Thoughts?
> Ira
