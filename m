Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192671396C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjE1MVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 08:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1MVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 08:21:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C34B6;
        Sun, 28 May 2023 05:21:12 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q3FOT-0003Co-9K; Sun, 28 May 2023 14:21:05 +0200
Message-ID: <746720e5-318c-6d9e-2d5a-a6ebf6b4b0c6@leemhuis.info>
Date:   Sun, 28 May 2023 14:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
Content-Language: en-US, de-DE
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, guy.b@bluewin.ch
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info>
 <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info>
 <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com>
 <CAO-hwJ+At1J_yUpX2q_dJekzZ-PoTDAvxmkTk_e4Yu0Z338bEA@mail.gmail.com>
 <55dda0bb-fe42-6dee-28ea-00121554d092@leemhuis.info>
 <CAHk-=whvhkSk6m8_AidhofgR9nq0Md+HbNad5r1RE69tZgbv6Q@mail.gmail.com>
 <nycvar.YFH.7.76.2305231422180.29760@cbobk.fhfr.pm>
 <CAO-hwJ+MTRu9KxqwQc7UYFBsa0kkrnYfwVB30KsLZnw=wfcOMg@mail.gmail.com>
 <nycvar.YFH.7.76.2305251308471.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2305262040330.29760@cbobk.fhfr.pm>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <nycvar.YFH.7.76.2305262040330.29760@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685276472;91502ff5;
X-HE-SMSGID: 1q3FOT-0003Co-9K
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.23 20:41, Jiri Kosina wrote:
> On Thu, 25 May 2023, Jiri Kosina wrote:
> 
>>>>> That bug is pre-existing (ie the problem was not introduced by that
>>>>> commit), but who knows if the retry makes things worse (ie if it then
>>>>> triggers on a retry, the response data will be the *previous* response).
>>>>>
>>>>> The whole "goto exit" games should be removed too, because we're in a
>>>>> for-loop, and instead of "goto exit" it should just do "break".
>>>>>
>>>>> IOW, something like this might be worth testing.
>>>>>
>>>>> That said, while I think the code is buggy, I doubt this is the actual
>>>>> cause of the problem people are reporting. But it would be lovely to
>>>>> hear if the attached patch makes any difference, and I think this is
>>>>> fixing a real - but unlikely - problem anyway.
>>>
>>> FWIW, Linus, your patch is
>>> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>
>>> Feel free to submit it to us or to apply it directly if you prefer as
>>> this is clearly a fix for a code path issue.
>>
>> It would be nice to hear from the people who were able to reproduce the 
>> issue whether this makes any observable difference in behavior though. I 
>> don't currently think it would, as it fixes a potential NULL pointer 
>> dereference, which is not what has been reported.
>>
>> Has anyone of the affected people tried to bisect the issue?
> 
> Could anyone

Reminder: a lot of the affected users can only be reached through the
bugzilla ticket (https://bugzilla.kernel.org/show_bug.cgi?id=217412 )
that made me start this thread. Sorry for this mess, but I can't simply
CC them because on account creation users are told that the "email
address will never be displayed to logged out users". Bugbot will
hopefully soon make this sort of problems history.

> who is able to reproduce the issue please check whether 
> reverting
> 
> 	586e8fede7953b16 ("HID: logitech-hidpp: Retry commands when device is busy")
> 
> has any observable effect?

See https://bugzilla.kernel.org/show_bug.cgi?id=217412#c26 and later –
it at least solved the problem for one user.

But it's all a mess (at least afaics). Earlier in that ticket some other
user said things work with 6.4-rc kernel, while for another confirmed
things are still broken. So maybe we deal with more than one problem. Or
testing went sideways for some of the users.

Ciao, Thorsten
