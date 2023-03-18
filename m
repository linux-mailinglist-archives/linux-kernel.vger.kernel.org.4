Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881866BFA4A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCRNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCRNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:38:24 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EFBD2821E;
        Sat, 18 Mar 2023 06:38:22 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pdWlD-0005NA-00; Sat, 18 Mar 2023 14:38:15 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 642E9C1B07; Sat, 18 Mar 2023 14:38:07 +0100 (CET)
Date:   Sat, 18 Mar 2023 14:38:07 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mips: bmips: BCM6358: disable RAC flush for TP1
Message-ID: <20230318133807.GA4619@alpha.franken.de>
References: <20230316180518.783613-1-noltari@gmail.com>
 <20230317102004.235879-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230317102004.235879-1-noltari@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:20:04AM +0100, Álvaro Fernández Rojas wrote:
> RAC flush causes kernel panics on BCM6358 with EHCI/OHCI when booting from TP1:
> [    3.881739] usb 1-1: new high-speed USB device number 2 using ehci-platform
> [    3.895011] Reserved instruction in kernel code[#1]:
> [    3.900113] CPU: 0 PID: 1 Comm: init Not tainted 5.10.16 #0
> [    3.905829] $ 0   : 00000000 10008700 00000000 77d94060
> [    3.911238] $ 4   : 7fd1f088 00000000 81431cac 81431ca0
> [    3.916641] $ 8   : 00000000 ffffefff 8075cd34 00000000
> [    3.922043] $12   : 806f8d40 f3e812b7 00000000 000d9aaa
> [    3.927446] $16   : 7fd1f068 7fd1f080 7ff559b8 81428470
> [    3.932848] $20   : 00000000 00000000 55590000 77d70000
> [    3.938251] $24   : 00000018 00000010
> [    3.943655] $28   : 81430000 81431e60 81431f28 800157fc
> [    3.949058] Hi    : 00000000
> [    3.952013] Lo    : 00000000
> [    3.955019] epc   : 80015808 setup_sigcontext+0x54/0x24c
> [    3.960464] ra    : 800157fc setup_sigcontext+0x48/0x24c
> [    3.965913] Status: 10008703	KERNEL EXL IE
> [    3.970216] Cause : 00800028 (ExcCode 0a)
> [    3.974340] PrId  : 0002a010 (Broadcom BMIPS4350)
> [    3.979170] Modules linked in: ohci_platform ohci_hcd fsl_mph_dr_of ehci_platform ehci_fsl ehci_hcd gpio_button_hotplug usbcore nls_base usb_common
> [    3.992907] Process init (pid: 1, threadinfo=(ptrval), task=(ptrval), tls=77e22ec8)
> [    4.000776] Stack : 81431ef4 7fd1f080 81431f28 81428470 7fd1f068 81431edc 7ff559b8 81428470
> [    4.009467]         81431f28 7fd1f080 55590000 77d70000 77d5498c 80015c70 806f0000 8063ae74
> [    4.018149]         08100002 81431f28 0000000a 08100002 81431f28 0000000a 77d6b418 00000003
> [    4.026831]         ffffffff 80016414 80080734 81431ecc 81431ecc 00000001 00000000 04000000
> [    4.035512]         77d54874 00000000 00000000 00000000 00000000 00000012 00000002 00000000
> [    4.044196]         ...
> [    4.046706] Call Trace:
> [    4.049238] [<80015808>] setup_sigcontext+0x54/0x24c
> [    4.054356] [<80015c70>] setup_frame+0xdc/0x124
> [    4.059015] [<80016414>] do_notify_resume+0x1dc/0x288
> [    4.064207] [<80011b50>] work_notifysig+0x10/0x18
> [    4.069036]
> [    4.070538] Code: 8fc300b4  00001025  26240008 <ac820000> ac830004  3c048063  0c0228aa  24846a00  26240010
> [    4.080686]
> [    4.082517] ---[ end trace 22a8edb41f5f983b ]---
> [    4.087374] Kernel panic - not syncing: Fatal exception
> [    4.092753] Rebooting in 1 seconds..
> 
> Because the bootloader (CFE) is not initializing the Read-ahead cache properly
> on the second thread (TP1). Since the RAC was not initialized properly, we
> should avoid flushing it at the risk of corrupting the instruction stream as
> seen in the trace above.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v3: add changes suggested by Florian:
>    - Switch to a bool and remove unneeded initialization.
>    - Remove if from bcm6358_quirks().
>    - Improve commit description and bcm6358_quirks() comment.
>  v2: check if we're running on TP1 and invert logic.
> 
>  arch/mips/bmips/dma.c   | 5 +++++
>  arch/mips/bmips/setup.c | 8 ++++++++
>  2 files changed, 13 insertions(+)

applied to mips-fixes with the Fixes tag added.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
