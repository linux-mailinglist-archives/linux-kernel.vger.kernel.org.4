Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44C1664CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjAJT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjAJT5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:57:25 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B21B03;
        Tue, 10 Jan 2023 11:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673380641;
        bh=RQq5pu5NWub8ZqozppXi0p7iitw87/LUUigchFQmVxY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ZrJz3/ygqAAvdb+rxMPc57zL4/R+16kGs6Yc35HYlJ0tuzi1rkRMFnyQ5uMywQrLf
         S8OuIaIFSwdvjO/k6iA62+tpYgdcbCmAJvWs92mlTxjP0EDJAaVbaQodjA80712XwM
         g7io7vCkC4zHnh37ViW69A3D2PoOKfH+tKEvBiHHSxGdfJDR4JfXbInX1wwEebZXcl
         D6Xx396Oj98onEM41owiZi3PnID968DtwVGNob4uYk/5K5YfkPPjwtiZ1NtW5usybE
         tqJhBiI09kAl5mo1A6thynwyPqGrTxVfPvNcyZqJB6jDaBDtYEo1HHhN0TwkckSDcK
         Qz0uvGVBye8xQ==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Ns1mx5bzrzg3s;
        Tue, 10 Jan 2023 14:57:21 -0500 (EST)
Message-ID: <57e095f5-2cf8-3f9a-0765-86990b4c1873@efficios.com>
Date:   Tue, 10 Jan 2023 14:57:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: rseq(2) man page
Content-Language: en-US
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, paulmck <paulmck@kernel.org>
References: <095c479b-baed-9d11-08a1-e698f59763d9@efficios.com>
 <425ddf00-24a1-bf02-29f1-937ba1545020@gmail.com>
 <71b43f20-5d6d-f3f8-b3cd-786dfbc8d34d@gmail.com>
 <c8cb6136-6924-4fae-f4bb-981dec2e1952@efficios.com>
 <71e6728d-c2a8-e646-5c6c-2de8dfa982cc@gmail.com>
 <c21ca3d7-9095-5613-5953-7870d9a6c23f@efficios.com>
 <71ea2fa3-e593-e1ae-7abd-377bdf302d24@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <71ea2fa3-e593-e1ae-7abd-377bdf302d24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-10 14:28, Alejandro Colomar wrote:
> 
> 
> On 1/10/23 17:54, Mathieu Desnoyers wrote:
> 

> 
> [...]
> 
>>>> .BI "int syscall(SYS_rseq, struct rseq *_Nullable " rseq ", uint32_t 
>>>> " rseq_len \
>>>
>>> What's the meaning for NULL?  Does it have a valid sentinel meaning, 
>>> or is it an invalid address?  If it's just interpreted as an invalid 
>>> address (for which from a user-space perspective a crash would be 
>>> legitimate), then I'd remove _Nullable.
>>
>> With the flags that are currently implemented (0 or 
>> RSEQ_FLAG_UNREGISTER),
>> the rseq argument is not expected to be legitimately NULL (it would 
>> return
>> -1, errno=EFAULT on registration, or -1, errno=EINVAL on unregister 
>> attempt).
>>
>> We may add new flags in the future which would not care about the rseq 
>> address
>> (it could very well be null then). Do you recommend that we only add the
>> _Nullable tag when this occurs ?
> 
> Yes; since it's what the user can pass, it makes sense to be as 
> constrained as possible.  If it were some return that the user would 
> have to inspect, it would make sense to be cautious on the NULL side of 
> things an use _Nullable preventively, but for an input, non-null is 
> preferred for now.

OK, updated.

> 
> 
> [...]
> 
>>
>> Updated version based on your comments pushed into my repo, thanks!
> 
> Cool! I'll have a look.

Thanks! Once you find it to your liking, I plan to sent it as a patch 
against the man-pages project.

Mathieu

> 
> Cheers,
> 
> Alex
> 
>>
>> Mathieu
>>
>>
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

