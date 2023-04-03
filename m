Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C16D53FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjDCVuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjDCVuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E96410C6;
        Mon,  3 Apr 2023 14:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34F1E62CF7;
        Mon,  3 Apr 2023 21:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BF3C433D2;
        Mon,  3 Apr 2023 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680558613;
        bh=OSiOZaIDM3s8SRNRyS9uWT5KNGK2XwwUBGAiTL9ji90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppV3PPfeyFChi/GlMSiDKWwDXPmFjgr43VjD1mY7PF2LLSy8YlwwIfI00IZDNMMGS
         xJQ5LiRpKNERGS96AQ87s4MR6DR+U5xk5ZMzd8Ut6uGzrvxm++ps1eqmamX5W4bz2i
         uKOkiQajx7lF86kdMRw/gGdbEewOklTZgG39uMocTdBiDbM8HNqgiOOTePjIFbF+dp
         AXhQ9cMXp2inMNmosrIYwN1kf2WyVyY6S6KgJzAivv7esXzm6bN3Yq7J5xWxCKTa4q
         CpKllid610dc6Ct8ai3m+Hz6ZAyqrfK8hUhjsay4AYwJbDF6DEMZfIc1NZUyvZarey
         bKmHXaUnqaIbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CD35C4052D; Mon,  3 Apr 2023 18:50:10 -0300 (-03)
Date:   Mon, 3 Apr 2023 18:50:10 -0300
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
Subject: Re: [PATCH v2] perf jit: Fix a few memory leaks
Message-ID: <ZCtKEuFCPGvHX1FI@kernel.org>
References: <20230403203545.1872196-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403203545.1872196-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 03, 2023 at 01:35:45PM -0700, Ian Rogers escreveu:
> As reported by leak sanitizer.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/genelf_debug.c | 45 +++++++++++++++++++++-------------
>  tools/perf/util/jitdump.c      |  7 +++++-
>  2 files changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
> index dd40683bd4c0..8786c366566e 100644
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
> @@ -487,28 +493,28 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	Elf_Scn *scn;
>  	Elf_Shdr *shdr;
>  	struct buffer_ext dl, di, da;
> -	int ret;
> +	int ret = -1;
>  
>  	buffer_ext_init(&dl);
>  	buffer_ext_init(&di);
>  	buffer_ext_init(&da);
>  
> -	ret = jit_process_debug_info(code_addr, debug, nr_debug_entries, &dl, &da, &di);
> -	if (ret)
> -		return -1;
> +	if (jit_process_debug_info(code_addr, debug, nr_debug_entries, &dl, &da, &di))
> +		goto out;
> +
>  	/*
>  	 * setup .debug_line section
>  	 */
>  	scn = elf_newscn(e);
>  	if (!scn) {
>  		warnx("cannot create section");
> -		return -1;
> +		goto out;
>  	}
>  
>  	d = elf_newdata(scn);
>  	if (!d) {
>  		warnx("cannot get new data");
> -		return -1;
> +		goto out;
>  	}
>  
>  	d->d_align = 1;
> @@ -521,7 +527,7 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	shdr = elf_getshdr(scn);
>  	if (!shdr) {
>  		warnx("cannot get section header");
> -		return -1;
> +		goto out;
>  	}
>  
>  	shdr->sh_name = 52; /* .debug_line */
> @@ -536,13 +542,13 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	scn = elf_newscn(e);
>  	if (!scn) {
>  		warnx("cannot create section");
> -		return -1;
> +		goto out;
>  	}
>  
>  	d = elf_newdata(scn);
>  	if (!d) {
>  		warnx("cannot get new data");
> -		return -1;
> +		goto out;
>  	}
>  
>  	d->d_align = 1;
> @@ -555,7 +561,7 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	shdr = elf_getshdr(scn);
>  	if (!shdr) {
>  		warnx("cannot get section header");
> -		return -1;
> +		goto out;
>  	}
>  
>  	shdr->sh_name = 64; /* .debug_info */
> @@ -570,13 +576,13 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	scn = elf_newscn(e);
>  	if (!scn) {
>  		warnx("cannot create section");
> -		return -1;
> +		goto out;
>  	}
>  
>  	d = elf_newdata(scn);
>  	if (!d) {
>  		warnx("cannot get new data");
> -		return -1;
> +		goto out;
>  	}
>  
>  	d->d_align = 1;
> @@ -589,7 +595,7 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	shdr = elf_getshdr(scn);
>  	if (!shdr) {
>  		warnx("cannot get section header");
> -		return -1;
> +		goto out;
>  	}
>  
>  	shdr->sh_name = 76; /* .debug_info */
> @@ -601,9 +607,14 @@ jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries
>  	/*
>  	 * now we update the ELF image with all the sections
>  	 */
> -	if (elf_update(e, ELF_C_WRITE) < 0) {
> +	if (elf_update(e, ELF_C_WRITE) < 0)
>  		warnx("elf_update debug failed");
> -		return -1;
> -	}
> -	return 0;
> +	else
> +		ret = 0;
> +
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
