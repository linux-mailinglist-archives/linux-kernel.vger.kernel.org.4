Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03D95B4E98
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiIKLwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiIKLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:52:08 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DFE2250F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:52:06 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id f26so1913579qto.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MQaM98zF6Au3ifgBX1LN9vhnn6oLk/4qb19oOxSo2ys=;
        b=SigBH0gvrEn1MEJM6v83gDZiBN7mUjGGRt4qVaAat9iISUXJD8JcDqtiVF/84C6yXf
         AKj/3foELjE98IRegp7cjL3MAqtx9H0Yp/UluKzROBF4yJ17gVd9gRzks01IxNrIlEV9
         H+F4IesaKttoAQlIBWKSCYzoAZp3sZdfA3HK8fviZeLfwD8A015T4mSrc8ANPBGla0BO
         yIO1GuLrrUIyDbSRWU7nHd5IXarxGehiiYze0OKQYJUbq52Z+DSDMGOkpKmu8ueSY+QL
         GoxOcp01Kdj+CvQdu+8ojPRDAyD8Rj8XwxawNeV/S+h+Blac5xlAOKlnG/5aYILTED2I
         y5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MQaM98zF6Au3ifgBX1LN9vhnn6oLk/4qb19oOxSo2ys=;
        b=j85rQ8P2srrA6sG0IPI48ijpaFVXOpcNgP/zIfyXotGXbzZpc6mIe0N41184WyKcEd
         1fPQpulFOFmXf7jXP1NuiZ1VNiaWQmWSiQG2HfwKWeSw2mSLpYp+VWX7y1TMmMGNSCTY
         UPd6evIMTTbU38OUeDAtI0eQlLnRnzbayT1nBgNz/FUmO8M3octsMhEz9UFE3bLVa3ZT
         hfQo0JtBL9sxu/BIKG5KX2NH/lyf2QEs5c1FWtHPsTtJrWtdH4EwmFSRI/l5U9YZYPYi
         7DRZcwCjm/X2DhMCHt8vH7EA42J7qVVZbEHt8JuSldafOSELOsvKg/ldJCbYswI0ZHni
         8tjg==
X-Gm-Message-State: ACgBeo1wCjnFfYAo5qe1lJg3kOjw7XQf9jRdXlFtHlu/LS0IU4LWkFFe
        BFRdAj8TTX1iTrjUtiEJXO3P2fZfEc6rEysgFDY=
X-Google-Smtp-Source: AA6agR59yOWQiuef4RAzd0Ue1tcPYotyEFBsUgd+CB1gxXMS9L+XZKteCqvdhwqa8jqp9+HXQehG4aJQLaCeAtS93eI=
X-Received: by 2002:a05:622a:14d1:b0:344:b14a:b22a with SMTP id
 u17-20020a05622a14d100b00344b14ab22amr18977092qtx.203.1662897125285; Sun, 11
 Sep 2022 04:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220907071023.3838692-1-feng.tang@intel.com> <20220907071023.3838692-4-feng.tang@intel.com>
 <CA+fCnZeT_mYndXDYoi0LHCcDkOK4V1TR_omE6CKdbMf6iDwP+w@mail.gmail.com> <Yx1caGQ8R2alhOKh@feng-clx>
In-Reply-To: <Yx1caGQ8R2alhOKh@feng-clx>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 11 Sep 2022 13:51:54 +0200
Message-ID: <CA+fCnZd1bDe9oQcCZjN+NTxs8qF3fzRoXcSZvyeCNxoX6U-wsg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm: kasan: Add free_meta size info in struct kasan_cache
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Sang, Oliver" <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 5:57 AM Feng Tang <feng.tang@intel.com> wrote:
>
> Hi Andrey,
>
> Thanks for reviewing this series!
>
> On Sun, Sep 11, 2022 at 07:14:55AM +0800, Andrey Konovalov wrote:
> > On Wed, Sep 7, 2022 at 9:11 AM Feng Tang <feng.tang@intel.com> wrote:
> > >
> > > When kasan is enabled for slab/slub, it may save kasan' free_meta
> > > data in the former part of slab object data area in slab object
> > > free path, which works fine.
> > >
> > > There is ongoing effort to extend slub's debug function which will
> > > redzone the latter part of kmalloc object area, and when both of
> > > the debug are enabled, there is possible conflict, especially when
> > > the kmalloc object has small size, as caught by 0Day bot [1]
> > >
> > > For better information for slab/slub, add free_meta's data size
> > > into 'struct kasan_cache', so that its users can take right action
> > > to avoid data conflict.
> > >
> > > [1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> > > ---
> > >  include/linux/kasan.h | 2 ++
> > >  mm/kasan/common.c     | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > index b092277bf48d..293bdaa0ba09 100644
> > > --- a/include/linux/kasan.h
> > > +++ b/include/linux/kasan.h
> > > @@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
> > >  struct kasan_cache {
> > >         int alloc_meta_offset;
> > >         int free_meta_offset;
> > > +       /* size of free_meta data saved in object's data area */
> > > +       int free_meta_size_in_object;
> >
> > I thinks calling this field free_meta_size is clear enough. Thanks!
>
> Yes, the name does look long. The "in_object" was added to make it
> also a flag for whether the free meta is saved inside object's data
> area.
>
> For 'free_meta_size', the code logic in slub should be:
>
>   if (info->free_meta_offset == 0 &&
>         info->free_meta_size >= ...)

I'd say you can keep the current logic and just rename the field to
make it shorter. But up to you, I'm fine with either approach. Thanks!
