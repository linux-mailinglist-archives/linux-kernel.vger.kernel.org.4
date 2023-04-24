Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CCA6EA2F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjDUFFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjDUFFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:05:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E070330DF;
        Thu, 20 Apr 2023 22:05:13 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Q2j6X4VGSz17V7m;
        Fri, 21 Apr 2023 13:01:24 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Apr
 2023 13:05:09 +0800
Date:   Fri, 21 Apr 2023 13:04:56 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     Changbin Du <changbin.du@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 2/3] perf: add helper map__fprintf_dsoname_dsoff
Message-ID: <20230421050456.qnwzj2kl47i6ahto@M910t>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
 <20230418031825.1262579-3-changbin.du@huawei.com>
 <3001bde2-b010-3c00-17de-1c78ef4b589b@intel.com>
 <20230420025511.fkd7upvuoxfz2xih@M910t>
 <ff8bc134-853d-a9d9-901b-2c20beed8d05@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ff8bc134-853d-a9d9-901b-2c20beed8d05@intel.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What do you get if you try below diff on top of
> your patches:
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c7bf1ac14e90..df0d21141185 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -576,8 +576,11 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
>  	if (PRINT_FIELD(DSO))
>  		output[type].print_ip_opts |= EVSEL__PRINT_DSO;
>  
> -	if (PRINT_FIELD(DSOFF))
> +	if (PRINT_FIELD(DSOFF)) {
>  		output[type].print_ip_opts |= EVSEL__PRINT_DSOFF;
> +		/* DSO offset is relative to dso->longname */
> +		symbol_conf.show_kernel_path = true;
> +	}
>  
>  	if (PRINT_FIELD(SYMOFFSET))
>  		output[type].print_ip_opts |= EVSEL__PRINT_SYMOFFSET;
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index a86614599269..19ebfd3468cc 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -67,6 +67,42 @@ char dso__symtab_origin(const struct dso *dso)
>  	return origin[dso->symtab_type];
>  }
>  
> +bool dso__is_file(const struct dso *dso)
> +{
> +	switch (dso->binary_type) {
> +	case DSO_BINARY_TYPE__KALLSYMS:
> +	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
> +		return false;
> +	case DSO_BINARY_TYPE__VMLINUX:
> +	case DSO_BINARY_TYPE__GUEST_VMLINUX:
> +		return true;
> +	case DSO_BINARY_TYPE__JAVA_JIT:
> +		return false;
> +	case DSO_BINARY_TYPE__DEBUGLINK:
> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
> +	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
> +	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
> +	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
> +	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
> +	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
> +	case DSO_BINARY_TYPE__GUEST_KMODULE:
> +	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
> +	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
> +	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
> +	case DSO_BINARY_TYPE__KCORE:
> +	case DSO_BINARY_TYPE__GUEST_KCORE:
> +	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
> +		return true;
> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
> +	case DSO_BINARY_TYPE__BPF_IMAGE:
> +	case DSO_BINARY_TYPE__OOL:
> +	case DSO_BINARY_TYPE__NOT_FOUND:
> +	default:
> +		return false;
> +	}
> +}
> +
>  int dso__read_binary_type_filename(const struct dso *dso,
>  				   enum dso_binary_type type,
>  				   char *root_dir, char *filename, size_t size)
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 0b7c7633b9f6..fb33f5224fb6 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -396,6 +396,8 @@ static inline bool dso__is_kallsyms(struct dso *dso)
>  	return dso->kernel && dso->long_name[0] != '/';
>  }
>  
> +bool dso__is_file(const struct dso *dso);
> +
>  void dso__free_a2l(struct dso *dso);
>  
>  enum dso_type dso__type(struct dso *dso, struct machine *machine);
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 7da96b41100f..9b79f88d371c 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -447,11 +447,12 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
>  
>  size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp)
>  {
> +	const struct dso *dso = map ? map__dso(map) : NULL;
>  	int printed = 0;
>  
>  	printed += fprintf(fp, " (");
>  	printed += map__fprintf_dsoname(map, fp);
> -	if (print_off && map && map__dso(map) && !map__dso(map)->kernel)
> +	if (print_off && dso && dso__is_file(dso))
>  		printed += fprintf(fp, "+0x%" PRIx64, addr);
>  	printed += fprintf(fp, ")");
>  
> 

Here are the outputs with above change.

For elf in build-id cache, it works as expected.
$ sudo perf script -F +dsoff
       perf-exec 12768   135.648023:          1 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf+0x28ee44)
       perf-exec 12768   135.648028:          1 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf+0x28ee44)
       perf-exec 12768   135.648030:         11 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf+0x28ee44)
       perf-exec 12768   135.648031:        295 cycles:  ffffffff96c8ee46 native_write_msr+0x6 (/home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf+0x28ee46)
       perf-exec 12768   135.648032:       8850 cycles:  ffffffff96c4c686 native_sched_clock+0x66 (/home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf+0x24c686)
              ls 27521   501.120978:    4309123 cycles:      7f31cb51c591 _dl_sort_maps+0x301 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)

But when I specify my vmlinux: (the binary_type is DSO_BINARY_TYPE__SYSTEM_PATH_DSO)
$ sudo perf script -k linux/vmlinux -F +dsoff
       perf-exec 12768   135.648023:          1 cycles:  ffffffff96c8ee44 [unknown] (/lib/modules/6.2.12/build/vmlinux)
       perf-exec 12768   135.648028:          1 cycles:  ffffffff96c8ee44 [unknown] (/lib/modules/6.2.12/build/vmlinux+0xffffffff96c8ee44)
       perf-exec 12768   135.648030:         11 cycles:  ffffffff96c8ee44 [unknown] (/lib/modules/6.2.12/build/vmlinux+0xffffffff96c8ee44)
       perf-exec 12768   135.648031:        295 cycles:  ffffffff96c8ee46 [unknown] (/lib/modules/6.2.12/build/vmlinux+0xffffffff96c8ee46)

This is for kcore file:
$ sudo perf script --kallsyms /proc/kallsyms -F +dsoff
       perf-exec 18922   267.284368:          1 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/proc/kcore+0x7fff96c91e44)
       perf-exec 18922   267.284372:          1 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/proc/kcore+0x7fff96c91e44)
       perf-exec 18922   267.284374:         11 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/proc/kcore+0x7fff96c91e44)

For ko, it's wierd that the binary_type of first one is DSO_BINARY_TYPE__NOT_FOUND.
$ sudo perf script -F +dsoff | grep '.ko'
           gedit 37410   769.927194:     199304 cycles:  ffffffffc0a3d050 ipt_do_table+0x0 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko)
           gedit 37410   770.459667:     271035 cycles:  ffffffffc0a3d050 ipt_do_table+0x0 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0xf0)
           gedit 37410   770.649838:     271878 cycles:  ffffffffc0a3d050 ipt_do_table+0x0 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0xf0)
           gedit 37410   771.239221:     216084 cycles:  ffffffffc0a3d13b ipt_do_table+0xeb (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0x1db)
           gedit 37410   771.257816:     219469 cycles:  ffffffffc0a3d165 ipt_do_table+0x115 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0x205)
           gedit 37410   771.531158:     288970 cycles:  ffffffffc0a3d151 ipt_do_table+0x101 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0x1f1)
           gedit 37410   771.816916:     321215 cycles:  ffffffffc0a3d151 ipt_do_table+0x101 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0x1f1)
           gedit 37410   773.624786:     332528 cycles:  ffffffffc0a3d2ea ipt_do_table+0x29a (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0x38a)

Maybe we can just filter by name? e.g. '[kernel.kallsyms]', '[guest.kernel.kallsyms]'.

-- 
Cheers,
Changbin Du
