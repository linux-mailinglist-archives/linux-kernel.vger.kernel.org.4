Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC71B74D823
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGJNuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGJNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:50:05 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB32398;
        Mon, 10 Jul 2023 06:50:03 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qIrGv-000548-Uw; Mon, 10 Jul 2023 15:49:50 +0200
Message-ID: <090d1bcb-608b-1aa3-7a59-f2b09ff0061e@leemhuis.info>
Date:   Mon, 10 Jul 2023 15:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/2] perf probe: fix regression introduced by switch to
 die_get_decl_file
Content-Language: en-US, de-DE
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230628084551.1860532-3-georgmueller@gmx.net>
 <1c85c4d6-7097-bc0a-d0ca-ebe234d63ece@leemhuis.info>
 <ZKwLKXL6rkoShDNc@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZKwLKXL6rkoShDNc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688997003;db093e26;
X-HE-SMSGID: 1qIrGv-000548-Uw
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 15:44, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 10, 2023 at 02:32:28PM +0200, Linux regression tracking (Thorsten Leemhuis) escreveu:
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Masami, Arnaldo, what's up here? Georg (who is not a regular
>> contributor) afaics found a regression in a commit you
>> authored/committed and even provided a patch-set to fix it (the first
>> one nearly four weeks ago, e.g. before the merge window started), but
>> hasn't received much support from your side to get this in. Could you
>> please look into this to get this cleared up? Or am I missing something
>> and progress to fix this has been made?
> 
> I'm back from a 2 week vacation,

Welcome back and hope you found some rest.

> going thru the pile, probably fell thru
> the cracks and Namyung, that processed patches while I was away didn't
> notice it either.
> 
> I'm checking,

Great, many thx! Ciao, Thorsten

>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>>
>> On 28.06.23 10:45, Georg Müller wrote:
>>> When switching from dwarf_decl_file() to die_get_decl_file(), a regression
>>> was introduced when having a binary where the DWARF info is split to
>>> multiple CUs. It is not possible to add probes to certain functions.
>>>
>>> These patches introduce a testcase which shows the current regression
>>> and a fix for the issue
>>>
>>> Signed-off-by: Georg Müller <georgmueller@gmx.net>
>>> Link: https://lore.kernel.org/r/5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net/
>>>
>>> ---
>>> Changes in v2:
>>>  - Add testcase
>>>
>>> Changes in v3:
>>>  - start new thread
>>>  - add stable to cc
>>>
>>> Georg Müller (2):
>>>   perf probe: add test for regression introduced by switch to
>>>     die_get_decl_file
>>>   perf probe: read DWARF files from the correct CU
>>>
>>>  .../shell/test_uprobe_from_different_cu.sh    | 77 +++++++++++++++++++
>>>  tools/perf/util/dwarf-aux.c                   |  4 +-
>>>  2 files changed, 80 insertions(+), 1 deletion(-)
>>>  create mode 100755 tools/perf/tests/shell/test_uprobe_from_different_cu.sh
>>>
>>> --
>>> 2.41.0
>>>
>>>
>>>
> 
