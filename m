Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED65F40A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJDKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJDKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:16:28 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83032CC88;
        Tue,  4 Oct 2022 03:16:26 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ofeyN-0004j4-4w; Tue, 04 Oct 2022 12:16:23 +0200
Message-ID: <409a039b-fd00-a480-ee82-e7a329fa7ae2@leemhuis.info>
Date:   Tue, 4 Oct 2022 12:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Slade Watkins <srw@sladewatkins.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Artem S. Tashkinov" <aros@gmx.com>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <63a8403d-b937-f870-3a9e-f92232d5306c@leemhuis.info>
 <534EB870-3AAE-4986-95F3-0E9AD9FCE45B@sladewatkins.net>
 <e9dd6af0-37ef-1195-0d3b-95601d1ab902@leemhuis.info>
 <20221003112605.4d5ec4e9@gandalf.local.home>
 <eb935178-995b-84f1-6cbe-3492ba74f85b@leemhuis.info>
 <CAMuHMdWq+NntrPqMHzP3XEvKZgjEwSHW80vwWkZnaTORRrhpHA@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <CAMuHMdWq+NntrPqMHzP3XEvKZgjEwSHW80vwWkZnaTORRrhpHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664878586;4783420b;
X-HE-SMSGID: 1ofeyN-0004j4-4w
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.22 11:20, Geert Uytterhoeven wrote:
> Hi Thorsten,
> 
> On Tue, Oct 4, 2022 at 10:41 AM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>> But I consider explaining things like bisection and localmodconfig in
>> the documentation as also important, as that's likely something the tool
>> won't be able to automate any time soon (or never, as realizing that is
>> likely hard and better left to a separate tool anyway).
> 
> Creating a simple Linux-specific wrapper around git bisect under
> scripts/ might be useful?
> The wrapper could copy .config to
> $(srctree)/arch/$(ARCH)/config/bisect_defconfig, automatically run
> "make bisect_defconfig" in each step, and show not only the bisected
> commit, but also the impact on .config.

Don't worry, I still remember that trick of yours from this discussion:
https://lore.kernel.org/all/12e09497-a848-b767-88f4-7dabd8360c5e@leemhuis.info/

Something like that would be a start, but I'd say having localmodconfig
covered would be wise also, as it speeds things up tremendously for
those that start with a full-blown x86 pc distro config.

There are also people that find regressions when updating from say
v5.18.15 to v5.19.4 and want to bisect that range; never tried if that
actually works with a stable git tree, but I'd assume that approach is
unwise. I also assume a lot of people would prefer to download only the
recent history or specific stable branches when cloning the git tree
(which is possible if you know what to do, but I guess most people don't).

Ciao, Thorsten
