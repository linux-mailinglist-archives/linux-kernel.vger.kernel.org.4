Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB54C70FCDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjEXRmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjEXRl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:41:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4082C119;
        Wed, 24 May 2023 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950117; x=1716486117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r6FHhG4idPEyk6XYTb9aP84pqgb9w1HnBj2Mi4iehE8=;
  b=l3UWOibFLEjSGOc6h78blLjWQdAT25hWzw+/x5e6tuZlxTiNP0PFEka4
   1f2diOfZKyy0rHlLatJXlsRZ19UjXcEZDuFcYVzMv8814tdmKYmYGV4Cy
   48kNC3GfXxx4em8BWES6AVVPdqYBUO6ITPhZxcQGcED/T9U6FcrZeZJNn
   8lnU4N11hsQJUaozhQ6N5AHcdBCjH700Y/sekw4HrL+hTVdq+i4ci3Be5
   saG4emqfHOuHGPeKzzAt14sjHa6jXJwcDuqK3WPSsG9L7x8ZzTUhiJE89
   DbLt7bAhOv2bKvVZb4yc16aR3tw82q7ogZGLrRkZleGaaopuMqW9uqv46
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="355994024"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="355994024"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="951115342"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="951115342"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.223.197])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:41:53 -0700
Message-ID: <5375b029-b4a3-f7ed-735f-d3985b8cede7@intel.com>
Date:   Wed, 24 May 2023 20:41:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] perf annotate: Handle x86 instruction suffix
 generally
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20230524052834.1041418-1-namhyung@kernel.org>
 <b054012a-94ee-fb86-da35-d3359b8b4683@intel.com>
 <CAM9d7cif9PPBWPEZx6MA6E4FHaAQLbi-0pEGwLrtLxiEASog9Q@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cif9PPBWPEZx6MA6E4FHaAQLbi-0pEGwLrtLxiEASog9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/23 19:10, Namhyung Kim wrote:
> Hi Adrian,
> 
> On Tue, May 23, 2023 at 11:11 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 24/05/23 08:28, Namhyung Kim wrote:
>>> Most of x86 instructions can have size suffix like b, w, l or q.
>>
>> (AT&T mnemonics)
> 
> Right, will update.
> 
>>
>>> Instead of adding all these instructions in the table, we can handle
>>> them in a general way.  For example, it can try to find an instruction
>>> as is.  If not found, it'd try again without the suffix if it's one of
>>> the allowed suffixes.
>>
>> I guess it might be possible that xyz is in the table but xyz<suffix>
>> is a completely different instruction?
> 
> Then xyz<suffix> should be in the table too.  The match without
> suffix is a fallback so it should find the correct instruction first.

Right, so when adding xyz to the table, xyz<suffix> does not need
to be added as well if it is the same instruction but with different
operand sizes, but xyz<suffix> must be added as well if it is a
different instruction with different ops.

> 
> Thanks,
> Namhyung
> 
> 
>>
>>>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>  tools/perf/util/annotate.c | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>> index b708bbc49c9e..7f05f2a2aa83 100644
>>> --- a/tools/perf/util/annotate.c
>>> +++ b/tools/perf/util/annotate.c
>>> @@ -70,6 +70,7 @@ struct arch {
>>>       struct ins_ops  *(*associate_instruction_ops)(struct arch *arch, const char *name);
>>>       bool            sorted_instructions;
>>>       bool            initialized;
>>> +     const char      *insn_suffix;
>>>       void            *priv;
>>>       unsigned int    model;
>>>       unsigned int    family;
>>> @@ -179,6 +180,7 @@ static struct arch architectures[] = {
>>>               .init = x86__annotate_init,
>>>               .instructions = x86__instructions,
>>>               .nr_instructions = ARRAY_SIZE(x86__instructions),
>>> +             .insn_suffix = "bwlq",
>>>               .objdump =  {
>>>                       .comment_char = '#',
>>>               },
>>> @@ -720,6 +722,26 @@ static struct ins_ops *__ins__find(struct arch *arch, const char *name)
>>>       }
>>>
>>>       ins = bsearch(name, arch->instructions, nmemb, sizeof(struct ins), ins__key_cmp);
>>> +     if (ins)
>>> +             return ins->ops;
>>> +
>>> +     if (arch->insn_suffix) {
>>> +             char tmp[32];
>>> +             char suffix;
>>> +             size_t len = strlen(name);
>>> +
>>> +             if (len == 0 || len >= sizeof(tmp))
>>> +                     return NULL;
>>> +
>>> +             suffix = name[len - 1];
>>> +             if (strchr(arch->insn_suffix, suffix) == NULL)
>>> +                     return NULL;
>>> +
>>> +             strcpy(tmp, name);
>>> +             tmp[len - 1] = '\0'; /* remove the suffix and check again */
>>> +
>>> +             ins = bsearch(tmp, arch->instructions, nmemb, sizeof(struct ins), ins__key_cmp);
>>> +     }
>>>       return ins ? ins->ops : NULL;
>>>  }
>>>
>>

