Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840BD74BD63
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGHLfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 07:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGHLff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 07:35:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0060BC
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 04:35:33 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qI6Dm-0004GA-MM; Sat, 08 Jul 2023 13:35:26 +0200
Message-ID: <df1d7d39-56f3-699c-0d0f-fcc8774f182e@leemhuis.info>
Date:   Sat, 8 Jul 2023 13:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
Content-Language: en-US, de-DE
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info>
 <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
 <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
 <2023070359-evasive-regroup-f3b8@gregkh>
 <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
 <2023070453-plod-swipe-cfbf@gregkh>
 <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
 <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
 <2023070509-undertow-pulverize-5adc@gregkh>
 <7668c45a-70b1-dc2f-d0f5-c0e76ec17145@leemhuis.info>
 <20230705084906.22eee41e6e72da588fce5a48@linux-foundation.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20230705084906.22eee41e6e72da588fce5a48@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688816133;4ce8089e;
X-HE-SMSGID: 1qI6Dm-0004GA-MM
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Linus to the list of recipients to ensure the fix makes it into
-rc1 (and can finally be backported to -stable).

Linus, here is the backstory, as I assume you haven't seen this yet:

CONFIG_PER_VMA_LOCK (which defaults to Y; merged for v6.4-rc1 in
0bff0aaea03 ("x86/mm: try VMA lock-based page fault handling first"))
sometimes causes memory corruption reported here:
https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
https://bugzilla.kernel.org/show_bug.cgi?id=217624

The plan since early this week is to mark CONFIG_PER_VMA_LOCK as broken;
latest patch that does this is this one afaics:
https://lore.kernel.org/all/20230706011400.2949242-3-surenb@google.com/

But that change or something similar hasn't reached you yet afaics;
note, this is the second patch of a series with two patches]

On 05.07.23 17:49, Andrew Morton wrote:
> On Wed, 5 Jul 2023 10:51:57 +0200 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:
> 
>>>>> I'm in wait-a-few-days-mode on this.  To see if we have a backportable
>>>>> fix rather than disabling the feature in -stable.
>>
>> Andrew, how long will you remain in "wait-a-few-days-mode"? Given what
>> Greg said below and that we already had three reports I know of I'd
>> prefer if we could fix this rather sooner than later in mainline --
>> especially as Arch Linux and openSUSE Tumbleweed likely have switched to
>> 6.4.y already or will do so soon.
> 
> I'll send today's 2-patch series to Linus today or tomorrow.

That afaics did not happen until now. :-(

This makes me regret that I did not CC Linus earlier. I always feel like
a snitcher when I do that. But in retrospective it seems it would have
been the right thing to do given the problem, as I suspect Linus would
have quickly applied the patch or marked the feature as broken himself.

So thx to this (and a handful of earlier, similar situations) I now
fully made my peace with feeling like a snitcher (I always knew that
it's kinda part of the position). When something in me says "Ick, this
looks bad to my untrained eyes" I'll immediately CC Linus.

Linus, if I take things to far just let me know. But I assume you get a
lot of mails and won't mind a few more.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
