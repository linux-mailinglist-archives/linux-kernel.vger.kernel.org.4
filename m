Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7311C7505ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjGLLYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjGLLYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:24:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6251736;
        Wed, 12 Jul 2023 04:24:23 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJXxE-000195-FJ; Wed, 12 Jul 2023 13:24:20 +0200
Message-ID: <b30258b7-ee09-e502-1a08-809ec0bfcf12@leemhuis.info>
Date:   Wed, 12 Jul 2023 13:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [regression] r8169 ASPM changes broke iwlwifi driver for Intel 3165
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <6f8715af-95c2-8333-2b32-206a143ebb52@leemhuis.info>
In-Reply-To: <6f8715af-95c2-8333-2b32-206a143ebb52@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689161063;f6ef6d18;
X-HE-SMSGID: 1qJXxE-000195-FJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding maintainers for r8169 to the list of recipients while dropping
the iwlwifi folks (the latter are already aware about the bad bisection)]

On 10.07.23 10:32, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developers don't keep an eye on it, I decided to forward it by mail.
> 
> Aloka Dixit, apparently it's cause by a change of yours: bd54f3c2907
> ("wifi: mac80211: generate EMA beacons in AP mode") [v6.4-rc1]

Heiner, this turned out to be a bad bisection. The reporter ran another
one and this time even verified the results by reverting the fix ontop
of v6.4. Turns out the issue is caused by 5fc3f6c90cc ("r8169:
consolidate disabling ASPM before EPHY access") you contributed.

Blacklisting r8169 fixes the issue, too. For details see:
https://bugzilla.kernel.org/show_bug.cgi?id=217635

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> not CCed them in mails like this.
> 
> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217635 :
> 
>> Distro: Arch Linux
>> Kernel version: 6.4.1.arch1-1
>> Happens on mainline kernel? : YES (linux-mainline 6.4-1)
>> Note: linux-mainline 6.4.1 is not available at time of this writing
>>
>> Arch linux bug:
>> https://bugs.archlinux.org/task/78984
>>
>> Summary:
>> No network access even after connecting to wifi. Websites don't load, ping doesn't work.
>> This didn't happen on kernel 6.3.x (specifically 6.3.9, the last 6.3 kernel provided by Arch).
>>
>> Bug happens on both Arch-provided kernel and mainline kernel
>>
>> Steps to reproduce:
>> 1) On fresh boot, connect to a wifi network
>>    a) Make sure wifi password is not saved beforehand
>> 2) Ping a url with terminal, or open a website with browser
>> 3) Ping fails to work / website doesn't load
> 
> See the ticket for more details and the bisection result that came later.
> 
> Aditya Kumar Singh, FWIW, I hope you don't mind that I CCed you, but you
> already contributed a fix for the culprit, so it seemed the right thing
> to do in this case.
> 
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
> 
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: bd54f3c29077f2
> https://bugzilla.kernel.org/show_bug.cgi?id=217635
> #regzbot title: net: wireless: iwlwifi driver broken on Intel 3165
> network card
> #regzbot ignore-activity

#regzbot introduced: 5fc3f6c90cca19e
