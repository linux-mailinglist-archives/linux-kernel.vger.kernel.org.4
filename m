Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF41F744D99
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGBMhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBMhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:37:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A312A;
        Sun,  2 Jul 2023 05:37:30 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qFwKN-0000ey-Ek; Sun, 02 Jul 2023 14:37:19 +0200
Message-ID: <10f2a5ee-91e2-1241-9e3b-932c493e61b6@leemhuis.info>
Date:   Sun, 2 Jul 2023 14:37:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: RCU stalls with wireguard over bonding over igb on Linux
 6.3.0+
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        David R <david@unsolicited.net>,
        Boris Ostrovsky <boris.ovstrosky@oracle.com>,
        Miguel Luis <miguel.luis@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RCU <rcu@vger.kernel.org>,
        Wireguard Mailing List <wireguard@lists.zx2c4.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Manuel 'satmd' Leiner <manuel.leiner@gmx.de>
References: <e5b76a4f-81ae-5b09-535f-114149be5069@gmail.com>
 <79196679-fb65-e5ad-e836-2c43447cfacd@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <79196679-fb65-e5ad-e836-2c43447cfacd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688301450;33a91d3a;
X-HE-SMSGID: 1qFwKN-0000ey-Ek
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.23 13:57, Bagas Sanjaya wrote:
> [also Cc: original reporter]

BTW: I think you CCed too many developers here. There are situations
where this can makes sense, but it's rare. And if you do this too often
people might start to not really look into your mails or might even
ignore them completely.

Normally it's enough to write the mail to (1) the people in the
signed-off-by-chain, (2) the maintainers of the subsystem that merged a
commit, and (3) the lists for all affected subsystems; leave it up to
developers from the first two groups to CC the maintainers of the third
group.

> On 7/2/23 10:31, Bagas Sanjaya wrote:
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> I've spent the last week on debugging a problem with my attempt to upgrade my kernel from 6.2.8 to 6.3.8 (now also with 
> [...]
>> See Bugzilla for the full thread.
>>
>> Anyway, I'm adding it to regzbot to make sure it doesn't fall through cracks
>> unnoticed:
>>
>> #regzbot introduced: fed8d8773b8ea6 https://bugzilla.kernel.org/show_bug.cgi?id=217620
>> #regzbot title: correcting acpi_is_processor_usable() check causes RCU stalls with wireguard over bonding+igb
>> #regzbot link: https://bugs.gentoo.org/909066

> satmd: Can you repeat bisection to confirm that fed8d8773b8ea6 is
> really the culprit?

I'd be careful to ask people that, as that might mean a lot of work for
them. Best to leave things like that to developers, unless it's pretty
obvious that something went sideways.

> Thorsten: It seems like the reporter concluded bisection to the
> (possibly) incorrect culprit.

What makes your think so? I just looked at bugzilla and it (for now)
seems reverting fed8d8773b8ea6 ontop of 6.4 fixed things for the
reporter, which is a pretty strong indicator that this change really
causes the trouble somehow.

/me really wonders what's he's missing

> What can I do in this case besides
> asking to repeat bisection?

Not much apart from updating regzbot state (e.g. something like "regzbot
introduced v6.3..v6.4") and a reply to your initial report (ideally with
a quick apology) to let everyone know it was a false alarm.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
