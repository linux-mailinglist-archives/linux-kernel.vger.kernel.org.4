Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B56BE4E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjCQJGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCQJGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:06:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D0B51FA4;
        Fri, 17 Mar 2023 02:05:27 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z42so4313989ljq.13;
        Fri, 17 Mar 2023 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679043926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JLGe4WLKJEfMjwFsU5TduwMyD6XjNQ+UwVPKLee/NHg=;
        b=hNiaCEG992hv1xO7NGCuIVV2KmW8EM9+f2L9fVeCWXcZyWV/AHTx2WDcHcEXLoSazW
         V8H+HBrWyqqvQ9lsYgrF2FSbeQsB5B0cfYYiuhAchcYAUBiBACjD3L23RUOFlg/4lRz5
         N8sNN0LXZI0K9UfobEUHjNf9KN1oinsKhPDrGisHCRDIRygCmWpURxA8M6rD0aP4I+2U
         uEXu99wTlNxs845vBSqEC6S8gigj05FlHgR277KXLbX+r1KnZeUs2MBbrPPMiu10ShH0
         lot7DenJGJuupxptzb4gsutQDZbydj+1oI0126yvFQTBlYGd54rZKm4SsAvC/js3RLV7
         EfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLGe4WLKJEfMjwFsU5TduwMyD6XjNQ+UwVPKLee/NHg=;
        b=MpWXRW+4gke/XldHM/dMCUIBzqwMYWHK5VPUINxwUFreYA+yzR2WGGHo+ybu9akesF
         wlQ+cKzrjBHHKYdtHijuv+et5Y4b+VpFQjxtchzciJrFKxNyLkrfSOVtp97rBqBVrCb9
         kgVHMGp3HAZUh3QPofZhVhmtBOw7xIrt140srdeXPo2FwXO4bhqxVMcMVgvQpLHypcNM
         zs0v5YaGH9O5JjxurmbujAWmbMEifsbzxL+/tyojrDHjEMG10ziBMUgg7wUYQ06+qaSi
         793c8H/BaEUS46kk2i3oE8U00LO23n1pIuQuFVFlYXdilLZUb2nyPFvvvPcF0KlMiefu
         SO4A==
X-Gm-Message-State: AO0yUKUjOKnZkgy9cNIXRfQYoF9dExgp6vnXng41NdCXDStd/lTce9dA
        bnsLpqIR5Q8ATqShoCL6WX2QoKGXJEAlpQ==
X-Google-Smtp-Source: AK7set9a3qRu4shYfvvjzSFC9qjn5/7Bri8KIvRQU7LOEvlOMePSawXxMa11djY1d1KJIPGENRQHmA==
X-Received: by 2002:a2e:8850:0:b0:299:a7be:5775 with SMTP id z16-20020a2e8850000000b00299a7be5775mr1981778ljj.35.1679043925537;
        Fri, 17 Mar 2023 02:05:25 -0700 (PDT)
Received: from pc636 (host-90-233-209-246.mobileonline.telia.com. [90.233.209.246])
        by smtp.gmail.com with ESMTPSA id g8-20020a19ac08000000b0047f7722b73csm274146lfc.142.2023.03.17.02.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 02:05:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 17 Mar 2023 10:05:22 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <ZBQtUr6MLhDYqPl5@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com>
 <ZAni8Q1NW9cWrvHJ@pc636>
 <20230315183648.5164af0f@gandalf.local.home>
 <ZBLQZSm+SuazEODN@pc636>
 <20230316095653.4beccbe0@gandalf.local.home>
 <ZBMwJYFYpfLsuW5F@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBMwJYFYpfLsuW5F@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 04:05:09PM +0100, Uladzislau Rezki wrote:
> On Thu, Mar 16, 2023 at 09:56:53AM -0400, Steven Rostedt wrote:
> > On Thu, 16 Mar 2023 09:16:37 +0100
> > Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > > > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > > > index ef8ed3b65d05..e6037752dcf0 100644
> > > > --- a/kernel/trace/trace_probe.h
> > > > +++ b/kernel/trace/trace_probe.h
> > > > @@ -256,6 +256,7 @@ struct trace_probe {
> > > >  struct event_file_link {
> > > >  	struct trace_event_file		*file;
> > > >  	struct list_head		list;
> > > > +	struct rcu_head			rcu;
> > > >  };
> > > >  
> > > >  static inline bool trace_probe_test_flag(struct trace_probe *tp,
> > > >  
> > > struct foo_a {
> > >   int a;
> > >   int b;
> > > };
> > 
> > Most machines today are 64 bits, even low end machines.
> > 
> >  struct foo_a {
> > 	long long a;
> > 	long long b;
> >  };
> > 
> > is more accurate. That's 16 bytes.
> > 
> > Although it is more likely off because list_head is a double pointer. But
> > let's just go with this, as the amount really doesn't matter here.
> > 
> > > 
> > > your obj size is 8 byte
> > > 
> > > struct foo_b {
> > >   struct rcu_head rcu;
> > 
> > Isn't rcu_head defined as;
> > 
> > struct callback_head {
> >         struct callback_head *next;
> >         void (*func)(struct callback_head *head);
> > } __attribute__((aligned(sizeof(void *))));
> > #define rcu_head callback_head
> > 
> > Which makes it 8 not 16 on 32 bit as well?
> > 
> > >   int a;
> > >   int b;
> > > };
> > 
> > So it should be 8 + 8 = 16, on 32 bit and 16 + 16 = 32 on 64bit.
> > 
> > > 
> > > now it becomes 16 + 8 = 24 bytes. In reallity a foo_b object
> > > will be 32 bytes since there is no slab for 24 bytes:
> > > 
> > > <snip>
> > >   kmalloc-32         19840  19840     32  128    1 : tunables    0    0    0 : slabdata    155    155      0
> > >   kmalloc-16         28857  28928     16  256    1 : tunables    0    0    0 : slabdata    113    113      0
> > >   kmalloc-8          37376  37376      8  512    1 : tunables    0    0    0 : slabdata     73     73      0
> > > <snip>
> > > 
> > > if we allocate 512 objects of foo_a it would be 4096 bytes
> > > in case of foo_b it is 24 * 512 = 12228 bytes.
> > 
> > This is for probe events. We usually allocate 1, maybe 2. Oh, some may even
> > allocate 100 to be crazy. But each probe event is in reality much larger
> > (1K perhaps) as each one allocates dentry's, inodes, etc. So 8 or 16 bytes
> > extra is still lost in the noise.
> > 
> > > 
> > > single argument will give you 4096 + 512 * 8 = 8192 bytes
> > > int terms of memory consumtion.
> > 
> > If someone allocate 512 instances, that would be closer to a meg in size
> > without this change. 8k is probably less than 1%
> > 
> In percentage. My case. (12228 - 8192) * 100 / 12228 = ~33% difference.
> 
> > > 
> > > And double argument will not give you better performance comparing
> > > with a single argument.
> > 
> > It will, because it will no longer have to allocate anything if need be.
> > Note, when it doesn't allocate the system is probably mostly idle and we
> > don't care about performance, but when it needs allocation, that's likely a
> > time when performance is a bit more important.
> > 
> The problem further is about pointer chasing, like comparing arrays and
> lists. It will take longer time to offload all pointers.
> 
Since i have a data, IMHO it is better to share than not:

--bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=3 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot"

# double-argument 10 run
Total time taken by all kfree'ers: 4387872408 ns, loops: 10000, batches: 958,  memory footprint: 40MB
Total time taken by all kfree'ers: 4415232304 ns, loops: 10000, batches: 982,  memory footprint: 39MB
Total time taken by all kfree'ers: 4270303081 ns, loops: 10000, batches: 955,  memory footprint: 42MB
Total time taken by all kfree'ers: 4364984147 ns, loops: 10000, batches: 953,  memory footprint: 40MB
Total time taken by all kfree'ers: 4225994506 ns, loops: 10000, batches: 942,  memory footprint: 40MB
Total time taken by all kfree'ers: 4601087346 ns, loops: 10000, batches: 1033, memory footprint: 40MB
Total time taken by all kfree'ers: 4853397855 ns, loops: 10000, batches: 1109, memory footprint: 38MB
Total time taken by all kfree'ers: 4627914204 ns, loops: 10000, batches: 1037, memory footprint: 39MB
Total time taken by all kfree'ers: 4274587317 ns, loops: 10000, batches: 938,  memory footprint: 33MB
Total time taken by all kfree'ers: 4642151205 ns, loops: 10000, batches: 1068, memory footprint: 39MB

# single-argument 10 run
Total time taken by all kfree'ers: 3661190052 ns, loops: 10000, batches: 831, memory footprint: 29MB
Total time taken by all kfree'ers: 3616277061 ns, loops: 10000, batches: 780, memory footprint: 27MB
Total time taken by all kfree'ers: 3704584439 ns, loops: 10000, batches: 810, memory footprint: 27MB
Total time taken by all kfree'ers: 3631291959 ns, loops: 10000, batches: 812, memory footprint: 28MB
Total time taken by all kfree'ers: 3610490769 ns, loops: 10000, batches: 795, memory footprint: 27MB
Total time taken by all kfree'ers: 3595446243 ns, loops: 10000, batches: 825, memory footprint: 28MB
Total time taken by all kfree'ers: 3686252889 ns, loops: 10000, batches: 784, memory footprint: 27MB
Total time taken by all kfree'ers: 3821475275 ns, loops: 10000, batches: 869, memory footprint: 27MB
Total time taken by all kfree'ers: 3740407185 ns, loops: 10000, batches: 813, memory footprint: 28MB
Total time taken by all kfree'ers: 3646684795 ns, loops: 10000, batches: 780, memory footprint: 24MB

And yes, there are side effects. For example a low memory condition.

--
Uladzislau Rezki
