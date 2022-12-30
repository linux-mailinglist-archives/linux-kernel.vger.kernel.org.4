Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A432D6598DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiL3Nkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiL3Nks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:40:48 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847AB1035;
        Fri, 30 Dec 2022 05:40:47 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DBC638B9;
        Fri, 30 Dec 2022 14:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672407646;
        bh=jUJe1fVvQCMktRfUj7CaQSfXa5sGAtCdcley5MZCF6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wo6fCueyiCZ2RsOmtvsAN21vqr2WN4CQontp8wlMqgr4FNnJlzyHUnqbXAfOwCaHh
         /gNPj3nmMpshBsxN8giXH/BtnCs7JPh28ZGf5aXlQlPpeFHtJbDQ1p4dRiaAnnYCXF
         TJklmHRJyKO3FF/b/Ji36WMVekqEyFFOD159Aeaw=
Date:   Fri, 30 Dec 2022 15:40:41 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/8] media: uvc: Allow quirking by entity guid
Message-ID: <Y67qWROM7rKywU3s@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-2-0d7978a817cc@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v2-2-0d7978a817cc@chromium.org>
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


On Fri, Dec 02, 2022 at 06:02:42PM +0100, Ricardo Ribalda wrote:
> When an IP is shared by multiple devices its erratas will be shared by
> all of them. Instead of creating a long list of device quirks, or
> waiting for the users to report errors in their hardware lets add a
> routine to add quirks based on the entity guid.

I'm not thrilled by this. An entity is not an "IP". Quirks are needed to
handle issues with particular firmware versions on particular devices.
The same entity GUID can be used by different devices running different
firmware versions, some that would require a quirk and some that
wouldn't.

> Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 9c05776f11d1..c63ecfd4617d 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1493,6 +1493,28 @@ static int uvc_parse_control(struct uvc_device *dev)
>  	return 0;
>  }
>  
> +static const struct uvc_entity_quirk {
> +	u8 guid[16];
> +	u32 quirks;
> +} uvc_entity_quirk[] = {
> +};
> +
> +static void uvc_entity_quirks(struct uvc_device *dev)
> +{
> +	struct uvc_entity *entity;
> +	int i;

unsigned int

> +
> +	list_for_each_entry(entity, &dev->entities, list) {
> +		for (i = 0; i < ARRAY_SIZE(uvc_entity_quirk); i++) {
> +			if (memcmp(entity->guid, uvc_entity_quirk[i].guid,
> +				   sizeof(entity->guid)) == 0) {
> +				dev->quirks |= uvc_entity_quirk[i].quirks;
> +				break;
> +			}
> +		}
> +	}
> +}
> +
>  /* -----------------------------------------------------------------------------
>   * Privacy GPIO
>   */
> @@ -2452,6 +2474,9 @@ static int uvc_probe(struct usb_interface *intf,
>  		goto error;
>  	}
>  
> +	/* Apply entity based quirks */
> +	uvc_entity_quirks(dev);
> +
>  	dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
>  		 dev->uvc_version >> 8, dev->uvc_version & 0xff,
>  		 udev->product ? udev->product : "<unnamed>",
> 

-- 
Regards,

Laurent Pinchart
