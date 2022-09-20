Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E25BE799
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiITNvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiITNvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:51:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78243C8C2;
        Tue, 20 Sep 2022 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663681882; x=1695217882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QgwIHoXybvmVSGl2JEjPwELkQGe2gdvnwkl/24eQF+g=;
  b=dnokYIVXD3b8jPC+I2aC3rysLeEBIa3KwWmqZUuqTjCiy34KRgokNh+0
   3eNgaG6nOTKKsW2R81QxzFXG7xD2t71/Jp2DZpIc8WFFZgzSubAc2e71n
   fPkASiQLal+OTkLyXucF9KIRB3KDsuzlPwIJ6js9BE578YEhw1NI+yZ+C
   aw04mJtqfRuIvxUCgBVSrMi5wodxkM/1XUMv3K2LY8CjPvMjSZuJRLsQC
   KlD+JE3MS3lhlM/Bm+JY+eNY2IowH0ijouAgSu2FscNrzuWxE36cIZjT/
   qw32m9pxJ9U2B1X/tRJDQ07liwe8InPCNcfJUbNRWlGJstKjtxiKCpadC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="297292572"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="297292572"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 06:51:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="744540749"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.32])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 06:51:16 -0700
Message-ID: <bf8988d7-2fd7-fa5d-25ff-2b439f1c0649@intel.com>
Date:   Tue, 20 Sep 2022 16:51:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] perf tools: Move dsos functions to util/dsos.c
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220916175902.1155177-1-namhyung@kernel.org>
 <20220916175902.1155177-2-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220916175902.1155177-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/22 20:58, Namhyung Kim wrote:

Maybe say why the move.

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dsos.c    | 29 +++++++++++++++++++++++++++++
>  tools/perf/util/dsos.h    |  3 +++
>  tools/perf/util/machine.c | 29 -----------------------------
>  3 files changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 2bd23e4cf19e..90a800625110 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -12,6 +12,35 @@
>  #include <symbol.h> // filename__read_build_id
>  #include <unistd.h>
>  
> +void dsos__init(struct dsos *dsos)
> +{
> +	INIT_LIST_HEAD(&dsos->head);
> +	dsos->root = RB_ROOT;
> +	init_rwsem(&dsos->lock);
> +}
> +
> +static void dsos__purge(struct dsos *dsos)
> +{
> +	struct dso *pos, *n;
> +
> +	down_write(&dsos->lock);
> +
> +	list_for_each_entry_safe(pos, n, &dsos->head, node) {
> +		RB_CLEAR_NODE(&pos->rb_node);
> +		pos->root = NULL;
> +		list_del_init(&pos->node);
> +		dso__put(pos);
> +	}
> +
> +	up_write(&dsos->lock);
> +}
> +
> +void dsos__exit(struct dsos *dsos)
> +{
> +	dsos__purge(dsos);
> +	exit_rwsem(&dsos->lock);
> +}
> +
>  static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
>  {
>  	if (a->maj > b->maj) return -1;
> diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
> index 5dbec2bc6966..49f448f106f8 100644
> --- a/tools/perf/util/dsos.h
> +++ b/tools/perf/util/dsos.h
> @@ -21,6 +21,9 @@ struct dsos {
>  	struct rw_semaphore lock;
>  };
>  
> +void dsos__init(struct dsos *dsos);
> +void dsos__exit(struct dsos *dsos);
> +
>  void __dsos__add(struct dsos *dsos, struct dso *dso);
>  void dsos__add(struct dsos *dsos, struct dso *dso);
>  struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 2a16cae28407..4c5540f5c753 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -50,13 +50,6 @@ static struct dso *machine__kernel_dso(struct machine *machine)
>  	return machine->vmlinux_map->dso;
>  }
>  
> -static void dsos__init(struct dsos *dsos)
> -{
> -	INIT_LIST_HEAD(&dsos->head);
> -	dsos->root = RB_ROOT;
> -	init_rwsem(&dsos->lock);
> -}
> -
>  static void machine__threads_init(struct machine *machine)
>  {
>  	int i;
> @@ -181,28 +174,6 @@ struct machine *machine__new_kallsyms(void)
>  	return machine;
>  }
>  
> -static void dsos__purge(struct dsos *dsos)
> -{
> -	struct dso *pos, *n;
> -
> -	down_write(&dsos->lock);
> -
> -	list_for_each_entry_safe(pos, n, &dsos->head, node) {
> -		RB_CLEAR_NODE(&pos->rb_node);
> -		pos->root = NULL;
> -		list_del_init(&pos->node);
> -		dso__put(pos);
> -	}
> -
> -	up_write(&dsos->lock);
> -}
> -
> -static void dsos__exit(struct dsos *dsos)
> -{
> -	dsos__purge(dsos);
> -	exit_rwsem(&dsos->lock);
> -}
> -
>  void machine__delete_threads(struct machine *machine)
>  {
>  	struct rb_node *nd;

