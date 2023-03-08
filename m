Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F366B06FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCHMXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCHMXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:23:12 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26D97FF1;
        Wed,  8 Mar 2023 04:22:37 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pZsnK-0004qN-E3; Wed, 08 Mar 2023 13:21:22 +0100
Message-ID: <2246a9d5-789d-08c9-f6a7-fb9db2edfe9f@leemhuis.info>
Date:   Wed, 8 Mar 2023 13:21:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
Content-Language: en-US, de-DE
To:     Felix Fietkau <nbd@nbd.name>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Mann <rauchwolke@gmx.net>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
 <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
 <6025e17e-4c29-6d36-6b9c-2fec543b21c4@wetzel-home.de>
 <debc7fe9-204d-63a7-aa61-91b20a46f385@wetzel-home.de>
 <4a02173f-3a60-0a7e-8962-3778e6c55bf3@nbd.name>
 <cfa5cc30-bf5a-bffd-4c2f-eec8a6522dd5@wetzel-home.de>
 <42185fa2-4191-fcf5-9c0f-fd7098bb856b@nbd.name>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <42185fa2-4191-fcf5-9c0f-fd7098bb856b@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678278158;2212533a;
X-HE-SMSGID: 1pZsnK-0004qN-E3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.23 12:57, Felix Fietkau wrote:
> On 08.03.23 12:41, Alexander Wetzel wrote:
>> On 08.03.23 08:52, Felix Fietkau wrote:
>>>> I'm also planning to provide some more debug patches, to figuring out
>>>> which part of commit 4444bc2116ae ("wifi: mac80211: Proper mark iTXQs
>>>> for resumption") fixes the issue for you. Assuming my understanding
>>>> above is correct the patch should not really fix/break anything for
>>>> you...With the findings above I would have expected your git bisec to
>>>> identify commit a790cc3a4fad ("wifi: mac80211: add wake_tx_queue
>>>> callback to drivers") as the first broken commit...
>>> I can't point to any specific series of events where it would go
>>> wrong, but I suspect that the problem might be the fact that you're
>>> doing tx scheduling from within ieee80211_handle_wake_tx_queue. I
>>> don't see how it's properly protected from potentially being called
>>> on different CPUs concurrently.
>>> Back when I was debugging some iTXQ issues in mt76, I also had
>>> problems when tx scheduling could happen from multiple places. My
>>> solution was to have a single worker thread that handles tx, which is
>>> scheduled from the wake_tx_queue op.
>>> Maybe you could do something similar in mac80211 for non-iTXQ drivers.
>> I think it's already doing all of that:
>> ieee80211_handle_wake_tx_queue() is the mac80211 implementation for the
>> wake_tx_queue op. The drivers without native iTXQ support simply link it
>> to this handler.
> I know. The problem I see is that I can't find anything that guarantees
> that .wake_tx_queue_op is not being called concurrently from multiple
> different places. ieee80211_handle_wake_tx_queue is doing the scheduling
> directly, instead of deferring it to a single workqueue/tasklet/thread,
> and multiple concurrent calls to it could potentially cause issues.

Alexander, Felix, many thx for looking into this.

This more and more sounds like something that might take a while to get
fixed, which makes it harder to get this fixed within those time-frames
Documentation/process/handling-regressions.rst outlines. So please allow
me to ask:

Is reverting the culprit (and reapplying it later once the real cause is
found and fixed) an option, or would that cause other regressions?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
