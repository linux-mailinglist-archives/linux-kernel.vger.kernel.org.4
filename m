Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C006D37E7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDBMkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 08:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDBMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 08:40:51 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF2E1B6;
        Sun,  2 Apr 2023 05:40:48 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pix0b-0005dt-9D; Sun, 02 Apr 2023 14:40:33 +0200
Message-ID: <3a2ca263-7f60-63d3-7f9a-208ab8197c07@leemhuis.info>
Date:   Sun, 2 Apr 2023 14:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait()
 and slow-stuck reboots
Content-Language: en-US, de-DE
To:     Mark Rutland <mark.rutland@arm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>
Cc:     peterz@infradead.org, draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, bvanassche@acm.org, klimova@google.com
References: <20230314230004.961993-1-alexey.klimov@linaro.org>
 <ZBhlL4tqSUi/c3qk@FVFF77S0Q05N.cambridge.arm.com>
 <ZBiEEyDaxq9oSXJk@FVFF77S0Q05N.cambridge.arm.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZBiEEyDaxq9oSXJk@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680439249;6dba8e56;
X-HE-SMSGID: 1pix0b-0005dt-9D
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 20.03.23 17:04, Mark Rutland wrote:
> On Mon, Mar 20, 2023 at 01:52:47PM +0000, Mark Rutland wrote:
>> On Tue, Mar 14, 2023 at 11:00:04PM +0000, Alexey Klimov wrote:
>>> #regzbot introduced: 0c5ffc3d7b15
>>> #regzbot title: CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and slow-stuck reboots
>>>
>>> The upstream changes are being merged into android-mainline repo and at some
>>> point we started to observe kernel panics on reboot or long reboot times.
>>
>> Where can I find the android-mainline repo, and which specific branch/commit
>> from that repo is being merged in?
> 
> I assume that was the android-mainline branch in:
> 
>   https://android.googlesource.com/kernel/common/
> 
> ... and I had a go with commit:
> 
>   8338670fd5bdf8d7 ("Merge "Merge 36289a03bcd3 ("Merge tag 'v6.3-p1' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6") into android-mainline" into android-mainline")
> 
> ... as that was the commit immediately before your local revert:
> 
>   a32cec8e3f2253bc ("ANDROID: Revert "cpuidle, dt: Push RCU-idle into driver")
> 
> Testing on Juno R2 with defconfig + PROVE_LOCKING=y + DEBUG_LOCKDEP=y, I cannot
> reproduce the reboot issue; everything seems to work just fine.
> 
> Can you say which config you're using?
> 
> Just to check: are you using a pristine version of that tree, or do you have
> any vendor hooks present? I note that there are special hooks added to the
> cpuidle and PSCI code, and I can imagine those might expect the old behaviour
> w.r.t. RCU and idle, so ruling those out would help.

No reply to this since more than 10 days afaics, hence for now assuming
that this is not really a regression.

#regzbot inconclusive: another dev could not reproduce issue; reporter
MIA and might have used a patched tree
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
