Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8145F0A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiI3Lao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiI3L3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:29:49 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BAC2ED7A;
        Fri, 30 Sep 2022 04:20:46 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oeE4S-0005oY-TH; Fri, 30 Sep 2022 13:20:44 +0200
Message-ID: <c8d18046-0e43-0c2c-6ae6-92fe16163f4e@leemhuis.info>
Date:   Fri, 30 Sep 2022 13:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [regression] Bug 216426 - USB-C port is incorrectly reporting
 that it's powered when Dell XPS 15-9500 is unplugged #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <f28e3bdf-2add-574a-cf0a-5d0253ea708a@leemhuis.info>
 <ead18940-4e8b-f5c1-f1ac-16040b4bcddc@leemhuis.info>
In-Reply-To: <ead18940-4e8b-f5c1-f1ac-16040b4bcddc@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664536847;b67a08ba;
X-HE-SMSGID: 1oeE4S-0005oY-TH
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

On 26.09.22 16:25, Thorsten Leemhuis wrote:
> On 01.09.22 11:07, Thorsten Leemhuis wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=216426
>>
>>>  Mattia Orlandi 2022-08-29 17:04:21 UTC
>>>
>>> System
>>> ------
>>> - Dell XPS 15 9500
>>> - 5.19.4 kernel
>>>
>>> Problem description
>>> -------------------
>>> Whenever I plug and then unplug my laptop from AC power using the USB-C port, the system thinks it is still plugged in (i.e., the KDE applet reports "Plugged in but still discharging").
>>> If I check in Dell's BIOS, it correctly reports when the power supply is plugged/unplugged; `acpi -V` also correctly shows `Adapter 0: off-line`.
>>>
>>> On the other hand, `upower -d` incorrectly reports `/org/freedesktop/UPower/devices/line_power_ucsi_source_psy_USBC000o002` as `online: yes`.
>>> Moreover, `journalctl` reports `ucsi_acpi USBC000:00: ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-110)`.
>>>
>>> I'm testing the LTS kernel (5.15.63) and the issue does not occur, so I assume it's a regression bug, possibly introduced in kernel 5.18 (I tried downgrading the kernel to version 5.18.16 and the issue was already present).
>>
>> See the ticket for more details. Apologies if I forwarded it to the
>> wrong folks, I cover a lot of ground and thus sometimes get things
>> wrong. :-/
>>
>> BTW, I'd also like to add the report to the list of tracked regressions
>> to ensure it's doesn't fall through the cracks in the end:
>>
>> #regzbot introduced: v5.15..v5.18
>> https://bugzilla.kernel.org/show_bug.cgi?id=216426
>> #regzbot ignore-activity
> 
> #regzbot introduced: f7090e0ef360d674f0

Looks like nobody yet check if the problem happens with mainline, so
let's stick to the backport for now:

#regzbot introduced: 0fbb5ce2f4267

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
