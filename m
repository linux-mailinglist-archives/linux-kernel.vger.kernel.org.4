Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A707215EC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 11:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFDJxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 05:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjFDJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 05:53:36 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2911ADF;
        Sun,  4 Jun 2023 02:53:32 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q5kQR-000400-Pp; Sun, 04 Jun 2023 11:53:27 +0200
Message-ID: <abf51606-b34b-0144-90a3-6d06cf4171b2@leemhuis.info>
Date:   Sun, 4 Jun 2023 11:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH rcu 11/20] srcu: Move grace-period fields from srcu_struct
 to srcu_usage
Content-Language: en-US, de-DE
To:     Jon Hunter <jonathanh@nvidia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230330224726.662344-11-paulmck@kernel.org>
 <6549da46-dddc-67ac-73c4-966965addad7@nvidia.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <6549da46-dddc-67ac-73c4-966965addad7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685872413;bbed989d;
X-HE-SMSGID: 1q5kQR-000400-Pp
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

On 01.06.23 13:14, Jon Hunter wrote:
> 
> On 30/03/2023 23:47, Paul E. McKenney wrote:
>> This commit moves the ->srcu_gp_seq, ->srcu_gp_seq_needed,
>> ->srcu_gp_seq_needed_exp, ->srcu_gp_start, and ->srcu_last_gp_end fields
>> from the srcu_struct structure to the srcu_usage structure to reduce
>> the size of the former in order to improve cache locality.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
>> Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> 
> I have noticed a suspend regression on some of our Tegra boards recently
> with v6.4-rc and interestingly bisect is pointing to this commit. I was
> unable revert this on top of the latest mainline but if I checkout this
> commit suspend fails and if I checkout the previous commit is passes.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 95433f726301
#regzbot title rcu: "spinlock bad magic" BUG when the SRCU notifier was
ever used
#regzbot monitor:
https://lore.kernel.org/all/20230526073539.339203-1-wenst@chromium.org/
#regzbot fix: notifier: Initialize new struct srcu_usage field
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
