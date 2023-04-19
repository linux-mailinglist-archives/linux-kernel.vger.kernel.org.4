Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E429D6E777C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjDSKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjDSKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:33:31 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A640ABB89;
        Wed, 19 Apr 2023 03:33:29 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4989861E4052B;
        Wed, 19 Apr 2023 12:33:28 +0200 (CEST)
Message-ID: <8453180c-a223-1576-4016-b9a350ee6698@molgen.mpg.de>
Date:   Wed, 19 Apr 2023 12:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Enable flow control before
 checking boot signature
Content-Language: en-US
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
References: <20230419090346.1671130-1-neeraj.sanjaykale@nxp.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230419090346.1671130-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Neeraj,


Thank you for your patch.

Am 19.04.23 um 11:03 schrieb Neeraj Sanjay Kale:
> This enables flow control before checking for bootloader signature and
> deciding whether FW download is needed or not. In case of V1 bootloader
> chips w8987 and w8997, it is observed that if WLAN FW is downloaded first
> and power save is enabled in wlan core, bootloader signatures are not
> emitted by the BT core when the chip is put to sleep. This results in BT
> FW download timeout error.

If there is a log message, maybe paste it.

> By enabling the flow control, the host enables
> its RTS pin, and an interrupt in chip's UART peripheral causes the
> bootloader to wakeup, enabling the bootloader signatures, which then helps

Nit: The verb wake up is spelled with a space.

> in downloading the bluetooth FW file.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>   drivers/bluetooth/btnxpuart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 93f3afc0c0c8..3ee41a0d45e7 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -967,7 +967,7 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
>   static int nxp_check_boot_sign(struct btnxpuart_dev *nxpdev)
>   {
>   	serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_PRI_BAUDRATE);
> -	serdev_device_set_flow_control(nxpdev->serdev, 0);
> +	serdev_device_set_flow_control(nxpdev->serdev, 1);

It was explicitly disabled before. Is it on by default?

Also, is there now a redundant line later in the flow enabling flow 
control, or was it never enabled?

Other place in the source code seem to use `true` or `false` instead of 1/0.

>   	set_bit(BTNXPUART_CHECK_BOOT_SIGNATURE, &nxpdev->tx_state);
>   
>   	return wait_event_interruptible_timeout(nxpdev->check_boot_sign_wait_q,


Kind regards,

Paul
