Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85E3730C37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjFOAeo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 20:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFOAem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:34:42 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352BC2690;
        Wed, 14 Jun 2023 17:34:41 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-3f9e5c011cfso24223881cf.1;
        Wed, 14 Jun 2023 17:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686789280; x=1689381280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIPgl4LDsOUaAZ1cp5WBGvNgF28pOvHufeowonwOr60=;
        b=lVZRNVavlDQMqsKuNlXtHUNeEWqNTHlG7xGzfuaid4MxwlE/HKE6ZtDb9y4gmX6uok
         OQm7rN28BRGT7JxL5wl8f4GJ3HWwOD4nQUPw9XYpOnWcrcROA6S9KZCgwVlkggYx5XnH
         M3J+9avV284YIH5h/86mvbhWFWvsO1zrbUBfHW700uEUbFkFzd85Dak65tvyXmfOpkem
         WeKJk7OSo2qT0v2ixYrlDlmIX/q0FPvRFosqsoXElS+byl37lGQF5niKESbuJLetPQxY
         ZORpxl6LAcr79eZBxjDVSzAseLs4EyRaFuz6Cj/odg5UREjS08SCZfMzlen0AyBq0rs/
         wubQ==
X-Gm-Message-State: AC+VfDyuA/g6OjG/QeYpzgyD9pVcsmdSBvBjjcmFwiUVSXGpihdKg0PA
        veSacXBubWFI2oDDPjQLuBcHx0yTq11QAxKqRh8=
X-Google-Smtp-Source: ACHHUZ7KB8Z9OUvf2UC6Hlca5S8aErvyd5gScVqNArSZPnbf00sX3OsGTavLXjoj0qQ3QX0crlKYh+0ZwdmveVwBWsM=
X-Received: by 2002:a05:622a:4d:b0:3f6:af5f:29a6 with SMTP id
 y13-20020a05622a004d00b003f6af5f29a6mr4447482qtw.33.1686789280168; Wed, 14
 Jun 2023 17:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230611072751.637227-1-irogers@google.com> <20230611072751.637227-2-irogers@google.com>
In-Reply-To: <20230611072751.637227-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 14 Jun 2023 17:34:29 -0700
Message-ID: <CAM9d7ci5zL8NWMrJVq4FQ242LNx0cQoY3Z32B+yuO2HFu6R1gA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf annotation: Switch lock from a mutex to a sharded_mutex
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yuan Can <yuancan@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Sun, Jun 11, 2023 at 12:28 AM Ian Rogers <irogers@google.com> wrote:
>
> Remove the "struct mutex lock" variable from annotation that is
> allocated per symbol. This removes in the region of 40 bytes per
> symbol allocation. Use a sharded mutex where the number of shards is
> set to the number of CPUs. Assuming good hashing of the annotation
> (done based on the pointer), this means in order to contend there
> needs to be more threads than CPUs, which is not currently true in any
> perf command. Were contention an issue it is straightforward to
> increase the number of shards in the mutex.
>
> On my Debian/glibc based machine, this reduces the size of struct
> annotation from 136 bytes to 96 bytes, or nearly 30%.

That's quite a good improvement given the number of symbols
we can have in a report session!

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

[SNIP]
> @@ -1291,17 +1292,64 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
>         return ins__scnprintf(&dl->ins, bf, size, &dl->ops, max_ins_name);
>  }
>
> -void annotation__init(struct annotation *notes)
> +void annotation__exit(struct annotation *notes)
>  {
> -       mutex_init(&notes->lock);
> +       annotated_source__delete(notes->src);
>  }
>
> -void annotation__exit(struct annotation *notes)
> +static struct sharded_mutex *sharded_mutex;
> +
> +static void annotation__init_sharded_mutex(void)
>  {
> -       annotated_source__delete(notes->src);
> -       mutex_destroy(&notes->lock);
> +       /* As many mutexes as there are CPUs. */
> +       sharded_mutex = sharded_mutex__new(cpu__max_present_cpu().cpu);
> +}
> +
> +static size_t annotation__hash(const struct annotation *notes)
> +{
> +       return ((size_t)notes) >> 4;

But I'm afraid it might create more contention depending on the
malloc implementation.  If it always returns 128-byte (or 256)
aligned memory for this struct then it could always collide in the
slot 0 if the number of CPU is 8 or less, right?

Thanks,
Namhyung


>  }
>
> +static struct mutex *annotation__get_mutex(const struct annotation *notes)
> +{
> +       static pthread_once_t once = PTHREAD_ONCE_INIT;
> +
> +       pthread_once(&once, annotation__init_sharded_mutex);
> +       if (!sharded_mutex)
> +               return NULL;
> +
> +       return sharded_mutex__get_mutex(sharded_mutex, annotation__hash(notes));
> +}
> +
> +void annotation__lock(struct annotation *notes)
> +       NO_THREAD_SAFETY_ANALYSIS
> +{
> +       struct mutex *mutex = annotation__get_mutex(notes);
> +
> +       if (mutex)
> +               mutex_lock(mutex);
> +}
> +
> +void annotation__unlock(struct annotation *notes)
> +       NO_THREAD_SAFETY_ANALYSIS
> +{
> +       struct mutex *mutex = annotation__get_mutex(notes);
> +
> +       if (mutex)
> +               mutex_unlock(mutex);
> +}
> +
> +bool annotation__trylock(struct annotation *notes)
> +{
> +       struct mutex *mutex = annotation__get_mutex(notes);
> +
> +       if (!mutex)
> +               return false;
> +
> +       return mutex_trylock(mutex);
> +}
> +
> +
>  static void annotation_line__add(struct annotation_line *al, struct list_head *head)
>  {
>         list_add_tail(&al->node, head);
