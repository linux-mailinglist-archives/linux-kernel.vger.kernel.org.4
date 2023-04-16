Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282AB6E386F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjDPMxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjDPMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:53:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40DA98;
        Sun, 16 Apr 2023 05:53:04 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1po1sJ-0000Ha-VW; Sun, 16 Apr 2023 14:53:00 +0200
Message-ID: <2d9b786b-ed1f-0687-ea6f-575faa6036a3@leemhuis.info>
Date:   Sun, 16 Apr 2023 14:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [regression] Bug 217069 - Wake on Lan is broken on r8169 since
 6.2
Content-Language: en-US, de-DE
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bob Moore <robert.moore@intel.com>,
        acpica-devel@lists.linuxfoundation.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
References: <e6aaddb9-afec-e77d-be33-570f9f10a9c2@leemhuis.info>
 <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info>
 <13aea525-108a-e018-987d-2447ff1d42df@leemhuis.info>
 <754225a2-95a9-2c36-1886-7da1a78308c2@loongson.cn>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <754225a2-95a9-2c36-1886-7da1a78308c2@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681649584;5b8dbad5;
X-HE-SMSGID: 1po1sJ-0000Ha-VW
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.23 14:35, Jianmin Lv wrote:
> From the feedbacks, the WOL issue has been fixed, and I have submitted a
> fixed patch to ACPICA, which has been reviewing in last week (Rafael
> also looked into the fixed patch).

Great, many thx. I looked for something like that, but failed to find it.

FWIW, a link to the patch submission would have been nice. I tried to
find it just now, but maybe it's not on lore.kernel.org or I did
something stupid. And
https://lists.linuxfoundation.org/pipermail/acpica-devel/ seems to lack
behind or might not be the list you submitted the patch to. Whatever.

> There are two kinds of issues in the bug, one is WOL failed in kexec
> reboot, another is WOL failed in cold reboot. The former one still exist
> after reverted patch(5c62d5aab8752e5ee7bfbe75ed6060db1c787f98),
> so this issue is not caused by the reverted patch. The second is caused
> by the reverted patch, and has been fixed with my provided patch.
> 
> Please see:
> https://bugzilla.kernel.org/show_bug.cgi?id=217069#c54
> https://bugzilla.kernel.org/show_bug.cgi?id=217069#c59

I'll post a quick update there.

Thx again.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> On 2023/4/14 下午8:48, Thorsten Leemhuis wrote:
>> On 19.03.23 08:20, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 22.02.23 08:57, Thorsten Leemhuis wrote:
>>>>
>>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>>> kernel developer don't keep an eye on it, I decided to forward it by
>>>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217069 :
>>>
>>> An issue that looked like a network bug was now bisected and it turns
>>> out it's cause by 5c62d5aab875 ("ACPICA: Events: Support fixed PCIe wake
>>> event") which Huacai Chen provided. Could you take a look at the ticket
>>> linked above?
>>
>> Jianmin did get close to a proper fix a while ago
>> (https://bugzilla.kernel.org/show_bug.cgi?id=217069#c46 ), but it
>> appears there wasn't any progress to fix this during the last week. Or
>> did I miss it?
>>
>> This is kinda unsatisfying, as the culprit is now known for nearly four
>> weeks; especially as this is a issue that is present in 6.2 since it was
>> released and would have been possible to fix there and in mainline with
>> a simple revert. We even got close to one two weeks ago already
>> (https://bugzilla.kernel.org/show_bug.cgi?id=217069#c49 ).
>>
>> #sigh
>>
>> I'd say we should revert this. Rafael, what's your opinion here?
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> -- 
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>> #regzbot poke
>>
> 
> 
> 
