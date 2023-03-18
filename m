Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003546BF9C0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 13:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCRMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 08:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRMIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 08:08:18 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060B430182;
        Sat, 18 Mar 2023 05:08:14 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pdVM4-00054s-Tt; Sat, 18 Mar 2023 13:08:13 +0100
Message-ID: <e20db4c4-b2a8-bc88-232f-d1213733d20c@leemhuis.info>
Date:   Sat, 18 Mar 2023 13:08:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        barry@messagefor.me.uk
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] focaltech touchpad driver misbehaves due to "kbuild:
 treat char as always unsigned"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679141295;ab4bbee5;
X-HE-SMSGID: 1pdVM4-00054s-Tt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a regression report in bugzilla.kernel.org. Jason, apparently
it's caused by a change of yours (3bc753c06dd0 ("kbuild: treat char as
always unsigned")), which apparently caused a problem in
drivers/input/mouse/focaltech.c to surface. Someone provided a patch
already to fix it here: https://bugs.archlinux.org/task/77733?getfile=22498

Back to the bug. As many (most?) kernel developer don't keep an eye on
bugzilla, I decided to forward it by mail. Quoting from
https://bugzilla.kernel.org/show_bug.cgi?id=217211 :

> Barry 2023-03-17 13:51:10 UTC
> 
> Created attachment 303972 [details] Kernel bisect result
> 
> O/S: Archlinux.
> 
> On any kernel release from 6.2 onwards I have found that the touchpad
> doesn't respond to multi finger touches properly. The pad works fine for
> single finger movement and single finger tap to click. If I click and
> hold the pad button and then use another finger to move such as for text
> selection, drag and drop, moving or resizing a window etc. Or if I try
> to use 2 finger scrolling then the mouse pointer jumps to the top or
> right or into the top right of the screen. All of this functionality
> worked as expected up to kernel 6.1.19.
> 
> I have bisected the kernel and got the attached result.
> 
> 
> I have checked out kernel 6.2.6 and removed the `-funsigned-char` from
> the Makefile. Kernel 6.2.6 built with the modified Makefile restores the
> correct functionality. I believe the touchpad uses the psmouse driver so
> maybe the new build option has broken this driver.>
> I have bisected the kernel and got the attached result.
> 
> 
> I have checked out kernel 6.2.6 and removed the `-funsigned-char`
> from the Makefile. Kernel 6.2.6 built with the modified Makefile
> restores the correct functionality. I believe the touchpad uses the
> psmouse driver so maybe the new build option has broken this driver.
> 
> [...]
> 
> barry@messagefor.me.uk 2023-03-18 11:49:27 UTC
> 
> Hi. If you check this link which is my report of the same bug on the
> arch bug tracker there is a patch attached which fixes the issue.
> 
> https://bugs.archlinux.org/task/77733#comment216336

See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 3bc753c06dd0
https://bugzilla.kernel.org/show_bug.cgi?id=217211
#regzbot title: kbuild/input: focaltech touchpad driver misbehaves due
to a checke how to treat char
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
