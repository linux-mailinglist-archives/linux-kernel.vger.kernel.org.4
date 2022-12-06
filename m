Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C83643D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiLFG15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiLFG1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:27:55 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34E01AF3B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:27:49 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p2RQh-0006r1-N5; Tue, 06 Dec 2022 07:27:47 +0100
Message-ID: <bba95554-19a0-d548-d63c-811b229cbca0@leemhuis.info>
Date:   Tue, 6 Dec 2022 07:27:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US, de-DE
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
 <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
 <25f4838b-208a-cf8c-914c-b2092665d56f@leemhuis.info>
 <23a61dd072ee1d2cc5b54281b0a9dc13e01aa0b8.camel@perches.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
In-Reply-To: <23a61dd072ee1d2cc5b54281b0a9dc13e01aa0b8.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1670308069;9a73765e;
X-HE-SMSGID: 1p2RQh-0006r1-N5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.22 06:54, Joe Perches wrote:
> On Tue, 2022-12-06 at 05:55 +0100, Thorsten Leemhuis wrote:
>> On 06.12.22 02:02, Joe Perches wrote:
>>> On Mon, 2022-12-05 at 13:14 -0800, Andrew Morton wrote:
>>>> Begin forwarded message:
>>>>
>>>> Date: Sun,  4 Dec 2022 12:33:37 +0100
>>>> From: Kai Wasserbäch <kai@dev.carbon-project.org>
>>>> To: linux-kernel@vger.kernel.org
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>, Thorsten Leemhuis <linux@leemhuis.info>
>>>> Subject: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn about missing Link:
>>>>
>>>> Thorsten Leemhuis suggested the following two changes to checkpatch, which
>>>> I hereby humbly submit for review. Please let me know if any changes
>>>> would be required for acceptance.
>>> [...]
>>>> Suggested-by: Thorsten Leemhuis <linux@leemhuis.info>
>>>> Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
>>>>
>>>> Kai Wasserbäch (2):
>>>>   feat: checkpatch: error on usage of a Buglink tag in the commit log
>>>
>>> Why, what's wrong with a buglink reference?
>>
>> Long story short: Linus doesn't like it:
>
> [...]
>
>> All of that obviously should have been in patch description. Let me
>> resubmit that patch with all of that in there, or are you dead against
>> this idea now?
> 
> No, better commit description would be useful

I'll prepare something.

> and perhaps a more
> generic, "is the thing in front of a URI/URL" a known/supported entry,
> instead of using an known invalid test would be a better mechanism.

Are you sure about that? It's not that I disagree completely, but it
sounds overly restrictive to me and makes it harder for new tags to
evolve in case we might want them.

And what tags would be on this allow-list? Anything else then "Link" and
"Patchwork"? Those are the ones that looked common and valid to me when
I ran

git log --grep='http' v4.0.. | grep http | grep -v '    Link: ' | less

and skimmed the output. Maybe "Datasheet" should be allowed, too -- not
sure.

But I found a few others that likely should be on the disallow list:
"Closes:", "Bug:", "Gitlab issue:", "References:", "Ref:", "Bugzilla:",
"RHBZ:", and "link", as "Link" should be used instead in all of these
cases afaics.

>>>>   feat: checkpatch: Warn about Reported-by: not being followed by a
>>>>     Link:
>>>
>>> I think this is unnecessary.
>>
>> I expect this to cause more discussion, which is why this should be in a
>> separate submission. But in the end the reasons are similar as above:
>> (1) Linus really want to see those links to make things easier for
>> future code archeologists. (2) My regression tracking efforts heavily
>> rely on those Links, as they allow to automatically connect reports with
>> patches and commits to fix the reported regression; without those the
>> tracking is a PITA and doesn't scale.
>>
>> Together that IMHO is strong enough reason to warn in this case.
> 
> Maybe, I think there might be some value in not intermixing signature
> tags and other tags though.

Hmm, sorry, not sure if I understood you here. Why do you consider
"Reported-by:" a signature tag? Isn't it more of an "appreciation" tag,
IOW, a kind of 'thank you' hat tip to the reporter?

Ciao, Thorsten
