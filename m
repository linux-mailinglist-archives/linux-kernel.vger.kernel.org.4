Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B66036B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiJRXhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRXhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:37:02 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB92A3F58
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:37:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSXenhN_1666136216;
Received: from B-P7TQMD6M-0146.lan(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSXenhN_1666136216)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 07:36:58 +0800
Date:   Wed, 19 Oct 2022 07:36:55 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ira.weiny@intel.com
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <9108233.CDJkKcVGEf@mypc>
 <Y08asdeoz5yOAefN@B-P7TQMD6M-0146.lan>
 <2019477.yKVeVyVuyW@mypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2019477.yKVeVyVuyW@mypc>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:

...

> 
> > One of what I need to care is nested kmap() usage,
> > some unmap/remap order cannot be simply converted to kmap_local()
> 
> Correct about nesting. If we map A and then B, we must unmap B and then A.
> 
> However, as you seem to convey, not always unmappings in right order (stack 
> based) is possible, sometimes because very long functions have many loop's 
> breaks and many goto exit labels.
> 
> > but I think
> > it's not the case for erofs_bread().  Actually EROFS has one of such nested
> > kmap() usage, but I don't really care its performance on HIGHMEM platforms,
> > so I think kmap() is still somewhat useful compared to kmap_local() from 
> this
> > point of view],
> 
> In Btrfs I solved (thanks to David S.' advice) by mapping only one of two 
> pages, only the one coming from the page cache. 
> 
> The other page didn't need the use of kmap_local_page() because it was 
> allocated in the filesystem with "alloc_page(GFP_NOFS)". GFP_NOFS won't ever 
> allocate from ZONE_HIGHMEM, therefore a direct page_address() could avoid the 
> mapping and the nesting issues.
> 
> Did you check if you may solve the same way? 

That is not simple.  Currently we have compressed pages and decompressed
pages (page cache or others), and they can be unmapped when either data
is all consumed, so compressed pages can be unmapped first, or
decompressed pages can be unmapped first.  That quite depends on which
pages goes first.

I think such usage is a quite common pattern for decoder or encoder,
you could take a look at z_erofs_lzma_decompress() in
fs/erofs/decompressor_lzma.c.  So kmap() is still useful for such cases
since I don't really care the HIGHMEM performance but correctness, but
other alternative could churn/complex the map/unmap/remap pattern.

Thanks,
Gao Xiang

> 
> A little group of people are working to remove all kmap() and kmap_atomic() we 
> meet across the whole kernel. I have not yet encountered conversions which 
> cannot be made. Sometimes we may refactor, if what I said above cannot apply.
> 
> > but in order to make it all work properly, I will try to do
> > stress test with 32-bit platform later. 
> 
> I use QEMU/KVM x86_32 VM, 6GB RAM, and a kernel with HIGHMEM64 enabled and an 
> openSUSE Tumbleweed 32 distro. I've heard that Debian too provides an x86_32 
> distribution. 
> 
> > Since it targets for the next cycle
> > 6.2, I will do a full stress test in the next following weeks.
> > 
> > Thanks,
> > Gao Xiang
> > 
> 
> Thanks,
> 
> Fabio
> 
