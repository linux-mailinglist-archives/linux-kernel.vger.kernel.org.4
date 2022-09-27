Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0395EBF97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiI0KUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiI0KUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:20:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C31AADCC5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:20:19 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1od7hJ-0000hh-P0; Tue, 27 Sep 2022 12:20:17 +0200
Message-ID: <e00c6eed-da22-7859-d660-a16af6280844@leemhuis.info>
Date:   Tue, 27 Sep 2022 12:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Content-Language: en-US, de-DE
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        vschneid@redhat.com, kernel-team@android.com,
        Derek Dolney <z23@posteo.net>, peterz@infradead.org
References: <20220725095952.206884-1-vdonnefort@google.com>
 <b5c5b02d-85ca-9d3b-2b3d-8892ab6d22a7@leemhuis.info>
 <42237005-5a6e-9462-bfdd-f1ba0c725c72@leemhuis.info>
 <YzLLBBRiwuQnD2zc@google.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YzLLBBRiwuQnD2zc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664274019;2530b15d;
X-HE-SMSGID: 1od7hJ-0000hh-P0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.22 12:05, Vincent Donnefort wrote:
> On Tue, Sep 20, 2022 at 11:59:06AM +0200, Thorsten Leemhuis wrote:
>> On 17.08.22 11:46, Thorsten Leemhuis wrote:
>>>
>>> On 25.07.22 11:59, Vincent Donnefort wrote:
>>>> The DYING/STARTING callbacks are not expected to fail. However, as reported
>>>> by Derek, drivers such as tboot are still free to return errors within
>>>> those sections, which halts the hot(un)plug and leaves the CPU in an
>>>> unrecoverable state.
>>>>
>>>> No rollback being possible there, let's only log the failures and proceed
>>>> with the following steps. This restores the hotplug behaviour prior to
>>>> commit 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
>>>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867
>>>> Fixes: 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
>>>> Reported-by: Derek Dolney <z23@posteo.net>
>>>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>>>> Tested-by: Derek Dolney <z23@posteo.net>
>>>
>>> What's the status here? Did that patch to fixing a regression fall
>>> through the cracks? It looks like nothing happened for 3 weeks now,
>>> that's why I wondered, but maybe I missed something.
>>
>> Hmm, Vincent seems to be MIA, at least I see no recent messages from him
>> on lore. Odd. But well, it's still a fix for a regression and it's up to
>> v5 already; Valentin already added his Reviewed-by, too. Would be a
>> shame to waste this.
>>
>> Thomas, could you maybe take a look at the patch?  Maybe we're lucky and
>> the patch is already good to go...
> 
> AFAIK, this patch is still valid.

Great, thx for confirming!

> I don't think I do have any further action on
> that though.

Well, it seems in this case someone needs to knock on some doors to get
the maintainers to look at this fix to finally get the regression
resolved, as it seems they haven't looked closely at the patch for good
or bad reasons. I hope this mail exchange was enough to get things
rolling again, otherwise we sooner or later we have to get Linus
involved. :-/

Ciao, Thorsten
