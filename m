Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9489633872
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiKVJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiKVJ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:29:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C925F2F668;
        Tue, 22 Nov 2022 01:29:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BEE9615CC;
        Tue, 22 Nov 2022 09:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3D4C433D7;
        Tue, 22 Nov 2022 09:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669109378;
        bh=gHG9zTs3gcESCSIEtqzL0lojXTHhoW87qwPZ4/mUsqI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hr1v7X8/YDlU4k+8beXAtBMShpzVe9doUgHh8gGi2gCcHQV98gVtgMYgimPxTG1I+
         0vTunFKIbqqgT5aeEvHWOTzto20Errnjq2imWnqLaPbdRasnrF6jGoYUj9pfnyO0+6
         fRVn8z+LV4hSKip9QseLi1sWpi72ZJY6SCBYJUet2nb09AGuOrmGE9fZwkG+m4YXuS
         7UxrlTRf8PlJPCA5zSW8h19BkWxW0wQAOnEZWWm0jdUC8uVLQsJmakt0mRbPfz05B7
         JPB7j3/pzCIhHfQgmlRpNxHkJQi6Jh7W8ertn43uUYzjp66jO9ByDp/Td1RbJxJWV/
         g8gV923AHaLoQ==
Date:   Tue, 22 Nov 2022 10:29:37 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     David Yang <mmyangfl@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: kye: Add support for MousePen M508X
In-Reply-To: <20221119205057.11694-1-mmyangfl@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211221028170.6045@cbobk.fhfr.pm>
References: <20221119191743.6466-1-mmyangfl@gmail.com> <20221119205057.11694-1-mmyangfl@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022, David Yang wrote:

> Genius MousePen M508X digitizer tablet sends incorrect report descriptor by
> default. This patch replaces it with a corrected one.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Thanks for the fix. A few comments below.

> @@ -626,18 +751,24 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  			*rsize = sizeof(easypen_m610x_rdesc_fixed);
>  		}
>  		break;
> -	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
> -		if (*rsize == EASYPEN_M406XE_RDESC_ORIG_SIZE) {
> -			rdesc = easypen_m406xe_rdesc_fixed;
> -			*rsize = sizeof(easypen_m406xe_rdesc_fixed);
> -		}
> -		break;
>  	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
>  		if (*rsize == PENSKETCH_M912_RDESC_ORIG_SIZE) {
>  			rdesc = pensketch_m912_rdesc_fixed;
>  			*rsize = sizeof(pensketch_m912_rdesc_fixed);
>  		}
>  		break;
> +	case USB_DEVICE_ID_KYE_MOUSEPEN_M508X:
> +		if (*rsize == MOUSEPEN_M508X_RDESC_ORIG_SIZE) {
> +			rdesc = mousepen_m508x_rdesc_fixed;
> +			*rsize = sizeof(mousepen_m508x_rdesc_fixed);
> +		}
> +		break;
> +	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
> +		if (*rsize == EASYPEN_M406XE_RDESC_ORIG_SIZE) {
> +			rdesc = easypen_m406xe_rdesc_fixed;
> +			*rsize = sizeof(easypen_m406xe_rdesc_fixed);
> +		}
> +		break;

What is the reason for moving USB_DEVICE_ID_KYE_EASYPEN_M406XE around?

>  	case USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE:
>  		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
>  					"Genius Gila Gaming Mouse");
> @@ -721,8 +852,9 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
>  	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
>  	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
> -	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
>  	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
> +	case USB_DEVICE_ID_KYE_MOUSEPEN_M508X:
> +	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:

Same here.

>  		ret = kye_tablet_enable(hdev);
>  		if (ret) {
>  			hid_err(hdev, "tablet enabling failed\n");
> @@ -756,6 +888,10 @@ static const struct hid_device_id kye_devices[] = {
>  				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
>  				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> +				USB_DEVICE_ID_KYE_PENSKETCH_M912) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> +				USB_DEVICE_ID_KYE_MOUSEPEN_M508X) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
>  				USB_DEVICE_ID_KYE_EASYPEN_M406XE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> @@ -764,8 +900,6 @@ static const struct hid_device_id kye_devices[] = {
>  				USB_DEVICE_ID_GENIUS_GX_IMPERATOR) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
>  				USB_DEVICE_ID_GENIUS_MANTICORE) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
> -				USB_DEVICE_ID_KYE_PENSKETCH_M912) },

This looks unrelated and incorrect, why are you dropping 
USB_DEVICE_ID_KYE_PENSKETCH_M912 from the device table?

Thanks,

-- 
Jiri Kosina
SUSE Labs

