Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC7696172
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjBNKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjBNKuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:50:40 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A990E22024;
        Tue, 14 Feb 2023 02:50:11 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pRssh-0008OS-ED; Tue, 14 Feb 2023 11:49:51 +0100
Message-ID: <a353b8d3-18e4-4060-ac15-68fca6c7d5e3@leemhuis.info>
Date:   Tue, 14 Feb 2023 11:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jorge Lopez <jorge.lopez2@hp.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Bocanegra <luisbocanegra17b@gmail.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 217020 - hp-wmi: Unable to change platform profile:
 Operation not supported
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676371811;ea8cbb11;
X-HE-SMSGID: 1pRssh-0008OS-ED
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217020 :

>  Luis Bocanegra 2023-02-11 03:51:28 UTC
> 
> Created attachment 303711 [details]
> ACPI table
> 
> Hi,
> 
> I have a hp omen 15-dc1004la (board 8575, latest BIOS installed) and
> currently can't change the thermal profile, I get this error:
> 
> # echo cool > /sys/firmware/acpi/platform_profile
> bash: echo: write error: Operation not supported
> 
> # cat /sys/firmware/acpi/platform_profile_choices
> cool balanced performance
> 
> # cat /sys/firmware/acpi/platform_profile
> balanced
> 
> I see no errors in dmesg
> 
> I remember being able to change it before (could hear fans spin up/down)
> so I rebuilt older versions of the module (on top of mainline) and these
> are my findings:
> 
> From 4c51ba9af42dff0ef6a2ca3edcefa76f3466959e to
> be9d73e64957bbd31ee9a0d11adc0f720974c558 can change power profiles with
> the above command, but the value in /sys/firmware/acpi/platform_profile
> stays the same.
> 
> After 4b4967cbd2685f313411e6facf915fb2ae01d796
> /sys/firmware/acpi/platform_profile_choices disappears, it comes back on
> dc6a6ab58379f25bf991d8e4a13b001ed806e881 but I get the Operation not
> supported error, same until HEAD(ce95010ef62d4bf470928969bafc9070ae98cbb1).
> 
> Attached a ACPI dump in case that's useful.
> 
> I'm not a developer so that's all the information I can give at the
> moment, but I'm open to provide more information if needed, also testing
> patches to debug/test this bug.


See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 4b4967cbd2685f31
https://bugzilla.kernel.org/show_bug.cgi?id=217020
#regzbot title: hp-wmi: changing platform profile became impossible
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
