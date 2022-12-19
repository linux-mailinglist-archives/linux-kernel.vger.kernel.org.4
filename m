Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF7C650AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiLSLmM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Dec 2022 06:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLSLmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:42:09 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C661660E8;
        Mon, 19 Dec 2022 03:42:04 -0800 (PST)
Received: from smtpclient.apple (p4fefcc21.dip0.t-ipconnect.de [79.239.204.33])
        by mail.holtmann.org (Postfix) with ESMTPSA id BEF6ECECF2;
        Mon, 19 Dec 2022 12:42:03 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v5] Bluetooth: Add hci_nxp to hci_uart module to support
 NXP BT chipsets
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLWFNWp=StPQ0=8hQe8bUoJzwSvCBk7Ybd=2oe=NROCgQ@mail.gmail.com>
Date:   Mon, 19 Dec 2022 12:42:03 +0100
Cc:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5742801D-881A-45BC-A8A7-28D694179D8E@holtmann.org>
References: <20221216094350.1121354-1-neeraj.sanjaykale@nxp.com>
 <85D2AE3F-97A5-4C88-8FC4-1684F3FD4438@holtmann.org>
 <CABBYNZLWFNWp=StPQ0=8hQe8bUoJzwSvCBk7Ybd=2oe=NROCgQ@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

>>> Add hci_nxp to the hci_uart module which adds support for the NXP BT
>>> chips. This driver has Power Save feature that will put the NXP bluetooth
>>> chip into sleep state, whenever there is no activity for certain duration
>>> of time (2000ms), and will be woken up when any activity is to be
>>> initiated.
>>> 
>>> The Power Save feature can be configured with the following set
>>> of commands (optional):
>>> hcitool -i hci0 cmd 3F 23 02 00 00    (enable Power Save)
>>> hcitool -i hci0 cmd 3F 23 03 00 00    (disable Power Save)
>>> where,
>>> OGF = 0x3F (vendor specific command)
>>> OCF = 0x23 (command to set Power Save state)
>>> arg[0] = 0x02 (disable Power Save)
>>> arg[0] = 0x03 (enable Power Save)
>>> arg[1,2,...] = XX (don't care)
>>> 
>>> The sleep/wake-up source can be configured with the following set
>>> of commands (optional):
>>> hcitool -i hci0 cmd 3F 53 03 14 01 FF    (set UART break method)
>>> hcitool -i hci0 cmd 3F 53 03 14 00 FF    (set UART DSR method)
>>> where,
>>> OGF = 0x3F (vendor specific command)
>>> OCF = 0x53 (command to set sleep and wake-up source)
>>> arg[0] = 0x00 (Chip to host method NONE)
>>> arg[0] = 0x01 (Chip to host method UART DTR)
>>> arg[0] = 0x02 (Chip to host method UART BREAK)
>>> arg[0] = 0x03 (Chip to host method GPIO)
>>> arg[1] = 0x14 (Chip to host GPIO[20] if arg[0] is 0x03, else 0xFF)
>>> arg[2] = 0x00 (Host to chip method UART DSR)
>>> arg[2] = 0x01 (Host to chip method UART BREAK)
>>> arg[3] = 0xXX (Reserved for future use)
>>> 
>>> By default, the hci_nxp sets power save enable, chip to host wake-up
>>> source as GPIO and host to chip sleep and wake-up source as UART
>>> break during driver initialization, by sending the respective
>>> commands to the chip.
>>> 
>>> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
>>> ---
>>> v2: Changed the subject/summary lines and added more details in the
>>> description. (Paul Menzel)
>>> v3: Made internal functions static, optimized the code, added few
>>> comments. (Sherry Sun)
>>> v4: Reworked entire code to send vendor commands cmd23 and cmd53 by
>>> using __hci_cmd_sync. (Luiz Augusto von Dentz)
>>> v5: Used hci_command_hdr and combined OGF+OCF into a single opcode.
>>> (Luiz Augusto von Dentz)
>>> ---
>>> MAINTAINERS                   |   6 +
>>> drivers/bluetooth/Kconfig     |  10 +
>>> drivers/bluetooth/Makefile    |   1 +
>>> drivers/bluetooth/hci_ldisc.c |   6 +
>>> drivers/bluetooth/hci_nxp.c   | 592 ++++++++++++++++++++++++++++++++++
>>> drivers/bluetooth/hci_nxp.h   |  94 ++++++
>>> drivers/bluetooth/hci_uart.h  |   8 +-
>>> 7 files changed, 716 insertions(+), 1 deletion(-)
>>> create mode 100644 drivers/bluetooth/hci_nxp.c
>>> create mode 100644 drivers/bluetooth/hci_nxp.h
>> 
>> so this is a clear NAK. Add this as serdev driver and not hook further into the
>> mess that is the HCI line discipline.
> 
> I wonder if we should make it more clear somehow, perhaps include a
> text on the likes of BT_HCIUART that is deprecated and new drivers
> shall use BT_HCIUART_SERDEV instead.

not even that. They need to be separate drivers. A long time ago I posted
the skeleton for btuart.ko and bt3wire.ko and that is where this has to go.

Regards

Marcel

