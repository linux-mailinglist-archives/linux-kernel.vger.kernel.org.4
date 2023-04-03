Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0506D5205
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjDCULy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7653410F2;
        Mon,  3 Apr 2023 13:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE83D629AE;
        Mon,  3 Apr 2023 20:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0666CC433EF;
        Mon,  3 Apr 2023 20:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680552710;
        bh=U38UF7+pRqPHpRIOZWZMKwQu3cGgQuKLd18QkaUH2MY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+3XXna3ykOvKXCh1Jm9Z+x4pxPZ5cNmUX2+fESQmUW/bRb/U05W6KUV3G9GtbOox
         GAcA2ShxwxwOL9WUTYYMkabxwrFZ6Q5+62Bwy6L7QWwMv6krCWXgTlhpHxmVSYTTPE
         8yWNA234dHQbwUcuKe/rHMKJPeBM/AlaN2VjqlUfhs0QHmQGc8qa/9zH+pl/Ux6qJP
         FnInkabUpUI3ncPrtDfiLPFyno5Nb77RxtTQIudurhJZqEnCnjY364FMtljh3F9h5h
         dA2xHafg6uRfYohmdQqgOPe9ICVa3S5N1NM2AY0oQuyDuDMOlR9r9G8q70UijxyWmi
         hgrx04ITNa0aw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A39374052D; Mon,  3 Apr 2023 17:11:47 -0300 (-03)
Date:   Mon, 3 Apr 2023 17:11:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        Yuan Can <yuancan@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf jit: Fix a few memory leaks
Message-ID: <ZCszA9FVNS5FIX1G@kernel.org>
References: <20230403185057.1844232-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403185057.1844232-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 03, 2023 at 11:50:57AM -0700, Ian Rogers escreveu:
> As reported by leak sanitizer.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/genelf_debug.c | 48 +++++++++++++++++++++++++---------
>  tools/perf/util/jitdump.c      |  7 ++++-
>  2 files changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
> index dd40683bd4c0..bdcd37c34b64 100644
> --- a/tools/perf/util/genelf_debug.c
> +++ b/tools/perf/util/genelf_debug.c
> @@ -87,6 +87,12 @@ buffer_ext_init(struct buffer_ext *be)
>  	be->max_sz = 0;
>  }
>  
> +static void
> +buffer_ext_exit(struct buffer_ext *be)
> +{
> +	free(be->data);
> +}
> +
>  static inline size_t
>  buffer_ext_size(struct buffer_ext *be)
>  {
> @@ -494,21 +500,26 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	buffer_ext_init(&da);
>  
>  	ret = jit_process_debug_info(code_addr, debug, nr_debug_entries, &dl, &da, &di);

Can we instead have:

	int ret = -1;
	if (jit_process_debug_info(code_addr, debug, nr_debug_entries, &dl, &da, &di))
		goto out;

And then remove all these ret = -1;

And...


> -	if (ret)
> -		return -1;
> +	if (ret) {
> +		ret = -1;
> +		goto out;
> +	}
> +
>  	/*
>  	 * setup .debug_line section
>  	 */
>  	scn = elf_newscn(e);
>  	if (!scn) {
>  		warnx("cannot create section");
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
>  
>  	d = elf_newdata(scn);
>  	if (!d) {
>  		warnx("cannot get new data");
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
>  
>  	d->d_align = 1;
> @@ -521,7 +532,8 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	shdr = elf_getshdr(scn);
>  	if (!shdr) {
>  		warnx("cannot get section header");
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
>  
>  	shdr->sh_name = 52; /* .debug_line */
> @@ -536,13 +548,15 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	scn = elf_newscn(e);
>  	if (!scn) {
>  		warnx("cannot create section");
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
>  
>  	d = elf_newdata(scn);
>  	if (!d) {
>  		warnx("cannot get new data");
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
>  
>  	d->d_align = 1;
> @@ -555,7 +569,8 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	shdr = elf_getshdr(scn);
>  	if (!shdr) {
>  		warnx("cannot get section header");
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
>  
>  	shdr->sh_name = 64; /* .debug_info */
> @@ -570,13 +585,15 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	scn = elf_newscn(e);
>  	if (!scn) {
>  		warnx("cannot create section");
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
>  
>  	d = elf_newdata(scn);
>  	if (!d) {
>  		warnx("cannot get new data");
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
>  
>  	d->d_align = 1;
> @@ -589,7 +606,8 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	shdr = elf_getshdr(scn);
>  	if (!shdr) {
>  		warnx("cannot get section header");
> -		return -1;
> +		ret = -1;
> +		goto out;
>  	}
>  
>  	shdr->sh_name = 76; /* .debug_info */
> @@ -603,7 +621,11 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	 */
>  	if (elf_update(e, ELF_C_WRITE) < 0) {
>  		warnx("elf_update debug failed");
> -		return -1;
> +		ret = -1;
>  	}
> -	return 0;

.. just add:
	ret = 0;

here?

> +out:
> +	buffer_ext_exit(&dl);
> +	buffer_ext_exit(&di);
> +	buffer_ext_exit(&da);
> +	return ret;
>  }
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 0e033278fa12..28e49502db5e 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -235,9 +235,11 @@ jit_open(struct jit_buf_desc *jd, const char *name)
>  	 */
>  	strcpy(jd->dir, name);
>  	dirname(jd->dir);
> +	free(buf);
>  
>  	return 0;
>  error:
> +	free(buf);
>  	funlockfile(jd->in);
>  	fclose(jd->in);
>  	return retval;
> @@ -523,7 +525,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
>  
>  	ret = perf_event__process_mmap2(tool, event, &sample, jd->machine);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	ret = jit_inject_event(jd, event);
>  	/*
> @@ -532,6 +534,8 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
>  	if (!ret)
>  		build_id__mark_dso_hit(tool, event, &sample, NULL, jd->machine);
>  
> +out:
> +	free(event);
>  	return ret;
>  }
>  
> @@ -874,6 +878,7 @@ jit_process(struct perf_session *session,
>  	}
>  
>  	nsinfo__put(jd.nsi);
> +	free(jd.buf);
>  
>  	return ret;
>  }
> -- 
> 2.40.0.348.gf938b09366-goog
> 

-- 

- Arnaldo
