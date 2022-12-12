Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070FF64A84E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiLLTx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiLLTxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:53:10 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F8D11B;
        Mon, 12 Dec 2022 11:53:08 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 26C27435C6;
        Mon, 12 Dec 2022 19:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670874787;
        bh=VAbuQcMBJSaPAYyt7Kw8rKx/OVonYwUI4lQ3FIukyl8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jnIUsDVwhUCzT6FOj6jzLNF49yq/WShvpRWAVRBfsTDG4FTrsJVlzwx2G19t3481v
         BzO0vy0G0bFzm1+yPyJs881WGbQtEvFFyhKxEsS8OwQgov0e8S0vLZ5gt954KXl1qQ
         ukMqyAWCzy1g3P8XAtoaxXZopPZCe2Vo1IWZjhEGnbcDsSgp0n1bwI1lvfxgQKWBAp
         rNmPZL52E31+xMia00VdwiUuaQQhc34fFGg+zPvaoA5B4fMCnCVAm2eIWiVEf5r+yV
         W+BBH2BayI86Ez3kMYUFzsnhb/aN4ia1Jl+/rpNhe4GP0LUtmgafEw+W30ry813Vc8
         y9UNn5rItmLxA==
Message-ID: <c4560ccd-fad4-ecb9-4d57-64d94b5ebf30@canonical.com>
Date:   Mon, 12 Dec 2022 11:53:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: manual merge of the kunit-next tree with the apparmor
 tree
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rae Moar <rmoar@google.com>
References: <20221208135327.01364529@canb.auug.org.au>
 <bff89220-df3a-a148-2ba4-6aad3874f322@canonical.com>
 <8e82905f-8bdf-05de-2e6a-d8b896d75910@linuxfoundation.org>
 <0e678eb2-455c-88f5-6732-2e8701ebb6e6@linuxfoundation.org>
 <9b21c055-4e1a-2c34-281c-39af7d73fe80@canonical.com>
 <fa9145fe-9815-900f-6dd0-bf80019a319e@linuxfoundation.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <fa9145fe-9815-900f-6dd0-bf80019a319e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/22 11:48, Shuah Khan wrote:
> On 12/12/22 12:20, John Johansen wrote:
>> On 12/12/22 10:03, Shuah Khan wrote:
>>> On 12/12/22 10:52, Shuah Khan wrote:
>>>> Hi David,
>>>>
>>>> On 12/8/22 13:10, John Johansen wrote:
>>>>> On 12/7/22 18:53, Stephen Rothwell wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Today's linux-next merge of the kunit-next tree got a conflict in:
>>>>>>
>>>>>>    security/apparmor/policy_unpack.c
>>>>>>
>>>>>> between commits:
>>>>>>
>>>>>>    371e50a0b19f ("apparmor: make unpack_array return a trianary value")
>>>>>>    73c7e91c8bc9 ("apparmor: Remove unnecessary size check when unpacking trans_table")
>>>>>>    217af7e2f4de ("apparmor: refactor profile rules and attachments")
>>>>>> (and probably others)
>>>>>>
>>>>>> from the apparmor tree and commit:
>>>>>>
>>>>>>    2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
>>>>>>
>>>>>> from the kunit-next tree.
>>>>>>
>>>>>> This is somewhat of a mess ... pity there is not a shared branch (or
>>>>>> better routing if the patches).
>>>>>>
>>>>> sorry, there was a miscommunication/misunderstanding, probably all on me, I
>>>>> thought the kunit stuff that is conflicting here was going to merge next
>>>>> cycle.
>>>>>
>>>>
>>>
>>> How about I just drop the following for now and handle this in the next cycle?
>>
>> if you want, the other way to handle it is we coordinate our pull requests.
>> You go first. And then I will submit a little later in the week, with the
>> references to the merge conflict and a pointer to a branch with it resolved.
>> This isn't even a particularly tricky merge conflict, it just has the little
>> subtly around making sure the include symbols are conditional.
>>
> 
> I assume Linus will not see any problems without your pull requests. In which
> case we can do this:
> 
> - I send my pull request today
> - You can follow with yours with the fixes later on this week
> 

okay

>> This doesn't affect me much as there is already another merge conflict with
>> the security tree that I need to deal with.
>>
> 
> 
>>> I think it might be least confusing option. Let me know. I can just do that
>>> and then send pull request in a day or tow once things settle down in next.
>>>
>>> 2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
>>>
>>
>> that is the other option. If you go that route I can help you do the rebase/merge
>> fix.
>>
> 
> Let's go with your earlier suggestion.
> 

ack

>> looking back at this, there wasn't anything explicit about this not going upstream
>> this cycle, I must have just assumed as the final version came about after rc7. So
>> my bad.
>>
> 
> Right - I ended up taking this as it looked like a patch if included could
> enable other changes to follow without being blocked. Also rc8 was in plan.
> 

yeah, my bad

> thanks,
> -- Shuah

