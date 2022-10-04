Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB425F3F47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiJDJSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJDJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:18:06 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478742CCBE;
        Tue,  4 Oct 2022 02:18:04 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1A3A661EA1930;
        Tue,  4 Oct 2022 11:18:01 +0200 (CEST)
Message-ID: <96d37e06-3bba-ee4a-d81d-f784aa7dbf03@molgen.mpg.de>
Date:   Tue, 4 Oct 2022 11:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] Bluetooth: btusb: Introduce generic USB reset
Content-Language: en-US
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        Ying Hsu <yinghsu@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20221004163224.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221004163224.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Archie,


Thank you for the patch.

Am 04.10.22 um 10:32 schrieb Archie Pusaka:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> On cmd_timeout and there is no reset_gpio, reset the USB port as a

Maybe:

s/there is no/with no/g

> last resort.

Can you please document your test setup, and also mention that you 
change the behavior of:

1.  btusb_intel_cmd_timeout
2.  btusb_rtl_cmd_timeout

[…]


Kind regards,

Paul


> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> Reviewed-by: Ying Hsu <yinghsu@chromium.org>
> 
> ---
> 
>   drivers/bluetooth/btusb.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 271963805a38..11040124ef79 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -696,6 +696,19 @@ struct btusb_data {
>   	unsigned cmd_timeout_cnt;
>   };
>   
> +static void generic_usb_reset(struct hci_dev *hdev, struct btusb_data *data)
> +{
> +	int err;
> +
> +	bt_dev_err(hdev, "Resetting usb device.");
> +	/* This is not an unbalanced PM reference since the device will reset */
> +	err = usb_autopm_get_interface(data->intf);
> +	if (!err)
> +		usb_queue_reset_device(data->intf);
> +	else
> +		bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);
> +}
> +
>   static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
>   {
>   	struct btusb_data *data = hci_get_drvdata(hdev);
> @@ -705,7 +718,7 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
>   		return;
>   
>   	if (!reset_gpio) {
> -		bt_dev_err(hdev, "No way to reset. Ignoring and continuing");
> +		generic_usb_reset(hdev, data);
>   		return;
>   	}
>   
> @@ -736,7 +749,7 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
>   		return;
>   
>   	if (!reset_gpio) {
> -		bt_dev_err(hdev, "No gpio to reset Realtek device, ignoring");
> +		generic_usb_reset(hdev, data);
>   		return;
>   	}
>   
> @@ -761,7 +774,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
>   {
>   	struct btusb_data *data = hci_get_drvdata(hdev);
>   	struct gpio_desc *reset_gpio = data->reset_gpio;
> -	int err;
>   
>   	if (++data->cmd_timeout_cnt < 5)
>   		return;
> @@ -787,13 +799,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
>   		return;
>   	}
>   
> -	bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
> -	/* This is not an unbalanced PM reference since the device will reset */
> -	err = usb_autopm_get_interface(data->intf);
> -	if (!err)
> -		usb_queue_reset_device(data->intf);
> -	else
> -		bt_dev_err(hdev, "Failed usb_autopm_get_interface with %d", err);
> +	generic_usb_reset(hdev, data);
>   }
>   
>   static inline void btusb_free_frags(struct btusb_data *data)
