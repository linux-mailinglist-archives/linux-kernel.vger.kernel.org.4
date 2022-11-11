Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201366253E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiKKGgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKKGge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:36:34 -0500
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742AA28B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:36:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VUWA-4Q_1668148586;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VUWA-4Q_1668148586)
          by smtp.aliyun-inc.com;
          Fri, 11 Nov 2022 14:36:28 +0800
Date:   Fri, 11 Nov 2022 14:36:25 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: enable large folio in device-based mode
Message-ID: <Y23taS26HMwhkdhN@B-P7TQMD6M-0146.local>
References: <20221110074023.8059-1-jefflexu@linux.alibaba.com>
 <315099ec-b6c3-1aa0-c83e-86f6074bd674@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <315099ec-b6c3-1aa0-c83e-86f6074bd674@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 10, 2022 at 03:59:14PM +0800, JeffleXu wrote:
> 
> 
> On 11/10/22 3:40 PM, Jingbo Xu wrote:
> > Enable large folio in device-based mode. Then the radahead routine will
> > pass down large folio containing multiple pages.
> > 
> > Enable this feature for non-compressed format for now, until the
> > compression part supports large folio later.
> > 
> > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > ---
> > I have tested it under workload of Linux compiling. I know it's not a
> > perfect workload testing this feature, because large folio is less
> > likely hit in this case since source files are generally small. But I
> > indeed observed large folios (e.g. 16 pages) by peeking
> > readahead_count(rac) in erofs_readahead().
> 
> Sorry, readahead_count(rac) returns the whole number of pages inside the
> rac, which can not prove large folio passed in.
> 
> I retired later and observed large folio (e.g. with order 2) by peeking
> folio_order(ctx->cur_folio) inside iomap_readahead_iter()

I will test it as well after I send out all bug fixes for this cycle.

Thanks,
Gao Xiang

> 
> > ---
> >  fs/erofs/inode.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > index ad2a82f2eb4c..e457b8a59ee7 100644
> > --- a/fs/erofs/inode.c
> > +++ b/fs/erofs/inode.c
> > @@ -295,6 +295,8 @@ static int erofs_fill_inode(struct inode *inode)
> >  		goto out_unlock;
> >  	}
> >  	inode->i_mapping->a_ops = &erofs_raw_access_aops;
> > +	if (!erofs_is_fscache_mode(inode->i_sb))
> > +		mapping_set_large_folios(inode->i_mapping);
> >  #ifdef CONFIG_EROFS_FS_ONDEMAND
> >  	if (erofs_is_fscache_mode(inode->i_sb))
> >  		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
> 
> -- 
> Thanks,
> Jingbo
