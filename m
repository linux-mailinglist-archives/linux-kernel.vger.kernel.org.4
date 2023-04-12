Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA56DED36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDLIGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLIGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:06:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7E32100
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:06:31 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A856F66031FF;
        Wed, 12 Apr 2023 09:06:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681286789;
        bh=jwulId4nLUPcaw4BGk1KKXtBppWVtodS0kpW0W1yZiQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WYZWNGIRibERfGpNAaJvjB9EBu3kf8VWvlTd2PwEopynZ+waRY/xEs/bV3+iScqdm
         rmPFvNRz6mPUPZd8jQqKKYvAMRve/jPY/FhVD1szcA9abbC8/y81yn/y5gzi//NAQm
         k9rg0bQLDv6yJ1fIl15EqJx1xdq+kAq1mqtMHxeyEh5NYx14GNFz09+uF1cNr+snjl
         +VQXyLLHwM9MBAR3XBAbOXdsu7oLsafPb57FPkkC4KUW+p4fFeMYWY1f9iFnq4f6s6
         JuxMEIoMTjFaY6lU22+Ug331DW3S0XOrnZv2cjyMgghWqoOLxeUQ6zshtuIcOYztYT
         JRg+8T6BiAxTg==
Message-ID: <783c03af-fc88-96c8-c6fc-6f02051dc6b1@collabora.com>
Date:   Wed, 12 Apr 2023 10:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/9] drm/mediatek: dp: Cache EDID for eDP panel
To:     Matthias Brugger <matthias.bgg@gmail.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
References: <20230404104800.301150-1-angelogioacchino.delregno@collabora.com>
 <20230404104800.301150-2-angelogioacchino.delregno@collabora.com>
 <09c61b94-1ed1-eb72-9682-1f1f203f6f63@gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <09c61b94-1ed1-eb72-9682-1f1f203f6f63@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/04/23 09:08, Matthias Brugger ha scritto:
> 
> 
> On 04/04/2023 12:47, AngeloGioacchino Del Regno wrote:
>> Since eDP panels are not removable it is safe to cache the EDID:
>> this will avoid a relatively long read transaction at every PM
>> resume that is unnecessary only in the "special" case of eDP,
>> hence speeding it up a little, as from now on, as resume operation,
>> we will perform only link training.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dp.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
>> index 1f94fcc144d3..84f82cc68672 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
>> @@ -118,6 +118,7 @@ struct mtk_dp {
>>       const struct mtk_dp_data *data;
>>       struct mtk_dp_info info;
>>       struct mtk_dp_train_info train_info;
>> +    struct edid *edid;
>>       struct platform_device *phy_dev;
>>       struct phy *phy;
>> @@ -1993,7 +1994,11 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge 
>> *bridge,
>>           usleep_range(2000, 5000);
>>       }
>> -    new_edid = drm_get_edid(connector, &mtk_dp->aux.ddc);
>> +    /* eDP panels aren't removable, so we can return a cached EDID. */
>> +    if (mtk_dp->edid && mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP)
>> +        new_edid = drm_edid_duplicate(mtk_dp->edid);
>> +    else
>> +        new_edid = drm_get_edid(connector, &mtk_dp->aux.ddc);
> 
> Maybe it would make sense to add a macro for the check of mtk_dp->bridge.type == 
> DRM_MODE_CONNECTOR_eDP
> it would make the code more readable.
> 

I had the same idea... but then avoided that because in most (if not all?) of the
DRM drivers (at least, the one I've read) this check is always open coded, so I
wrote it like that for consistency and nothing else.

I have no strong opinions on that though!

>>       /*
>>        * Parse capability here to let atomic_get_input_bus_fmts and
>> @@ -2022,6 +2027,10 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge 
>> *bridge,
>>           drm_atomic_bridge_chain_post_disable(bridge, connector->state->state);
>>       }
>> +    /* If this is an eDP panel and the read EDID is good, cache it for later */
>> +    if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP && !mtk_dp->edid && new_edid)
>> +        mtk_dp->edid = drm_edid_duplicate(new_edid);
>> +
> 
> How about putting this in an else if branch of mtk_dp_parse_capabilities. At least 
> we could get rid of the check regarding if new_edid != NULL.
> 
> I was thinking on how to put both if statements in one block, but I think the 
> problem is, that we would leak memory if the capability parsing failes due to the 
> call to drm_edid_duplicate(). Correct?
> 

Correct. The only other "good" place would be in the `if (new_edid)` conditional,
but that wouldn't be as readable as it is right now...

Cheers,
Angelo

