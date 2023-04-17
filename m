Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE46E4441
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjDQJqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjDQJqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:46:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAB36587
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:45:37 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7382D66030BF;
        Mon, 17 Apr 2023 10:44:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681724693;
        bh=3IaKflbgHD9hS5DM4EWVUIZEN11iO1DqpHHauFtwhzs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k2o4JlP+lXIr49d7sofYXSwgAJJ+3ks/Y8jidnv8WVyLffO6f/b6AkNCqDrSS9iZ5
         3DN8DlYYN8tT4urwA+GbfvJqzCAkie0UYYgig4QyDn8P0RZXwb1XwhVLPqYrG123ui
         qXN0PjS3deh3PerPFE1dXOHXcHNldOPkQ2kP2suIG28gJVZEX3GShiJEP7BL5a5tVN
         /nRepjm/uynvvmpnq0kb7VLNXqwNe2op3r+qxaUZwvZnY+xnNRUhJCKShwrEdNwjmN
         l4mKT6SNuudbBXq1DLnNjCrIa3EBE1EvKIU9ZdmWNiUep2eRmYQx0rbBPNKd1gCbgm
         Vreh5DQ5aDUrA==
Message-ID: <51d94c13-853c-519d-f206-722288b5edf4@collabora.com>
Date:   Mon, 17 Apr 2023 11:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/panel: novatek-nt35950: Improve error handling
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230415-konrad-longbois-next-v1-1-ce695dc9df84@linaro.org>
 <ea9f27a2-ce75-01a9-3758-0fe0bfcd1e5e@linaro.org>
 <e9c2e179-eacc-151e-123b-a4e425e76333@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <e9c2e179-eacc-151e-123b-a4e425e76333@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/04/23 11:44, AngeloGioacchino Del Regno ha scritto:
> Il 17/04/23 09:25, Neil Armstrong ha scritto:
>> On 15/04/2023 13:00, Konrad Dybcio wrote:
>>> In a very peculiar case when probing and registering with the secondary
>>> DSI host succeeds, but the OF backlight or DSI attachment fails, the
>>> primary DSI device is automatically cleaned up, but the secondary one
>>> is not, leading to -EEXIST when the driver core tries to handle
>>> -EPROBE_DEFER.
>>>
>>> Unregister the DSI1 device manually on failure to prevent that.
>>>
>>> Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC 
>>> panels")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   drivers/gpu/drm/panel/panel-novatek-nt35950.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c 
>>> b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
>>> index abf752b36a52..7498fc6258bb 100644
>>> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
>>> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
>>> @@ -585,8 +585,11 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
>>>                  DRM_MODE_CONNECTOR_DSI);
>>>       ret = drm_panel_of_backlight(&nt->panel);
>>> -    if (ret)
>>> +    if (ret) {
> 
> If this is not a dual-DSI case, nt->dsi[1] will be NULL: I agree it's still
> fine as in the kernel won't crash in that case, but for logical correctness
> I would still account for that:
> 
>          if (num_dsis == 2)
>              mipi_dsi_device_unregister(nt->dsi[1]);
> 
>>> +        mipi_dsi_device_unregister(nt->dsi[1]);
>>> +
>>>           return dev_err_probe(dev, ret, "Failed to get backlight\n");
>>> +    }
>>>       drm_panel_add(&nt->panel);
>>> @@ -602,6 +605,9 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
>>>           ret = mipi_dsi_attach(nt->dsi[i]);
>>>           if (ret < 0) {
> 
> Same here, please add a check for num_dsis.
> 
> Regards,
> Angelo

Eh, too late, I just noticed that this got picked already...
