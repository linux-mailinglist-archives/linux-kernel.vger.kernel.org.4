Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E616C2D61
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCUJA5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 05:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjCUJA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:00:29 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC73D93A;
        Tue, 21 Mar 2023 01:59:02 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id hf2so12843910qtb.3;
        Tue, 21 Mar 2023 01:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679389076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3c3sA3MMjESnwXk4E5cN5peA4kX2fpUwWLFzglk4UI=;
        b=cpJiLiPw5JocweMPfva/j120ZbrVVN2nJuLKZgcr/jeOtDUPlVCRaM8aHMSCgcp1Zn
         dE9FsQUyESUNwrKZzym5Q+Ea28oDRlx5IcMe+yuy+TEBl98ycr2sCpESKOwUafwSmpIk
         hfTWABgkBfqRCntfUrtwI20tLu803+DS0ED558WmILzR/9zvlsNI3tggR3RCmOKI8FBV
         0mkxKY07siolQKMQWVdak55uqx2yArlucKTQkpmmjP5LGFAtEavk4FQbNiMPR8uhIv53
         xKZlL69KImdhoLEl6BvzBjMKW84ZYLIdGzJ3HOb9lWtS1kcWr1s/BCX75PYZL/f2RyT8
         0GjA==
X-Gm-Message-State: AO0yUKVamHXqq+WnPtTFMBV8a5qu6OD9Wa9aiybd3fTOf+CEi5oW0u92
        SKwyrWVCw3IRq0ql18oaHtDDTR0svXMtEA==
X-Google-Smtp-Source: AK7set9F+vbsTwkJXm/k6x9dVA1C6jI3Dj4nT0B74nSOLkwqzM2zco9Ni3Q+C0yQzMcPxXSsAQVwhg==
X-Received: by 2002:ac8:5a8d:0:b0:3bf:e43f:6992 with SMTP id c13-20020ac85a8d000000b003bfe43f6992mr2803210qtc.57.1679389076030;
        Tue, 21 Mar 2023 01:57:56 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id s14-20020a37450e000000b007417e60f621sm8943319qka.126.2023.03.21.01.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 01:57:55 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5447d217bc6so268593257b3.7;
        Tue, 21 Mar 2023 01:57:55 -0700 (PDT)
X-Received: by 2002:a81:ac0d:0:b0:545:45f4:2e50 with SMTP id
 k13-20020a81ac0d000000b0054545f42e50mr602754ywh.4.1679388614423; Tue, 21 Mar
 2023 01:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
 <fac6b2c757166df891d60bd00524af7e7d30fe78.camel@physik.fu-berlin.de>
In-Reply-To: <fac6b2c757166df891d60bd00524af7e7d30fe78.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Mar 2023 09:50:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUJ+o4qf056XgLHtkoPnqL+Nk4jZhQ7zntKS0_1dzYAEg@mail.gmail.com>
Message-ID: <CAMuHMdUJ+o4qf056XgLHtkoPnqL+Nk4jZhQ7zntKS0_1dzYAEg@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Mar 21, 2023 at 9:47 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2023-03-21 at 09:30 +0100, Geert Uytterhoeven wrote:
> > sh/migor_defconfig:
> >
> >     mm/slab.c: In function ‘slab_memory_callback’:
> >     mm/slab.c:1127:23: error: implicit declaration of function ‘init_cache_node_node’; did you mean ‘drain_cache_node_node’? [-Werror=implicit-function-declaration]
> >      1127 |                 ret = init_cache_node_node(nid);
> >         |                       ^~~~~~~~~~~~~~~~~~~~
> >         |                       drain_cache_node_node
> >
> > The #ifdef condition protecting the definition of init_cache_node_node()
> > no longer matches the conditions protecting the (multiple) users.
> >
> > Fix this by syncing the conditions.
> >
> > Fixes: 76af6a054da40553 ("mm/migrate: add CPU hotplug to demotion #ifdef")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Link: https://lore.kernel.org/r/b5bdea22-ed2f-3187-6efe-0c72330270a4@infradead.org
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  mm/slab.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/slab.c b/mm/slab.c
> > index ba454246ee13dd4d..de1523a78f2e7367 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -839,7 +839,7 @@ static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
> >       return 0;
> >  }
> >
> > -#if (defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)) || defined(CONFIG_SMP)
> > +#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
> >  /*
> >   * Allocates and initializes node for a node on each slab cache, used for
> >   * either memory or cpu hotplug.  If memory is being hot-added, the kmem_cache_node
>
> FWIW, the other #ifdef starting at drain_cache_node_node() closes with "#endif /* CONFIG_NUMA */",
> while this #ifdef just ends with "#endif". Just in case you want to make this consistent.

I guess that's fine, as init_cache_node_node() is a small function.
#endif comments are typically used when the start and end markers
do not fit on your (80x25 ;-) screen.

> Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
