Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E24B729C74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbjFIONp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjFIONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:13:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513DD19D;
        Fri,  9 Jun 2023 07:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9DEE6585A;
        Fri,  9 Jun 2023 14:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D680FC4339B;
        Fri,  9 Jun 2023 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320021;
        bh=l2+SvJnNBLIENWkFfwEGUQJXHHVIpUGVew3BYM0U4Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugCfuqSWjfVNVVJhze16ODTO+KkQIfW3UIgzQwMx4uNPsK5XjzH3pkHENZ9tgAU2m
         yuAnkb99xnZ7PIPuiQ3Iq8i7yEEz1ZJihTVPmpwy5R5MdvzWPhyMaMhKXSWOJS6AxA
         PkYpK4WuTB8qO92/G+kX7CAmM3ePqf0NQd6pl0K248Q9xUei6rIvtbkc88ShrcJaKc
         wezX5ZYEgSwJPCWzUwucJ0GoJjEK9hVWrI/X0xZBqPXnUVecavPa3Ij3IrLvnDbPbt
         TDPnt1xiSfGUtWh5sm/RpFg43iHtzpBhikF2NYSR4fjtPlf6FbgboAmI5XtidOa0F3
         92GqRrcRHG7eQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 26ED940692; Fri,  9 Jun 2023 11:13:38 -0300 (-03)
Date:   Fri, 9 Jun 2023 11:13:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v2 02/26] perf thread: Make threads rbtree non-invasive
Message-ID: <ZIMzkkxp0RFgjIwW@kernel.org>
References: <20230608232823.4027869-1-irogers@google.com>
 <20230608232823.4027869-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608232823.4027869-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 08, 2023 at 04:27:59PM -0700, Ian Rogers escreveu:
> Separate the rbtree out of thread and into a new struct
> thread_rb_node. The refcnt is in thread and the rbtree is responsible
> for a single count.

You stated what you did, but didn't spell out the reason, can you
ellaborate on this so that the git history becomes more helpful for new
contributors?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-report.c |   2 +-
>  tools/perf/builtin-trace.c  |   2 +-
>  tools/perf/util/machine.c   | 101 +++++++++++++++++++++++-------------
>  tools/perf/util/thread.c    |   3 --
>  tools/perf/util/thread.h    |   6 ++-
>  5 files changed, 73 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 92c6797e7cba..c7d526283baf 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -911,7 +911,7 @@ static int tasks_print(struct report *rep, FILE *fp)
>  		     nd = rb_next(nd)) {
>  			task = tasks + itask++;
>  
> -			task->thread = rb_entry(nd, struct thread, rb_node);
> +			task->thread = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
>  			INIT_LIST_HEAD(&task->children);
>  			INIT_LIST_HEAD(&task->list);
>  			thread__set_priv(task->thread, task);
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 62c7c99a0fe4..b0dd202d14eb 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4348,7 +4348,7 @@ DEFINE_RESORT_RB(threads, (thread__nr_events(a->thread->priv) < thread__nr_event
>  	struct thread *thread;
>  )
>  {
> -	entry->thread = rb_entry(nd, struct thread, rb_node);
> +	entry->thread = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
>  }
>  
>  static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp)
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index a1954ac85f59..cbf092e32ee9 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -43,7 +43,8 @@
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
>  
> -static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
> +static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
> +				     struct thread *th, bool lock);
>  static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
>  
>  static struct dso *machine__kernel_dso(struct machine *machine)
> @@ -72,6 +73,21 @@ static void machine__threads_init(struct machine *machine)
>  	}
>  }
>  
> +static int thread_rb_node__cmp_tid(const void *key, const struct rb_node *nd)
> +{
> +	int to_find = (int) *((pid_t *)key);
> +
> +	return to_find - (int)rb_entry(nd, struct thread_rb_node, rb_node)->thread->tid;
> +}
> +
> +static struct thread_rb_node *thread_rb_node__find(const struct thread *th,
> +						   struct rb_root *tree)
> +{
> +	struct rb_node *nd = rb_find(&th->tid, tree, thread_rb_node__cmp_tid);
> +
> +	return rb_entry(nd, struct thread_rb_node, rb_node);
> +}
> +
>  static int machine__set_mmap_name(struct machine *machine)
>  {
>  	if (machine__is_host(machine))
> @@ -214,10 +230,10 @@ void machine__delete_threads(struct machine *machine)
>  		down_write(&threads->lock);
>  		nd = rb_first_cached(&threads->entries);
>  		while (nd) {
> -			struct thread *t = rb_entry(nd, struct thread, rb_node);
> +			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
>  
>  			nd = rb_next(nd);
> -			__machine__remove_thread(machine, t, false);
> +			__machine__remove_thread(machine, trb, trb->thread, false);
>  		}
>  		up_write(&threads->lock);
>  	}
> @@ -605,6 +621,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
>  	struct rb_node **p = &threads->entries.rb_root.rb_node;
>  	struct rb_node *parent = NULL;
>  	struct thread *th;
> +	struct thread_rb_node *nd;
>  	bool leftmost = true;
>  
>  	th = threads__get_last_match(threads, machine, pid, tid);
> @@ -613,7 +630,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
>  
>  	while (*p != NULL) {
>  		parent = *p;
> -		th = rb_entry(parent, struct thread, rb_node);
> +		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
>  
>  		if (th->tid == tid) {
>  			threads__set_last_match(threads, th);
> @@ -633,30 +650,39 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
>  		return NULL;
>  
>  	th = thread__new(pid, tid);
> -	if (th != NULL) {
> -		rb_link_node(&th->rb_node, parent, p);
> -		rb_insert_color_cached(&th->rb_node, &threads->entries, leftmost);
> +	if (th == NULL)
> +		return NULL;
>  
> -		/*
> -		 * We have to initialize maps separately after rb tree is updated.
> -		 *
> -		 * The reason is that we call machine__findnew_thread
> -		 * within thread__init_maps to find the thread
> -		 * leader and that would screwed the rb tree.
> -		 */
> -		if (thread__init_maps(th, machine)) {
> -			rb_erase_cached(&th->rb_node, &threads->entries);
> -			RB_CLEAR_NODE(&th->rb_node);
> -			thread__put(th);
> -			return NULL;
> -		}
> -		/*
> -		 * It is now in the rbtree, get a ref
> -		 */
> -		thread__get(th);
> -		threads__set_last_match(threads, th);
> -		++threads->nr;
> +	nd = malloc(sizeof(*nd));
> +	if (nd == NULL) {
> +		thread__put(th);
> +		return NULL;
> +	}
> +	nd->thread = th;
> +
> +	rb_link_node(&nd->rb_node, parent, p);
> +	rb_insert_color_cached(&nd->rb_node, &threads->entries, leftmost);
> +
> +	/*
> +	 * We have to initialize maps separately after rb tree is updated.
> +	 *
> +	 * The reason is that we call machine__findnew_thread within
> +	 * thread__init_maps to find the thread leader and that would screwed
> +	 * the rb tree.
> +	 */
> +	if (thread__init_maps(th, machine)) {
> +		rb_erase_cached(&nd->rb_node, &threads->entries);
> +		RB_CLEAR_NODE(&nd->rb_node);
> +		free(nd);
> +		thread__put(th);
> +		return NULL;
>  	}
> +	/*
> +	 * It is now in the rbtree, get a ref
> +	 */
> +	thread__get(th);
> +	threads__set_last_match(threads, th);
> +	++threads->nr;
>  
>  	return th;
>  }
> @@ -1109,7 +1135,7 @@ size_t machine__fprintf(struct machine *machine, FILE *fp)
>  
>  		for (nd = rb_first_cached(&threads->entries); nd;
>  		     nd = rb_next(nd)) {
> -			struct thread *pos = rb_entry(nd, struct thread, rb_node);
> +			struct thread *pos = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
>  
>  			ret += thread__fprintf(pos, fp);
>  		}
> @@ -2020,10 +2046,14 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
>  	return 0;
>  }
>  
> -static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock)
> +static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
> +				     struct thread *th, bool lock)
>  {
>  	struct threads *threads = machine__threads(machine, th->tid);
>  
> +	if (!nd)
> +		nd = thread_rb_node__find(th, &threads->entries.rb_root);
> +
>  	if (threads->last_match == th)
>  		threads__set_last_match(threads, NULL);
>  
> @@ -2032,11 +2062,12 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
>  
>  	BUG_ON(refcount_read(&th->refcnt) == 0);
>  
> -	rb_erase_cached(&th->rb_node, &threads->entries);
> -	RB_CLEAR_NODE(&th->rb_node);
> +	thread__put(nd->thread);
> +	rb_erase_cached(&nd->rb_node, &threads->entries);
> +	RB_CLEAR_NODE(&nd->rb_node);
>  	--threads->nr;
>  
> -	thread__put(th);
> +	free(nd);
>  
>  	if (lock)
>  		up_write(&threads->lock);
> @@ -2044,7 +2075,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
>  
>  void machine__remove_thread(struct machine *machine, struct thread *th)
>  {
> -	return __machine__remove_thread(machine, th, true);
> +	return __machine__remove_thread(machine, NULL, th, true);
>  }
>  
>  int machine__process_fork_event(struct machine *machine, union perf_event *event,
> @@ -3167,7 +3198,6 @@ int machine__for_each_thread(struct machine *machine,
>  {
>  	struct threads *threads;
>  	struct rb_node *nd;
> -	struct thread *thread;
>  	int rc = 0;
>  	int i;
>  
> @@ -3175,8 +3205,9 @@ int machine__for_each_thread(struct machine *machine,
>  		threads = &machine->threads[i];
>  		for (nd = rb_first_cached(&threads->entries); nd;
>  		     nd = rb_next(nd)) {
> -			thread = rb_entry(nd, struct thread, rb_node);
> -			rc = fn(thread, priv);
> +			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
> +
> +			rc = fn(trb->thread, priv);
>  			if (rc != 0)
>  				return rc;
>  		}
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index d949bffc0ed6..38d300e3e4d3 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -66,7 +66,6 @@ struct thread *thread__new(pid_t pid, pid_t tid)
>  
>  		list_add(&comm->list, &thread->comm_list);
>  		refcount_set(&thread->refcnt, 1);
> -		RB_CLEAR_NODE(&thread->rb_node);
>  		/* Thread holds first ref to nsdata. */
>  		thread->nsinfo = nsinfo__new(pid);
>  		srccode_state_init(&thread->srccode_state);
> @@ -84,8 +83,6 @@ void thread__delete(struct thread *thread)
>  	struct namespaces *namespaces, *tmp_namespaces;
>  	struct comm *comm, *tmp_comm;
>  
> -	BUG_ON(!RB_EMPTY_NODE(&thread->rb_node));
> -
>  	thread_stack__free(thread);
>  
>  	if (thread->maps) {
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 86737812e06b..3b3f9fb5a916 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -29,8 +29,12 @@ struct lbr_stitch {
>  	struct callchain_cursor_node	*prev_lbr_cursor;
>  };
>  
> +struct thread_rb_node {
> +	struct rb_node rb_node;
> +	struct thread *thread;
> +};
> +
>  struct thread {
> -	struct rb_node		rb_node;
>  	struct maps		*maps;
>  	pid_t			pid_; /* Not all tools update this */
>  	pid_t			tid;
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 

- Arnaldo
