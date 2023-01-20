Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7DE6753E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjATLzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjATLzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:55:04 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198FACA3B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:55:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id rl14so9998694ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPwVKRrBRFK3jFjJvU5Sg6lMI3S9/OL0NPdp1XhCJto=;
        b=HmBRtxFmYcIFCweRBMNq8Thv74hXRM0L2mgce9nbGVg0S8+P4nklS3yKaT0Wz7FfuH
         v8SZqvwZxN4pGhDGC8Quq5M4gW+yIYhL7C8JwgUZzLxCPeeTjPQ0OGwProzMWc7jVEil
         upe1a3/iJ2OsvrydAwFNINR3CTvQhvd9g8ldmQ1mE1ZbcxLxwY/aysLaJaviBN+TJJtR
         MxIdfYoNk2n3sG8VrOqNVsIOI+Jiaih1IuptF6Amlfuq6/UBlcecC1c8PGs0+pVZhrwp
         cpP0IOk6H+je5+ZveR5aMnjaSUamOjGZOc6383K3IRES+wjgfaJ8V+6SXuKdsaH7Q+TE
         zSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPwVKRrBRFK3jFjJvU5Sg6lMI3S9/OL0NPdp1XhCJto=;
        b=uoKjR5V/cJBjhoD5yUf5faIwdU9BryWMoF1t9a61zg7NxAmlYUZFZA8OSwtgC6Bfrw
         fXNpHfeSIMxKrr+oDEE2nr4Wq/MIfWGExQ9uZ6tt2J7QAsOsRMLGLxMMIRAeaDBKbbUF
         Y22Km0QOd1ytO1Y9TwYQOkvAwvy44JzRGyTz+lpCUtW4c14OrSdtPqzyHqqpIEXDY4Kj
         mI9uZjdWhB9tLVHKWcnVsbPCj/BtO5Gel8fzpqGFkZgHq0tLocaacsBPzPQGf6vgGla/
         7G4j3m6VJrYaiPmcjhyggGn1J0p2l/gHTobbYo79ju18nRDElaSwSqLeMS457zW5dG4p
         6FoQ==
X-Gm-Message-State: AFqh2kpfxTGGkrapg90HI5se6qGmIfiSwB+heEqlsPMQy9qb5SBDx5Qr
        FRDWs2vtHPBdZgju1or7zSehWXcb6vXkfBWIo+A=
X-Google-Smtp-Source: AMrXdXuaENncKZQc33MSnti/Ol9Z2wAhRQU8myUVCNr5xYyz95bn2ei5fqnRxpsjxcVZ4tPMuL7l0SN60RR2ksFDOXg=
X-Received: by 2002:a17:906:5a54:b0:84c:4d1:5e9a with SMTP id
 my20-20020a1709065a5400b0084c04d15e9amr1000372ejc.297.1674215699383; Fri, 20
 Jan 2023 03:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20230113031921.64716-1-bhe@redhat.com> <20230113031921.64716-4-bhe@redhat.com>
 <Y8U6Gi5d4F8mO0ib@pc636> <Y8kSwyJBe426pj7R@fedora> <Y8k8K9Ztfm/Yj5PO@fedora>
In-Reply-To: <Y8k8K9Ztfm/Yj5PO@fedora>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Fri, 20 Jan 2023 12:54:47 +0100
Message-ID: <CA+KHdyXJhAMh=HXK7_pO0kTBvSCAuJNT-6pMhtXWgDO3pM7R-A@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On 01/19/23 at 05:52pm, Baoquan He wrote:
> > On 01/16/23 at 12:50pm, Uladzislau Rezki wrote:
> > > On Fri, Jan 13, 2023 at 11:19:17AM +0800, Baoquan He wrote:
> > > > Currently, vread can read out vmalloc areas which is associated with
> > > > a vm_struct. While this doesn't work for areas created by vm_map_ram()
> > > > interface because it doesn't have an associated vm_struct. Then in vread(),
> > > > these areas are all skipped.
> > > >
> > > > Here, add a new function vmap_ram_vread() to read out vm_map_ram areas.
> > > > The area created with vmap_ram_vread() interface directly can be handled
> > > > like the other normal vmap areas with aligned_vread(). While areas
> > > > which will be further subdivided and managed with vmap_block need
> > > > carefully read out page-aligned small regions and zero fill holes.
> > > >
> > > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > > ---
> > > >  mm/vmalloc.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++-----
> > > >  1 file changed, 73 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index ab4825050b5c..13875bc41e27 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3544,6 +3544,65 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
> > > >   return copied;
> > > >  }
> > > >
> > > > +static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags)
> > > > +{
> > > > + char *start;
> > > > + struct vmap_block *vb;
> > > > + unsigned long offset;
> > > > + unsigned int rs, re, n;
> > > > +
> > > > + /*
> > > > +  * If it's area created by vm_map_ram() interface directly, but
> > > > +  * not further subdividing and delegating management to vmap_block,
> > > > +  * handle it here.
> > > > +  */
> > > > + if (!(flags & VMAP_BLOCK)) {
> > > > +         aligned_vread(buf, addr, count);
> > > > +         return;
> > > > + }
> > > > +
> > > > + /*
> > > > +  * Area is split into regions and tracked with vmap_block, read out
> > > > +  * each region and zero fill the hole between regions.
> > > > +  */
> > > > + vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> > > > +
> > > > + spin_lock(&vb->lock);
> > > > + if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> > > >
> > > CPU-X invokes free_vmap_block() whereas we take the vb->lock and do
> > > some manipulations with vb that might be already freed over RCU-core.
> > >
> > > Should we protect it by the rcu_read_lock() also here?
> >
> > Just go over the vb and vbq code again, seems we don't need the
> > rcu_read_lock() here. The rcu lock is needed when operating on the
> > vmap_block_queue->free list. I don't see race between the vb accessing
> > here and those list adding or removing on vmap_block_queue->free with
> > rcu. If I miss some race windows between them, please help point out.
> >
> > However, when I check free_vmap_block(), I do find a risk. As you said,
>
> Forgot to add details about why there's no race between free_vmap_block()
> and vmap_ram_vread() because we have taken vmap_area_lock at the beginning
> of vread(). So, except of the missing checking on returned value from
> xa_load(), free_vmap_block() either is blocked to wait for vmap_area_lock
> before calling unlink_va(), or finishes calling unlink_va() to remove
> the vmap from vmap_area_root tree. In both cases, no race happened.
>
Agree. xa_load()s return value should be checked. Because it can be that
there is no vmap_block associated with an address if xa_erase() was done
earlier.

--
Uladzislau Rezki
