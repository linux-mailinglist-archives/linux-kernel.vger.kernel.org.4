Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C80603865
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJSDHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJSDHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:07:09 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743F591873
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:07:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSYayHV_1666148819;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSYayHV_1666148819)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 11:07:01 +0800
Date:   Wed, 19 Oct 2022 11:06:58 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y09p0hTSxeUPgLsJ@B-P7TQMD6M-0146.local>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <9108233.CDJkKcVGEf@mypc>
 <Y08asdeoz5yOAefN@B-P7TQMD6M-0146.lan>
 <2019477.yKVeVyVuyW@mypc>
 <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
 <Y09mS6LrHCGmi+AJ@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y09mS6LrHCGmi+AJ@iweiny-desk3>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ira,

On Tue, Oct 18, 2022 at 07:51:55PM -0700, Ira Weiny wrote:
> On Wed, Oct 19, 2022 at 07:36:55AM +0800, Gao Xiang wrote:
> > On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> > > On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:
> > 
> > ...
> 
> [snip]
> 
> > > 
> > > In Btrfs I solved (thanks to David S.' advice) by mapping only one of two 
> > > pages, only the one coming from the page cache. 
> > > 
> > > The other page didn't need the use of kmap_local_page() because it was 
> > > allocated in the filesystem with "alloc_page(GFP_NOFS)". GFP_NOFS won't ever 
> > > allocate from ZONE_HIGHMEM, therefore a direct page_address() could avoid the 
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
> > fs/erofs/decompressor_lzma.c.  So kmap() is still useful for such cases
> > since I don't really care the HIGHMEM performance but correctness, but
> > other alternative could churn/complex the map/unmap/remap pattern.
> > 
> 
> When you say kmap() is still useful is this because of the map/unmap ordering
> restrictions or because the address is required in different threads?

... mainly due to map/unmap ordering restriction. I think
the decompressor here could still be a simple dependency.  I'm not
sure if there are more complicated cases (like multiple
decoding/encoding sources into target pages) though..

Thanks,
Gao Xiang

> 
> Ira
