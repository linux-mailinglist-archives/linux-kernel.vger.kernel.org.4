Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4626036A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJRXV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJRXVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:21:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660DFD7E22
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:21:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f11so26289666wrm.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajmz96vcovXQRjeuZ4/E3ppLBL3uDj8he2LEPEk4hVo=;
        b=FRyv3neGDjbHMxgH/aQD4XoB4GGDLosEaWT9DLBdhThqEzj2mXU4fSChtpayESYVzb
         3hIhHhgf0RJw203FmbPfwarvXDp8hRYHps5/Zr8/ojMnGM0wcksanz53UUqAR+BGHzTf
         fZwPLNulKBwtDNy72t4LswcrUVit9YcVsvQ5rkme1DMH/3ySGDVilBJgEj9UfPCK58Xu
         W4Gv4kXhYEj4LvnrcIe/qtnix6JM5xnjRMZoZnZBUl7+plbHx9K9zdUa6vX0R2k66uzl
         3KJLTLMcNKqZxMJRQoxMXFPvxxlXpIn325qz0TCnRdC66NYY6022grlDW2E8AT79qH33
         z+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ajmz96vcovXQRjeuZ4/E3ppLBL3uDj8he2LEPEk4hVo=;
        b=20YhOGBHRJ3f++Y4oTzlwSX6ydcCxR4cNlY+DuljBTHp4v/atpIrByubupGgjbOXV8
         n8gFOkyINSplBdPfMKJKPOcPzTMrjnbF4sXwOLFz5+ypw4FF6Il5mvq7o6mXF3nJyZIJ
         mLhcl9Ltfzu2IlOCNZOvzPRUYJ87dDPLPPY3vmYpsyMdS9q7R0XtcyZEuVrYzIrLc8g+
         nRpwX/uBx15m/y4Ol5898H+VZ9B4+kdwvljfN4NvJhP16ZIn0cYUL9GV7h5y0V7vP7VG
         sXZK0XT9Y7tRNhfwNEzRaZXTgJc1XLBnkP51+QvpuxDkAvV+hrZPBgDwMFpdyjaJ9PVW
         9Qqg==
X-Gm-Message-State: ACrzQf3ZFzkWGju6/X8k6VAmt1+MZtOR93R4ne53838f8frOVRy827EK
        //ByjuGXSIgh82z6zunyLT9QPzeE/iykhcFm
X-Google-Smtp-Source: AMsMyM51DD7GvlAY8yKzx1BR4ZpxTyqmJcB+tv9gzdkzz1hahP07PhV2an9hK84VCICTAy/XKCOoDA==
X-Received: by 2002:a5d:64c4:0:b0:231:3d94:6eb2 with SMTP id f4-20020a5d64c4000000b002313d946eb2mr3137140wri.580.1666135274763;
        Tue, 18 Oct 2022 16:21:14 -0700 (PDT)
Received: from mypc.localnet (host-82-59-43-249.retail.telecomitalia.it. [82.59.43.249])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b003b5054c6f87sm14476792wmc.21.2022.10.18.16.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 16:21:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ira.weiny@intel.com
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Date:   Wed, 19 Oct 2022 01:21:27 +0200
Message-ID: <2019477.yKVeVyVuyW@mypc>
In-Reply-To: <Y08asdeoz5yOAefN@B-P7TQMD6M-0146.lan>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com> <9108233.CDJkKcVGEf@mypc> <Y08asdeoz5yOAefN@B-P7TQMD6M-0146.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:
> Hi Fabio,
> 
> On Tue, Oct 18, 2022 at 09:18:49PM +0200, Fabio M. De Francesco wrote:
> > On Tuesday, October 18, 2022 12:53:13 PM CEST Gao Xiang wrote:
> > > Convert all mapped erofs_bread() users to use kmap_local_page()
> > > instead of kmap() or kmap_atomic().
> > > 
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > ---
> > >  fs/erofs/data.c     | 8 ++------
> > >  fs/erofs/internal.h | 3 +--
> > >  fs/erofs/xattr.c    | 8 ++++----
> > >  fs/erofs/zmap.c     | 4 ++--
> > >  4 files changed, 9 insertions(+), 14 deletions(-)
> > > 
> > 
> > I just realized that you know the code of fs/erofs very well. I saw a Gao 
> > Xiang in MAINTAINERS, although having a different email address.
> > 
> > Therefore, I'm sure that everybody can trust that you checked everything 
is 
> > needed to assure the safety of the conversions.
> > 
> > However, an extended commit message would have prevented me to send you 
the 
> > previous email with all those questions / objections.
> 
> Thanks for your suggestion. 
> Yeah, this conversion looks trivial [since most
> paths for erofs_bread() don't have more restriction in principle so we can
> just disable migration.

Not sure about what you mean by "restrictions". Few months ago I updated the 
kmap_local_page() documentantation (highmem.rst). Please take a look at it, so 
that you may check if what you call restrictions are intended the way you 
mean.

The two most important rules are (1) that users cannot hand the virtual kernel 
addresses returned by kmap_local_page() to other contexts (that is why they 
are thread local) and (2) how to nest mappings /unmappings.

> One of what I need to care is nested kmap() usage,
> some unmap/remap order cannot be simply converted to kmap_local()

Correct about nesting. If we map A and then B, we must unmap B and then A.

However, as you seem to convey, not always unmappings in right order (stack 
based) is possible, sometimes because very long functions have many loop's 
breaks and many goto exit labels.

> but I think
> it's not the case for erofs_bread().  Actually EROFS has one of such nested
> kmap() usage, but I don't really care its performance on HIGHMEM platforms,
> so I think kmap() is still somewhat useful compared to kmap_local() from 
this
> point of view],

In Btrfs I solved (thanks to David S.' advice) by mapping only one of two 
pages, only the one coming from the page cache. 

The other page didn't need the use of kmap_local_page() because it was 
allocated in the filesystem with "alloc_page(GFP_NOFS)". GFP_NOFS won't ever 
allocate from ZONE_HIGHMEM, therefore a direct page_address() could avoid the 
mapping and the nesting issues.

Did you check if you may solve the same way? 

A little group of people are working to remove all kmap() and kmap_atomic() we 
meet across the whole kernel. I have not yet encountered conversions which 
cannot be made. Sometimes we may refactor, if what I said above cannot apply.

> but in order to make it all work properly, I will try to do
> stress test with 32-bit platform later. 

I use QEMU/KVM x86_32 VM, 6GB RAM, and a kernel with HIGHMEM64 enabled and an 
openSUSE Tumbleweed 32 distro. I've heard that Debian too provides an x86_32 
distribution. 

> Since it targets for the next cycle
> 6.2, I will do a full stress test in the next following weeks.
> 
> Thanks,
> Gao Xiang
> 

Thanks,

Fabio


