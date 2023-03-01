Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285626A6403
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCAADo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCAADl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:03:41 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653F302B7;
        Tue, 28 Feb 2023 16:03:40 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id i4so7423424ils.1;
        Tue, 28 Feb 2023 16:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677629019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqlh8BQKuxQaHWLyKXNgCkeWAA6Guq7VsUwjTAIoHs0=;
        b=S6TTJVN4fOpTd9WQylK1e1I/+nUjvsTfwffHYj8ecdaRv5k9Z+bK2kfMCU/Lyak2Cx
         uwxrC3miRMSs0BHfKksqg1m21IKdE+QZW115OEAsOi0EjQIo97/8q4T3KCcnFiVJ71i7
         ovNkkzKBROxin5u2gPpgdCIBaO2mY35S72aHPT17zy6TCqmdPjWiE6yERPzVYYZvTKuf
         wnTK0luuR/uZm+dAqnEpWq+5rJE+qGJnaN/L/uoP0uVsmw/GQc/KPJlLid+KYzXf3ExS
         I8Fn+qora0r3espilXlHwUkPdjktQTTjeH6FPmHqBIAB7D1iHsF9BE0f5+uy8KOgw9Fs
         w0Ow==
X-Gm-Message-State: AO0yUKW3lJWzC4bH/dMikkOIebjI8398VNSRTkNqQ49DmwWseSM2az9N
        idWuhBnfT6YP1slE/H0UUTJqbgo1oAnxF5cJMf8=
X-Google-Smtp-Source: AK7set+GUKbLh5qalgpqMBZZB4Q0jnLgBVp/H8mRmWkJnfYp00sV4gjO/A/J+pu7vUTbX7hx9LX+bsCTsq75sIopSYo=
X-Received: by 2002:a05:6e02:66b:b0:314:8c8:de65 with SMTP id
 l11-20020a056e02066b00b0031408c8de65mr2199182ilt.3.1677629019509; Tue, 28 Feb
 2023 16:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20230228115125.144172-1-leo.yan@linaro.org> <20230228115125.144172-10-leo.yan@linaro.org>
In-Reply-To: <20230228115125.144172-10-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Feb 2023 16:03:27 -0800
Message-ID: <CAM9d7cgXkPw_op7tj7eZE4xP68reO8cDmwpHOa+13C1CSeOOjg@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] perf kvm: Use histograms list to replace cached list
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 3:53 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> perf kvm tool defines its own cached list which is managed with RB tree,
> histograms also provide RB tree to manage data entries.  Since now we
> have introduced histograms in the tool, it's not necessary to use the
> self defined list and we can directly use histograms list to manage
> KVM events.
>
> This patch changes to use histograms list to track KVM events, and it
> invokes the common function hists__output_resort_cb() to sort result,
> this also give us flexibility to extend more sorting key words easily.
>
> After histograms list supported, the cached list is redundant so remove
> the relevant code for it.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/builtin-kvm.c   | 186 +++++++++++++++++++------------------
>  tools/perf/util/kvm-stat.h |   7 --
>  2 files changed, 94 insertions(+), 99 deletions(-)
>
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index da84f5063d4d..32dc697ff707 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -421,44 +421,37 @@ struct vcpu_event_record {
>         struct kvm_event *last_event;
>  };
>
> -
> -static void init_kvm_event_record(struct perf_kvm_stat *kvm)
> -{
> -       unsigned int i;
> -
> -       for (i = 0; i < EVENTS_CACHE_SIZE; i++)
> -               INIT_LIST_HEAD(&kvm->kvm_events_cache[i]);
> -}
> -
>  #ifdef HAVE_TIMERFD_SUPPORT
> -static void clear_events_cache_stats(struct list_head *kvm_events_cache)
> +static void clear_events_cache_stats(void)
>  {
> -       struct list_head *head;
> +       struct rb_root_cached *root;
> +       struct rb_node *nd;
>         struct kvm_event *event;
> -       unsigned int i;
> -       int j;
> -
> -       for (i = 0; i < EVENTS_CACHE_SIZE; i++) {
> -               head = &kvm_events_cache[i];
> -               list_for_each_entry(event, head, hash_entry) {
> -                       /* reset stats for event */
> -                       event->total.time = 0;
> -                       init_stats(&event->total.stats);
> -
> -                       for (j = 0; j < event->max_vcpu; ++j) {
> -                               event->vcpu[j].time = 0;
> -                               init_stats(&event->vcpu[j].stats);
> -                       }
> +       int i;
> +
> +       if (hists__has(&kvm_hists.hists, need_collapse))
> +               root = &kvm_hists.hists.entries_collapsed;
> +       else
> +               root = kvm_hists.hists.entries_in;
> +
> +       for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
> +               struct hist_entry *he;
> +
> +               he = rb_entry(nd, struct hist_entry, rb_node_in);
> +               event = container_of(he, struct kvm_event, he);
> +
> +               /* reset stats for event */
> +               event->total.time = 0;
> +               init_stats(&event->total.stats);
> +
> +               for (i = 0; i < event->max_vcpu; ++i) {
> +                       event->vcpu[i].time = 0;
> +                       init_stats(&event->vcpu[i].stats);
>                 }
>         }
>  }
>  #endif
>
> -static int kvm_events_hash_fn(u64 key)
> -{
> -       return key & (EVENTS_CACHE_SIZE - 1);
> -}
> -
>  static bool kvm_event_expand(struct kvm_event *event, int vcpu_id)
>  {
>         int old_max_vcpu = event->max_vcpu;
> @@ -484,21 +477,51 @@ static bool kvm_event_expand(struct kvm_event *event, int vcpu_id)
>         return true;
>  }
>
> +static void *kvm_he_zalloc(size_t size)
> +{
> +       struct kvm_event *kvm_ev;
> +
> +       kvm_ev = zalloc(size + sizeof(*kvm_ev));
> +       if (!kvm_ev)
> +               return NULL;
> +
> +       return &kvm_ev->he;
> +}
> +
> +static void kvm_he_free(void *he)
> +{
> +       struct kvm_event *kvm_ev;
> +
> +       kvm_ev = container_of(he, struct kvm_event, he);
> +       free(kvm_ev);
> +}
> +
> +static struct hist_entry_ops kvm_ev_entry_ops = {
> +       .new    = kvm_he_zalloc,
> +       .free   = kvm_he_free,
> +};
> +
>  static struct kvm_event *kvm_alloc_init_event(struct perf_kvm_stat *kvm,
>                                               struct event_key *key,
> -                                             struct perf_sample *sample __maybe_unused)
> +                                             struct perf_sample *sample)
>  {
>         struct kvm_event *event;
> +       struct hist_entry *he;
>
> -       event = zalloc(sizeof(*event));
> -       if (!event) {
> -               pr_err("Not enough memory\n");
> +       he = hists__add_entry_ops(&kvm_hists.hists, &kvm_ev_entry_ops,
> +                                 &kvm->al, NULL, NULL, NULL, sample, true);
> +       if (he == NULL) {
> +               pr_err("Failed to allocate hist entry\n");
>                 return NULL;
>         }
>
> +       hists__inc_nr_samples(&kvm_hists.hists, 0);
> +
> +       event = container_of(he, struct kvm_event, he);
>         event->perf_kvm = kvm;
>         event->key = *key;
>         init_stats(&event->total.stats);
> +
>         return event;
>  }
>
> @@ -507,22 +530,26 @@ static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
>                                                struct perf_sample *sample)
>  {
>         struct kvm_event *event;
> -       struct list_head *head;
> +       struct rb_root_cached *root;
> +       struct rb_node *nd;
>
>         BUG_ON(key->key == INVALID_KEY);
>
> -       head = &kvm->kvm_events_cache[kvm_events_hash_fn(key->key)];
> -       list_for_each_entry(event, head, hash_entry) {
> +       if (hists__has(&kvm_hists.hists, need_collapse))
> +               root = &kvm_hists.hists.entries_collapsed;
> +       else
> +               root = kvm_hists.hists.entries_in;
> +
> +       for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
> +               struct hist_entry *he = rb_entry(nd, struct hist_entry,
> +                                                rb_node_in);
> +
> +               event = container_of(he, struct kvm_event, he);
>                 if (event->key.key == key->key && event->key.info == key->info)
>                         return event;

This seems inefficient and even unnecessary.  You should find
the event based on the return value of hist_entry__cmp() from
the root and go down.

But I think that's what hists__add_entry_ops() does.  Maybe
you may need to move the init logic (like init_stats) to the
kvm_he_zalloc().

Thanks,
Namhyung


>         }
>
> -       event = kvm_alloc_init_event(kvm, key, sample);
> -       if (!event)
> -               return NULL;
> -
> -       list_add(&event->hash_entry, head);
> -       return event;
> +       return kvm_alloc_init_event(kvm, key, sample);
>  }
