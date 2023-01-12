Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EE3668446
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjALUug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbjALUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:49:57 -0500
X-Greylist: delayed 1346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 12:20:20 PST
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89D12609;
        Thu, 12 Jan 2023 12:20:20 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 83B4FC80091;
        Thu, 12 Jan 2023 20:57:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Et299hrPquQa; Thu, 12 Jan 2023 20:57:52 +0100 (CET)
Received: from [192.168.176.165] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 6319BC8008D;
        Thu, 12 Jan 2023 20:57:51 +0100 (CET)
Message-ID: <5824c823-dced-bdff-dbd1-5cec9e89480f@tuxedocomputers.com>
Date:   Thu, 12 Jan 2023 20:57:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 09/13] HID: i2c-hid: acpi: Stop setting wakeup_capable
Content-Language: en-US
To:     Raul E Rangel <rrangel@chromium.org>, linux-acpi@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20220929093200.v6.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 29.09.22 um 18:19 schrieb Raul E Rangel:
> This is now handled by the i2c-core drive >
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> (no changes since v5)
> 
> Changes in v5:
> - Added Acked-by: Benjamin Tissoires
> 
>   drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> index b96ae15e0ad917e..375c77c3db74d92 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> @@ -105,11 +105,6 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
>   
>   	acpi_device_fix_up_power(adev);
>   
> -	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> -		device_set_wakeup_capable(dev, true);
> -		device_set_wakeup_enable(dev, false);
> -	}
> -
>   	return i2c_hid_core_probe(client, &ihid_acpi->ops,
>   				  hid_descriptor_address, 0);
>   }

this patch is causing a regression on the Clevo NL50RU of which the touchpad 
instantly wakes up the device when going to sleep. That wasn't triggered until 
this patch by the default settings: Setting wake capable but not enabling it by 
default. So unless a user enabled it by hand, the device went correctly to sleep.

I'm not deep into this subsystem so I don't know what the best approach is to 
?work around this firmware bug?/?fix this issue?:
- Changing the default back again?
- Adding a quirk list for bad devices?
- Maybe this isn't a firmware bug, but the touchpad was not meant to wakeup the 
device and we can somehow detect that?

For reference: The debugging issue that lead me here: 
https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1719789

Kind regards,
Werner
