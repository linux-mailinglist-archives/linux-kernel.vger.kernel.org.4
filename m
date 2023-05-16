Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48720704FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjEPNxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjEPNxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:53:36 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DFF7ED4;
        Tue, 16 May 2023 06:53:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pyv6s-0005No-Jr; Tue, 16 May 2023 15:53:02 +0200
Message-ID: <1f07cd1f-2553-9194-78d4-fcfbc1fd2abb@leemhuis.info>
Date:   Tue, 16 May 2023 15:53:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, guy.b@bluewin.ch
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info>
 <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info>
 <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684245187;2d7357ed;
X-HE-SMSGID: 1pyv6s-0005No-Jr
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.23 15:24, Bagas Sanjaya wrote:
> On 5/11/23 18:58, Thorsten Leemhuis wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>
>> On 08.05.23 11:55, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>>
>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>> kernel developers don't keep an eye on it, I decided to forward it by mail.
>>>
>>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217412 :
>>
>> TWIMC: a few other users (three or four iirc) showed up in that ticket
>> and reported problems with the receiver, albeit the symptoms are not
>> exactly the same for all of them, so there might be more than one problem.
>>
>> I'll try to motivate the affected users to perform a bisection. But
>> would be great if those with more knowledge about this code could
>> briefly look into the ticket, maybe the details the users shared allows
>> one of you to guess what causes this.
> 
> Hmm,
> 
> You noted in the similar report [1] that developers involved here
> ignore this regressions. I wonder if Linus has to be hired in
> this case, and if it is the case, let's take a look and hear closely what
> he will say.
> 
> [1]: https://lore.kernel.org/regressions/8941c5f2-3861-da68-06ca-adc68a37e53b@leemhuis.info/

You CCed him so maybe we'll learn soon.

I expect he doesn't like the situation, but at the same time I guess
there is nothing much he will do (which is why I do not CC him in cases
like this, unless they are urgent/severe or something like that).

That's because as far as I know in the end it is the duty of the
reporter(s) to find the the culprit.

Because in the end developers and subsystem maintainers are volunteers,
too -- and making them bisect each and every report would make the job
way to hard. And the question "which developer/subsystem maintainer
needs to perform the bisection" would often become quickly complicated
as well, as an issue in one area of the kernel can be caused by a change
in a totally different area (for file-systems that is way more likely
than for input drivers, but still). Not to mention that developer and
subsystem maintainers might not even have the environment at hand to
reproduce the issue.

That being said: I think a quick "We looked into these three reports
that might be related, but we have no idea what might cause this;
somebody needs to bisect things" from one of the involved
developers/maintainers would have been nice (appropriate?).

Ciao, Thorsten
