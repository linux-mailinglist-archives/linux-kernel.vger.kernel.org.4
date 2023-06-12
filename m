Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5596872CB02
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjFLQID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjFLQH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:07:58 -0400
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670A130
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:07:55 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 8k5AqyVHYzrnG8k5AqvqoC; Mon, 12 Jun 2023 18:07:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1686586073; bh=C9lVHEipiO2rrCzzjQikvmaiVgb86Ugo7xwo8BBwLEI=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=dI9xtEsx7I/q9LipVhMy6AeyMKy9t2iBAgqNv2sUxFgbpW/3AYk2vQtS7lnzubwY5
         h12p3zCn5000JWTMUIqviOv29aWdAjO/exAecYuUEOAaDA7YrzAKw9jOLoVWwEADfX
         G5jaFMwReCVppn7n+re2gsD/axYNJDFSZtw660gSlxOqgHZxLGvSyEXvRBN7lbAZii
         wWFSrbjDruGTttqbTZeqmiPjNZVqZRrNlqWJglXhgB6y5fiRULESCkY/buv1X0nI62
         akdc2mrMa1F2ZMZXZFq20U4SRmtrrod5aPXAjuS7iySkSzd9fUNqs2UqdLPvuMt8ja
         9c+SexGH/zszA==
Message-ID: <5aff32cf-74ea-b632-9d4d-a01ca0d31821@enneenne.com>
Date:   Mon, 12 Jun 2023 18:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] pps: Increase PPS_MAX_SOURCES value.
Content-Language: en-US
To:     Charlie Johnston <charlie.johnston@ni.com>
Cc:     linux-kernel@vger.kernel.org, brenda.streiff@ni.com
References: <20230605203147.694716-1-charlie.johnston@ni.com>
 <fe435e68-8e05-9078-0fe6-63ef7cce2fc9@enneenne.com>
 <b794bccc-0233-4d78-df6f-bf7c688a7d7d@ni.com>
 <70ce864c-ca13-4fc4-fcb5-9b7f91579a90@enneenne.com>
 <38f38f66-0fd5-4e6c-4839-8272cef77046@ni.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <38f38f66-0fd5-4e6c-4839-8272cef77046@ni.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNHoWjjsDpVkUmd/TjHXIrjmHcri4vNat0TGanoRsRoOMzkR5nrRHbQGIHBudJwgES0nT2Rnxgqcr2dPao7ZocMFC3jp7JzSO/wJNwtMI0emnN1GUHC6
 Vquc8MCzBQ9WoP5vhtdyDxB2ii3AuWzu6VhRV2Yy6lGORcGejJsHYuf54YhTeEaYzgvQt19webGzA7F+5XhBt4hYTyx591gwvJQP+408o/Hva2KBVGSjH4Tu
 4U6l0H58wBhejizaqu/Fxc2DAKFpjOpAFplm2anCLGk=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 23:00, Charlie Johnston wrote:
> On 6/9/23 02:30, Rodolfo Giometti wrote:
>> On 08/06/23 00:07, Charlie Johnston wrote:
>>> On 6/7/23 02:33, Rodolfo Giometti wrote:
>>>> On 05/06/23 22:31, Charlie Johnston wrote:
>>>>> For consistency with what ptp uses for minors, this
>>>>> change sets PPS_MAX_SOURCES to MINORMASK + 1.
>>>>>
>>>>> The PPS_MAX_SOURCES value is currently set to 16. In
>>>>> some cases this was not sufficient for a system. For
>>>>> example, a system with multiple (4+) PCIe cards each
>>>>> with 4 PTP-capable ethernet interfaces could run out
>>>>> of the available PPS major:minors if each interface
>>>>> registers a PPS source.
>>>>>
>>>>> Signed-off-by: Charlie Johnston <charlie.johnston@ni.com>
>>>>> ---
>>>>>     include/uapi/linux/pps.h | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>>>>> index 009ebcd8ced5..85f472330da8 100644
>>>>> --- a/include/uapi/linux/pps.h
>>>>> +++ b/include/uapi/linux/pps.h
>>>>> @@ -26,7 +26,7 @@
>>>>>     #include <linux/types.h>
>>>>>       #define PPS_VERSION        "5.3.6"
>>>>> -#define PPS_MAX_SOURCES        16        /* should be enough... */
>>>>> +#define PPS_MAX_SOURCES        (MINORMASK + 1)
>>>>>       /* Implementation note: the logical states ``assert'' and ``clear''
>>>>>      * are implemented in terms of the chip register, i.e. ``assert''
>>>>
>>>> I have just one question: are you sure that it's safe to call idr_alloc(..., 0, (MINORMASK + 1), ...)?
>>>>
>>>> Ciao,
>>>>
>>>> Rodolfo
>>>>
>>>
>>> Thanks for taking a look!
>>>
>>> My understanding is that idr_alloc(..., start, end, ...) can take any end value up to INT_MAX. It also handles any values <= 0 by treating them as equal to INT_MAX + 1 since the end value is non-inclusive. I can't think of any reason using MINORMASK + 1 here would be an issue since it's much less than the maximum value idr_alloc() allows.
>>>
>>> A number of drivers (e.g. ptp) just explicitly use a start and end value of 0, but I don't think that change would fit here.
>>
>> I see and maybe I should replace the usage of idr_*() with ida_*() as PTP does...
>>
>> However the right-thing(TM) to do here should be dropping PPS_MAX_SOURCES at all!
>>
>> Let me go deeper in this issue. I'm going to produce a patch set in next days. Have you any chances to test it?
>>
>> Ciao,
>>
>> Rodolfo
>>
> MINORMASK
> I'll have to check when the system we used for testing is available again (not easy to find a system with 20+ Ethernet ports) but I'd be happy to test a patch!

Great! Please, let me know.

> I know an increase to PPS_MAX_SOURCES was tested on that system.

I see and it seems that it's safer to set PPS_MAX_SOURCES to MINORMASK... so 
please reproduce your patch with this simple modification, then I'm going to 
produce a patch to drop the PPS_MAX_SOURCES define since it's not needed anymore.

After that you should test all these modifications in order to safely add them 
to Linux.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

