Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2BB6EAC0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjDUNuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjDUNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:49:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79639025
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:49:38 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ppr8r-0004Wa-8k; Fri, 21 Apr 2023 15:49:37 +0200
Message-ID: <b51f571a-d6b2-1908-d94a-bc0b2a751905@leemhuis.info>
Date:   Fri, 21 Apr 2023 15:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: the wake-on-lan regression from 6.2 (was: Re: Linux regressions
 report for mainline [2023-04-16])
Content-Language: en-US, de-DE
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <168166781352.1843526.278570500979918184@leemhuis.info>
 <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
 <CAJZ5v0j_MwW6JaqTRNhmz=LcW8==GZ0X-=W0+z0tOsGQyDd0Dw@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAJZ5v0j_MwW6JaqTRNhmz=LcW8==GZ0X-=W0+z0tOsGQyDd0Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1682084978;95dd4424;
X-HE-SMSGID: 1ppr8r-0004Wa-8k
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.23 13:38, Rafael J. Wysocki wrote:
> On Sun, Apr 16, 2023 at 10:49 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Sun, Apr 16, 2023 at 10:59 AM Regzbot (on behalf of Thorsten
>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>
>>> Wake-on-lan (WOL) apparently is broken for a huge number of users since
>>> 6.2 was released[1]. This is known for 8 weeks now and about 4 weeks ago
>>> it was bisected to commit 5c62d5aab87 ("ACPICA: Events: Support fixed
>>> PCIe wake event") we immediately could have reverted. The developer that
>>> looked into this was even willing to do the revert late March, but then
>>> got discouraged by a maintainer [2]. But well, a fix was apparently[3]
>>> finally posted for review last week (to the acpica-devel list); with a
>>> bit of luck your might get it next week. Still a bit sad that 6.2 is
>>> broken for so long now, as Greg wants to see it fixed in mainline first.
>>>
>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217069
>>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=217069#c50
>>> [3] https://lore.kernel.org/all/754225a2-95a9-2c36-1886-7da1a78308c2@loongson.cn/
>>
>> I find that bugzilla discussion very confusing, it's not clear what
>> the status of the patch actually is.
>>
>> And the sane lkml thread just says "the patch is under review" without
>> actually saying *where* said patch is, or where the review is.
>>
>> It sounds like it got perhaps into some internal ACPCICA queue? None
>> of those links are very clear on any of this.
>>
>> Rafael?
> 
> There is a pull request for ACPICA that corresponds to this (IIUC),
> https://github.com/acpica/acpica/pull/866

Rafael, what happened to this? From the github acpica discussion is
looks a lot like there was no real progress. And
drivers/acpi/acpica/evevent.c in next looks unchanged; and from
searching for ACPI_EVENT_PCIE_WAKE on lore it also looks like neither
the fix nor a revert was posted. But I might be missing something.

/me still hopes we can get this fixed somehow before Linus releases 6.3

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
