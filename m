Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A066BD2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjCPPFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCPPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:05:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB65FBAD2C;
        Thu, 16 Mar 2023 08:05:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r27so2746455lfe.10;
        Thu, 16 Mar 2023 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678979113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uffFfXiabczaI0jKGUZNsFXzehKi34g9pKeACP002zM=;
        b=a5S8iZVQkoa3W6bl+kiq/uojcYGMWtTIRhNZHBB24sG1nQ8gkqRXwP3eIh+xbzHeeT
         d4pg6C4576VXWqdxyF2fvr8CSDsjpLhoXbl6UcUiAQW4Q7jB1yl45PxUtD4ulffopXOA
         bavulUa/dnmsziLIRXe+ap0qnOanGyPDiet4sfqzTjJtBClLmLHsuW8D7KeGneArpluG
         IWlaaloUWa9NMmFIgvStVu+HqKM5FRUIMtk7frRGqKatTa0U9DzSlnULJ+0FvSMtx2NA
         Ohpfjcn+MycuI4Ffno7n0VQt8pysTiwMz7jobv89dEIoxR0oe23Mq/40rt6QxcJTkwc8
         I9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678979113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uffFfXiabczaI0jKGUZNsFXzehKi34g9pKeACP002zM=;
        b=eH/GZydoS5Jl5FbsQ8Dsi0t2WHAWxbMIHkOQdsN/+CMthaF7fZH50pM8ax0Yw0hb+G
         0Aok0B2YM7x91EXCqLqHSdbSYJstgEtjJyOOZ4EyOdDZVjOxWjLk8/4mmI7DHe6vKjsS
         nMkyCQgIwXJ9mX65AY5A3i5Z3FvZ4PNv8oFRiBIK1tr/Ol8T9FKt0989Z51s/f9NPi38
         2D0swYMSKO76OZYBu1aZL6EArs5psGMZPX2A0UY+BBuJeSBS7XHSZ2QNEYVhNqKAQa5O
         d5sx5dLKCDau/VRqpmmCfMWC8lpuILrfl/DPwWSRQELofwmsDMcgZEPVQL6DcefOrAcK
         JrAg==
X-Gm-Message-State: AO0yUKWO2wZj8hjeow/8hWs54ZkKP1aa7q/Y1EVvToLmDpQUlGGrAi0F
        HG1Q0u6BZeT7Xaib5TGEbAQ=
X-Google-Smtp-Source: AK7set/z7tIo2PKRO9aFULOVZQphkue7B7gQSrm5ui/PFTloTIbNodzQVZjVROGGEcd+j5joE6Akhw==
X-Received: by 2002:ac2:5981:0:b0:4dc:807a:d144 with SMTP id w1-20020ac25981000000b004dc807ad144mr3138165lfn.39.1678979112737;
        Thu, 16 Mar 2023 08:05:12 -0700 (PDT)
Received: from pc636 (host-90-233-209-246.mobileonline.telia.com. [90.233.209.246])
        by smtp.gmail.com with ESMTPSA id d27-20020ac2545b000000b004dbebb3a6fasm1254314lfn.175.2023.03.16.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:05:12 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Mar 2023 16:05:09 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <ZBMwJYFYpfLsuW5F@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com>
 <ZAni8Q1NW9cWrvHJ@pc636>
 <20230315183648.5164af0f@gandalf.local.home>
 <ZBLQZSm+SuazEODN@pc636>
 <20230316095653.4beccbe0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316095653.4beccbe0@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 09:56:53AM -0400, Steven Rostedt wrote:
> On Thu, 16 Mar 2023 09:16:37 +0100
> Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > > index ef8ed3b65d05..e6037752dcf0 100644
> > > --- a/kernel/trace/trace_probe.h
> > > +++ b/kernel/trace/trace_probe.h
> > > @@ -256,6 +256,7 @@ struct trace_probe {
> > >  struct event_file_link {
> > >  	struct trace_event_file		*file;
> > >  	struct list_head		list;
> > > +	struct rcu_head			rcu;
> > >  };
> > >  
> > >  static inline bool trace_probe_test_flag(struct trace_probe *tp,
> > >  
> > struct foo_a {
> >   int a;
> >   int b;
> > };
> 
> Most machines today are 64 bits, even low end machines.
> 
>  struct foo_a {
> 	long long a;
> 	long long b;
>  };
> 
> is more accurate. That's 16 bytes.
> 
> Although it is more likely off because list_head is a double pointer. But
> let's just go with this, as the amount really doesn't matter here.
> 
> > 
> > your obj size is 8 byte
> > 
> > struct foo_b {
> >   struct rcu_head rcu;
> 
> Isn't rcu_head defined as;
> 
> struct callback_head {
>         struct callback_head *next;
>         void (*func)(struct callback_head *head);
> } __attribute__((aligned(sizeof(void *))));
> #define rcu_head callback_head
> 
> Which makes it 8 not 16 on 32 bit as well?
> 
> >   int a;
> >   int b;
> > };
> 
> So it should be 8 + 8 = 16, on 32 bit and 16 + 16 = 32 on 64bit.
> 
> > 
> > now it becomes 16 + 8 = 24 bytes. In reallity a foo_b object
> > will be 32 bytes since there is no slab for 24 bytes:
> > 
> > <snip>
> >   kmalloc-32         19840  19840     32  128    1 : tunables    0    0    0 : slabdata    155    155      0
> >   kmalloc-16         28857  28928     16  256    1 : tunables    0    0    0 : slabdata    113    113      0
> >   kmalloc-8          37376  37376      8  512    1 : tunables    0    0    0 : slabdata     73     73      0
> > <snip>
> > 
> > if we allocate 512 objects of foo_a it would be 4096 bytes
> > in case of foo_b it is 24 * 512 = 12228 bytes.
> 
> This is for probe events. We usually allocate 1, maybe 2. Oh, some may even
> allocate 100 to be crazy. But each probe event is in reality much larger
> (1K perhaps) as each one allocates dentry's, inodes, etc. So 8 or 16 bytes
> extra is still lost in the noise.
> 
> > 
> > single argument will give you 4096 + 512 * 8 = 8192 bytes
> > int terms of memory consumtion.
> 
> If someone allocate 512 instances, that would be closer to a meg in size
> without this change. 8k is probably less than 1%
> 
In percentage. My case. (12228 - 8192) * 100 / 12228 = ~33% difference.

> > 
> > And double argument will not give you better performance comparing
> > with a single argument.
> 
> It will, because it will no longer have to allocate anything if need be.
> Note, when it doesn't allocate the system is probably mostly idle and we
> don't care about performance, but when it needs allocation, that's likely a
> time when performance is a bit more important.
> 
The problem further is about pointer chasing, like comparing arrays and
lists. It will take longer time to offload all pointers.

--
Uladzislau Rezki
