Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDE7069A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjEQNVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjEQNU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:20:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACB7869E;
        Wed, 17 May 2023 06:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00C216435E;
        Wed, 17 May 2023 13:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F39DC433D2;
        Wed, 17 May 2023 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329632;
        bh=aQiWW7Sdsr+o2DyA54VNt+Odfm3FpPnC88Wf65skaZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+AjWg1OFx8McK4RKaRFz80zDw6/g1xWwgV18zOG44681onmz1DDMqpM8xd2mAIFq
         hchboMYNKBO7kYVrWNwPGDacrdIIkUalcYd2Jxp72OAP5mlugBVqhq5pDdJI8qA4Tp
         cjCPN6sNrMmHQeWECLilh3y9Wx5IyePPlQAdSfrH7zhoPXe+edMKpyZgWxjqcxP1lY
         q8tV56vyRDMfBarc7d01EQrk85WEDLcrqg4W/KZvqN+cmkDbB9VLtyb3FpCnLJPgu0
         IN3Mlt3t8jmg2mk+qmay/V+MoYZo5jgbMcnFknuKCBCUEDcfdZyrGY5Rg6QtT8dMCw
         w+s5rHpKLJ4xw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C46B3403B5; Wed, 17 May 2023 10:20:29 -0300 (-03)
Date:   Wed, 17 May 2023 10:20:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] perf pmu: Replace all non-returning strlcpy with strscpy
Message-ID: <ZGTUnU6t+1XWCcFG@kernel.org>
References: <20230516000500.3884588-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516000500.3884588-1-azeemshaikh38@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 16, 2023 at 12:05:00AM +0000, Azeem Shaikh escreveu:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.

Peter, I'll try and process the tools/ part, to check if this builds
with all the test containers I have.

- Arnaldo
 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  kernel/events/core.c                                |    6 +++---
>  tools/perf/arch/x86/util/event.c                    |    2 +-
>  tools/perf/arch/x86/util/machine.c                  |    2 +-
>  tools/perf/builtin-buildid-cache.c                  |    6 +++---
>  tools/perf/builtin-daemon.c                         |    4 ++--
>  tools/perf/jvmti/libjvmti.c                         |    2 +-
>  tools/perf/tests/dlfilter-test.c                    |    2 +-
>  tools/perf/tests/symbols.c                          |    2 +-
>  tools/perf/ui/tui/helpline.c                        |    2 +-
>  tools/perf/util/annotate.c                          |    4 ++--
>  tools/perf/util/auxtrace.c                          |    2 +-
>  tools/perf/util/dso.c                               |    2 +-
>  tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |    2 +-
>  tools/perf/util/llvm-utils.c                        |    4 ++--
>  tools/perf/util/machine.c                           |    8 ++++----
>  tools/perf/util/pmu-hybrid.c                        |    2 +-
>  tools/perf/util/pmu.c                               |    2 +-
>  tools/perf/util/probe-file.c                        |    2 +-
>  tools/perf/util/svghelper.c                         |    2 +-
>  tools/perf/util/symbol.c                            |    4 ++--
>  tools/perf/util/synthetic-events.c                  |    4 ++--
>  21 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index db016e418931..6039fdf00b3c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8245,7 +8245,7 @@ static void perf_event_comm_event(struct perf_comm_event *comm_event)
>  	unsigned int size;
>  
>  	memset(comm, 0, sizeof(comm));
> -	strlcpy(comm, comm_event->task->comm, sizeof(comm));
> +	strscpy(comm, comm_event->task->comm, sizeof(comm));
>  	size = ALIGN(strlen(comm)+1, sizeof(u64));
>  
>  	comm_event->comm = comm;
> @@ -8700,7 +8700,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
>  	}
>  
>  cpy_name:
> -	strlcpy(tmp, name, sizeof(tmp));
> +	strscpy(tmp, name, sizeof(tmp));
>  	name = tmp;
>  got_name:
>  	/*
> @@ -9124,7 +9124,7 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
>  	    ksym_type == PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
>  		goto err;
>  
> -	strlcpy(name, sym, KSYM_NAME_LEN);
> +	strscpy(name, sym, KSYM_NAME_LEN);
>  	name_len = strlen(name) + 1;
>  	while (!IS_ALIGNED(name_len, sizeof(u64)))
>  		name[name_len++] = '\0';
> diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
> index 5741ffe47312..91fe2ef920c7 100644
> --- a/tools/perf/arch/x86/util/event.c
> +++ b/tools/perf/arch/x86/util/event.c
> @@ -64,7 +64,7 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
>  		event->mmap.pgoff = map__pgoff(map);
>  		event->mmap.pid   = machine->pid;
>  
> -		strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
> +		strscpy(event->mmap.filename, kmap->name, PATH_MAX);
>  
>  		if (perf_tool__process_synth_event(tool, event, machine,
>  						   process) != 0) {
> diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
> index 31679c35d493..1ff0be147205 100644
> --- a/tools/perf/arch/x86/util/machine.c
> +++ b/tools/perf/arch/x86/util/machine.c
> @@ -40,7 +40,7 @@ static int add_extra_kernel_map(struct extra_kernel_map_info *mi, u64 start,
>  	mi->maps[mi->cnt].start = start;
>  	mi->maps[mi->cnt].end   = end;
>  	mi->maps[mi->cnt].pgoff = pgoff;
> -	strlcpy(mi->maps[mi->cnt].name, name, KMAP_NAME_LEN);
> +	strscpy(mi->maps[mi->cnt].name, name, KMAP_NAME_LEN);
>  
>  	mi->cnt += 1;
>  
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index cd381693658b..0cc4c39558ad 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -36,7 +36,7 @@ static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
>  	char root_dir[PATH_MAX];
>  	char *p;
>  
> -	strlcpy(root_dir, proc_dir, sizeof(root_dir));
> +	strscpy(root_dir, proc_dir, sizeof(root_dir));
>  
>  	p = strrchr(root_dir, '/');
>  	if (!p)
> @@ -104,7 +104,7 @@ static int build_id_cache__kcore_existing(const char *from_dir, char *to_dir,
>  			  to_dir, dent->d_name);
>  		if (!compare_proc_modules(from, to) &&
>  		    same_kallsyms_reloc(from_dir, to_subdir)) {
> -			strlcpy(to_dir, to_subdir, to_dir_sz);
> +			strscpy(to_dir, to_subdir, to_dir_sz);
>  			ret = 0;
>  			break;
>  		}
> @@ -121,7 +121,7 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
>  	char from_dir[PATH_MAX], to_dir[PATH_MAX];
>  	char *p;
>  
> -	strlcpy(from_dir, filename, sizeof(from_dir));
> +	strscpy(from_dir, filename, sizeof(from_dir));
>  
>  	p = strrchr(from_dir, '/');
>  	if (!p || strcmp(p + 1, "kcore"))
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 34cbe3e959aa..aa6ebf46370a 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -606,7 +606,7 @@ static int setup_server_socket(struct daemon *daemon)
>  	memset(&addr, 0, sizeof(addr));
>  	addr.sun_family = AF_UNIX;
>  
> -	strlcpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
> +	strscpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
>  	unlink(path);
>  
>  	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) == -1) {
> @@ -877,7 +877,7 @@ static int setup_client_socket(struct daemon *daemon)
>  
>  	memset(&addr, 0, sizeof(addr));
>  	addr.sun_family = AF_UNIX;
> -	strlcpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
> +	strscpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
>  
>  	if (connect(fd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
>  		perror("failed: connect");
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index fcca275e5bf9..04d6825d23c8 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -158,7 +158,7 @@ copy_class_filename(const char * class_sign, const char * file_name, char * resu
>  		result[i] = '\0';
>  	} else {
>  		/* fallback case */
> -		strlcpy(result, file_name, max_length);
> +		strscpy(result, file_name, max_length);
>  	}
>  }
>  
> diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
> index 086fd2179e41..7003418614ef 100644
> --- a/tools/perf/tests/dlfilter-test.c
> +++ b/tools/perf/tests/dlfilter-test.c
> @@ -234,7 +234,7 @@ static int get_dlfilters_path(char *buf, size_t sz)
>  		if (access(path, R_OK))
>  			return -1;
>  	}
> -	strlcpy(buf, dirname(path), sz);
> +	strscpy(buf, dirname(path), sz);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
> index 2d1aa42d36a9..a6b44fa4ec6f 100644
> --- a/tools/perf/tests/symbols.c
> +++ b/tools/perf/tests/symbols.c
> @@ -45,7 +45,7 @@ static void exit_test_info(struct test_info *ti)
>  static void get_test_dso_filename(char *filename, size_t max_sz)
>  {
>  	if (dso_to_test)
> -		strlcpy(filename, dso_to_test, max_sz);
> +		strscpy(filename, dso_to_test, max_sz);
>  	else
>  		perf_exe(filename, max_sz);
>  }
> diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
> index db4952f5990b..1040e4c33469 100644
> --- a/tools/perf/ui/tui/helpline.c
> +++ b/tools/perf/ui/tui/helpline.c
> @@ -24,7 +24,7 @@ static void tui_helpline__push(const char *msg)
>  	SLsmg_set_color(0);
>  	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
>  	SLsmg_refresh();
> -	strlcpy(ui_helpline__current, msg, sz);
> +	strscpy(ui_helpline__current, msg, sz);
>  }
>  
>  static int tui_helpline__show(const char *format, va_list ap)
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 11992cfe271c..5e1a623be915 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1702,7 +1702,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  		if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
>  			char *new_name = dso__filename_with_chroot(dso, filename);
>  			if (new_name) {
> -				strlcpy(filename, new_name, filename_size);
> +				strscpy(filename, new_name, filename_size);
>  				free(new_name);
>  			}
>  		}
> @@ -2002,7 +2002,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		kce.len = sym->end - sym->start;
>  		if (!kcore_extract__create(&kce)) {
>  			delete_extract = true;
> -			strlcpy(symfs_filename, kce.extract_filename,
> +			strscpy(symfs_filename, kce.extract_filename,
>  				sizeof(symfs_filename));
>  		}
>  	} else if (dso__needs_decompress(dso)) {
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index a0368202a746..e69841ba3014 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1213,7 +1213,7 @@ void auxtrace_synth_guest_error(struct perf_record_auxtrace_error *auxtrace_erro
>  	auxtrace_error->fmt = 1;
>  	auxtrace_error->ip = ip;
>  	auxtrace_error->time = timestamp;
> -	strlcpy(auxtrace_error->msg, msg, MAX_AUXTRACE_ERROR_MSG);
> +	strscpy(auxtrace_error->msg, msg, MAX_AUXTRACE_ERROR_MSG);
>  	if (machine_pid) {
>  		auxtrace_error->fmt = 2;
>  		auxtrace_error->machine_pid = machine_pid;
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index a86614599269..7db2f30f6a0d 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -318,7 +318,7 @@ int filename__decompress(const char *name, char *pathname,
>  		unlink(tmpbuf);
>  
>  	if (pathname && (fd >= 0))
> -		strlcpy(pathname, tmpbuf, len);
> +		strscpy(pathname, tmpbuf, len);
>  
>  	return fd;
>  }
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> index b450178e3420..5b14c6701ecb 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> @@ -507,7 +507,7 @@ int intel_pt__strerror(int code, char *buf, size_t buflen)
>  {
>  	if (code < 1 || code >= INTEL_PT_ERR_MAX)
>  		code = INTEL_PT_ERR_UNK;
> -	strlcpy(buf, intel_pt_err_msgs[code], buflen);
> +	strscpy(buf, intel_pt_err_msgs[code], buflen);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> index 4e8e243a6e4b..3d7c614adc80 100644
> --- a/tools/perf/util/llvm-utils.c
> +++ b/tools/perf/util/llvm-utils.c
> @@ -80,7 +80,7 @@ search_program(const char *def, const char *name,
>  	if (def && def[0] != '\0') {
>  		if (def[0] == '/') {
>  			if (access(def, F_OK) == 0) {
> -				strlcpy(output, def, PATH_MAX);
> +				strscpy(output, def, PATH_MAX);
>  				return 0;
>  			}
>  		} else if (def[0] != '\0')
> @@ -99,7 +99,7 @@ search_program(const char *def, const char *name,
>  	while (path) {
>  		scnprintf(buf, sizeof(buf), "%s/%s", path, name);
>  		if (access(buf, F_OK) == 0) {
> -			strlcpy(output, buf, PATH_MAX);
> +			strscpy(output, buf, PATH_MAX);
>  			ret = 0;
>  			break;
>  		}
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 9e02e19c1b7a..d035b35d226e 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1223,7 +1223,7 @@ int machine__create_extra_kernel_map(struct machine *machine,
>  
>  	kmap = map__kmap(map);
>  
> -	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
> +	strscpy(kmap->name, xm->name, KMAP_NAME_LEN);
>  
>  	err = maps__insert(machine__kernel_maps(machine), map);
>  
> @@ -1314,7 +1314,7 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
>  			.pgoff = pgoff,
>  		};
>  
> -		strlcpy(xm.name, ENTRY_TRAMPOLINE_NAME, KMAP_NAME_LEN);
> +		strscpy(xm.name, ENTRY_TRAMPOLINE_NAME, KMAP_NAME_LEN);
>  
>  		if (machine__create_extra_kernel_map(machine, kernel, &xm) < 0)
>  			return -1;
> @@ -1935,7 +1935,7 @@ int machine__process_mmap2_event(struct machine *machine,
>  			.pgoff = event->mmap2.pgoff,
>  		};
>  
> -		strlcpy(xm.name, event->mmap2.filename, KMAP_NAME_LEN);
> +		strscpy(xm.name, event->mmap2.filename, KMAP_NAME_LEN);
>  		ret = machine__process_kernel_mmap_event(machine, &xm, bid);
>  		if (ret < 0)
>  			goto out_problem;
> @@ -1992,7 +1992,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
>  			.pgoff = event->mmap.pgoff,
>  		};
>  
> -		strlcpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
> +		strscpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
>  		ret = machine__process_kernel_mmap_event(machine, &xm, NULL);
>  		if (ret < 0)
>  			goto out_problem;
> diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
> index 38628805a952..1c6e7f7da856 100644
> --- a/tools/perf/util/pmu-hybrid.c
> +++ b/tools/perf/util/pmu-hybrid.c
> @@ -27,7 +27,7 @@ bool perf_pmu__hybrid_mounted(const char *name)
>  	if (strncmp(name, "cpu_", 4))
>  		return false;
>  
> -	strlcpy(pmu_name, name, sizeof(pmu_name));
> +	strscpy(pmu_name, name, sizeof(pmu_name));
>  	return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
>  }
>  
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index ad209c88a124..7e2d97926e9f 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -599,7 +599,7 @@ static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name)
>  	struct perf_pmu pmu = {.name = pmu_name};
>  	FILE *file;
>  
> -	strlcpy(pmu_name, name, sizeof(pmu_name));
> +	strscpy(pmu_name, name, sizeof(pmu_name));
>  	for (template = templates; *template; template++) {
>  		file = perf_pmu__open_file_at(&pmu, dirfd, *template);
>  		if (!file)
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 3d50de3217d5..8bc90b856ce3 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -459,7 +459,7 @@ static int probe_cache__open(struct probe_cache *pcache, const char *target,
>  
>  	if (target && build_id_cache__cached(target)) {
>  		/* This is a cached buildid */
> -		strlcpy(sbuildid, target, SBUILD_ID_SIZE);
> +		strscpy(sbuildid, target, SBUILD_ID_SIZE);
>  		dir_name = build_id_cache__linkname(sbuildid, NULL, 0);
>  		goto found;
>  	}
> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index 5c62d3118c41..dd877b259f75 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -332,7 +332,7 @@ static char *cpu_model(void)
>  	if (file) {
>  		while (fgets(buf, 255, file)) {
>  			if (strstr(buf, "model name")) {
> -				strlcpy(cpu_m, &buf[13], 255);
> +				strscpy(cpu_m, &buf[13], 255);
>  				break;
>  			}
>  		}
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 6b9c55784b56..57223c770b89 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1967,7 +1967,7 @@ int dso__load(struct dso *dso, struct map *map)
>  			char *new_name = dso__filename_with_chroot(dso, name);
>  			if (new_name) {
>  				is_reg = is_regular_file(new_name);
> -				strlcpy(name, new_name, PATH_MAX);
> +				strscpy(name, new_name, PATH_MAX);
>  				free(new_name);
>  			}
>  		}
> @@ -2254,7 +2254,7 @@ static int find_matching_kcore(struct map *map, char *dir, size_t dir_sz)
>  		scnprintf(kallsyms_filename, sizeof(kallsyms_filename),
>  			  "%s/%s/kallsyms", dir, nd->s);
>  		if (!validate_kcore_addresses(kallsyms_filename, map)) {
> -			strlcpy(dir, kallsyms_filename, dir_sz);
> +			strscpy(dir, kallsyms_filename, dir_sz);
>  			ret = 0;
>  			break;
>  		}
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index b2e4afa5efa1..d7c13e3ded9f 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1979,7 +1979,7 @@ int perf_event__synthesize_event_update_unit(struct perf_tool *tool, struct evse
>  	if (ev == NULL)
>  		return -ENOMEM;
>  
> -	strlcpy(ev->unit, evsel->unit, size + 1);
> +	strscpy(ev->unit, evsel->unit, size + 1);
>  	err = process(tool, (union perf_event *)ev, NULL, NULL);
>  	free(ev);
>  	return err;
> @@ -2013,7 +2013,7 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
>  	if (ev == NULL)
>  		return -ENOMEM;
>  
> -	strlcpy(ev->name, evsel->name, len + 1);
> +	strscpy(ev->name, evsel->name, len + 1);
>  	err = process(tool, (union perf_event *)ev, NULL, NULL);
>  	free(ev);
>  	return err;
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 
> 

-- 

- Arnaldo
