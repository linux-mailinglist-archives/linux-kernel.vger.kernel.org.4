Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6A06EC4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjDXFZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDXFZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:25:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E322270B;
        Sun, 23 Apr 2023 22:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682313923; x=1713849923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=91RRsNX44/hdSFSjrVWDEIFtCxnJzfCeIwLQIh6YSTM=;
  b=TtqFiktVUI+jCL4MIqJbxPetPGdk1Z1ffXvsP6jrglkxwihexVIHQzPI
   XLidVEqV3N+34HKcYHekhIcn9OUVU3pEQIqvkkelZCGbWVdyvjJPboeNI
   vJK55cDiJnvbq+5c/dZILAFkV4BqYbeCu7kG6rkv74NOoc6K71vgiDl+O
   HVDBqUPReJBR98W9cWeXB+XC84T832sv8gK9NrYFp2TOQvYipOfbssSBI
   vq2rf/2uVVfuIvaCCT4hQ366vBekGco+TBSX6hfDOKGLY38nCiuh8/Kjs
   L3iViEv7WM5w0YYYKqRLYLJGrOgRb93gLlLwUrIsW2cyOfXvz6MzbCsOW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="346385440"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="346385440"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:25:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="817121762"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="817121762"
Received: from faerberc-mobl2.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.217])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:25:19 -0700
Message-ID: <c3c59d7f-ead6-ae8d-d7d5-2842406048fd@intel.com>
Date:   Mon, 24 Apr 2023 08:25:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/3] perf: add helper map__fprintf_dsoname_dsoff
Content-Language: en-US
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
 <20230418031825.1262579-3-changbin.du@huawei.com>
 <3001bde2-b010-3c00-17de-1c78ef4b589b@intel.com>
 <20230420025511.fkd7upvuoxfz2xih@M910t>
 <ff8bc134-853d-a9d9-901b-2c20beed8d05@intel.com>
 <20230421050456.qnwzj2kl47i6ahto@M910t>
 <03753b17-f380-94fc-d6eb-c5dfb1edb5d5@intel.com>
 <20230423043242.bjoqrkdztl3snaj4@M910t>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230423043242.bjoqrkdztl3snaj4@M910t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/23 07:32, Changbin Du wrote:
> On Fri, Apr 21, 2023 at 10:30:45AM +0300, Adrian Hunter wrote:
>> On 21/04/23 08:04, Changbin Du wrote:
>>>> What do you get if you try below diff on top of
>>>> your patches:
>>>>
>>>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>>>> index c7bf1ac14e90..df0d21141185 100644
>>>> --- a/tools/perf/builtin-script.c
>>>> +++ b/tools/perf/builtin-script.c
>>>> @@ -576,8 +576,11 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
>>>>  	if (PRINT_FIELD(DSO))
>>>>  		output[type].print_ip_opts |= EVSEL__PRINT_DSO;
>>>>  
>>>> -	if (PRINT_FIELD(DSOFF))
>>>> +	if (PRINT_FIELD(DSOFF)) {
>>>>  		output[type].print_ip_opts |= EVSEL__PRINT_DSOFF;
>>>> +		/* DSO offset is relative to dso->longname */
>>>> +		symbol_conf.show_kernel_path = true;
>>>> +	}
>>>>  
>>>>  	if (PRINT_FIELD(SYMOFFSET))
>>>>  		output[type].print_ip_opts |= EVSEL__PRINT_SYMOFFSET;
>>>> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
>>>> index a86614599269..19ebfd3468cc 100644
>>>> --- a/tools/perf/util/dso.c
>>>> +++ b/tools/perf/util/dso.c
>>>> @@ -67,6 +67,42 @@ char dso__symtab_origin(const struct dso *dso)
>>>>  	return origin[dso->symtab_type];
>>>>  }
>>>>  
>>>> +bool dso__is_file(const struct dso *dso)
>>>> +{
>>>> +	switch (dso->binary_type) {
>>>> +	case DSO_BINARY_TYPE__KALLSYMS:
>>>> +	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
>>>> +		return false;
>>>> +	case DSO_BINARY_TYPE__VMLINUX:
>>>> +	case DSO_BINARY_TYPE__GUEST_VMLINUX:
>>>> +		return true;
>>>> +	case DSO_BINARY_TYPE__JAVA_JIT:
>>>> +		return false;
>>>> +	case DSO_BINARY_TYPE__DEBUGLINK:
>>>> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
>>>> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
>>>> +	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
>>>> +	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
>>>> +	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
>>>> +	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
>>>> +	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
>>>> +	case DSO_BINARY_TYPE__GUEST_KMODULE:
>>>> +	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
>>>> +	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
>>>> +	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
>>>> +	case DSO_BINARY_TYPE__KCORE:
>>>> +	case DSO_BINARY_TYPE__GUEST_KCORE:
>>>> +	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
>>>> +		return true;
>>>> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
>>>> +	case DSO_BINARY_TYPE__BPF_IMAGE:
>>>> +	case DSO_BINARY_TYPE__OOL:
>>>> +	case DSO_BINARY_TYPE__NOT_FOUND:
>>>> +	default:
>>>> +		return false;
>>>> +	}
>>>> +}
>>>> +
>>>>  int dso__read_binary_type_filename(const struct dso *dso,
>>>>  				   enum dso_binary_type type,
>>>>  				   char *root_dir, char *filename, size_t size)
>>>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>>>> index 0b7c7633b9f6..fb33f5224fb6 100644
>>>> --- a/tools/perf/util/dso.h
>>>> +++ b/tools/perf/util/dso.h
>>>> @@ -396,6 +396,8 @@ static inline bool dso__is_kallsyms(struct dso *dso)
>>>>  	return dso->kernel && dso->long_name[0] != '/';
>>>>  }
>>>>  
>>>> +bool dso__is_file(const struct dso *dso);
>>>> +
>>>>  void dso__free_a2l(struct dso *dso);
>>>>  
>>>>  enum dso_type dso__type(struct dso *dso, struct machine *machine);
>>>> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
>>>> index 7da96b41100f..9b79f88d371c 100644
>>>> --- a/tools/perf/util/map.c
>>>> +++ b/tools/perf/util/map.c
>>>> @@ -447,11 +447,12 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
>>>>  
>>>>  size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp)
>>>>  {
>>>> +	const struct dso *dso = map ? map__dso(map) : NULL;
>>>>  	int printed = 0;
>>>>  
>>>>  	printed += fprintf(fp, " (");
>>>>  	printed += map__fprintf_dsoname(map, fp);
>>>> -	if (print_off && map && map__dso(map) && !map__dso(map)->kernel)
>>>> +	if (print_off && dso && dso__is_file(dso))
>>>>  		printed += fprintf(fp, "+0x%" PRIx64, addr);
>>>>  	printed += fprintf(fp, ")");
>>>>  
>>>>
>>>
>>> Here are the outputs with above change.
>>>
>>> For elf in build-id cache, it works as expected.
>>> $ sudo perf script -F +dsoff
>>>        perf-exec 12768   135.648023:          1 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf+0x28ee44)
>>>        perf-exec 12768   135.648028:          1 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf+0x28ee44)
>>>        perf-exec 12768   135.648030:         11 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf+0x28ee44)
>>>        perf-exec 12768   135.648031:        295 cycles:  ffffffff96c8ee46 native_write_msr+0x6 (/home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf+0x28ee46)
>>>        perf-exec 12768   135.648032:       8850 cycles:  ffffffff96c4c686 native_sched_clock+0x66 (/home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf+0x24c686)
>>
>> A bit messy though.  User can use option --show-kernel-path
>> so let's not force that after all.
>>
>>>               ls 27521   501.120978:    4309123 cycles:      7f31cb51c591 _dl_sort_maps+0x301 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
>>>
>>> But when I specify my vmlinux: (the binary_type is DSO_BINARY_TYPE__SYSTEM_PATH_DSO)
>>> $ sudo perf script -k linux/vmlinux -F +dsoff
>>>        perf-exec 12768   135.648023:          1 cycles:  ffffffff96c8ee44 [unknown] (/lib/modules/6.2.12/build/vmlinux)
>>>        perf-exec 12768   135.648028:          1 cycles:  ffffffff96c8ee44 [unknown] (/lib/modules/6.2.12/build/vmlinux+0xffffffff96c8ee44)
>>>        perf-exec 12768   135.648030:         11 cycles:  ffffffff96c8ee44 [unknown] (/lib/modules/6.2.12/build/vmlinux+0xffffffff96c8ee44)
>>>        perf-exec 12768   135.648031:        295 cycles:  ffffffff96c8ee46 [unknown] (/lib/modules/6.2.12/build/vmlinux+0xffffffff96c8ee46)
>>>
>>> This is for kcore file:
>>> $ sudo perf script --kallsyms /proc/kallsyms -F +dsoff
>>>        perf-exec 18922   267.284368:          1 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/proc/kcore+0x7fff96c91e44)
>>>        perf-exec 18922   267.284372:          1 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/proc/kcore+0x7fff96c91e44)
>>>        perf-exec 18922   267.284374:         11 cycles:  ffffffff96c8ee44 native_write_msr+0x4 (/proc/kcore+0x7fff96c91e44)
>>>
>>> For ko, it's wierd that the binary_type of first one is DSO_BINARY_TYPE__NOT_FOUND.
>>> $ sudo perf script -F +dsoff | grep '.ko'
>>>            gedit 37410   769.927194:     199304 cycles:  ffffffffc0a3d050 ipt_do_table+0x0 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko)
>>>            gedit 37410   770.459667:     271035 cycles:  ffffffffc0a3d050 ipt_do_table+0x0 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0xf0)
>>>            gedit 37410   770.649838:     271878 cycles:  ffffffffc0a3d050 ipt_do_table+0x0 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0xf0)
>>>            gedit 37410   771.239221:     216084 cycles:  ffffffffc0a3d13b ipt_do_table+0xeb (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0x1db)
>>>            gedit 37410   771.257816:     219469 cycles:  ffffffffc0a3d165 ipt_do_table+0x115 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0x205)
>>>            gedit 37410   771.531158:     288970 cycles:  ffffffffc0a3d151 ipt_do_table+0x101 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0x1f1)
>>>            gedit 37410   771.816916:     321215 cycles:  ffffffffc0a3d151 ipt_do_table+0x101 (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0x1f1)
>>>            gedit 37410   773.624786:     332528 cycles:  ffffffffc0a3d2ea ipt_do_table+0x29a (/lib/modules/6.2.12/kernel/net/ipv4/netfilter/ip_tables.ko+0x38a)
>>>
>>> Maybe we can just filter by name? e.g. '[kernel.kallsyms]', '[guest.kernel.kallsyms]'.
>>
>> Using the dso->binary_type deals with other cases also.
>> We can just change case DSO_BINARY_TYPE__NOT_FOUND to return
>> true.
>>
>> How about this:
>>
>> commit abaf1cbf5be5d50b1b3682511b92794394b72178
>> Author: Adrian Hunter <adrian.hunter@intel.com>
>> Date:   Fri Apr 21 10:15:14 2023 +0300
>>
>>     perf script: Refine printing of dso offset
>>     
>>     Print dso offset only for object files, and in those cases force using the
>>     dso->long_name if the dso->name starts with '[' or the dso is kcore, in
>>     order to avoid special names such as [vdso], or mixing up kcore with
>>     vmlinux.
>>     
>>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
>> index a86614599269..046fbfcfdaab 100644
>> --- a/tools/perf/util/dso.c
>> +++ b/tools/perf/util/dso.c
>> @@ -67,6 +67,39 @@ char dso__symtab_origin(const struct dso *dso)
>>  	return origin[dso->symtab_type];
>>  }
>>  
>> +bool dso__is_object_file(const struct dso *dso)
>> +{
>> +	switch (dso->binary_type) {
>> +	case DSO_BINARY_TYPE__KALLSYMS:
>> +	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
>> +	case DSO_BINARY_TYPE__JAVA_JIT:
>> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
>> +	case DSO_BINARY_TYPE__BPF_IMAGE:
>> +	case DSO_BINARY_TYPE__OOL:
>> +		return false;
>> +	case DSO_BINARY_TYPE__VMLINUX:
>> +	case DSO_BINARY_TYPE__GUEST_VMLINUX:
>> +	case DSO_BINARY_TYPE__DEBUGLINK:
>> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
>> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
>> +	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
>> +	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
>> +	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
>> +	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
>> +	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
>> +	case DSO_BINARY_TYPE__GUEST_KMODULE:
>> +	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
>> +	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
>> +	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
>> +	case DSO_BINARY_TYPE__KCORE:
>> +	case DSO_BINARY_TYPE__GUEST_KCORE:
>> +	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
>> +	case DSO_BINARY_TYPE__NOT_FOUND:
>> +	default:
>> +		return true;
>> +	}
>> +}
>> +
>>  int dso__read_binary_type_filename(const struct dso *dso,
>>  				   enum dso_binary_type type,
>>  				   char *root_dir, char *filename, size_t size)
>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>> index 0b7c7633b9f6..b23a157c914d 100644
>> --- a/tools/perf/util/dso.h
>> +++ b/tools/perf/util/dso.h
>> @@ -379,23 +379,25 @@ void dso__reset_find_symbol_cache(struct dso *dso);
>>  size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
>>  size_t dso__fprintf(struct dso *dso, FILE *fp);
>>  
>> -static inline bool dso__is_vmlinux(struct dso *dso)
>> +static inline bool dso__is_vmlinux(const struct dso *dso)
>>  {
>>  	return dso->binary_type == DSO_BINARY_TYPE__VMLINUX ||
>>  	       dso->binary_type == DSO_BINARY_TYPE__GUEST_VMLINUX;
>>  }
>>  
>> -static inline bool dso__is_kcore(struct dso *dso)
>> +static inline bool dso__is_kcore(const struct dso *dso)
>>  {
>>  	return dso->binary_type == DSO_BINARY_TYPE__KCORE ||
>>  	       dso->binary_type == DSO_BINARY_TYPE__GUEST_KCORE;
>>  }
>>  
>> -static inline bool dso__is_kallsyms(struct dso *dso)
>> +static inline bool dso__is_kallsyms(const struct dso *dso)
>>  {
>>  	return dso->kernel && dso->long_name[0] != '/';
>>  }
>>  
>> +bool dso__is_object_file(const struct dso *dso);
>> +
>>  void dso__free_a2l(struct dso *dso);
>>  
>>  enum dso_type dso__type(struct dso *dso, struct machine *machine);
>> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
>> index 7da96b41100f..5e7808b0bc87 100644
>> --- a/tools/perf/util/map.c
>> +++ b/tools/perf/util/map.c
>> @@ -424,14 +424,21 @@ size_t map__fprintf(struct map *map, FILE *fp)
>>  		       map__start(map), map__end(map), map__pgoff(map), dso->name);
>>  }
>>  
>> -size_t map__fprintf_dsoname(struct map *map, FILE *fp)
>> +static bool prefer_dso_long_name(const struct dso *dso, bool print_off)
>> +{
>> +	return dso->long_name &&
>> +	       (symbol_conf.show_kernel_path ||
>> +		(print_off && (dso->name[0] == '[' || dso__is_kcore(dso))));
>> +}
>> +
>> +static size_t __map__fprintf_dsoname(struct map *map, bool print_off, FILE *fp)
>>  {
>>  	char buf[symbol_conf.pad_output_len_dso + 1];
>>  	const char *dsoname = "[unknown]";
>>  	const struct dso *dso = map ? map__dso(map) : NULL;
>>  
>>  	if (dso) {
>> -		if (symbol_conf.show_kernel_path && dso->long_name)
>> +		if (prefer_dso_long_name(dso, print_off))
>>  			dsoname = dso->long_name;
>>  		else
>>  			dsoname = dso->name;
>> @@ -445,13 +452,21 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
>>  	return fprintf(fp, "%s", dsoname);
>>  }
>>  
>> +size_t map__fprintf_dsoname(struct map *map, FILE *fp)
>> +{
>> +	return __map__fprintf_dsoname(map, false, fp);
>> +}
>> +
>>  size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp)
>>  {
>> +	const struct dso *dso = map ? map__dso(map) : NULL;
>>  	int printed = 0;
>>  
>> +	if (print_off && (!dso || !dso__is_object_file(dso)))
>> +		print_off = false;
>>  	printed += fprintf(fp, " (");
>> -	printed += map__fprintf_dsoname(map, fp);
>> -	if (print_off && map && map__dso(map) && !map__dso(map)->kernel)
>> +	printed += __map__fprintf_dsoname(map, print_off, fp);
>> +	if (print_off)
>>  		printed += fprintf(fp, "+0x%" PRIx64, addr);
>>  	printed += fprintf(fp, ")");
>>  
>>
>>
> I am fine with this polish patch. So will send this standalone or append to this
> thread?

I will send my patch separately.


