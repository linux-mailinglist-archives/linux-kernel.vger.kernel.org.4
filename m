Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5343F673CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjASOrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjASOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:47:05 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BD275A25
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:44:28 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pIW9D-0004rQ-Rv; Thu, 19 Jan 2023 15:44:11 +0100
Message-ID: <27bd67f4-8b08-6c5b-137c-e9ef543e6d56@leemhuis.info>
Date:   Thu, 19 Jan 2023 15:44:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bisected] clang 15 built kernel fails to boot, stuck at "Loading
 Linux 6.1.1 ...", gcc 12 built kernel with same config boots fine
Content-Language: en-US, de-DE
To:     "Erhard F." <erhard_f@mailbox.org>, sandipan.das@amd.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230119022303.177052e4@yea>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230119022303.177052e4@yea>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674139468;e4b0ccca;
X-HE-SMSGID: 1pIW9D-0004rQ-Rv
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 19.01.23 02:23, Erhard F. wrote:
> Hi!
> 
> I did a kernel bisect for an issue I originally posted on https://github.com/ClangBuiltLinux/linux/issues/1774
> 
> It is about kernel 6.1.x not booting on my machines when built with clang. A gcc built kernel with the same config just works fine. Turns out kernel v6.2-rc4 and earlier v6.2-rc are still affected.
> 
> I did a kernel bisect which revealed this commit:
> 
>  # git bisect bad
> 706460a96fc654e80b6bed1f562b00d2ce9f2f4d is the first bad commit
> commit 706460a96fc654e80b6bed1f562b00d2ce9f2f4d
> Author: Sandipan Das <sandipan.das@amd.com>
> Date:   Thu Aug 11 17:59:51 2022 +0530
> 
>     perf/x86/amd/core: Add generic branch record interfaces
>     
>     AMD processors that are capable of recording branches support either Branch
>     Sampling (BRS) or Last Branch Record (LBR). In preparation for adding Last
>     Branch Record Extension Version 2 (LbrExtV2) support, introduce new static
>     calls which act as gateways to call into the feature-dependent functions
>     based on what is available on the processor.
>     
>     Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Link: https://lore.kernel.org/r/b75dbc32663cb395f0d701167e952c6a6b0445a3.1660211399.git.sandipan.das@amd.com
> 
>  arch/x86/events/amd/core.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> 
> For more details please have a look at https://github.com/ClangBuiltLinux/linux/issues/1774

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot introduced 706460a96fc654e80b6be ^
https://github.com/ClangBuiltLinux/linux/issues/1774
#regzbot title perf/x86/amd/core: clang 15 built kernel fails to boot
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
