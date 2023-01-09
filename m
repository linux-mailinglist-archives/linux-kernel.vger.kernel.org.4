Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A7662142
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjAIJSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjAIJSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:18:12 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BCF1A828;
        Mon,  9 Jan 2023 01:14:41 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pEoEo-00030V-8i; Mon, 09 Jan 2023 10:14:38 +0100
Message-ID: <b74f4337-2e52-fe01-666c-d08335e9f4f4@leemhuis.info>
Date:   Mon, 9 Jan 2023 10:14:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, berilko@gmail.com,
        =?UTF-8?Q?Stefan_Br=c3=bcns?= <stefan.bruens@rwth-aachen.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: =?UTF-8?Q?=5bRegression=5d_Bug=c2=a0216903_-_HiRes_Scroll_for_Perfo?=
 =?UTF-8?Q?rmance_Mouse_MX_broken_in_6=2e1?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673255681;6e6a64d8;
X-HE-SMSGID: 1pEoEo-00030V-8i
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
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216903 :

>  berilko@gmail.com 2023-01-08 19:14:21 UTC
> 
> Since 6.1 Kernel driver for hid-logitech-hidpp no more detect Performance MX as FastScroll
> 
> Self-made patch is:
> --- archlinux-linux/drivers/hid/hid-logitech-hidpp.c	2023-01-09 00:41:25.310773805 +0700
> +++ archlinux-linux/drivers/hid/hid-logitech-hidpp.c	2023-01-09 01:09:10.844967608 +0700
> @@ -3479,7 +3479,7 @@
>  						  HIDPP_GET_REGISTER,
>  						  HIDPP_ENABLE_FAST_SCROLL,
>  						  NULL, 0, &response);
> -		if (!ret) {
> +		if (!ret || /* Patch for Performance MX */ hidpp->hid_dev->product == 0x101a) {
>  			hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL;
>  			hid_dbg(hidpp->hid_dev, "Detected HID++ 1.0 fast scroll\n");
>  		}
> 
> [reply] [−] Comment 1 Stefan Brüns 2023-01-08 23:39:50 UTC
> 
> Unfortunately, the hires auto detection is broken for HID++1.0 devices.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-logitech-hidpp.c#L3477
> 
> ```
> 		ret = hidpp_send_rap_command_sync(hidpp,
> 						  REPORT_ID_HIDPP_SHORT,
> 						  HIDPP_GET_REGISTER,
> 						  HIDPP_ENABLE_FAST_SCROLL,
> 						  NULL, 0, &response);
> ```
> 
> This command tries to read from register 0x40, while the FAST_SCROLL feature is BIT(6) (0x40) in register 0x01.
> 
> For my M705, enabling and disabling of FAST_SCROLL is possible (writing 0x42/0x02 to register 0x1), and the current setting can be read back.
> 
> I don't think auto-detection is possible for HID++1.0 devices.
> 

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.0..v6.1
https://bugzilla.kernel.org/show_bug.cgi?id=216903
#regzbot title: hid: HiRes Scroll for Performance Mouse MX broken
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
