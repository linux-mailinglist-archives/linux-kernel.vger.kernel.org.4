Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187BD6C7069
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjCWSny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCWSnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:43:51 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26D3FF08
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1679597029;
        bh=jeUin32YtQzZhhgIojdyXJmObzwf8N5YsZ3ueZarszs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gDOdm2Vjm/JaNMQ7zrD5+bEK6ZYbCkwTAAZdP9XbDXv8lq3yK/LOPyrOaEMf/vCeE
         YQzn7JV/+xa0kM+hCjh7/68oHrwFbWPdjW7sCijvVG7Ctt2PAlwws4LiYGYcLZPFPt
         npe4mNiXnYAiSKHDtwo8ib+c/p2exJPONFZfdnYYYDZ6rQDKE4DarTdH9NDPF8ILkj
         bO//72RwlBsWV9S84vtPDuI2dhZQaiRk/dahM15zDYzSW+O4igOiQI3UjNKA4yd/R4
         +tfvNDzcvCbWWs0n3pjao8BdA5fWsq+Lm9O4d2gp7yGntwlvYExsAL5tsMk2NWbvKA
         VLdGnqIee9ciQ==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PjDks5sXGzt3H;
        Thu, 23 Mar 2023 14:43:49 -0400 (EDT)
Message-ID: <79f7638e-bbeb-d959-6143-c678a8225459@efficios.com>
Date:   Thu, 23 Mar 2023 14:44:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tracepoint: Fix CFI failures with tp_stub_func
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230323114012.2162285-1-mark.rutland@arm.com>
 <20230323085321.0f8d1b98@gandalf.local.home>
 <ZBxX/uu/s5IKBQOw@FVFF77S0Q05N.cambridge.arm.com>
 <ZBx9+ZyiF6LoKbPr@FVFF77S0Q05N.cambridge.arm.com>
 <20230323123455.36dd83f6@gandalf.local.home>
 <ed29379c-d683-7140-ba82-b3fe8e4d49a5@efficios.com>
 <20230323144220.2729561c@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230323144220.2729561c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-23 14:42, Steven Rostedt wrote:
> On Thu, 23 Mar 2023 14:37:15 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> Repeated again so Mathieu doesn't have to search for it.
>>>
>>>       [ Note, this version does use undefined compiler behavior (assuming that
>>>         a stub function with no parameters or return, can be called by a location
>>>         that thinks it has parameters but still no return value. Static calls
>>>         do the same thing, so this trick is not without precedent.
>>>
>>>         There's another solution that uses RCU tricks and is more complex, but
>>>         can be an alternative if this solution becomes an issue.
>>>
>>>         Link: https://lore.kernel.org/lkml/20210127170721.58bce7cc@gandalf.local.home/
>>>       ]
>>
>> Ugh. The last thing we need there is more RCU complexity. My brain is still recovering
>> from fixing the last time the introduction of static calls special-cases ended up subtly
>> breaking tracepoints.
> 
> Well, we can go back to your approach with doing the check in the iterator.
> Setting it to 0x1UL I think is what you wanted (to know it's a removed
> function and not a random NULL).
> 
> I could write that up if you want.

I can write the patch and send an RFC, won't take long.

Thanks,

Mathieu

> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

