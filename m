Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAC6BC8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCPIRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCPIRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:17:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCD8474C5;
        Thu, 16 Mar 2023 01:17:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eg48so4128646edb.13;
        Thu, 16 Mar 2023 01:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678954600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJSwqwX1kM7OmJ2qiAAI5tNR9TgYHz/Z+czj3x+7JkY=;
        b=jYJ1iOLsrE9Iz57+I2YtUy5kpPvpwSy9JSVYsiHebUojfRXHir+MH8n0lw6E8QhRlD
         6J+DeP+LNHLY8t0xXuVylPs1/PqxKQedieLM4472YLY3Jl4+ZD2LCTh2lVDAisaucRMJ
         BDL1gNre1xOKwUxxaDCJXWjFnWNBLUii1Z2sxsZCpLv+IceLEQVJ8YQhu3czrc9XAh9U
         CiCSkQyaeDYiuPO9/ChHXkpyhaBLXU1rShY2BxzIYgMP1xlDRK9MCnHNHNxOSl53mnLt
         wPAfr6CGV0JOGgfcJCEG35A+5I9XRM+ZTV2/pqQXViGC3ncpa8o7MDJ+fJ2YPDEON/HL
         SVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJSwqwX1kM7OmJ2qiAAI5tNR9TgYHz/Z+czj3x+7JkY=;
        b=xwUYYzSRo5Jp2dddJH46U8qsiFXpG9pd9fO/PihzhU6a3mJihW/UdJ30rXGXLHPxgY
         hM9uAz/pVhEVn3VRYF4WzIBFRNzLQeTR9Dbh+xfbbloiniLKegs6P8N17YIJwaJZ86ba
         tpZrwMUL+N9mTWlKNNnH+DO4FX8aftuYTOxYh3fU8r4N2SSpf2YixZvCGGmqgVgUPNJZ
         uf4pdh+nkCLgpzKowroTeQkfzqcr9NXvGvPF3faqJETd145m8rn3NO41JUcaz4liNrBc
         HaMubQPWM2qWF0z+vfCKnTB0ucAgj3Spq3J7786SDmvunw9g+PO1lBunjw48OUO+yl6Q
         JEzw==
X-Gm-Message-State: AO0yUKVmueZcvyQJHBNjeOT/m64AQQPNQx2hUuIo7D2RVEtXxUkdHf8+
        RV7UWkWz5HTu+OWcIzcIXwI=
X-Google-Smtp-Source: AK7set9UBeiMbNMwtzRfrxfZz7RMwIhyXu2mpmsfRN2SGbJpd0BssiVEpCP7Yd0cRteVdYHhc4Dspg==
X-Received: by 2002:a17:906:5a95:b0:886:7e24:82eb with SMTP id l21-20020a1709065a9500b008867e2482ebmr9771344ejq.21.1678954600139;
        Thu, 16 Mar 2023 01:16:40 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id gx4-20020a170906f1c400b00930aa50372csm297324ejb.43.2023.03.16.01.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:16:39 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Mar 2023 09:16:37 +0100
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
Message-ID: <ZBLQZSm+SuazEODN@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com>
 <ZAni8Q1NW9cWrvHJ@pc636>
 <20230315183648.5164af0f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315183648.5164af0f@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 9 Mar 2023 14:45:21 +0100
> Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > > The kvfree_rcu()'s single argument name is deprecated therefore
> > > rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
> > > underline that it is for sleepable contexts.
> > > 
> > > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >  
> > Could you please add you reviwed-by or Acked-by tags so we can bring
> > our series with renaming for the next merge window?
> 
> I don't know. Perhaps we should just apply this patch and not worry about
> sleeping and whatnot.
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 04f0fdae19a1..5de945a8f61d 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -76,6 +76,7 @@ static unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
>  struct osnoise_instance {
>  	struct list_head	list;
>  	struct trace_array	*tr;
> +	struct rcu_head		rcu;
>  };
>  
>  static struct list_head osnoise_instances;
> @@ -159,7 +160,7 @@ static void osnoise_unregister_instance(struct trace_array *tr)
>  	if (!found)
>  		return;
>  
> -	kvfree_rcu(inst);
> +	kvfree_rcu(inst, rcu);
>  }
>  
>  /*
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 20d0c4a97633..ef5fafb40c76 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1172,7 +1172,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
>  		return -ENOENT;
>  
>  	list_del_rcu(&link->list);
> -	kvfree_rcu(link);
> +	kvfree_rcu(link, rcu);
>  
>  	if (list_empty(&tp->event->files))
>  		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index ef8ed3b65d05..e6037752dcf0 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -256,6 +256,7 @@ struct trace_probe {
>  struct event_file_link {
>  	struct trace_event_file		*file;
>  	struct list_head		list;
> +	struct rcu_head			rcu;
>  };
>  
>  static inline bool trace_probe_test_flag(struct trace_probe *tp,
>
struct foo_a {
  int a;
  int b;
};

your obj size is 8 byte

struct foo_b {
  struct rcu_head rcu;
  int a;
  int b;
};

now it becomes 16 + 8 = 24 bytes. In reallity a foo_b object
will be 32 bytes since there is no slab for 24 bytes:

<snip>
  kmalloc-32         19840  19840     32  128    1 : tunables    0    0    0 : slabdata    155    155      0
  kmalloc-16         28857  28928     16  256    1 : tunables    0    0    0 : slabdata    113    113      0
  kmalloc-8          37376  37376      8  512    1 : tunables    0    0    0 : slabdata     73     73      0
<snip>

if we allocate 512 objects of foo_a it would be 4096 bytes
in case of foo_b it is 24 * 512 = 12228 bytes.

single argument will give you 4096 + 512 * 8 = 8192 bytes
int terms of memory consumtion.

And double argument will not give you better performance comparing
with a single argument.

So it depends on what you want to achieve by that patch.

--
Uladzislau Rezki
