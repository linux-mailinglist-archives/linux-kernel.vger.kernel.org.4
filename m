Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7A960556B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiJTCSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJTCSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:18:46 -0400
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF55170DDC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:18:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VScrTTV_1666232317;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VScrTTV_1666232317)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 10:18:39 +0800
Date:   Thu, 20 Oct 2022 10:18:36 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ira.weiny@intel.com
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y1Cv/LuiGpVdO5im@B-P7TQMD6M-0146.local>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <2019477.yKVeVyVuyW@mypc>
 <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
 <12077010.O9o76ZdvQC@mypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12077010.O9o76ZdvQC@mypc>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:17:05PM +0200, Fabio M. De Francesco wrote:
> On Wednesday, October 19, 2022 1:36:55 AM CEST Gao Xiang wrote:
> > On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> > > On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:
> > 
> > ...
> > 
> > > 
> > > > One of what I need to care is nested kmap() usage,
> > > > some unmap/remap order cannot be simply converted to kmap_local()
> > > 
> > > Correct about nesting. If we map A and then B, we must unmap B and then A.
> > > 
> > > However, as you seem to convey, not always unmappings in right order 
> (stack 
> > > based) is possible, sometimes because very long functions have many loop's 
> > > breaks and many goto exit labels.
> > > 
> > > > but I think
> > > > it's not the case for erofs_bread().  Actually EROFS has one of such 
> nested
> > > > kmap() usage, but I don't really care its performance on HIGHMEM 
> platforms,
> > > > so I think kmap() is still somewhat useful compared to kmap_local() from 
> > > this
> > > > point of view],
> > > 
> 
> fs/erofs conversions are in our (Ira's and my) list. So I'm am happy to see 
> that we can delete some entries because of your changes. :-)
> 
> > > In Btrfs I solved (thanks to David S.' advice) by mapping only one of two 
> > > pages, only the one coming from the page cache. 
> > > 
> > > The other page didn't need the use of kmap_local_page() because it was 
> > > allocated in the filesystem with "alloc_page(GFP_NOFS)". GFP_NOFS won't 
> ever 
> > > allocate from ZONE_HIGHMEM, therefore a direct page_address() could avoid 
> the 
> > > mapping and the nesting issues.
> > > 
> > > Did you check if you may solve the same way? 
> > 
> > That is not simple.  Currently we have compressed pages and decompressed
> > pages (page cache or others), and they can be unmapped when either data
> > is all consumed, so compressed pages can be unmapped first, or
> > decompressed pages can be unmapped first.  That quite depends on which
> > pages goes first.
> > 
> > I think such usage is a quite common pattern for decoder or encoder,
> > you could take a look at z_erofs_lzma_decompress() in
> > fs/erofs/decompressor_lzma.c.  
> 
> I haven't yet read that code, however I may attempt to propose a pattern for 
> solving this kinds of issue, I mean where you don't know which page got mapped 
> last...
> 
> It's not elegant but it may work. You have compressed and decompressed pages 
> and you can't know in advance what page should be unmapped first because you 
> can't know in which order they where mapped, right?
> 

Not really.

> I'd use a variable to save two different values, each representing the last 
> page mapped. When the code gets to the unmapping block (perhaps in an "out" 
> label), just check what that variable contains. Depending on that value, say 
> 'c' or 'd', you will be able to know what must be unmapped for first. An "if / 
> else" can do the work.

That is not the simple nested unmapped case as you said above, I could take
a very brief example:

1. map a decompresed page
2. map a compressed page
3. working
4. decompressed page is all consumed, unmap the current decompressed page
5. map the next decompressed page
6. working
7. decompressed page is all consumed, unmap the current decompressed page
8. map the next decompressed page
9. working
10. compressed page is all consumed, unmap the current compressed page
11. map the next compressed page
12. working
13. ... (anyway, unmap and remap a compressed page or a decompressed page
         in any order.)

until all process is finished.  by using kmap(), it's much simple to
implement this, but kmap_local(), it only complexes the code.

Thanks,
Gao Xiang

> 
> What do you think of this?
> 
