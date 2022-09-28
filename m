Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6868C5EE88E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiI1Vpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbiI1Vpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:45:42 -0400
X-Greylist: delayed 39579 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 14:45:40 PDT
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC46A485
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:45:39 -0700 (PDT)
Date:   Wed, 28 Sep 2022 23:45:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1664401537;
        bh=kH+/tmczecKnhnIrUtubeU3tV5TZ91lbO2+kdfSMlPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjSj4u/9FSkzVFsqxXdsV5Ch7Bk9OUigNZr321HrEPfCi6qMZY4pnfIV5uQsD7UXR
         yHPWoSqMls64BbTa8ebsUeur0roeRF2RC+24/7Lt8PFaXFp5yXchf7QVvBXNX5J+To
         Y8H0vQaWqGDpJS0zLgEQFkRKrs0+OK207otlUfQc=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@amadeus.com>
Subject: Re: [PATCH] tmpfs: ensure O_LARGEFILE with generic_file_open()
Message-ID: <d21b5676-fd4d-4470-8290-44d407048469@t-8ch.de>
References: <20220928104535.61186-1-linux@weissschuh.net>
 <4d5a721-cffe-cc7-8023-ae86ba35cb7d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d5a721-cffe-cc7-8023-ae86ba35cb7d@google.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-28 13:27-0700, Hugh Dickins wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> On Wed, 28 Sep 2022, Thomas Weißschuh wrote:
> > From: Thomas Weißschuh <thomas.weissschuh@amadeus.com>
> > 
> > Without this check open() will open large files on tmpfs although
> > O_LARGEFILE was not specified. This is inconsistent with other
> > filesystems.
> > Also it will later result in EOVERFLOW on stat() or EFBIG on write().
> > 
> > Link: https://lore.kernel.org/lkml/76bedae6-22ea-4abc-8c06-b424ceb39217@t-8ch.de/
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@amadeus.com>
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> Thanks! I think you deserve some special award for finding and fixing
> such an ancient bug/inconsistency - dating back to early v2.4 it seems.

Seems to be my special talent.

> But only affecting 32-bit; and since we've happily lived with it so long,
> and the fix does change behaviour for userspace, better not to Cc stable.

That was my feeling, too.

> There are some other filesystems still behaving as tmpfs was (ramfs,
> hugetlbfsi, and I didn't look further); but we do make more of an effort
> to keep tmpfs in line with the major filesystems - thank you.

NFS seems also to be affected, which I think warrants a fix.
My plan was to wait for the feedback to this patch and if it works out to then
submit patches for NFS as validating that will be a bit more involved.

> > ---
> >  mm/shmem.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 42e5888bf84d..902c5550fabc 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -3876,6 +3876,7 @@ EXPORT_SYMBOL(shmem_aops);
> >  
> >  static const struct file_operations shmem_file_operations = {
> >  	.mmap		= shmem_mmap,
> > +	.open		= generic_file_open,
> >  	.get_unmapped_area = shmem_get_unmapped_area,
> >  #ifdef CONFIG_TMPFS
> >  	.llseek		= shmem_file_llseek,
> > 
> > base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
> > -- 
> > 2.37.3

