Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7242362C0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiKPO0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiKPO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:26:49 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96911C08;
        Wed, 16 Nov 2022 06:26:47 -0800 (PST)
Received: from [10.16.7.85] (hh-wlan-02.rz-berlin.mpg.de [141.14.51.18])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0440461EA1931;
        Wed, 16 Nov 2022 15:26:44 +0100 (CET)
Message-ID: <aedc0972-1df9-6d65-f8a0-2f735469c27f@molgen.mpg.de>
Date:   Wed, 16 Nov 2022 15:26:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1] Bluetooth: Add hci_nxp BT submodule with controller
 Power Save feature for NXP BT chipsets.
Content-Language: en-US
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
References: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Neeraj,


Thank you for your patch.


Am 16.11.22 um 17:42 schrieb Neeraj Sanjay Kale:

Please remove the dot/period at the end of the summary/subject line.

> Added proprietary hci_uart driver code to the linux hci uart sub-system as

Please use present tense: Add

“proprietary … code” sounds strange, as Linux is FLOSS. Please clarify.

> hci_nxp. This driver has Power Save feature that will put the NXP bluetooth
> chip into sleep state, whenever there is no activity for certain duration
> of time (2000ms), and will be woken up when any activity is to be
> initiated.
> 
> This Power Save feature will be enabled by default and can be disabled and
> re-enabled by the following set of commands:
> hcitool -i hci0 cmd 3F 23 02 00 00    (disable Power Save)
> hcitool -i hci0 cmd 3F 23 03 00 00    (enable Power Save)
> 
> The Power Save feature uses UART break signal by default as chip sleep and
> wake-up source, and can be set with the following set of commands:
> hcitool -i hci0 cmd 3F 53 03 14 01 FF    (set UART break method)
> hcitool -i hci0 cmd 3F 53 03 14 02 15    (set chip's GPIO[20] method)

Please mention the datasheet, and how you tested the driver.

> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>   MAINTAINERS                   |   6 +
>   drivers/bluetooth/Kconfig     |  10 +
>   drivers/bluetooth/Makefile    |   1 +
>   drivers/bluetooth/hci_ldisc.c |   6 +
>   drivers/bluetooth/hci_nxp.c   | 763 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/hci_nxp.h   | 118 +++++++
>   drivers/bluetooth/hci_uart.h  |   8 +-
>   7 files changed, 911 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/bluetooth/hci_nxp.c
>   create mode 100644 drivers/bluetooth/hci_nxp.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e55a4d4..6b2c264 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22591,6 +22591,12 @@ L:	linux-mm@kvack.org
>   S:	Maintained
>   F:	mm/zswap.c
>   
> +NXP BLUETOOTH WIRELESS DRIVERS
> +M:	amitkumar.karwar@nxp.com
> +M:	neeraj.sanjaykale@nxp.com

Mentioning a mailing list, and maybe setting up a functional address, 
would be nice (nxp-bluetooth-wireless-linux-driver@nxp.com).

> +S:	Maintained
> +F:	drivers/bluetooth/hci_nxp*
> +
>   THE REST
>   M:	Linus Torvalds <torvalds@linux-foundation.org>
>   L:	linux-kernel@vger.kernel.org

[…]


Kind regards,

Paul
