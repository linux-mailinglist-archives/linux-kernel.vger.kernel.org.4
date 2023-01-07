Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328D3660F57
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjAGOJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjAGOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:08:56 -0500
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CAEB1C3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 06:08:54 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id E9sRpKyqPRTYIE9sRpsN7c; Sat, 07 Jan 2023 15:08:53 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Jan 2023 15:08:53 +0100
X-ME-IP: 86.243.100.34
Message-ID: <340cf324-29a1-a0c4-638d-b820f6cb3473@wanadoo.fr>
Date:   Sat, 7 Jan 2023 15:08:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] tracing/eprobe: Replace kzalloc with kmalloc
Content-Language: fr
To:     Quanfa Fu <quanfafu@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230107034557.1156022-1-quanfafu@gmail.com>
 <30dd32b4-cd74-77a1-d9ad-84e361680dac@wanadoo.fr>
 <CAM4UoyqAGUbLaaoDyvFSTKvgpq9Oz7HuxKLMf3ryOsjHofcpVw@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAM4UoyqAGUbLaaoDyvFSTKvgpq9Oz7HuxKLMf3ryOsjHofcpVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 07/01/2023 à 13:23, Quanfa Fu a écrit :
> On Sat, Jan 7, 2023 at 4:42 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Le 07/01/2023 à 04:45, Quanfa Fu a écrit :
>>> Since this memory will be filled soon below, I feel that there is
>>> no need for a memory of all zeros here. 'snprintf' does not return
>>> negative num according to ISO C99, so I feel that no judgment is
>>> needed here.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
>>> ---
>>>    kernel/trace/trace_eprobe.c | 4 +---
>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
>>> index 352b65e2b910..cd1d271a74e7 100644
>>> --- a/kernel/trace/trace_eprobe.c
>>> +++ b/kernel/trace/trace_eprobe.c
>>> @@ -917,15 +917,13 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
>>>        for (i = 0; i < argc; i++)
>>>                len += strlen(argv[i]) + 1;
>>>
>>> -     ep->filter_str = kzalloc(len, GFP_KERNEL);
>>> +     ep->filter_str = kmalloc(len, GFP_KERNEL);
>>>        if (!ep->filter_str)
>>>                return -ENOMEM;
>>>
>>>        p = ep->filter_str;
>>>        for (i = 0; i < argc; i++) {
>>>                ret = snprintf(p, len, "%s ", argv[i]);
>>> -             if (ret < 0)
>>> -                     goto error;
>>>                if (ret > len) {
>>
> 
> I think that:
> 
> for example, argc = 2, argv = {"a", "b"};
> 
> Before the loop
> ===============
> len = (1 + 1) + (1 + 1) = 4;
> ep->filter_str = 0x00 0x00 0x00 0x00
>                         ^
>                          |__ p
> 
> After the loop:
> ===============
> i = 1, snprintf write: 'a' and ' ', so ret = 2
> i = 2, snprintf write: 'b' and ' ', so ret = 2
> ===============

Ok, I missed the space after the %s.

Sorry for the noise.

>   Since the length of the last argv is not enough
> to write, the space is replaced by null
> 
> ep->filter_str = 0x61 0x20 0x62 0x00
>                                                            ^
>                                                            |__ p
> p = ep->fiter_str + 2 (ret1) +2 (ret2) = ep->filter_str + 4
> ===============
> so After p[-1] = *(ep->filter_str + 3) = '\0';
> ep->filter_str = 0x61 0x20 0x62 0x00
> 
> According to ISO C99: " If the output was truncated due to this limit
> then the return value is the number of characters (excluding the
> terminating null byte) which would have been written to the final
> string if enough  space  had been available"
> 
> The last snprintf will end with 'NULL', so I think p[-1] = '\0' can
> also be deleted

Hmm, now that I see it, I think that it is there to remove the last 
space (even if there shouldn't be any because the last snprintf will be 
truncated).

Code LGTM as-is, even if puzzling.

CJ

> 

