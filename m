Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE7645A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLGMxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiLGMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:53:06 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25D2982C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:53:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l26so7285665wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 04:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SaZKvzrELtZk2moYXHTejAAx0pVU4ccKfYCaOf5kf6s=;
        b=Zn0bxdNAFoGshkFY4WWwXydY9YieUgDTNZ7UMeR67e3fjlwuS3bimPdqo+MlcClmlA
         fLNNhn7lOtPh3kHboREx0u0pavIRPoZ8MPQtUqmVWQhHoWMnG69jDb8GbMwd6C7GFJsQ
         NuSKOtY9XaouhxW8KB/Vri7ug8VeMKV2+LGU19xE5ea0m30ANCKbs/VGpcQEbVv40n9x
         I985ZKWJvAV1wo2PsPaLr88Rk9C81QmEfEhpUq5bQA8od3/kVF2kWGBu0xyDFcEgAESi
         qlcoV56MVSQKnM4xnFKdxcjsZ6xpA9yE+2XNVbWboluVsLgl9Hf4w/PNkj/u1euW8ww8
         DS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaZKvzrELtZk2moYXHTejAAx0pVU4ccKfYCaOf5kf6s=;
        b=QzGTMEovi1XTXvzHMFyt57BJ464yvgcmViCpkXxm/HWPxlR3wTOS0Tgk0BVUxpBikH
         XX/rMnjojEPDPorTlgJ+tQuJOjYaZvvAqBtdqjloC3Aa+KEjrGJm35I2trX2BR0TwHfU
         chzqzQKdIPC0O5IizOAHHgZ/dK1gesFCEE30gz3CWvnCeEipooqGN5XpcUEn+Ms6v7o2
         5+qVvgQ7hFyzzU16NCOhOLyzWDJX6QBwlqDdQLg0simA8ncPDu8Gm0R9udVHhSHjBUzC
         u58R2GyoC9ySf3jglJBt8xcjz1YkwwVQhFBSrBDxWlxC54XuK7/r4BFOr2jcUthT/21n
         vGDQ==
X-Gm-Message-State: ANoB5pne9b5QUPJXnUopyteC0onUU8FOaRpzTKi80k7P2E82LnJx1I09
        3IoeNesbCp5wJv6TaT8Z48ORvQ==
X-Google-Smtp-Source: AA0mqf6jVbDAqxIxt3K1pXrMoZOl/WacnQGFWIw2cU8q357bgB5/zhXEO0AhmwEdMCP8UHHxuv0l0g==
X-Received: by 2002:a1c:6a02:0:b0:3cf:71e4:75b with SMTP id f2-20020a1c6a02000000b003cf71e4075bmr56055226wmc.114.1670417583450;
        Wed, 07 Dec 2022 04:53:03 -0800 (PST)
Received: from localhost (ip-046-005-139-011.um12.pools.vodafone-ip.de. [46.5.139.11])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6445000000b002368f6b56desm23188922wrw.18.2022.12.07.04.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 04:53:03 -0800 (PST)
Date:   Wed, 7 Dec 2022 13:53:00 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, cgroups@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: Low TCP throughput due to vmpressure with swap enabled
Message-ID: <Y5CMrPMDxngMZWN8@cmpxchg.org>
References: <Y30rdnZ+lrfOxjTB@cmpxchg.org>
 <CABWYdi3PqipLxnqeepXeZ471pfeBg06-PV0Uw04fU-LHnx_A4g@mail.gmail.com>
 <CABWYdi0qhWs56WK=k+KoQBAMh+Tb6Rr0nY4kJN+E5YqfGhKTmQ@mail.gmail.com>
 <Y4T43Tc54vlKjTN0@cmpxchg.org>
 <CABWYdi0z6-46PrNWumSXWki6Xf4G_EP1Nvc-2t00nEi0PiOU3Q@mail.gmail.com>
 <CABWYdi25hricmGUqaK1K0EB-pAm04vGTg=eiqRF99RJ7hM7Gyg@mail.gmail.com>
 <Y4+RPry2tfbWFdSA@cmpxchg.org>
 <CANn89iJfx4QdVBqJ23oFJoz5DJKou=ZwVBNNXFNDJRNAqNvzwQ@mail.gmail.com>
 <Y4+rNYF9WZyJyBQp@cmpxchg.org>
 <20221206231049.g35ltbxbk54izrie@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231049.g35ltbxbk54izrie@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 11:10:49PM +0000, Shakeel Butt wrote:
> On Tue, Dec 06, 2022 at 09:51:01PM +0100, Johannes Weiner wrote:
> > On Tue, Dec 06, 2022 at 08:13:50PM +0100, Eric Dumazet wrote:
> > > On Tue, Dec 6, 2022 at 8:00 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > @@ -1701,10 +1701,10 @@ void mem_cgroup_sk_alloc(struct sock *sk);
> > > >  void mem_cgroup_sk_free(struct sock *sk);
> > > >  static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
> > > >  {
> > > > -       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_pressure)
> > > > +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->socket_pressure)
> > > 
> > > && READ_ONCE(memcg->socket_pressure))
> > > 
> > > >                 return true;
> > > >         do {
> > > > -               if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
> > > > +               if (memcg->socket_pressure)
> > > 
> > > if (READ_ONCE(...))
> > 
> > Good point, I'll add those.
> > 
> > > > @@ -7195,10 +7194,10 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
> > > >                 struct page_counter *fail;
> > > >
> > > >                 if (page_counter_try_charge(&memcg->tcpmem, nr_pages, &fail)) {
> > > > -                       memcg->tcpmem_pressure = 0;
> > > 
> > > Orthogonal to your patch, but:
> > > 
> > > Maybe avoid touching this cache line too often and use READ/WRITE_ONCE() ?
> > > 
> > >     if (READ_ONCE(memcg->socket_pressure))
> > >       WRITE_ONCE(memcg->socket_pressure, false);
> > 
> > Ah, that's a good idea.
> > 
> > I think it'll be fine in the failure case, since that's associated
> > with OOM and total performance breakdown anyway.
> > 
> > But certainly, in the common case of the charge succeeding, we should
> > not keep hammering false into that variable over and over.
> > 
> > How about the delta below? I also flipped the branches around to keep
> > the common path at the first indentation level, hopefully making that
> > a bit clearer too.
> > 
> > Thanks for taking a look, Eric!
> > 
> 
> I still think we should not put a persistent state of socket pressure on
> unsuccessful charge which will only get reset on successful charge. I
> think the better approach would be to limit the pressure state by time
> window same as today but set it on charge path. Something like below:

I don't mind doing that if necessary, but looking at the code I don't
see why it would be.

The socket code sets protocol memory pressure on allocations that run
into limits, and clears pressure on allocations that succeed and
frees. Why shouldn't we do the same thing for memcg?

@@ -7237,6 +7235,9 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
        mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
        refill_stock(memcg, nr_pages);
+
+       if (unlikely(READ_ONCE(memcg->socket_pressure)))
+               WRITE_ONCE(memcg->socket_pressure, false);
 }
