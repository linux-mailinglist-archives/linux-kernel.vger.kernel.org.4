Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF564D75A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLOHkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiLOHj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:39:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67752D1F8;
        Wed, 14 Dec 2022 23:39:55 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p5iqQ-0006Su-Cb; Thu, 15 Dec 2022 08:39:54 +0100
Message-ID: <95b6739b-6d8e-dc41-b637-e366ac883829@leemhuis.info>
Date:   Thu, 15 Dec 2022 08:39:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [git pull] Input updates for v6.1-rc5
Content-Language: en-US, de-DE
To:     Aman Dhoot <amandhoot12@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>
References: <Y3gwySzRvhCwdSgW@google.com>
 <824effa5-8b9a-c28a-82bb-9b0ab24623e1@kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <824effa5-8b9a-c28a-82bb-9b0ab24623e1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671089995;3188d7e9;
X-HE-SMSGID: 1p5iqQ-0006Su-Cb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 13.12.22 12:41, Jiri Slaby wrote:
> On 19. 11. 22, 2:26, Dmitry Torokhov wrote:
>> to receive updates for the input subsystem. You will get:
>>
>> - a fix for 8042 to stop leaking platform device on unload
>> - a fix for Goodix touchscreens on devices like Nanote UMPC-01 where we
>>    need to reset controller to load config from firmware
>> - a workaround for Acer Switch to avoid interrupt storm from home and
>>    power buttons
>> - a workaround for more ASUS ZenBook models to detect keyboard cnotroller
>> - a fix for iforce driver to properly handle communication errors
>> - touchpad on HP Laptop 15-da3001TU switched to RMI mode
>>
>> Changelog:
>> ---------
>>
>> Aman Dhoot (1):
>>        Input: synaptics - switch touchpad on HP Laptop 15-da3001TU to
>> RMI mode
> 
> This appears to break keyboard on HP's 15-da1xxx which appears to have
> the same ID: SYN3286. This happens on 6.0.12.

Thx for forwarding that report. CCing Aman, who authored that commit
(ac5408991ea6 in mainline, but it was backported to many stable kernels,
too)

Aman, could you look at this? If there is no easy fix in sight I wonder
if it might be the best to revert this soonish, so that Greg can pick up
that revert to stable quickly afterwards.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> synaptics excerpt from dmesg:
> psmouse serio1: synaptics: Trying to set up SMBus access
> psmouse serio1: synaptics: SMbus companion is not ready yet
> ...
> psmouse serio1: synaptics: queried max coordinates: x [..5648], y [..4826]
> psmouse serio1: synaptics: queried min coordinates: x [1292..], y [1026..]
> psmouse serio1: synaptics: Trying to set up SMBus access
> rmi4_smbus 6-002c: registering SMbus-connected sensor
> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics,
> product: TM3320-003, fw id: 2659795
> input: Synaptics TM3320-003 as
> /devices/pci0000:00/0000:00:1f.4/i2c-6/6-002c/rmi4-00/input/input21
> 
> This was reported downstream as a regression between 6.0.10 and 6.0.12:
> https://bugzilla.suse.com/show_bug.cgi?id=1206358
> 
> Full dmesgs available there too.
> 
> 
> 6.0.10 has this instead of the above:
> psmouse serio1: synaptics: queried max coordinates: x [..5648], y [..4826]
> psmouse serio1: synaptics: queried min coordinates: x [1292..], y [1026..]
> psmouse serio1: synaptics: Your touchpad (PNP: SYN3286 PNP0f13) says it
> can support a different bus. If i2c-hid and hid-rmi are not used, you
> might want to try setting psmouse.synaptics_intertouch to 1 and report
> this to linux-input@vger.kernel.org.
> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.16, id: 0x1e2b1,
> caps: 0xf00323/0x840300/0x2e800/0x400000, board id: 3320, fw id: 2659795

P.P.S.: I for now assume that it's a problem that also is present in
mainline and thus will track it as such.

#regzbot introduced ac5408991ea6
https://bugzilla.suse.com/show_bug.cgi?id=1206358
#regzbot title input: synaptics: keyboard broken on HP's 15-da1xxx
#regzbot ignore-activity
