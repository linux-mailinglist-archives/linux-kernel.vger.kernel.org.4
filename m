Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FA56DEFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjDLI4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjDLI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:56:12 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0D9EDE;
        Wed, 12 Apr 2023 01:55:55 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A91E616E;
        Wed, 12 Apr 2023 10:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681289737;
        bh=UDmQ7tdOotgFk5t4ad0iJfZyoWPgoUIsI0VIhJnxXf0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q+TYV5v67df4OrQnVbqUVMf8xRBj/90aGqKD713V8X8PRiI9ynollZUZg6ilFukM9
         vuqxAWUhJBmUyUK5Xcwp1bVUfxUxdRlWFi4PhRLk50PMGDJxHyk1HKjWF1quCwSKNh
         aR8GsekZvyDlCs17zh97oufICfEBn5B+vZIaB4+w=
Message-ID: <2bf56c04-733b-24a5-a344-166a94cd51f7@ideasonboard.com>
Date:   Wed, 12 Apr 2023 11:55:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/omap: dsi: Fix deferred probe warnings
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230412073954.20601-1-tony@atomide.com>
 <20230412085044.GP11253@pendragon.ideasonboard.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230412085044.GP11253@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 11:50, Laurent Pinchart wrote:
> Hi Tony,
> 
> Thank you for the patch.
> 
> On Wed, Apr 12, 2023 at 10:39:53AM +0300, Tony Lindgren wrote:
>> We may not have dsi->dsidev initialized during probe, and that can
>> lead into various dsi related warnings as omap_dsi_host_detach() gets
>> called with dsi->dsidev set to NULL.
>>
>> The warnings can be "Fixed dependency cycle(s)" followed by a
>> WARNING: CPU: 0 PID: 787 at drivers/gpu/drm/omapdrm/dss/dsi.c:4414.
> 
> How can this happen ? I assume .detach() can't be called without a
> priori successful call to .attach(), that that sets dsi->dsidev.

I had a quick look, and the driver calls mipi_dsi_host_register() in 
probe, and mipi_dsi_host_unregister() in remove.

mipi_dsi_host_unregister() always calls mipi_dsi_detach(), but I don't 
think mipi_dsi_host_register() always calls attach, which happens later 
when the peripheral probes.

  Tomi

>> Let's fix the warnings by checking for a valid dsi->dsidev.
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>   drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
>> @@ -4411,7 +4411,7 @@ static int omap_dsi_host_detach(struct mipi_dsi_host *host,
>>   {
>>   	struct dsi_data *dsi = host_to_omap(host);
>>   
>> -	if (WARN_ON(dsi->dsidev != client))
>> +	if (dsi->dsidev && WARN_ON(dsi->dsidev != client))
>>   		return -EINVAL;
>>   
>>   	cancel_delayed_work_sync(&dsi->dsi_disable_work);
> 

