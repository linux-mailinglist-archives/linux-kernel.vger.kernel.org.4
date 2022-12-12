Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B71764A80D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiLLTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLLTUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:20:44 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727AD62D2;
        Mon, 12 Dec 2022 11:20:43 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3AD81435CB;
        Mon, 12 Dec 2022 19:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670872837;
        bh=nfmDJk9u5lHB22nuwmkaPwBfTpLDhD42htZXhP6A1is=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=GGmUmnL6i1BLVav+qwWMNnVqeHLOcOSjxWp/EB37Cw/PRRR7lLuuiZxJk6Cqy8rQ4
         cCmlb69kxM4uxLQBfbSDyQdthsm2voGLdhMLaQmmu8/NnG1cQLvUjxdSZ5GBNu9mc4
         e+5IswbMMMvnmFW+SnjREeSUvVZlE/WO5Zl0ibxNve2ApRUuVX5tmg75jC67jQo/dF
         b/nEruDiCNd7ZvM9Z5KGmhQu+E8+9d3Vrp5f7FTJMWlDSoZ1wxPdcPMQgpJVBUqpT5
         lDoqIrC8B4QX7MN1hVNvRgI3INq6HjvZ2goifoTQ3vNDTsexsa9coPhFUvSdhjSOAG
         6pMILcEV/I38Q==
Message-ID: <9b21c055-4e1a-2c34-281c-39af7d73fe80@canonical.com>
Date:   Mon, 12 Dec 2022 11:20:32 -0800
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
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <0e678eb2-455c-88f5-6732-2e8701ebb6e6@linuxfoundation.org>
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

On 12/12/22 10:03, Shuah Khan wrote:
> On 12/12/22 10:52, Shuah Khan wrote:
>> Hi David,
>>
>> On 12/8/22 13:10, John Johansen wrote:
>>> On 12/7/22 18:53, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Today's linux-next merge of the kunit-next tree got a conflict in:
>>>>
>>>>    security/apparmor/policy_unpack.c
>>>>
>>>> between commits:
>>>>
>>>>    371e50a0b19f ("apparmor: make unpack_array return a trianary value")
>>>>    73c7e91c8bc9 ("apparmor: Remove unnecessary size check when unpacking trans_table")
>>>>    217af7e2f4de ("apparmor: refactor profile rules and attachments")
>>>> (and probably others)
>>>>
>>>> from the apparmor tree and commit:
>>>>
>>>>    2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
>>>>
>>>> from the kunit-next tree.
>>>>
>>>> This is somewhat of a mess ... pity there is not a shared branch (or
>>>> better routing if the patches).
>>>>
>>> sorry, there was a miscommunication/misunderstanding, probably all on me, I
>>> thought the kunit stuff that is conflicting here was going to merge next
>>> cycle.
>>>
>>
> 
> How about I just drop the following for now and handle this in the next cycle?

if you want, the other way to handle it is we coordinate our pull requests.
You go first. And then I will submit a little later in the week, with the
references to the merge conflict and a pointer to a branch with it resolved.
This isn't even a particularly tricky merge conflict, it just has the little
subtly around making sure the include symbols are conditional.

This doesn't affect me much as there is already another merge conflict with
the security tree that I need to deal with.

> I think it might be least confusing option. Let me know. I can just do that
> and then send pull request in a day or tow once things settle down in next.
> 
> 2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
> 

that is the other option. If you go that route I can help you do the rebase/merge
fix.

looking back at this, there wasn't anything explicit about this not going upstream
this cycle, I must have just assumed as the final version came about after rc7. So
my bad.

> thanks,
> -- Shuah

