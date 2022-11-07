Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25E561EBAB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiKGHUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiKGHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:20:29 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07760EA
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:20:29 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id c2so10264934plz.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 23:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgoRVUgxwXJrcmiPeyTeFWYr8HX0hdcHEbm1EMJUS3k=;
        b=tGuVmynlCKS41wB+STnS20ND816H1/6aCKBJZ+D9TzdUKKd2lQGOKaJvNTbAPVrzwW
         35QIUzAX3701Y4qKB8vKyREpSHgNqn2q+YuGVvQ3PlFm9Iy+LHROgKiqcbcE7pkQHGXP
         pq67v1awBFylWTGOemLQp6h6+P3IZw1pgFLlAEy8bKyWhStFmf6uZ01i3K3SbKTqvmwd
         9/or89fZ6LdPlcLW2PAff1ymF/eY6ZPwVQlFaAG5Yyu/dW1iyxvY7Hgap3AEAUvs3i8S
         LvwwiQ3YLKPNMp/jeIC6rKbfEscgerIYmvEh7/CHgB/1Oj3vFO7r373RlsgnXPF8HH35
         ad8g==
X-Gm-Message-State: ANoB5pmyECSvMWaHXCSUoU18NEfhm2HRSm87/4QOA+crzWw4WhD03ot1
        t0iQW/u2aGsPFwGoz8lyOJo=
X-Google-Smtp-Source: AA0mqf6S7IR5t8Rig4uve/uPxrkEQhBeAoMqQb/ZrHuiItMUuOyPSx0Ho7wrdZlqWsgf1aPXmXNB9Q==
X-Received: by 2002:a17:902:bf0a:b0:188:6862:cc3d with SMTP id bi10-20020a170902bf0a00b001886862cc3dmr15727874plb.17.1667805628385;
        Sun, 06 Nov 2022 23:20:28 -0800 (PST)
Received: from fedora ([47.153.164.177])
        by smtp.gmail.com with ESMTPSA id x12-20020aa78f0c000000b0056cee8af3a5sm3710764pfr.29.2022.11.06.23.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:20:27 -0800 (PST)
Date:   Sun, 6 Nov 2022 23:20:24 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH 8/8] mm/slub, percpu: correct the calculation of early
 percpu allocation size
Message-ID: <Y2ixuDbcQgtqE1Ox@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-9-bhe@redhat.com>
 <b3776af5-65c7-62b4-7624-184420d0da63@suse.cz>
 <Y2iLLIL/jBL4dftJ@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2iLLIL/jBL4dftJ@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On Mon, Nov 07, 2022 at 12:35:56PM +0800, Baoquan He wrote:
> On 11/06/22 at 09:56pm, Vlastimil Babka wrote:
> > On 10/24/22 10:14, Baoquan He wrote:
> > > SLUB allocator relies on percpu allocator to initialize its ->cpu_slab
> > > during early boot. For that, the dynamic chunk of percpu which serves
> > > the early allocation need be large enough to satisfy the kmalloc
> > > creation.
> > > 
> > > However, the current BUILD_BUG_ON() in alloc_kmem_cache_cpus() doesn't
> > > consider the kmalloc array with NR_KMALLOC_TYPES length. Fix that
> > > with correct calculation.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > Cc: Christoph Lameter <cl@linux.com>
> > > Cc: Pekka Enberg <penberg@kernel.org>
> > > Cc: David Rientjes <rientjes@google.com>
> > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > ---
> > >  mm/slub.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > As only slub is touched and there's no prerequsities in the previous
> > patches, I took this to the slab tree, branch
> > slab/for-6.2/cleanups
> 
> Yes, it only changes slub code. Thanks for taking it.
> 
> I will resend v2 with the left 7 percpu only patches with update.
> 
> 

Don't worry about resending them, I'll pick them up tomorrow morning.

Thanks,
Dennis
