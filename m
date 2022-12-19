Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED01E650A98
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLSLKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiLSLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:10:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4121510DA;
        Mon, 19 Dec 2022 03:10:05 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p7E1z-0004IE-OX; Mon, 19 Dec 2022 12:10:03 +0100
Message-ID: <12c40aac-8f3b-fea2-17bb-d6a954d26597@leemhuis.info>
Date:   Mon, 19 Dec 2022 12:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Andrew M <quantumphazor@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: =?UTF-8?Q?=5bregression=5d_Bug=c2=a0216817_-_btusb_device_with_ID_0?=
 =?UTF-8?Q?489=3ae0d0_no_longer_working_after_v6=2e0?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671448205;e76b99f4;
X-HE-SMSGID: 1p7E1z-0004IE-OX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216817 :

>  Andrew M 2022-12-18 04:28:43 UTC
> 
> The internal USB Bluetooth device in my laptop no longer works since v6.0
> 
> Device in question:
> ID 0489:e0d0 Foxconn / Hon Hai
> 
> Works fine in 5.19.x and fails after 6.0
> I ran a bisect that resulted in it breaking after this commit:
> 26afbd826ee326e63a334c37fd45e82e50a615ec Bluetooth: Add initial implementation of CIS connections
> 
> System: Lenovo ThinkPad T14 (AMD) Gen 2
> 
> dmesg output:
> 
> [    0.978396] usb 5-4: new full-speed USB device number 2 using xhci_hcd
> [    1.142461] usb 5-4: New USB device found, idVendor=0489, idProduct=e0d0, bcdDevice= 0.01
> [    1.142467] usb 5-4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    4.591285] Bluetooth: Core ver 2.22
> [    4.591304] Bluetooth: HCI device and connection manager initialized
> [    4.591308] Bluetooth: HCI socket layer initialized
> [    4.591309] Bluetooth: L2CAP socket layer initialized
> [    4.591315] Bluetooth: SCO socket layer initialized
> [    4.871972] usbcore: registered new interface driver btusb
> [    4.883484] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [    4.973465] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    4.973468] Bluetooth: BNEP filters: protocol multicast
> [    4.973472] Bluetooth: BNEP socket layer initialized
> [    4.975525] Bluetooth: hci0: unexpected cc 0x2060 length: 1 < 7
> [    4.975537] Bluetooth: hci0: Opcode 0x2060 failed: -38
> [    6.985714] Bluetooth: hci0: command tx timeout
> 
> Attached is output of lsusb -v -d 0489:e0d0

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 26afbd826ee3
https://bugzilla.kernel.org/show_bug.cgi?id=216817
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
