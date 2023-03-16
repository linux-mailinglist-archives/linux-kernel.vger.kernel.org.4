Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727726BD799
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCPRzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCPRzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:55:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D8A7EC8;
        Thu, 16 Mar 2023 10:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C768C620B3;
        Thu, 16 Mar 2023 17:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EC1C433EF;
        Thu, 16 Mar 2023 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678989294;
        bh=fAyb965+K/lVukS5xMMsFo8dHBwVzWtpB66j36wUhfQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UWWcY/xsxSDztGJ1ZGPxAmoxhqYpFmkLeA3Fh/08eS5A41/B1j30+sB4aLlxsDTHo
         CXBZo6/IINhxXCKdwFdtMLXs2ZCFqCmkiyokkvRa0CPkkG1wTHUzftEZ1g9CN83oaV
         gVDvf1+PA2yqTQyITRfSVLzdLbHKLvZBx8znxOgPAYTUWVcee66fQ/1MeTEUcmQGLc
         DWwtS9liV/Cv6KyMdPnkMXqjQ1rf84tRWHQPGHsHSX7J75P+n6PljEd9dvuZI+EL4k
         MhVImE8gXWKxus3MQtM7XzOUE+d7eGiRe+YmWus1KkXJZsna76uKz4j7ErB5lYeo17
         JBOEd0GDk5Naw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D82431540395; Thu, 16 Mar 2023 10:54:53 -0700 (PDT)
Date:   Thu, 16 Mar 2023 10:54:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
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
Message-ID: <9c5a24c2-8b8c-4037-9607-76f4438693f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com>
 <ZAni8Q1NW9cWrvHJ@pc636>
 <20230315183648.5164af0f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315183648.5164af0f@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:36:48PM -0400, Steven Rostedt wrote:
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

Just in case it is not clear:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

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
