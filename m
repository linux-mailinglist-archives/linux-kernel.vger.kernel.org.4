Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7246034F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJRV3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJRV3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:29:30 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C27636B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:29:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSXOP2U_1666128562;
Received: from B-P7TQMD6M-0146.lan(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSXOP2U_1666128562)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 05:29:24 +0800
Date:   Wed, 19 Oct 2022 05:29:21 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ira.weiny@intel.com
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y08asdeoz5yOAefN@B-P7TQMD6M-0146.lan>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <9108233.CDJkKcVGEf@mypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9108233.CDJkKcVGEf@mypc>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Tue, Oct 18, 2022 at 09:18:49PM +0200, Fabio M. De Francesco wrote:
> On Tuesday, October 18, 2022 12:53:13 PM CEST Gao Xiang wrote:
> > Convert all mapped erofs_bread() users to use kmap_local_page()
> > instead of kmap() or kmap_atomic().
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/erofs/data.c     | 8 ++------
> >  fs/erofs/internal.h | 3 +--
> >  fs/erofs/xattr.c    | 8 ++++----
> >  fs/erofs/zmap.c     | 4 ++--
> >  4 files changed, 9 insertions(+), 14 deletions(-)
> > 
> 
> I just realized that you know the code of fs/erofs very well. I saw a Gao 
> Xiang in MAINTAINERS, although having a different email address.
> 
> Therefore, I'm sure that everybody can trust that you checked everything is 
> needed to assure the safety of the conversions.
> 
> However, an extended commit message would have prevented me to send you the 
> previous email with all those questions / objections.

Thanks for your suggestion.  Yeah, this conversion looks trivial [since most
paths for erofs_bread() don't have more restriction in principle so we can
just disable migration.  One of what I need to care is nested kmap() usage,
some unmap/remap order cannot be simply converted to kmap_local() but I think
it's not the case for erofs_bread().  Actually EROFS has one of such nested
kmap() usage, but I don't really care its performance on HIGHMEM platforms,
so I think kmap() is still somewhat useful compared to kmap_local() from this
point of view], but in order to make it all work properly, I will try to do
stress test with 32-bit platform later.  Since it targets for the next cycle
6.2, I will do a full stress test in the next following weeks.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> Fabio
> 
