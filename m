Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BDF6B466B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjCJOm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjCJOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:42:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0B121145;
        Fri, 10 Mar 2023 06:42:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B351EB822DE;
        Fri, 10 Mar 2023 14:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEDDC4339E;
        Fri, 10 Mar 2023 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678459349;
        bh=QJI8jxSgxgCLw9wGmPZcqm/kqPEh7EYtxapd36JTFFI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jagdd7lRHQi3lc3huqDqkxQNWUIs3SIcRlDMZoAGSNrqo1TFz6+k0nh5wfP1cHiYE
         jk5xn3GFxPY0pshfPnoHZmk5wzfjItgeEuGvMahBBckgClGiCjWIes9VLYkBtb19ya
         yBY4UV29JAESz+KTz3bequANVsoU2UZ9ZG1GomhUXReTT/MGVbeJJD1EMNXxG6m90o
         KV60xDeMOb3TEbq0BshOq1Pan0uljZEpVwfpGzRcqFBclgSeIIBpHHh5/z8L733w/4
         1wcbFqryw/pllWlsSDcz6MgNNys1ZncdovQ5K3YfaUAtB8SFF2nnUHWg8zrz0kDrA+
         TZq2uyV6YExAA==
Date:   Fri, 10 Mar 2023 15:42:31 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Philippe Troin <phil@fifi.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: add HP 13t-aw100 & 14t-ea100 digitizer battery
 quirks
In-Reply-To: <20230306185026.8B85A1A0008D@ceramic.home.fifi.org>
Message-ID: <nycvar.YFH.7.76.2303101542240.1142@cbobk.fhfr.pm>
References: <20230306185026.8B85A1A0008D@ceramic.home.fifi.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023, Philippe Troin wrote:

> Similar to many other devices using the Synopsys Designware Elantech
> hardware, HP Spectre x360 13t-aw100 and 14t-ea100 report an empty
> battery devices, supposedly for the active stylus.
> 
> Apply the HID_BATTERY_QUIRK_IGNORE quirk to ignore the battery reports
> from these devices. Note that there are multiple versions of the panel
> installed in the 14t-ea100.
> 
> Signed-off-by: Philippe Troin <phil@fifi.org>
> ---
>  drivers/hid/hid-ids.h   | 3 +++
>  drivers/hid/hid-input.c | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 63545cd307e5..22e716b66fb8 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -420,6 +420,9 @@
>  #define I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN	0x261A
>  #define I2C_DEVICE_ID_SURFACE_GO2_TOUCHSCREEN	0x2A1C
>  #define I2C_DEVICE_ID_LENOVO_YOGA_C630_TOUCHSCREEN	0x279F
> +#define I2C_DEVICE_ID_HP_SPECTRE_X360_13T_AW100	0x29F5
> +#define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1	0x2BED
> +#define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2	0x2BEE
>  
>  #define USB_VENDOR_ID_ELECOM		0x056e
>  #define USB_DEVICE_ID_ELECOM_BM084	0x0061
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 7fc967964dd8..5c65a584b3fa 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -398,6 +398,12 @@ static const struct hid_device_id hid_battery_quirks[] = {
>  	  HID_BATTERY_QUIRK_IGNORE },
>  	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_LENOVO_YOGA_C630_TOUCHSCREEN),
>  	  HID_BATTERY_QUIRK_IGNORE },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_13T_AW100),
> +	  HID_BATTERY_QUIRK_IGNORE },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1),
> +	  HID_BATTERY_QUIRK_IGNORE },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2),
> +	  HID_BATTERY_QUIRK_IGNORE },

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

