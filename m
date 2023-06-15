Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AD6731820
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjFOMFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344861AbjFOMFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:05:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380333A81;
        Thu, 15 Jun 2023 05:03:27 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q9lMn-0002JV-L1; Thu, 15 Jun 2023 13:42:17 +0200
Message-ID: <8f21a1ca-3bbb-f37d-47f6-35648d3d7763@leemhuis.info>
Date:   Thu, 15 Jun 2023 13:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] tools/perf: Fix to get declared file name from
 clang DWARF5
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <166731050151.2100653.8202870942871353491.stgit@devnote3>
 <166731052936.2100653.13380621874859467731.stgit@devnote3>
 <5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686830607;ed41629e;
X-HE-SMSGID: 1q9lMn-0002JV-L1
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 09.06.23 14:21, Georg Müller wrote:
> 
> Am 01.11.22 um 14:48 schrieb Masami Hiramatsu (Google):
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Fix to get the declared file name even if it uses file index 0
>> in DWARF5, using custom die_get_decl_file() function.
>>
> 
> this patch breaks perf probe on fedora 38.
> 
> I was trying to a add a probe to systemd-logind using
> kernel-6.3.6-200.fc38.x86_64 with kernel-tools-6.3.3-200.fc38.x86_64.
> 
> When trying to add a probe, I get the following message:
> 
> # perf probe -x /usr/lib/systemd/systemd-logind
> --funcs="match_unit_removed"
> match_unit_removed
> 
> Function exists and was found:
> 
> # perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
> A function DIE doesn't have decl_line. Maybe broken DWARF?
> A function DIE doesn't have decl_line. Maybe broken DWARF?
> Probe point 'match_unit_removed' not found.
>   Error: Failed to add events.
> 
> When reverting dc9a5d2ccd5c823cc05cafe75fcf19b682d8152c, I was able to
> add the probe point:
> 
> # ./perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
> Added new event:
>   probe_systemd:match_unit_removed (on match_unit_removed in
> /usr/lib/systemd/systemd-logind)
> 
> You can now use it in all perf tools, such as:
> 
>     perf record -e probe_systemd:match_unit_removed -aR sleep 1
> 
> 
> Probe point is then visible with and without this commit:
> 
> # perf probe -l
>   probe_systemd:match_unit_removed (on match_unit_removed in
> /usr/lib/systemd/systemd-logind)
> # ./perf probe -l
>   probe_systemd:match_unit_removed (on
> match_unit_removed@../src/login/logind-dbus.c in
> /usr/lib/systemd/systemd-logind)

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced dc9a5d2ccd5c823cc05cafe75fcf19b682d8152c
#regzbot title tools/perf: adding a specific probe suddenly fails
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
