Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843FB7109FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbjEYKVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbjEYKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:21:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7021F1A2;
        Thu, 25 May 2023 03:20:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af318fa2b8so4148181fa.0;
        Thu, 25 May 2023 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685010038; x=1687602038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKTxoI+93bAIesA0outxo0/LkqsnMtrIeM8EPXBLaGM=;
        b=EP4wH3TcMzGQvrjNpxSmcpliomfcgcSpXFDtVbADG7nXItV0KO7c5H3ErQUKRcsLiv
         X8aGCGDERCQys08Mdu8fGaCufpXUP0kqQm1fJR9lKVq2yGash1b2UMUoHfup8iPmvBE4
         Cg3+MLQbgP4GfVuxADVSHFnN/GoM/HRc9oGdX5WtoT0nd2zsn2L9uVFBatDvyXb/ObNi
         ZtQniUVQf4dlMYjdYLnXBp97gpHTZSnLIGzhbCmBqGsIv5OldhYNbNh5D/HR1JUHWI0B
         +CQCZ2kvE0aI6sbDdf8bFnEbmhNbBeVFpVzuCoyswkGY+hpdVcFwxdNDLROYEeA5UvYz
         PlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685010038; x=1687602038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKTxoI+93bAIesA0outxo0/LkqsnMtrIeM8EPXBLaGM=;
        b=koKgMag0UDcIMqnfQ2vEOvO0ru6eb9eEhYPiIaLwW8M9TzEGmHfjuFi28aNJPL3FSo
         vG896IpK4uaUk3XzmNUItOQRsudq7BRckrTeIykubtQUyNcqENafi2IZr1lqaqcVGfRg
         VrX8YlaDuiMVQGsSFp00HMY9dbj/9nkfiuEVZn/NbDHIPcDzEvK15gXalNtcrkeAmFl3
         z/5rmyJ4KIfc2WRRsQx+06tpRs+u5XANP07NroN8DoHduPGp+JEh4hNOeaDhLwx+KnPG
         TcF5WEkYpt5Ug3e80UhdGSA8qzb1MLkDBUENGcD/gtWbUI5+7l1KECI58zeWs2lunXZy
         XxeA==
X-Gm-Message-State: AC+VfDyz7OJuMKK4gpZiRXb0jePt9fxZM9JjNN66uFF9MYHuC91rkqWO
        kJzG1gUIaP0kYbA2bJnFdTA=
X-Google-Smtp-Source: ACHHUZ6cvCJ7fl4YemnOhhNmxtMKSJrQrkm0PvdEtVa52SjGhqXx97JNXm3GE91koWePebmkiftUCw==
X-Received: by 2002:a05:651c:102f:b0:2af:b260:fd4d with SMTP id w15-20020a05651c102f00b002afb260fd4dmr1165908ljm.44.1685010037360;
        Thu, 25 May 2023 03:20:37 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id y28-20020a05651c021c00b002adf8d948dasm186282ljn.35.2023.05.25.03.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 03:20:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 25 May 2023 12:20:34 +0200
To:     Dave Chinner <david@fromorbit.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/9] Mitigate a vmap lock contention
Message-ID: <ZG82ch1AdrAbpkJ6@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <ZGyqiaRnMJPFhxR6@debian-BULLSEYE-live-builder-AMD64>
 <ZGzX3vRMlGHIcYCe@pc636>
 <ZG0AE9mjHkRZIGmr@debian-BULLSEYE-live-builder-AMD64>
 <ZG3d1FUXiCk3QL3D@pc636>
 <ZG6IKE7yNEkJhge+@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG6IKE7yNEkJhge+@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 07:56:56AM +1000, Dave Chinner wrote:
> On Wed, May 24, 2023 at 11:50:12AM +0200, Uladzislau Rezki wrote:
> > On Wed, May 24, 2023 at 03:04:28AM +0900, Hyeonggon Yoo wrote:
> > > On Tue, May 23, 2023 at 05:12:30PM +0200, Uladzislau Rezki wrote:
> > > And I would like to ask some side questions:
> > > 
> > > 1. Is vm_[un]map_ram() API still worth with this patchset?
> > > 
> > It is up to community to decide. As i see XFS needs it also. Maybe in
> > the future it can be removed(who knows). If the vmalloc code itself can
> > deliver such performance as vm_map* APIs.
> 
> vm_map* APIs cannot be replaced with vmalloc, they cover a very
> different use case.  i.e.  vmalloc allocates mapped memory,
> vm_map_ram() maps allocated memory....
> 
> > vm_map_ram() and friends interface was added because of vmalloc drawbacks.
> 
> No. vm_map*() were scalability improvements added in 2009 to replace
> on vmap() and vunmap() to avoid global lock contention in the vmap
> allocator that XFS had been working around for years with it's own
> internal vmap cache....
> 
> commit 95f8e302c04c0b0c6de35ab399a5551605eeb006
> Author: Nicholas Piggin <npiggin@gmail.com>
> Date:   Tue Jan 6 14:43:09 2009 +1100
> 
>     [XFS] use scalable vmap API
>     
>     Implement XFS's large buffer support with the new vmap APIs. See the vmap
>     rewrite (db64fe02) for some numbers. The biggest improvement that comes from
>     using the new APIs is avoiding the global KVA allocation lock on every call.
>     
>     Signed-off-by: Nick Piggin <npiggin@suse.de>
>     Reviewed-by: Christoph Hellwig <hch@infradead.org>
>     Signed-off-by: Lachlan McIlroy <lachlan@sgi.com>
> 
> vmap/vunmap() themselves were introduce in 2.5.32 (2002) and before
> that XFS was using remap_page_array() and vfree() in exactly the
> same way it uses vm_map_ram() and vm_unmap_ram() today....
> 
> XFS has a long, long history of causing virtual memory allocator
> scalability and contention problems. As you can see, this isn't our
> first rodeo...
> 
Let me be more specific, sorry it looks like there is misunderstanding.
I am talking about removing of vb_alloc()/vb_free() per-cpu stuff. If
alloc_vmap_area() gives same performance:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d50c551592fc..a1687bbdad30 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2503,12 +2503,6 @@ void vm_unmap_ram(const void *mem, unsigned int count)

        kasan_poison_vmalloc(mem, size);

-       if (likely(count <= VMAP_MAX_ALLOC)) {
-               debug_check_no_locks_freed(mem, size);
-               vb_free(addr, size);
-               return;
-       }
-
        va = find_unlink_vmap_area(addr);
        if (WARN_ON_ONCE(!va))
                return;
@@ -2539,12 +2533,6 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
        unsigned long addr;
        void *mem;

-       if (likely(count <= VMAP_MAX_ALLOC)) {
-               mem = vb_alloc(size, GFP_KERNEL);
-               if (IS_ERR(mem))
-                       return NULL;
-               addr = (unsigned long)mem;
-       } else {
                struct vmap_area *va;
                va = alloc_vmap_area(size, PAGE_SIZE,
                                VMALLOC_START, VMALLOC_END,
@@ -2554,7 +2542,6 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)

                addr = va->va_start;
                mem = (void *)addr;
-       }

        if (vmap_pages_range(addr, addr + size, PAGE_KERNEL,
                                pages, PAGE_SHIFT) < 0) {


+ other related parts.

--
Uladzislau Rezki
