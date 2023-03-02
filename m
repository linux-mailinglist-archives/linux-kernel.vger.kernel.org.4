Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363566A7AC3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 06:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCBFR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 00:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCBFR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 00:17:28 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD3C303ED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 21:17:26 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pXbJi-0001gV-Us; Thu, 02 Mar 2023 06:17:22 +0100
Message-ID: <ff62632d-7558-a86c-5541-a54de6e107e7@leemhuis.info>
Date:   Thu, 2 Mar 2023 06:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <cover.1674217480.git.linux@leemhuis.info>
 <bb5dfd55ea2026303ab2296f4a6df3da7dd64006.1674217480.git.linux@leemhuis.info>
 <20230301204602.5e9bf3c0@kernel.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v4 2/3] checkpatch: warn when Reported-by: is not followed
 by Link:
In-Reply-To: <20230301204602.5e9bf3c0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1677734246;f3fbfcfd;
X-HE-SMSGID: 1pXbJi-0001gV-Us
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.23 05:46, Jakub Kicinski wrote:
> On Fri, 20 Jan 2023 13:35:19 +0100 Thorsten Leemhuis wrote:
>> From: Kai Wasserbäch <kai@dev.carbon-project.org>
>>
>> Encourage patch authors to link to reports by issuing a warning, if
>> a Reported-by: is not accompanied by a link to the report. Those links
>> are often extremely useful for any code archaeologist that wants to know
>> more about the backstory of a change than the commit message provides.
>> That includes maintainers higher up in the patch-flow hierarchy, which
>> is why Linus asks developers to add such links [1, 2, 3]. To quote [1]:
> 
> Is it okay if we exclude syzbot reports from this rule?
> If full syzbot report ID is provided - it's as good as a link. 

Hmmm. Not sure. Every special case makes things harder for humans and
software that looks at a commits downstream. Clicking on a link also
makes things easy for code archaeologists that might look into the issue
months or years later (which might not even know how to find the report
and potential discussions on lore from the syzbot report ID).

Hence, wouldn't it be better to ask the syzbot folks to change their
reporting slightly and suggest something like this instead in their
reports (the last line is the new one):

```
IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bba886ab504fcafecafe@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/cafecaca0cafecaca0cafecaca0@google.com/
```

This might not be to hard if they known the message-id in advance. Maybe
they could even use the syzbot report ID as msg-id to make things even
easier. And for developers not much would change afaics, they just need
to copy and paste two lines instead of one.

> And regression tracking doesn't seem to happen much on syzbot 
> reports either.

Yeah, right now I most of the time stay away from CI reports and leave
the tracking to the people that run the CI (unless it's something I
consider worth tracking), but I hope that might change over time to have
things in one place.

> I like the addition otherwise, it's already catching missing links 
> in netdev land!

Thx for saying this!

Ciao, Thorsten
