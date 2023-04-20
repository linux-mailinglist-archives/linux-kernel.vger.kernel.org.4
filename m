Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2B6E942E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjDTMXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjDTMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:23:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A38F;
        Thu, 20 Apr 2023 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681993417; x=1713529417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yv4blA62X3WJ+SUshSA+UbW4er8IVJsm5Rvo7sAhWrI=;
  b=QwZluq1PuHKpO7oy5GEgKJmW8xVowWqnJXkFU9zqMG2Lb9ql09Pp6UJ2
   1nKYjJVfx4X8bimqnsI7AHiMRvGdu8a/AHmvVya4rpK9CXT5npPOpAvFY
   Cmc1U50JyWPHMfbdpykEOhnchKQUZkX0HdJfxk0WUr/fKHQNrv4bLlOVO
   SxXlp9PyCYK8FS9sITxMHY3D3/tu+dPFO3y3m8GRa0U1cXetGDLssOVCl
   cWDqi3UWYvf5r59Zk12OJxcK6mIR0bxjCvoewvmOPrWCEMVEHnT9K+w3c
   oU0Bp5tj4l6BF8CNbOjgtZI2ZI931OS66QLC9PA9Cx9rQ2zjyZj/De4Yj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334550439"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="334550439"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 05:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="803323357"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="803323357"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2023 05:23:36 -0700
Received: from [10.255.228.114] (kliang2-mobl1.ccr.corp.intel.com [10.255.228.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 27332580BBE;
        Thu, 20 Apr 2023 05:22:57 -0700 (PDT)
Message-ID: <2b4f404c-24bf-a57a-1335-ae2fed18ddbb@linux.intel.com>
Date:   Thu, 20 Apr 2023 08:22:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
 <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com>
 <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com>
 <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com>
 <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
 <ZEEjJVTIcXvsV4Fh@kernel.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZEEjJVTIcXvsV4Fh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-20 7:33 a.m., Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 19, 2023 at 09:51:20AM -0700, Ian Rogers escreveu:
>> On Wed, Apr 19, 2023 at 7:16 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>> For ADL/RPL platforms
>>> - Segmentation fault which I just found this morning.
>>> # ./perf stat true
>>> Segmentation fault (core dumped)
>  
>> This may also stem from the reference count checking work that Arnaldo
>> is currently merging. It is hard to test hybrid because it uses
>> non-generic code paths.
> 
> Hey, could you please try this under gdb and provide a backtrace? 

Here is the backtrace.

#0  get_group_fd (thread=0, cpu_map_idx=<optimized out>,
evsel=0x555556015af0) at util/evsel.c:1722
#1  evsel__open_cpu (evsel=<optimized out>, cpus=<optimized out>,
threads=<optimized out>,
    start_cpu_map_idx=<optimized out>, end_cpu_map_idx=<optimized out>)
at util/evsel.c:2105
#2  0x000055555561dd9e in __run_perf_stat (run_idx=<optimized out>,
argv=0x7fffffffe1d0, argc=1)
    at builtin-stat.c:734
#3  run_perf_stat (run_idx=<optimized out>, argv=0x7fffffffe1d0, argc=1)
at builtin-stat.c:949
#4  cmd_stat (argc=1, argv=0x7fffffffe1d0) at builtin-stat.c:2537
#5  0x00005555556b56a0 in run_builtin (p=p@entry=0x555555f84450
<commands+336>, argc=argc@entry=2,
    argv=argv@entry=0x7fffffffe1d0) at perf.c:323
#6  0x00005555555fe2d9 in handle_internal_command (argv=0x7fffffffe1d0,
argc=2) at perf.c:377
#7  run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at
perf.c:421
#8  main (argc=2, argv=0x7fffffffe1d0) at perf.c:537

Thanks,
Kan

> It may
> indeed be related to this refcount checking work, there was a bug fixed
> by the ARM guys for cs-etm and I combed thru and fixed some other use
> before check for NULL cases, maybe one more slipped up.
> 
> Here I couldn't reproduce, but I don't have a Intel hybrid system, will
> check with an ARM, but unsure if it will exercise the same code paths...
> 
> - Arnaldo
