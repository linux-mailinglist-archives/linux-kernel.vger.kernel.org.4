Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51533604F70
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiJSSRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiJSSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:17:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D591ABEE0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:16:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so614653wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhFpcNLAWcGDCBo0K7yVdazuvwSnNgkUZyErY0NIE1c=;
        b=he9NpC2bg44o27n2ccTQZQQa6V/ilBK8VkwzBsH3BoGDoFiZKIv7zwtKQzzyIFV3EQ
         ls313Q9MIR/eh6dOGpzb8ElOHrrbHfA8jWvYpl7fGmMNCDfbrZRwJPAjafyt8Cvv8Jbi
         BTZoIqAu5mL+9x54oVByaOyHX2gVN8T6xwjiDBsBVablPuWruvCzwIF8aSN8AVEJKdec
         iDAE7XjJozmp8irP9D0fQRsrAbpNKlD8yzcShaNmQ+FT0fmTl2HF/SB9h7bq4E8J5wcM
         OyF4m1sr2tatMgN5g6MaiCQBLxUrGrj4ZpJxd3EL1uBVfNLVlPxWCwxzCqSYJkjcXFF0
         tgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhFpcNLAWcGDCBo0K7yVdazuvwSnNgkUZyErY0NIE1c=;
        b=WTFdQj6gFDtRvoSI0AtMkyxmnIVqGFiSA+GGAyqWraJiNMPHJeUBkifE5pNppMt9mB
         aAsFCXvos4HXmdt8xD7uWUUaLEYIRLD750k39IJC1HoktIv3ikl8o1Xyc8+zPmjyXafW
         iXhbsuGPqDIWKZTN4aErQw0tM5yyASulOI6cLXqqxalJ9VdKvfPy+W22YVRYZtAJF2KD
         NxHDHby9ZA10IMuSDB5NAHuBu7LTdrOZ9Eea0JXzW6Y/VbSHZ3qNhD5F4DmEvMlamGB4
         KrarwjFzphRngTIZ7wuPsCvJOdqXsDw4qbFOfSRBK8jC8M95FwqLuP7MrWgropfNcrDq
         KmQw==
X-Gm-Message-State: ACrzQf2x7rP1oeuvDdOLj7fJWAvKo0wjl148z7HznYOtq0mqZ+wI5r2s
        EDtq4RyNlUGjWZ0bNqk5lKDBYwM6p3QdtS0o
X-Google-Smtp-Source: AMsMyM60hSkepDp4MHgqGpWApnFiMjPz5F65vp8JEYVikCB4i2VdBy40K2G7DQqVUYnSDJwVMFHEow==
X-Received: by 2002:a05:600c:4fd4:b0:3c6:fb81:ab3c with SMTP id o20-20020a05600c4fd400b003c6fb81ab3cmr6991132wmq.160.1666203412456;
        Wed, 19 Oct 2022 11:16:52 -0700 (PDT)
Received: from mypc.localnet (host-82-59-43-249.retail.telecomitalia.it. [82.59.43.249])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c438700b003b4c979e6bcsm623420wmn.10.2022.10.19.11.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:16:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ira.weiny@intel.com
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Date:   Wed, 19 Oct 2022 20:17:05 +0200
Message-ID: <12077010.O9o76ZdvQC@mypc>
In-Reply-To: <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com> <2019477.yKVeVyVuyW@mypc> <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 19, 2022 1:36:55 AM CEST Gao Xiang wrote:
> On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> > On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:
> 
> ...
> 
> > 
> > > One of what I need to care is nested kmap() usage,
> > > some unmap/remap order cannot be simply converted to kmap_local()
> > 
> > Correct about nesting. If we map A and then B, we must unmap B and then A.
> > 
> > However, as you seem to convey, not always unmappings in right order 
(stack 
> > based) is possible, sometimes because very long functions have many loop's 
> > breaks and many goto exit labels.
> > 
> > > but I think
> > > it's not the case for erofs_bread().  Actually EROFS has one of such 
nested
> > > kmap() usage, but I don't really care its performance on HIGHMEM 
platforms,
> > > so I think kmap() is still somewhat useful compared to kmap_local() from 
> > this
> > > point of view],
> > 

fs/erofs conversions are in our (Ira's and my) list. So I'm am happy to see 
that we can delete some entries because of your changes. :-)

> > In Btrfs I solved (thanks to David S.' advice) by mapping only one of two 
> > pages, only the one coming from the page cache. 
> > 
> > The other page didn't need the use of kmap_local_page() because it was 
> > allocated in the filesystem with "alloc_page(GFP_NOFS)". GFP_NOFS won't 
ever 
> > allocate from ZONE_HIGHMEM, therefore a direct page_address() could avoid 
the 
> > mapping and the nesting issues.
> > 
> > Did you check if you may solve the same way? 
> 
> That is not simple.  Currently we have compressed pages and decompressed
> pages (page cache or others), and they can be unmapped when either data
> is all consumed, so compressed pages can be unmapped first, or
> decompressed pages can be unmapped first.  That quite depends on which
> pages goes first.
> 
> I think such usage is a quite common pattern for decoder or encoder,
> you could take a look at z_erofs_lzma_decompress() in
> fs/erofs/decompressor_lzma.c.  

I haven't yet read that code, however I may attempt to propose a pattern for 
solving this kinds of issue, I mean where you don't know which page got mapped 
last...

It's not elegant but it may work. You have compressed and decompressed pages 
and you can't know in advance what page should be unmapped first because you 
can't know in which order they where mapped, right?

I'd use a variable to save two different values, each representing the last 
page mapped. When the code gets to the unmapping block (perhaps in an "out" 
label), just check what that variable contains. Depending on that value, say 
'c' or 'd', you will be able to know what must be unmapped for first. An "if / 
else" can do the work.

What do you think of this?

> So kmap() is still useful for such cases
> since I don't really care the HIGHMEM performance but correctness, but
> other alternative could churn/complex the map/unmap/remap pattern.

Sooner or later someone will have to address this issue and remove those 
kmap() call sites. We are working on this and hope to always figure out a way 
to work it out. 

I hope that what I wrote above may help, although I'm writing on a purely 
theoretically bases, since, as said, I haven't yet seen that code.

If due to my poor English I've not been able to convey my thoughts please let 
me know, so that I'll try to reword.

Thanks,

Fabio

> Thanks,
> Gao Xiang
> 
> > 
> > A little group of people are working to remove all kmap() and 
kmap_atomic() we 
> > meet across the whole kernel. I have not yet encountered conversions which 
> > cannot be made. Sometimes we may refactor, if what I said above cannot 
apply.
> > 
> > > but in order to make it all work properly, I will try to do
> > > stress test with 32-bit platform later. 
> > 
> > I use QEMU/KVM x86_32 VM, 6GB RAM, and a kernel with HIGHMEM64G enabled 
and an 
> > openSUSE Tumbleweed 32 distro. I've heard that Debian too provides an 
x86_32 
> > distribution. 
> > 
> > > Since it targets for the next cycle
> > > 6.2, I will do a full stress test in the next following weeks.
> > > 
> > > Thanks,
> > > Gao Xiang
> > > 
> > 
> > Thanks,
> > 
> > Fabio
> > 
> 



