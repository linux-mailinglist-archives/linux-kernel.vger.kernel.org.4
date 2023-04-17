Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7B6E4059
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDQHFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDQHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:05:32 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D31BFD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:05:30 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1poIvY-0005nV-Ek; Mon, 17 Apr 2023 09:05:28 +0200
Message-ID: <416a5def-cbd7-2acf-0dd6-1b8826b5dfc1@leemhuis.info>
Date:   Mon, 17 Apr 2023 09:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Linux regressions report for mainline [2023-04-16]
Content-Language: en-US, de-DE
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <168166781352.1843526.278570500979918184@leemhuis.info>
 <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681715131;304b69d5;
X-HE-SMSGID: 1poIvY-0005nV-Ek
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.23 22:48, Linus Torvalds wrote:
> On Sun, Apr 16, 2023 at 10:59 AM Regzbot (on behalf of Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> Wake-on-lan (WOL) apparently is broken for a huge number of users since
>> 6.2 was released[1]. This is known for 8 weeks now and about 4 weeks ago
>> it was bisected to commit 5c62d5aab87 ("ACPICA: Events: Support fixed
>> PCIe wake event") we immediately could have reverted. The developer that
>> looked into this was even willing to do the revert late March, but then
>> got discouraged by a maintainer [2]. But well, a fix was apparently[3]
>> finally posted for review last week (to the acpica-devel list); with a
>> bit of luck your might get it next week. Still a bit sad that 6.2 is
>> broken for so long now, as Greg wants to see it fixed in mainline first.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217069
>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=217069#c50
>> [3] https://lore.kernel.org/all/754225a2-95a9-2c36-1886-7da1a78308c2@loongson.cn/
> 
> I find that bugzilla discussion very confusing, it's not clear what
> the status of the patch actually is.
> 
> And the sane lkml thread just says "the patch is under review" without
> actually saying *where* said patch is, or where the review is.
>
> It sounds like it got perhaps into some internal ACPCICA queue? None
> of those links are very clear on any of this.
> 
> Rafael?

FWIW, yeah, had the same problems and already had asked for a link to
the patch submission. A few hours ago Jianmin Lv replied and pointed me
here: https://github.com/acpica/acpica/pull/866

/me meanwhile wonders if acpica-devel was abandoned or if its list
archive (https://lists.linuxfoundation.org/pipermail/acpica-devel/ ) is
just broken.

>> Another issue from the 6.2 days still not fixed are a huge number of
>> DISCARD request on NVME devices with Btrfs caused by 63a7cb13071
>> ("btrfs: auto enable discard=async when possible") [1, 2].
> 
> Yeah, automatic discard is a broken idea, and that should just be reverted.
> 
> The number of devices that have *horrible* problems with discard is
> too high for any kind of "do discard by default" logic.
> 
> David, please don't do that. Just because discard happens to work well
> on some disk, *you* care about, does not in any way mean that "do
> discard by default" is sane.
> 
> Discard needs to be opt-in. Not out-opt.

Not my area of expertise, but is this maybe something where we can
automatically enable async discard by default if some easily detectable
conditions are met? E.g. if the device supports PCIe 12.0, NVMe 9.1, or
was produced in 2030 and later (note, I used bogus numbers here on purpose).

Ciao, Thorsten
