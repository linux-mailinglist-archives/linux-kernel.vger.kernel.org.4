Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3B6D06B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjC3N2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjC3N2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:28:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542C4213C;
        Thu, 30 Mar 2023 06:28:35 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1phsKO-00025P-KA; Thu, 30 Mar 2023 15:28:32 +0200
Message-ID: <7fe4e169-1cf9-2a26-0567-021172dadd3c@leemhuis.info>
Date:   Thu, 30 Mar 2023 15:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Gross <markgross@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 217234 - Touchpad disabled after wakeup from sleep
 on Lenovo Yoga 7i 15ITL5 (bisected)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680182915;27f7e9b0;
X-HE-SMSGID: 1phsKO-00025P-KA
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developers don't keep an eye on it, I decided to forward it by mail.

Hans, apparently it's cause by a change of yours.

Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
not CCed them in mails like this.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217234 :

>  arsgeiger@gmail.com 2023-03-22 23:52:35 UTC
> 
> Created attachment 304002 [details]
> libinput events on linux6.0
> 
> After booting linux6.1 and later upon closing the lid and opening it again, the touchpad is no longer usable. After powering off and booting linux6.0 again (no other changes), the touchpad does continue to work after closing the lid and opening it again.
> 
> When the touchpad gets disabled on linux6.1, after logging in to gnome, I can re-enable it from the settings. Using `libinput debug-events --verbose` Here is a comparison of the output on linux6.0:
> 
>>    2: event10 - lid: suspending touchpad
>> -event1   SWITCH_TOGGLE           +0.000s     switch lid state 1
>>    3: event10 - lid: resume touchpad
>> -event6   KEYBOARD_KEY            +2.164s     KEY_F22 (192) pressed
>>  event6   KEYBOARD_KEY            +2.164s     KEY_F22 (192) released
>>  event6   KEYBOARD_KEY            +2.627s     KEY_F22 (192) pressed
>>  event6   KEYBOARD_KEY            +2.627s     KEY_F22 (192) released
>> -event1   SWITCH_TOGGLE           +2.168s     switch lid state 0
> 
> And linux 6.1+:
> 
>>   2: event10 - lid: suspending touchpad
>> -event1   SWITCH_TOGGLE           +0.000s     switch lid state 1
>>    3: event10 - lid: resume touchpad
>> -event6   KEYBOARD_KEY            +2.000s     KEY_TOUCHPAD_TOGGLE (530)
>> pressed
>>  event6   KEYBOARD_KEY            +2.000s     KEY_TOUCHPAD_TOGGLE (530)
>>  released
>> -event1   SWITCH_TOGGLE           +2.000s     switch lid state 0

> [...]

>  arsgeiger@gmail.com 2023-03-30 11:50:11 UTC
> 
> Alright, I found the offending commit (which does not exist in linux6.0 but was backported to linux6.1):
> https://gitlab.com/linux-kernel/stable/-/commit/5829f8a897e4f030cd2d32a930eea8954ab5dcd3
> 
> Building linux6.2 with this commit reverted does workaround the issue for me.

See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 5829f8a897e4f0
https://bugzilla.kernel.org/show_bug.cgi?id=217234
#regzbot title: platform/x86: ideapad-laptop: Touchpad disabled after
wakeup
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

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"
