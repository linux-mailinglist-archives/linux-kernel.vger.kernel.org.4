Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D061D6D5F53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjDDLnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjDDLnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:43:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270A199E;
        Tue,  4 Apr 2023 04:43:11 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F0AD17F8;
        Tue,  4 Apr 2023 13:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680608589;
        bh=BU08CCqdOeu/LcxZYn91p63mOw0uMiEjv7Vyull9bio=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JNUDGUqCcv8f8HzS+lS/1m2zv6gYP0td+9UvvUVNxX/SDC77d6YSxdOWqqXzm5ic0
         mx+p5z3OCbWOF7u64uukvn9kGi1YHb7j+0TD1VPdhcAsxEKcvw9VGHIczHh6GHSv6A
         YW+SsEC27lT3WHXKN1Brsjx+NkT2BnhFR5unsrhk=
Message-ID: <781c9273-24c5-8b0d-b810-a5eb9b98679e@ideasonboard.com>
Date:   Tue, 4 Apr 2023 14:43:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 10/13] media: ti: Add CSI2RX support for J721E
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        mripard@kernel.org, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sakari.ailus@linux.intel.com,
        linux-kernel@vger.kernel.org, bparrot@ti.com,
        niklas.soderlund+renesas@ragnatech.se, j-luthra@ti.com,
        devarsht@ti.com, praneeth@ti.com, u-kumar1@ti.com, vigneshr@ti.com,
        nm@ti.com, martyn.welch@collabora.com
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <20230314115516.667-11-vaishnav.a@ti.com>
 <20230324181425.GM18895@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230324181425.GM18895@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 20:14, Laurent Pinchart wrote:

>> +static int ti_csi2rx_link_validate_get_fmt(struct media_pad *pad,
>> +					   struct v4l2_subdev_format *fmt)
>> +{
>> +	if (is_media_entity_v4l2_subdev(pad->entity)) {
>> +		struct v4l2_subdev *sd =
>> +			media_entity_to_v4l2_subdev(pad->entity);
>> +
>> +		fmt->which = V4L2_SUBDEV_FORMAT_ACTIVE;
>> +		fmt->pad = pad->index;
>> +		return v4l2_subdev_call(sd, pad, get_fmt, NULL, fmt);
> 
> This will crash with any source that uses the subdev active state. You
> can't pass NULL for the state here.
> 
> How about exporting v4l2_subdev_link_validate_get_format() instead, to
> replace this function ?

I don't think that's a good idea, or needed. 
v4l2_subdev_link_validate_get_format() is an internal helper. Exporting 
it would potentially make maintenance more difficult in the future.

Here, you know the source is the cdns csi2rx. It's always a subdev, so 
is_media_entity_v4l2_subdev() is not needed (I'm not sure why it's used 
in v4l2_subdev_link_validate_get_format either...).

You can use v4l2_subdev_call_state_active() to call the get_fmt here.

Also, the fmt doesn't seem to be initialized to zero, so it'll contain 
garbage in, e.g. the stream field.

Moving to another topic, cdns-csi2rx driver is already (before this 
series) in upstream, but afaics j7 is the only user for it. In other 
words, it's not in use before this series.

I think it would make sense to convert cdns-csi2rx to use subdev state 
first, before adding the j7 csi2rx. That shouldn't be much work, and 
will clean up the driver nicely. With that you could also simplify the 
ti_csi2rx_link_validate by just locking the cdns csi2rx state, and using 
it directly, without using get_fmt and getting the copy of the format. 
It would also help later when adding streams support.

Personally I'd go straight to streams support, as adding it afterwards 
might have some pain points (based on my CAL experience...). At least 
WIP streams patches on top would be a very good thing to have, as they 
will highlight if there are any major changes needed.

  Tomi

