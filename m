Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294506BD19A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCPN5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCPN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:57:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC2BCFC0;
        Thu, 16 Mar 2023 06:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2A4CB821A2;
        Thu, 16 Mar 2023 13:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F244CC433D2;
        Thu, 16 Mar 2023 13:56:54 +0000 (UTC)
Date:   Thu, 16 Mar 2023 09:56:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
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
Message-ID: <20230316095653.4beccbe0@gandalf.local.home>
In-Reply-To: <ZBLQZSm+SuazEODN@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
        <20230201150815.409582-5-urezki@gmail.com>
        <ZAni8Q1NW9cWrvHJ@pc636>
        <20230315183648.5164af0f@gandalf.local.home>
        <ZBLQZSm+SuazEODN@pc636>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 09:16:37 +0100
Uladzislau Rezki <urezki@gmail.com> wrote:

> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index ef8ed3b65d05..e6037752dcf0 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -256,6 +256,7 @@ struct trace_probe {
> >  struct event_file_link {
> >  	struct trace_event_file		*file;
> >  	struct list_head		list;
> > +	struct rcu_head			rcu;
> >  };
> >  
> >  static inline bool trace_probe_test_flag(struct trace_probe *tp,
> >  
> struct foo_a {
>   int a;
>   int b;
> };

Most machines today are 64 bits, even low end machines.

 struct foo_a {
	long long a;
	long long b;
 };

is more accurate. That's 16 bytes.

Although it is more likely off because list_head is a double pointer. But
let's just go with this, as the amount really doesn't matter here.

> 
> your obj size is 8 byte
> 
> struct foo_b {
>   struct rcu_head rcu;

Isn't rcu_head defined as;

struct callback_head {
        struct callback_head *next;
        void (*func)(struct callback_head *head);
} __attribute__((aligned(sizeof(void *))));
#define rcu_head callback_head

Which makes it 8 not 16 on 32 bit as well?

>   int a;
>   int b;
> };

So it should be 8 + 8 = 16, on 32 bit and 16 + 16 = 32 on 64bit.

> 
> now it becomes 16 + 8 = 24 bytes. In reallity a foo_b object
> will be 32 bytes since there is no slab for 24 bytes:
> 
> <snip>
>   kmalloc-32         19840  19840     32  128    1 : tunables    0    0    0 : slabdata    155    155      0
>   kmalloc-16         28857  28928     16  256    1 : tunables    0    0    0 : slabdata    113    113      0
>   kmalloc-8          37376  37376      8  512    1 : tunables    0    0    0 : slabdata     73     73      0
> <snip>
> 
> if we allocate 512 objects of foo_a it would be 4096 bytes
> in case of foo_b it is 24 * 512 = 12228 bytes.

This is for probe events. We usually allocate 1, maybe 2. Oh, some may even
allocate 100 to be crazy. But each probe event is in reality much larger
(1K perhaps) as each one allocates dentry's, inodes, etc. So 8 or 16 bytes
extra is still lost in the noise.

> 
> single argument will give you 4096 + 512 * 8 = 8192 bytes
> int terms of memory consumtion.

If someone allocate 512 instances, that would be closer to a meg in size
without this change. 8k is probably less than 1%

> 
> And double argument will not give you better performance comparing
> with a single argument.

It will, because it will no longer have to allocate anything if need be.
Note, when it doesn't allocate the system is probably mostly idle and we
don't care about performance, but when it needs allocation, that's likely a
time when performance is a bit more important.

-- Steve
