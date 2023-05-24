Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F320070ED65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbjEXFyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjEXFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:54:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF113E;
        Tue, 23 May 2023 22:54:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae5dc9eac4so4200555ad.1;
        Tue, 23 May 2023 22:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684907658; x=1687499658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qmpQ8CZWBqNpjBXlf/vqm5PoXrDI3CUBIg7+r/yPqX4=;
        b=Ll/kZY4z6GmbqweRRDzeefXlVdAGFZlUdDBFJEEMbnx3h+Ai+c8cqNCxSTkGFketNw
         C+DGOb0/ZJZRjKYhfBlEOR2yoc2OBWfvsq0i/+9Zev4wmSL3MPPsq29MahVf9CRjSJEh
         ojsW9Q5vHIve/zDAZ12KN3ozwikW/7+QNf5Lgw/IJCVPBZnFAhikIxygmuWMi7bdaKyk
         r/rI6PMOlYB1WLK/WOu3cw+D9+hYWYzwubMDCINnWIjDc+FbUqKiiMUQoROl6pqKpbcD
         UZ3FkgMtjT6fd8zloBWdktCLFkjIo4tsryrYxDI4kfTTKW4LePLeEg2fCje+8yGW+EMU
         E5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684907658; x=1687499658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmpQ8CZWBqNpjBXlf/vqm5PoXrDI3CUBIg7+r/yPqX4=;
        b=ilhmHy4E7wMwNaYcYaSr0V4Evcl8iN5oz1R5UTM/t1MunQh4Zie+BEgtJZvMbSw3bR
         Bkf5LaZTmCxxPjos1Q+M9E0NIp3QPY/r0LXVLV8RbQgYn7EOrFLqfDahp9Do2K1RL0B2
         OqfhcqbbMZnzKluTIKbaCBRqCLj9HaNBD+zJ/Cn0S4laS9sgN6cKtoxuY/h5+ZkR04lN
         Fbt/kv4JgbSKTCvX2m2XWc0C3ZA6bTfX5OXNgTasG6yg2NtGForWAkKZuNsBcMFDAfd4
         pxYwltvtGcqlgvPYvqnkbgKvi2iozRGZmIPz1OcXuYxQOPccnbZW+SVFMd5grC98Ma3S
         hCgg==
X-Gm-Message-State: AC+VfDzcIMBB8dcYRKNjVYi7CQ7PQZI9TYPY7aWPfyi6otd18EDoUdSb
        Ila0+BqKNFMn1DhjCWYn2yY=
X-Google-Smtp-Source: ACHHUZ76vGdzaPECnMi7UdUsqTthz47m8It48b8hGnCFJV0vnlbq9vB/sfF/1XsTkmmCIr3dHhHU3A==
X-Received: by 2002:a17:903:188:b0:1ae:600d:3d07 with SMTP id z8-20020a170903018800b001ae600d3d07mr18751108plg.4.1684907658072;
        Tue, 23 May 2023 22:54:18 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 ([211.216.218.61])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902bb8a00b001aaeeeebaf1sm7723002pls.201.2023.05.23.22.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 22:54:17 -0700 (PDT)
Date:   Wed, 24 May 2023 14:54:33 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        kasan-dev@googlegroups.com, Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Gong Ruiqi <gongruiqi1@huawei.com>
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
Message-ID: <ZG2mmWT5dxfMC3DW@debian-BULLSEYE-live-builder-AMD64>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com>
 <5f5a858a-7017-5424-0fa0-db3b79e5d95e@huawei.com>
 <CAB=+i9R0GZiau7PKDSGdCOijPH1TVqA3rJ5tQLejJpoR55h6dg@mail.gmail.com>
 <19707cc6-fa5e-9835-f709-bc8568e4c9cd@huawei.com>
 <CAB=+i9T-iqtMZw8y7SxkaFBtiXA93YwFFEtQyGynBsorud1+_Q@mail.gmail.com>
 <1cec95d5-5cd4-fbf9-754b-e6a1229d45c3@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cec95d5-5cd4-fbf9-754b-e6a1229d45c3@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 04:58:25PM +0800, GONG, Ruiqi wrote:
> 
> 
> On 2023/05/22 16:03, Hyeonggon Yoo wrote:
> > On Mon, May 22, 2023 at 4:35 PM Gong Ruiqi <gongruiqi1@huawei.com> wrote:
> >> On 2023/05/17 6:35, Hyeonggon Yoo wrote:
> > [...]
> >>>>>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> >>>>>> +# define SLAB_RANDOMSLAB       ((slab_flags_t __force)0x01000000U)
> >>>>>> +#else
> >>>>>> +# define SLAB_RANDOMSLAB       0
> >>>>>> +#endif
> >>>
> >>> There is already the SLAB_KMALLOC flag that indicates if a cache is a
> >>> kmalloc cache. I think that would be enough for preventing merging
> >>> kmalloc caches?
> >>
> >> After digging into the code of slab merging (e.g. slab_unmergeable(),
> >> find_mergeable(), SLAB_NEVER_MERGE, SLAB_MERGE_SAME etc), I haven't
> >> found an existing mechanism that prevents normal kmalloc caches with
> >> SLAB_KMALLOC from being merged with other slab caches. Maybe I missed
> >> something?
> >>
> >> While SLAB_RANDOMSLAB, unlike SLAB_KMALLOC, is added into
> >> SLAB_NEVER_MERGE, which explicitly indicates the no-merge policy.
> > 
> > I mean, why not make slab_unmergable()/find_mergeable() not to merge kmalloc
> > caches when CONFIG_RANDOM_KMALLOC_CACHES is enabled, instead of a new flag?
> > 
> > Something like this:
> > 
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 607249785c07..13ac08e3e6a0 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -140,6 +140,9 @@ int slab_unmergeable(struct kmem_cache *s)
> >   if (slab_nomerge || (s->flags & SLAB_NEVER_MERGE))
> >   return 1;
> > 
> > + if (IS_ENALBED(CONFIG_RANDOM_KMALLOC_CACHES) && (flags & SLAB_KMALLOC))
> > + return 1;
> > +
> >   if (s->ctor)
> >   return 1;
> > 
> > @@ -176,6 +179,9 @@ struct kmem_cache *find_mergeable(unsigned int
> > size, unsigned int align,
> >   if (flags & SLAB_NEVER_MERGE)
> >   return NULL;
> > 
> > + if (IS_ENALBED(CONFIG_RANDOM_KMALLOC_CACHES) && (flags & SLAB_KMALLOC))
> > + return NULL;
> > +
> >   list_for_each_entry_reverse(s, &slab_caches, list) {
> >   if (slab_unmergeable(s))
> >   continue;
> 
> Ah I see. My concern is that it would affect not only normal kmalloc
> caches, but kmalloc_{dma,cgroup,rcl} as well: since they were all marked
> with SLAB_KMALLOC when being created, this code could potentially change
> their mergeablity. I think it's better not to influence those irrelevant
> caches.

I see. no problem at all as we're not running out of cache flags.

By the way, is there any reason to only randomize normal caches
and not dma/cgroup/rcl caches?

Thanks,

-- 
Hyeonggon Yoo

Doing kernel stuff as a hobby
Undergraduate | Chungnam National University
Dept. Computer Science & Engineering
