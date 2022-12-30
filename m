Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6BD6598C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiL3NhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3Ng7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:36:59 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59844DE8D;
        Fri, 30 Dec 2022 05:36:58 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BCBE2F5;
        Fri, 30 Dec 2022 14:36:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672407416;
        bh=wv1AV7X/uWKMU9wRGXYtfli0dTrUxZJgNcnxbZIPMXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JA/F++lUFbYj5/xuzDD3FHhbE5B10JhVIpFjw3sYsQbkEs1PmdzEaIq2/j6I72GQo
         3CNbYv9oWbQlzvuQivJ2i/DR8SSFxnka6Os+eSSy2LXUvMvND7ZqtA8ksyuKba3wST
         QeXWozDmsYuiN1jn1utg0zlDGcZEFmC/SpYQ5yGE=
Date:   Fri, 30 Dec 2022 15:36:51 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/8] media: uvc: Extend documentation of
 uvc_video_clock_decode()
Message-ID: <Y67pc3ZEoteZ0S2l@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-1-0d7978a817cc@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v2-1-0d7978a817cc@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

s/uvc/uvcvideo/ in the subject line.

On Fri, Dec 02, 2022 at 06:02:41PM +0100, Ricardo Ribalda wrote:
> Make a explicit reference to uvc 1.5, explaining how the algorithm

s/a explicit/an explicit/
s/uvc/UVC/

> supports the different behaviour of uvc 1.1 and 1.5.

Ditto.

> Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 170a008f4006..ab56e65ca324 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -517,6 +517,9 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  	/*
>  	 * To limit the amount of data, drop SCRs with an SOF identical to the
>  	 * previous one.
> +	 * This filtering is also needed for supporting UVC 1.5. Where all the
> +	 * data packages of the same frame contains the same sof. In that case
> +	 * only the first one will match the host_sof.

  	 * To limit the amount of data, drop SCRs with an SOF identical to the
  	 * previous one. This filtering is also needed to support UVC 1.5, where
	 * all the data packets of the same frame contains the same SOF. In that
	 * case only the first one will match the host_sof.

Conditionally-Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I can fix this when applying if there's no other need to submit a v3.

>  	 */
>  	dev_sof = get_unaligned_le16(&data[header_size - 2]);
>  	if (dev_sof == stream->clock.last_sof)
> 

-- 
Regards,

Laurent Pinchart
