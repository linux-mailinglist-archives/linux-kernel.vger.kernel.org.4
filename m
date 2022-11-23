Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E05635387
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiKWI4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbiKWI4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:56:19 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6547FDD87;
        Wed, 23 Nov 2022 00:56:10 -0800 (PST)
Message-ID: <ff604843-f4d6-df33-c7d0-c613014e4b53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669193768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmj3iGmMmrXHk3HK77keyYkqNEJHYSCRlerSaDAfDUk=;
        b=D5Aj3RhtwMWJnDMUva6Mjt9xgD0ci30UClHNBQTvnZDiNA5KEbTIY34G2wcfpcT1hCXeQ6
        5YGZ90JHwk/EjsjViF1j8zIO446hE9MtBykM8ugD0CrsE7o5L7TRfgJPeSkHvv1IGQTNtB
        IWYpGRa8+o75OZR9gjeTF/h6Ucc2W90=
Date:   Wed, 23 Nov 2022 16:56:01 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4] media: uvcvideo: Fix bandwidth error for Alcor camera
Content-Language: en-US
To:     Ai Chao <aichao@kylinos.cn>, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, ribalda@chromium.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221122084833.1241078-1-aichao@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <20221122084833.1241078-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chao.

在 2022/11/22 16:48, Ai Chao 写道:
> For Alcor Corp. Slave camera(1b17:6684/2017:0011), it support to output
>   compressed video data, and it return a wrong dwMaxPayloadTransferSize
Instead of starting with a space, please start with a letter.
>   fields. This is a fireware issue, but the manufacturer cannot provide
>   a const return fieldsby the fireware. For some device, it requested

s/fireware/firmware/ ???

>   2752512 B/frame bandwidth. For normally device, it requested 3072 or 1024
>   B/frame bandwidth. so we check the dwMaxPayloadTransferSize fields,if it
>   large than 0x1000, reset dwMaxPayloadTransferSize to 1024, and the camera
>   preview normally.

Until here.

>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
>
> ---
> change for v4
> - Change usb_match_one_id to usb_match_id
> - Modify the discription
>
> change for v3
> - Add VID/PID 2017:0011
>
> change for v2
> - Used usb_match_one_id to check VID and PID
> ---
> ---
>   drivers/media/usb/uvc/uvc_video.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d2eb9066e4dc..75bdd71d0e5a 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -135,6 +135,11 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>   	static const struct usb_device_id elgato_cam_link_4k = {
>   		USB_DEVICE(0x0fd9, 0x0066)
>   	};
> +	static const struct usb_device_id alcor_corp_slave_cam[] = {
> +		{ USB_DEVICE(0x2017, 0x0011) },
> +		{ USB_DEVICE(0x1b17, 0x6684) },
> +		{ }
> +	};
>   	struct uvc_format *format = NULL;
>   	struct uvc_frame *frame = NULL;
>   	unsigned int i;
> @@ -234,6 +239,13 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>   
>   		ctrl->dwMaxPayloadTransferSize = bandwidth;
>   	}
> +
> +	/* Alcor Corp. Slave camera return wrong dwMaxPayloadTransferSize */
> +	if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&
> +	    (ctrl->dwMaxPayloadTransferSize > 0x1000) &&
> +	    usb_match_id(stream->dev->intf, alcor_corp_slave_cam)) {
> +		ctrl->dwMaxPayloadTransferSize = 1024;
> +	}
>   }
>   
>   static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)

Others, LGTM.

Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>

-- 
Jackie Liu
