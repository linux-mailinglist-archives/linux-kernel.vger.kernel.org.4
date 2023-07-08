Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0338E74BDC4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGHOSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGHOR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:17:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0599F183;
        Sat,  8 Jul 2023 07:17:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qI8kx-00053q-Qa; Sat, 08 Jul 2023 16:17:51 +0200
Message-ID: <c65d0837-5e64-bec7-9e56-04aa91148d05@leemhuis.info>
Date:   Sat, 8 Jul 2023 16:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a
 ("wifi: iwlwifi: split 22000.c into multiple files")
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Baruch, Yaara" <yaara.baruch@intel.com>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com>
 <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
In-Reply-To: <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688825877;d2788880;
X-HE-SMSGID: 1qI8kx-00053q-Qa
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 12:55, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 07.07.23 10:25, Zhang, Rui wrote:
>>
>> I run into a NULL pointer dereference and kernel boot hang after
>> switching to latest upstream kernel, and git bisect shows that below
>> commit is the first offending commit, and I have confirmed that commit
>> 19898ce9cf8a has the issue while 19898ce9cf8a~1 does not.
> 
> FWIW, this is the fourth such report about this that I'm aware of.
> 
> The first is this one (with two affected users afaics):
> https://bugzilla.kernel.org/show_bug.cgi?id=217622
> 
> The second is this one:
> https://lore.kernel.org/all/CAAJw_Zug6VCS5ZqTWaFSr9sd85k%3DtyPm9DEE%2BmV%3DAKoECZM%2BsQ@mail.gmail.com/
> 
> The third:
> https://lore.kernel.org/all/9274d9bd3d080a457649ff5addcc1726f08ef5b2.camel@xry111.site/
> 
> And in the past few days two people from Fedora land talked to me on IRC
> with problems that in retrospective might be caused by this as well.

I got confirmation: one of those cases is also caused by 19898ce9cf8a
But I write for a different reason:

Larry (now CCed) looked at the culprit and spotted something that looked
suspicious to him; he posted a patch and looks for testers:
https://lore.kernel.org/all/0068af47-e475-7e8d-e476-c374e90dff5f@lwfinger.net/

Ciao, Thorsten

> This many reports about a problem at this stage of the cycle makes me
> suspect we'll see a lot more once -rc1 is out. That's why I raising the
> awareness of this. Sadly a simple revert of just this commit is not
> possible. :-/
> 
> Ciao, Thorsten
> 
>> commit 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2 (refs/bisect/bad)
>> Author:     Johannes Berg <johannes.berg@intel.com>
>> AuthorDate: Wed Jun 21 13:12:07 2023 +0300
>> Commit:     Johannes Berg <johannes.berg@intel.com>
>> CommitDate: Wed Jun 21 14:07:00 2023 +0200
>>
>>     wifi: iwlwifi: split 22000.c into multiple files
>>     
>>     Split the configuration list in 22000.c into four new files,
>>     per new device family, so we don't have this huge unusable
>>     file. Yes, this duplicates a few small things, but that's
>>     still much better than what we have now.
>>     
>>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>     Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
>>     Link:
>> https://lore.kernel.org/r/20230621130443.7543603b2ee7.Ia8dd54216d341ef1ddc0531f2c9aa30d30536a5d@changeid
>>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>
>> I have some screenshots which show that RIP points to iwl_mem_free_skb,
>> I can create a kernel bugzilla and attach the screenshots there if
>> needed.
>>
>> BTW, lspci output of the wifi device and git bisect log attached.
>>
>> If any other information needed, please let me know.
> 
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.
> 
> P.S.: for regzbot
> 
> #regzbot ^introduced 19898ce9cf8a
> #regzbot dup-of:
> https://lore.kernel.org/all/a5cdc7f8-b340-d372-2971-0d24b01de217@gmail.com/
