Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D316F6DCA18
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDJRiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjDJRiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:38:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5191BE4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:38:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a52667955dso4478315ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681148289; x=1683740289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao3YUfQTjR7qBJcO8EApW9sgj4iOJlnQmNbTg6seOCM=;
        b=P0Yu8RfcWaztZwB5gMnan5ZL3+NGTMOr/SI9waTbhOWQ6rdGTe2U7QtFIaG39SXz+t
         UC2mJML+QxLBqgdyaG/o5khtJRjTHVoxXD7l5f86cFJ+TuEJwOCyQpmvYpSaD/BPhjDS
         GZm1gQ99xRFLixv29I0WdNwT74lDsw6E304guJokVTyUt/foZXzrI1UY5XS4maW4sLxu
         hLWi8rql/vtaA6kNxcKNBE+jmlfOmHqWPnZ10EvmSXMoAfhe7c0G+YixwJQiudhk3ziB
         enk1/JXewJXreHBvuuNXaAlNb2W3yIap9z6XJ4d9AQXbOJEcUPpbuoUUWitzo/QBcNKj
         eoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681148289; x=1683740289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao3YUfQTjR7qBJcO8EApW9sgj4iOJlnQmNbTg6seOCM=;
        b=iul7Zm3RScbPomaBSQhFD1MvEwq3emfXJvFTAe92VbNg/aH3WGTJyC1zSi384rxU9h
         nAAOnRDzb0nVzUzmBmdzJbhG73jdWhJk5a+8Wcl3pDamqJdUfpaUBIiWkfwXbC2tb5S+
         cAGfhAryH3T9NIKca7XvdU6xqH/RsZPtXN0a5NDms3pb0O4Uynkv9fO2osLTmq0IDlnI
         CF3I15JiIOwZxr4fGtB9XVSgKzxQBW+wjz5372yxvUP8sPDyPLiLtB/j0shv3OKqG0H2
         ZXtxm+hrABllvzoi8P1aInDmB3tRp5jdh+cKWQ4FpEPeAovXJrMEkabEzMqLRtv3DRr0
         e8Vg==
X-Gm-Message-State: AAQBX9ezleFURIFi9Nc10btOrmOya4TG6wursBDi/dzxZtAfHExX4G7A
        uCx/9pvIzVdUUztT5YB/ph4=
X-Google-Smtp-Source: AKy350ayGqJbfMRsaUxLIZRJrldYOq2Bv00aa7GT286U/TmrEHGz6hGKmp5TiIHzbv/nBIer5z2MOg==
X-Received: by 2002:a62:5fc7:0:b0:633:88de:7272 with SMTP id t190-20020a625fc7000000b0063388de7272mr8114909pfb.2.1681148288627;
        Mon, 10 Apr 2023 10:38:08 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id w11-20020a63d74b000000b00513cc8c9597sm7196540pgi.10.2023.04.10.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:38:08 -0700 (PDT)
Date:   Mon, 10 Apr 2023 10:38:06 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "yebin (H)" <yebin10@huawei.com>
Cc:     Ye Bin <yebin@huaweicloud.com>, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, linux-mm@kvack.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, dchinner@redhat.com
Subject: Re: [PATCH 2/2] lib/percpu_counter: fix dying cpu compare race
Message-ID: <ZDRJfiOaS2bOxiT5@yury-laptop>
References: <20230404014206.3752945-1-yebin@huaweicloud.com>
 <20230404014206.3752945-3-yebin@huaweicloud.com>
 <ZCuQhDLkRhJy081W@yury-laptop>
 <642BC9A1.4040802@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <642BC9A1.4040802@huawei.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 02:54:25PM +0800, yebin (H) wrote:
> 
> 
> On 2023/4/4 10:50, Yury Norov wrote:
> > On Tue, Apr 04, 2023 at 09:42:06AM +0800, Ye Bin wrote:
> > > From: Ye Bin <yebin10@huawei.com>
> > > 
> > > In commit 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") a race
> > > condition between a cpu dying and percpu_counter_sum() iterating online CPUs
> > > was identified.
> > > Acctually, there's the same race condition between a cpu dying and
> > > __percpu_counter_compare(). Here, use 'num_online_cpus()' for quick judgment.
> > > But 'num_online_cpus()' will be decreased before call 'percpu_counter_cpu_dead()',
> > > then maybe return incorrect result.
> > > To solve above issue, also need to add dying CPUs count when do quick judgment
> > > in __percpu_counter_compare().
> > Not sure I completely understood the race you are describing. All CPU
> > accounting is protected with percpu_counters_lock. Is it a real race
> > that you've faced, or hypothetical? If it's real, can you share stack
> > traces?
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > ---
> > >   lib/percpu_counter.c | 11 ++++++++++-
> > >   1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> > > index 5004463c4f9f..399840cb0012 100644
> > > --- a/lib/percpu_counter.c
> > > +++ b/lib/percpu_counter.c
> > > @@ -227,6 +227,15 @@ static int percpu_counter_cpu_dead(unsigned int cpu)
> > >   	return 0;
> > >   }
> > > +static __always_inline unsigned int num_count_cpus(void)
> > This doesn't look like a good name. Maybe num_offline_cpus?
> > 
> > > +{
> > > +#ifdef CONFIG_HOTPLUG_CPU
> > > +	return (num_online_cpus() + num_dying_cpus());
> >                 ^                                    ^
> >           'return' is not a function. Braces are not needed
> > 
> > Generally speaking, a sequence of atomic operations is not an atomic
> > operation, so the above doesn't look correct. I don't think that it
> > would be possible to implement raceless accounting based on 2 separate
> > counters.
> Yes, there is indeed a concurrency issue with doing so here. But I saw that
> the process was first
> set up dying_mask and then reduce the number of online CPUs. The total
> quantity maybe is larger
> than the actual value and may fall back to a slow path.But this won't cause
> any problems.

This sounds like an implementation detail. If it will change in
future, your accounting will get broken.

If you think it's a consistent behavior and will be preserved in
future, then it must be properly commented in your patch.

Thanks,
Yury
