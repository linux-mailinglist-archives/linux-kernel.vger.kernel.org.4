Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD8737658
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjFTVBI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjFTVBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:01:05 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45846172C;
        Tue, 20 Jun 2023 14:01:02 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-77e2c42de06so166879939f.1;
        Tue, 20 Jun 2023 14:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687294861; x=1689886861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WYJca1eb5VzLBWJJ/VK8wEJMLKXyBkl732zQR+WNbY=;
        b=JDiBGLBWrGYnivVED+F213eCgOqVF+2TbW+Ur49Xf+vF5tdY40UyeO2UkEl8gSyGIR
         QUX93q1D0j2m/qs1IDH1LhqcUsPvT+BAukDXjG49hvIVw4HzZvcLNKMAUYJdcFgb+Isn
         +vdO1qWTqVK8uEd67b1IpVPN1gd1CzvcStiZaStIfjORP+2XgobX/ilz9c4RtK84NtgE
         qrKUucV/QvhMNce8DvpCGinl4qfwaHZPTt0jyUxFLq9A4frNkqL3MkWNeR1UUhLZhNb+
         8fi8hijxiCI/tYjiSIAwAkN9Q2Da9vGVOKd9Vvz4DJ8IFMoNgK3jbJqzfWoaR4VxpAg4
         7BDw==
X-Gm-Message-State: AC+VfDx1ICs0zJvjY1RBweAGRibBOoQdpQRELkuOhP7yUZbQpn+RLjJT
        ifH0OmKWaERwygDx4xU/ABVMLm6o3M8DQJB233A=
X-Google-Smtp-Source: ACHHUZ6X9waeOYS918TExb+qsYqXVlh4yWai9asgNusCQm8wl3cT7vaFZvTNyVpBfi0svDnhgiV9UQTESJyBviorEYw=
X-Received: by 2002:a5e:a704:0:b0:77e:2309:7b9c with SMTP id
 b4-20020a5ea704000000b0077e23097b9cmr11616031iod.5.1687294861183; Tue, 20 Jun
 2023 14:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230615200843.2459645-1-irogers@google.com>
In-Reply-To: <20230615200843.2459645-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 14:00:49 -0700
Message-ID: <CAM9d7cg2RbasQLHVzhBjJbpLnx7Sf79PQQuNTdWRuH+mbp9Y5A@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol: Remove symbol_name_rb_node
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Wang <wangborong@cdjrlc.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, Jun 15, 2023 at 1:08 PM Ian Rogers <irogers@google.com> wrote:
>
> Most perf commands want to sort symbols by name and this is done via
> an invasive rbtree that on 64-bit systems costs 24 bytes. Sorting the
> symbols in a DSO by name is optional and not done by default, however,
> if sorting is requested the 24 bytes is allocated for every
> symbol.
>
> This change removes the rbtree and uses a sorted array of symbol
> pointers instead (costing 8 bytes per symbol). As the array is created
> on demand then there are further memory savings. The complexity of
> sorting the array and using the rbtree are the same.

Nice, I like the savings and lazy allocation.

>
> To support going to the next symbol, the index of the current symbol
> needs to be passed around as a pair with the current symbol. This
> requires some API changes.

But I'm not sure if we need the index for the normal use cases.
IIUC only one place to require it: map__for_each_symbol_by_name.
Maybe we can have a separate API for it?

In general, I'd like to split the commit to have on-demand part and
array changes separately.

Thanks,
Namhyung


>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-kallsyms.c    |   1 -
>  tools/perf/builtin-lock.c        |   2 -
>  tools/perf/builtin-report.c      |   1 -
>  tools/perf/tests/builtin-test.c  |   1 -
>  tools/perf/tests/dlfilter-test.c |   4 +-
>  tools/perf/ui/browsers/map.c     |   2 +-
>  tools/perf/util/dso.c            |   7 +-
>  tools/perf/util/dso.h            |   3 +-
>  tools/perf/util/map.c            |   7 +-
>  tools/perf/util/map.h            |  13 +--
>  tools/perf/util/maps.c           |   2 +-
>  tools/perf/util/probe-event.c    |  16 ++--
>  tools/perf/util/symbol.c         | 131 ++++++++++++++++---------------
>  tools/perf/util/symbol.h         |  12 +--
>  tools/perf/util/symbol_conf.h    |   1 -
>  tools/perf/util/symbol_fprintf.c |  10 +--
>  16 files changed, 103 insertions(+), 110 deletions(-)
>
> diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
> index 3751df744577..7f75c5b73f26 100644
> --- a/tools/perf/builtin-kallsyms.c
> +++ b/tools/perf/builtin-kallsyms.c
> @@ -62,7 +62,6 @@ int cmd_kallsyms(int argc, const char **argv)
>         if (argc < 1)
>                 usage_with_options(kallsyms_usage, options);
>
> -       symbol_conf.sort_by_name = true;
>         symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
>         if (symbol__init(NULL) < 0)
>                 return -1;
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 8b505e1e5002..da36ace66d68 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1774,7 +1774,6 @@ static int __cmd_report(bool display_info)
>         }
>
>         /* for lock function check */
> -       symbol_conf.sort_by_name = true;
>         symbol_conf.allow_aliases = true;
>         symbol__init(&session->header.env);
>
> @@ -1904,7 +1903,6 @@ static int __cmd_contention(int argc, const char **argv)
>                 con.save_callstack = true;
>
>         /* for lock function check */
> -       symbol_conf.sort_by_name = true;
>         symbol_conf.allow_aliases = true;
>         symbol__init(&session->header.env);
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index a31a23af5547..dcedfe00f04d 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1676,7 +1676,6 @@ int cmd_report(int argc, const char **argv)
>                          * See symbol__browser_index.
>                          */
>                         symbol_conf.priv_size += sizeof(u32);
> -                       symbol_conf.sort_by_name = true;
>                 }
>                 annotation_config__init(&report.annotation_opts);
>         }
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index aa44fdc84763..1f6557ce3b0a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -542,7 +542,6 @@ int cmd_test(int argc, const char **argv)
>                 return run_workload(workload, argc, argv);
>
>         symbol_conf.priv_size = sizeof(int);
> -       symbol_conf.sort_by_name = true;
>         symbol_conf.try_vmlinux_path = true;
>
>         if (symbol__init(NULL) < 0)
> diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
> index 086fd2179e41..5265b5185217 100644
> --- a/tools/perf/tests/dlfilter-test.c
> +++ b/tools/perf/tests/dlfilter-test.c
> @@ -265,11 +265,11 @@ static int get_ip_addr(struct test_data *td)
>         if (!map)
>                 return -1;
>
> -       sym = map__find_symbol_by_name(map, "foo");
> +       sym = map__find_symbol_by_name(map, "foo", /*idx=*/NULL);
>         if (sym)
>                 td->foo = sym->start;
>
> -       sym = map__find_symbol_by_name(map, "bar");
> +       sym = map__find_symbol_by_name(map, "bar", /*idx=*/NULL);
>         if (sym)
>                 td->bar = sym->start;
>
> diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
> index 3d1b958d8832..2211e0638e89 100644
> --- a/tools/perf/ui/browsers/map.c
> +++ b/tools/perf/ui/browsers/map.c
> @@ -59,7 +59,7 @@ static int map_browser__search(struct map_browser *browser)
>                 u64 addr = strtoull(target, NULL, 16);
>                 sym = map__find_symbol(browser->map, addr);
>         } else
> -               sym = map__find_symbol_by_name(browser->map, target);
> +               sym = map__find_symbol_by_name(browser->map, target, NULL);
>
>         if (sym != NULL) {
>                 u32 *idx = symbol__browser_index(sym);
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 046fbfcfdaab..bdfead36b83a 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1320,7 +1320,9 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
>                         dso->id = *id;
>                 dso__set_long_name_id(dso, dso->name, id, false);
>                 dso__set_short_name(dso, dso->name, false);
> -               dso->symbols = dso->symbol_names = RB_ROOT_CACHED;
> +               dso->symbols = RB_ROOT_CACHED;
> +               dso->symbol_names = NULL;
> +               dso->symbol_names_len = 0;
>                 dso->data.cache = RB_ROOT;
>                 dso->inlined_nodes = RB_ROOT_CACHED;
>                 dso->srclines = RB_ROOT_CACHED;
> @@ -1364,7 +1366,8 @@ void dso__delete(struct dso *dso)
>         inlines__tree_delete(&dso->inlined_nodes);
>         srcline__tree_delete(&dso->srclines);
>         symbols__delete(&dso->symbols);
> -
> +       dso->symbol_names_len = 0;
> +       zfree(&dso->symbol_names);
>         if (dso->short_name_allocated) {
>                 zfree((char **)&dso->short_name);
>                 dso->short_name_allocated = false;
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index b23a157c914d..b41c9782c754 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -150,7 +150,8 @@ struct dso {
>         struct rb_node   rb_node;       /* rbtree node sorted by long name */
>         struct rb_root   *root;         /* root of rbtree that rb_node is in */
>         struct rb_root_cached symbols;
> -       struct rb_root_cached symbol_names;
> +       struct symbol    **symbol_names;
> +       size_t           symbol_names_len;
>         struct rb_root_cached inlined_nodes;
>         struct rb_root_cached srclines;
>         struct {
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index f30d34903aa4..2db4fa186e3b 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -390,7 +390,7 @@ struct symbol *map__find_symbol(struct map *map, u64 addr)
>         return dso__find_symbol(map__dso(map), addr);
>  }
>
> -struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
> +struct symbol *map__find_symbol_by_name(struct map *map, const char *name, size_t *idx)
>  {
>         struct dso *dso;
>
> @@ -398,10 +398,9 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
>                 return NULL;
>
>         dso = map__dso(map);
> -       if (!dso__sorted_by_name(dso))
> -               dso__sort_by_name(dso);
> +       dso__sort_by_name(dso);
>
> -       return dso__find_symbol_by_name(dso, name);
> +       return dso__find_symbol_by_name(dso, name, idx);
>  }
>
>  struct map *map__clone(struct map *from)
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 66a87b3d9965..70ab3297bebf 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -148,16 +148,17 @@ struct thread;
>   * @map: the 'struct map *' in which symbols are iterated
>   * @sym_name: the symbol name
>   * @pos: the 'struct symbol *' to use as a loop cursor
> + * @idx: the cursor index in the symbol names array
>   */
> -#define __map__for_each_symbol_by_name(map, sym_name, pos)     \
> -       for (pos = map__find_symbol_by_name(map, sym_name);     \
> +#define __map__for_each_symbol_by_name(map, sym_name, pos, idx)                \
> +       for (pos = map__find_symbol_by_name(map, sym_name, &idx);       \
>              pos &&                                             \
>              !symbol__match_symbol_name(pos->name, sym_name,    \
>                                         SYMBOL_TAG_INCLUDE__DEFAULT_ONLY); \
> -            pos = symbol__next_by_name(pos))
> +            pos = dso__next_symbol_by_name(map__dso(map), &idx))
>
> -#define map__for_each_symbol_by_name(map, sym_name, pos)               \
> -       __map__for_each_symbol_by_name(map, sym_name, (pos))
> +#define map__for_each_symbol_by_name(map, sym_name, pos, idx)  \
> +       __map__for_each_symbol_by_name(map, sym_name, (pos), idx)
>
>  void map__init(struct map *map,
>                u64 start, u64 end, u64 pgoff, struct dso *dso);
> @@ -201,7 +202,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
>
>  int map__load(struct map *map);
>  struct symbol *map__find_symbol(struct map *map, u64 addr);
> -struct symbol *map__find_symbol_by_name(struct map *map, const char *name);
> +struct symbol *map__find_symbol_by_name(struct map *map, const char *name, size_t *idx);
>  void map__fixup_start(struct map *map);
>  void map__fixup_end(struct map *map);
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 233438c95b53..4ba474b3b94c 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -218,7 +218,7 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
>         down_read(maps__lock(maps));
>
>         maps__for_each_entry(maps, pos) {
> -               sym = map__find_symbol_by_name(pos->map, name);
> +               sym = map__find_symbol_by_name(pos->map, name, NULL);
>
>                 if (sym == NULL)
>                         continue;
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 6e2110d605fb..16822a8a540f 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -74,7 +74,6 @@ int init_probe_symbol_maps(bool user_only)
>  {
>         int ret;
>
> -       symbol_conf.sort_by_name = true;
>         symbol_conf.allow_aliases = true;
>         ret = symbol__init(NULL);
>         if (ret < 0) {
> @@ -382,6 +381,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
>         struct symbol *sym;
>         u64 address = 0;
>         int ret = -ENOENT;
> +       size_t idx;
>
>         /* This can work only for function-name based one */
>         if (!pp->function || pp->file)
> @@ -392,7 +392,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
>                 return -EINVAL;
>
>         /* Find the address of given function */
> -       map__for_each_symbol_by_name(map, pp->function, sym) {
> +       map__for_each_symbol_by_name(map, pp->function, sym, idx) {
>                 if (uprobes) {
>                         address = sym->start;
>                         if (sym->type == STT_GNU_IFUNC)
> @@ -3738,7 +3738,6 @@ int del_perf_probe_events(struct strfilter *filter)
>  int show_available_funcs(const char *target, struct nsinfo *nsi,
>                          struct strfilter *_filter, bool user)
>  {
> -        struct rb_node *nd;
>         struct map *map;
>         struct dso *dso;
>         int ret;
> @@ -3767,17 +3766,16 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
>                 goto end;
>         }
>         dso = map__dso(map);
> -       if (!dso__sorted_by_name(dso))
> -               dso__sort_by_name(dso);
> +       dso__sort_by_name(dso);
>
>         /* Show all (filtered) symbols */
>         setup_pager();
>
> -       for (nd = rb_first_cached(&dso->symbol_names); nd; nd = rb_next(nd)) {
> -               struct symbol_name_rb_node *pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
> +       for (size_t i = 0; i < dso->symbol_names_len; i++) {
> +               struct symbol *pos = dso->symbol_names[i];
>
> -               if (strfilter__compare(_filter, pos->sym.name))
> -                       printf("%s\n", pos->sym.name);
> +               if (strfilter__compare(_filter, pos->name))
> +                       printf("%s\n", pos->name);
>         }
>  end:
>         map__put(map);
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index d275d3bef7d5..04bf77519179 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -440,38 +440,34 @@ static struct symbol *symbols__next(struct symbol *sym)
>         return NULL;
>  }
>
> -static void symbols__insert_by_name(struct rb_root_cached *symbols, struct symbol *sym)
> +static int symbols__sort_name_cmp(const void *vlhs, const void *vrhs)
>  {
> -       struct rb_node **p = &symbols->rb_root.rb_node;
> -       struct rb_node *parent = NULL;
> -       struct symbol_name_rb_node *symn, *s;
> -       bool leftmost = true;
> +       const struct symbol *lhs = *((const struct symbol **)vlhs);
> +       const struct symbol *rhs = *((const struct symbol **)vrhs);
>
> -       symn = container_of(sym, struct symbol_name_rb_node, sym);
> -
> -       while (*p != NULL) {
> -               parent = *p;
> -               s = rb_entry(parent, struct symbol_name_rb_node, rb_node);
> -               if (strcmp(sym->name, s->sym.name) < 0)
> -                       p = &(*p)->rb_left;
> -               else {
> -                       p = &(*p)->rb_right;
> -                       leftmost = false;
> -               }
> -       }
> -       rb_link_node(&symn->rb_node, parent, p);
> -       rb_insert_color_cached(&symn->rb_node, symbols, leftmost);
> +       return strcmp(lhs->name, rhs->name);
>  }
>
> -static void symbols__sort_by_name(struct rb_root_cached *symbols,
> -                                 struct rb_root_cached *source)
> +static struct symbol **symbols__sort_by_name(struct rb_root_cached *source, size_t *len)
>  {
> -       struct rb_node *nd;
> +       struct symbol **result;
> +       size_t i = 0, size = 0;
> +
> +       for (struct rb_node *nd = rb_first_cached(source); nd; nd = rb_next(nd))
> +               size++;
> +
> +       result = malloc(sizeof(*result) * size);
> +       if (!result)
> +               return NULL;
>
> -       for (nd = rb_first_cached(source); nd; nd = rb_next(nd)) {
> +       for (struct rb_node *nd = rb_first_cached(source); nd; nd = rb_next(nd)) {
>                 struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
> -               symbols__insert_by_name(symbols, pos);
> +
> +               result[i++] = pos;
>         }
> +       qsort(result, size, sizeof(*result), symbols__sort_name_cmp);
> +       *len = size;
> +       return result;
>  }
>
>  int symbol__match_symbol_name(const char *name, const char *str,
> @@ -491,48 +487,51 @@ int symbol__match_symbol_name(const char *name, const char *str,
>                 return arch__compare_symbol_names(name, str);
>  }
>
> -static struct symbol *symbols__find_by_name(struct rb_root_cached *symbols,
> +static struct symbol *symbols__find_by_name(struct symbol *symbols[],
> +                                           size_t symbols_len,
>                                             const char *name,
> -                                           enum symbol_tag_include includes)
> +                                           enum symbol_tag_include includes,
> +                                           size_t *found_idx)
>  {
> -       struct rb_node *n;
> -       struct symbol_name_rb_node *s = NULL;
> +       size_t i, lower = 0, upper = symbols_len;
> +       struct symbol *s;
>
> -       if (symbols == NULL)
> +       if (!symbols_len)
>                 return NULL;
>
> -       n = symbols->rb_root.rb_node;
> -
> -       while (n) {
> +       while (lower < upper) {
>                 int cmp;
>
> -               s = rb_entry(n, struct symbol_name_rb_node, rb_node);
> -               cmp = symbol__match_symbol_name(s->sym.name, name, includes);
> +               i = (lower + upper) / 2;
> +               s = symbols[i];
> +               cmp = symbol__match_symbol_name(s->name, name, includes);
>
>                 if (cmp > 0)
> -                       n = n->rb_left;
> +                       upper = i;
>                 else if (cmp < 0)
> -                       n = n->rb_right;
> -               else
> +                       lower = i + 1;
> +               else {
> +                       if (found_idx)
> +                               *found_idx = i;
>                         break;
> +               }
>         }
> -
> -       if (n == NULL)
> -               return NULL;
> -
> -       if (includes != SYMBOL_TAG_INCLUDE__DEFAULT_ONLY)
> +       if (includes != SYMBOL_TAG_INCLUDE__DEFAULT_ONLY) {
>                 /* return first symbol that has same name (if any) */
> -               for (n = rb_prev(n); n; n = rb_prev(n)) {
> -                       struct symbol_name_rb_node *tmp;
> +               for (; i > 0; i--) {
> +                       struct symbol *tmp = symbols[i - 1];
>
> -                       tmp = rb_entry(n, struct symbol_name_rb_node, rb_node);
> -                       if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
> +                       if (!arch__compare_symbol_names(tmp->name, s->name)) {
> +                               if (found_idx)
> +                                       *found_idx = i - 1;
> +                       } else
>                                 break;
>
>                         s = tmp;
>                 }
> -
> -       return &s->sym;
> +       }
> +       assert(!found_idx || s == symbols[*found_idx]);
> +       return s;
>  }
>
>  void dso__reset_find_symbol_cache(struct dso *dso)
> @@ -590,31 +589,41 @@ struct symbol *dso__next_symbol(struct symbol *sym)
>         return symbols__next(sym);
>  }
>
> -struct symbol *symbol__next_by_name(struct symbol *sym)
> +struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
>  {
> -       struct symbol_name_rb_node *s = container_of(sym, struct symbol_name_rb_node, sym);
> -       struct rb_node *n = rb_next(&s->rb_node);
> +       if (*idx + 1 >= dso->symbol_names_len)
> +               return NULL;
>
> -       return n ? &rb_entry(n, struct symbol_name_rb_node, rb_node)->sym : NULL;
> +       ++*idx;
> +       return dso->symbol_names[*idx];
>  }
>
>   /*
>    * Returns first symbol that matched with @name.
>    */
> -struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name)
> +struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx)
>  {
> -       struct symbol *s = symbols__find_by_name(&dso->symbol_names, name,
> -                                                SYMBOL_TAG_INCLUDE__NONE);
> +       struct symbol *s = symbols__find_by_name(dso->symbol_names, dso->symbol_names_len,
> +                                               name, SYMBOL_TAG_INCLUDE__NONE, idx);
>         if (!s)
> -               s = symbols__find_by_name(&dso->symbol_names, name,
> -                                         SYMBOL_TAG_INCLUDE__DEFAULT_ONLY);
> +               s = symbols__find_by_name(dso->symbol_names, dso->symbol_names_len,
> +                                       name, SYMBOL_TAG_INCLUDE__DEFAULT_ONLY, idx);
>         return s;
>  }
>
>  void dso__sort_by_name(struct dso *dso)
>  {
> -       dso__set_sorted_by_name(dso);
> -       return symbols__sort_by_name(&dso->symbol_names, &dso->symbols);
> +       mutex_lock(&dso->lock);
> +       if (!dso__sorted_by_name(dso)) {
> +               size_t len;
> +
> +               dso->symbol_names = symbols__sort_by_name(&dso->symbols, &len);
> +               if (dso->symbol_names) {
> +                       dso->symbol_names_len = len;
> +                       dso__set_sorted_by_name(dso);
> +               }
> +       }
> +       mutex_unlock(&dso->lock);
>  }
>
>  /*
> @@ -2656,10 +2665,6 @@ int symbol__init(struct perf_env *env)
>
>         symbol__elf_init();
>
> -       if (symbol_conf.sort_by_name)
> -               symbol_conf.priv_size += (sizeof(struct symbol_name_rb_node) -
> -                                         sizeof(struct symbol));
> -
>         if (symbol_conf.try_vmlinux_path && vmlinux_path__init(env) < 0)
>                 return -1;
>
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 5ca8665dd2c1..af87c46b3f89 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -43,8 +43,7 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>
>  /**
>   * A symtab entry. When allocated this may be preceded by an annotation (see
> - * symbol__annotation), a browser_index (see symbol__browser_index) and rb_node
> - * to sort by name (see struct symbol_name_rb_node).
> + * symbol__annotation) and/or a browser_index (see symbol__browser_index).
>   */
>  struct symbol {
>         struct rb_node  rb_node;
> @@ -95,11 +94,6 @@ static inline size_t symbol__size(const struct symbol *sym)
>  struct strlist;
>  struct intlist;
>
> -struct symbol_name_rb_node {
> -       struct rb_node  rb_node;
> -       struct symbol   sym;
> -};
> -
>  static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
>  {
>         return path__join(bf, size, symbol_conf.symfs, path);
> @@ -136,9 +130,9 @@ void dso__delete_symbol(struct dso *dso,
>
>  struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
>  struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
> -struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name);
>
> -struct symbol *symbol__next_by_name(struct symbol *sym);
> +struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx);
> +struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx);
>
>  struct symbol *dso__first_symbol(struct dso *dso);
>  struct symbol *dso__last_symbol(struct dso *dso);
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index f26f81eb8252..0b589570d1d0 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -18,7 +18,6 @@ struct symbol_conf {
>                         show_kernel_path,
>                         use_modules,
>                         allow_aliases,
> -                       sort_by_name,
>                         show_nr_samples,
>                         show_total_period,
>                         use_callchain,
> diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
> index d9e5ad040b6a..088f4abf230f 100644
> --- a/tools/perf/util/symbol_fprintf.c
> +++ b/tools/perf/util/symbol_fprintf.c
> @@ -63,13 +63,11 @@ size_t dso__fprintf_symbols_by_name(struct dso *dso,
>                                     FILE *fp)
>  {
>         size_t ret = 0;
> -       struct rb_node *nd;
> -       struct symbol_name_rb_node *pos;
>
> -       for (nd = rb_first_cached(&dso->symbol_names); nd; nd = rb_next(nd)) {
> -               pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
> -               ret += fprintf(fp, "%s\n", pos->sym.name);
> -       }
> +       for (size_t i = 0; i < dso->symbol_names_len; i++) {
> +               struct symbol *pos = dso->symbol_names[i];
>
> +               ret += fprintf(fp, "%s\n", pos->name);
> +       }
>         return ret;
>  }
> --
> 2.41.0.162.gfafddb0af9-goog
>
