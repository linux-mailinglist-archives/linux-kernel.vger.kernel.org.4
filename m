Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1C6CFA8D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 07:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjC3FGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 01:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC3FGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:06:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB064C10;
        Wed, 29 Mar 2023 22:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680152799; x=1711688799;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=xnYueHXHnBopTCtf+1j6Fg08FJi+4+maB8SpYTuPIqs=;
  b=RnIwDRRX/qlPkPLqFToqFDiTJe3UoSpACIsB51Myp/gfW83C0NecHam9
   m+JRd5Jo+1bAjo2BWFxCgKT5K9bU3aReUmhVvqxMKUxXc4Ztkb0rxu+7g
   iXz1JpO1KOW2521GgbaWocUSIwcn3s7z9jZ/1uUUTIsgppKbJuSjUSHMt
   qEiw32MGQ27K/UpLdj9yzzsdDu2bENOF/27/FteF7cb2FwkMLIGy5r6Tt
   JoDJ+PSKZ9xnogrOh36u3SQzhVF35jo0rafBJ7dwdxvPN2+OTNwKoifoa
   10DcdNhdj4pBxKI9BprNPrr2acPM8JtdjpDKLtGH247+CEgTtHG7zZnps
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="321454751"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="321454751"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 22:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="808497205"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="808497205"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.32.122])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 22:06:25 -0700
Message-ID: <8f7077e8-bcce-a13f-48d3-92a3cb80b02a@intel.com>
Date:   Thu, 30 Mar 2023 08:06:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/1] perf report: append inlines to non-dwarf callchains
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, asavkov@redhat.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20230316133557.868731-1-asavkov@redhat.com>
 <CAM9d7ciT7Wtmxt0_2ZVv4nbAb1KoeX_itTSAhz8B9T41-NeZYQ@mail.gmail.com>
 <ZBQZoyJc7mhUrL8n@samus.usersys.redhat.com>
 <CAM9d7ch9NjnaB5dB6fO7WKdwPd8M9DmNpdu4-V-8R+96ssxMvA@mail.gmail.com>
 <ZBtalEw0qKQFlVWR@kernel.org>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZBtalEw0qKQFlVWR@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/23 21:44, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 22, 2023 at 11:18:49AM -0700, Namhyung Kim escreveu:
>> On Fri, Mar 17, 2023 at 12:41 AM Artem Savkov <asavkov@redhat.com> wrote:
>>>
>>> On Thu, Mar 16, 2023 at 02:26:18PM -0700, Namhyung Kim wrote:
>>>> Hello,
>>>>
>>>> On Thu, Mar 16, 2023 at 6:36 AM Artem Savkov <asavkov@redhat.com> wrote:
>>>>>
>>>>> In an email to Arnaldo Andrii Nakryiko suggested that perf can get
>>>>> information about inlined functions from dwarf when available and then
>>>>> add it to userspace stacktraces even in framepointer or lbr mode.
>>>>> Looking closer at perf it turned out all required bits and pieces are
>>>>> already there and inline information can be easily added to both
>>>>> framepointer and lbr callchains by adding an append_inlines() call to
>>>>> add_callchain_ip().
>>>>
>>>> Looks great!  Have you checked it with perf report -g callee ?
>>>> I'm not sure the ordering of inlined functions is maintained
>>>> properly.  Maybe you can use --no-children too to simplify
>>>> the output.
>>>
>>> Thanks for the suggestion. I actually have another test program with
>>> functions being numbered rather than (creatively) named, so it might be
>>> easier to use it to figure out ordering. Here's the code:
>>
>> Yep, looks good.
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> So, I'll apply this shorter patch instead, ok?
> 
> - Arnaldo
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 803c9d1803dd26ef..abf6167f28217fe6 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -44,6 +44,7 @@
>  #include <linux/zalloc.h>
>  
>  static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
> +static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
>  
>  static struct dso *machine__kernel_dso(struct machine *machine)
>  {
> @@ -2322,6 +2323,10 @@ static int add_callchain_ip(struct thread *thread,
>  	ms.maps = al.maps;
>  	ms.map = al.map;
>  	ms.sym = al.sym;
> +
> +	if (append_inlines(cursor, &ms, ip) == 0)
> +		return 0;
> +
>  	srcline = callchain_srcline(&ms, al.addr);
>  	return callchain_cursor_append(cursor, ip, &ms,
>  				       branch, flags, nr_loop_iter,

This seems to be breaking --branch-history.  I am not sure
append_inlines() makes sense for branches.  Maybe this should be:

	if (!branch && !append_inlines(cursor, &ms, ip))
		return 0;
