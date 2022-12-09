Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482A1648073
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLIJza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiLIJzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:55:04 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D2C59FDD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:54:58 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p3a5o-0001pj-A2; Fri, 09 Dec 2022 10:54:56 +0100
Message-ID: <c0f9e6d8-d402-df54-475d-0552dd5576dd@leemhuis.info>
Date:   Fri, 9 Dec 2022 10:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US, de-DE
To:     Joe Perches <joe@perches.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
 <4af6cd7f0833f18e9eee8caba1913e682c5ec071.1670527774.git.kai@dev.carbon-project.org>
 <3953eb4913bf9b5610854624c4c632e710cd1ec9.camel@perches.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 2/2] checkpatch: warn when Reported-by: is not followed by
 Link:
In-Reply-To: <3953eb4913bf9b5610854624c4c632e710cd1ec9.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1670579698;f7c81136;
X-HE-SMSGID: 1p3a5o-0001pj-A2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.12.22 21:21, Joe Perches wrote:
> On Thu, 2022-12-08 at 20:32 +0100, Kai Wasserbäch wrote:
>> Encourage patch authors to link to reports by issuing a warning, if
>> a Reported-by: is not accompanied by a link to the report. Those links
>> are often extremely useful for any code archaeologist that wants to know
>> more about the backstory of a change than the commit message provides.
>> That includes maintainers higher up in the patch-flow hierarchy, which
>> is why Linus asks developers to add such links [1, 2, 3]. To quote [1]:
>>
>>> Again, the commit has a link to the patch *submission*, which is
>>> almost entirely useless. There's no link to the actual problem the
>>> patch fixes.
>>>
>>> [...]
>>>
>>> Put another way: I can see that
>>>
>>> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
>>>
>>> in the commit, but I don't have a clue what the actual report was, and
>>> there really isn't enough information in the commit itself, except for
>>> a fairly handwavy "Device drivers might, for instance, still need to
>>> flush operations.."
>>>
>>> I don't want to know what device drivers _might_ do. I would want to
>>> have an actual pointer to what they do and where.
>>
>> Another reason why these links are wanted: the ongoing regression
>> tracking efforts can only scale with them, as they allow the regression
>> tracking bot 'regzbot' to automatically connect tracked reports with
>> patches that are posted or committed to fix tracked regressions.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3144,6 +3144,20 @@ sub process {
>>  					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
> 
> I believe this use of '"$here\n" . $rawline . "\n"' to be a defect.
> I think this should just use $herecurr
> 
> And the unnecessary space before a newline is an abomination ;)
> 
>   					     "Co-developed-by and Signed-off-by: name/email do not match\n" . $herecurr . $rawlines[$linenr]);

Well, that's existing code. Want me to add a separate patch that fixes
both of these aspects up in that area?

>> +
>> +			# check if Reported-by: is followed by a Link:
>> +			if ($sign_off =~ /^reported-by:$/i) {
>> +				if (!defined $lines[$linenr]) {
>> +					WARN("BAD_REPORTED_BY_LINK",
>> +					     "Reported-by: should be immediately followed by Link: to the report\n" . "$here\n" . $rawline);
>> +				} elsif ($rawlines[$linenr] !~ /^\s*link:\s*(.*)/i) {
>> +					WARN("BAD_REPORTED_BY_LINK",
>> +					     "Reported-by: should be immediately followed by Link: to the report\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
>> +				} elsif ($lines[$linenr] !~ /https?:\/\//i) {
>> +					WARN("BAD_REPORTED_BY_LINK",
>> +					     "Link: following Reported-by: should contain an URL\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
> 
> Please use a space before and after a string concatenation '.'

Okay, went with " . $herecurr . $rawlines[$linenr]" here, the result
seems to be the same afaics.

> English generally uses "a URL" and not "an URL"
> https://www.techtarget.com/whatis/feature/Which-is-correct-a-URL-or-an-URL

Thx!

/me grumbles, he should have remembered that

Ciao, Thorsten
