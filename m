Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58B16D7CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbjDEMbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjDEMbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:31:35 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6032C1BD0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:31:34 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8346685F7F;
        Wed,  5 Apr 2023 14:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1680697892;
        bh=qNqzvu4NApAiCop59NMMwGn31purYKOu6gBuay5tl0o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EphCrJcFmFxaXYH8FXF1+7h4KVOMmZQHJDBAC5vusb+wp3J9LydhVYGKXYTPRbY00
         wJPRUyMP58xsR5gMby1mtCFLTWu2oe9L8JCh1cVszN/JQiFLGFE794ewSa/kvZD7hS
         OJc/uQvJwNFWwqt50UfV2pRVv920xno+ll9zMxLBqnT3K29M09JyUikhgOQop+lt9B
         8HIYVDiZ2/jyf8zovS979ibJAVdueDLoA/FYFuEQvzO3w1F0riBmZ/DcnnUgMZYiQI
         YR9lM2iCCLTcwGIQ3lwO4K6N0d7Nbfxocg4VFg1aNEsEYcJi8PaLLSaQXbJCGsnBGf
         u4jSuVjJd6ViA==
Message-ID: <4b15b282-7243-3f75-4a2e-ba86791f6431@denx.de>
Date:   Wed, 5 Apr 2023 14:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm: bridge: ldb: add support for using channel 1 only
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20230404073720.1465552-1-luca.ceresoli@bootlin.com>
 <5b514970-cfc8-41de-7ae6-f608f5187860@denx.de>
 <20230405093017.62ccb4f6@booty>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230405093017.62ccb4f6@booty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 09:30, Luca Ceresoli wrote:

[...]

>>> @@ -311,10 +314,23 @@ static int fsl_ldb_probe(struct platform_device *pdev)
>>>    	if (IS_ERR(fsl_ldb->regmap))
>>>    		return PTR_ERR(fsl_ldb->regmap);
>>>    
>>> -	/* Locate the panel DT node. */
>>> -	panel_node = of_graph_get_remote_node(dev->of_node, 1, 0);
>>> -	if (!panel_node)
>>> -		return -ENXIO;
>>> +	/* Locate the remote ports and the panel node */
>>> +	remote1 = of_graph_get_remote_node(dev->of_node, 1, 0);
>>> +	remote2 = of_graph_get_remote_node(dev->of_node, 2, 0);
>>> +	fsl_ldb->ch0_enabled = (remote1 != NULL);
>>> +	fsl_ldb->ch1_enabled = (remote2 != NULL);
>>> +	panel_node = of_node_get(remote1 ? remote1 : remote2);
>>
>> You can even do this without the middle 'remote1' I think:
>>
>> panel_node = of_node_get(remote1 ? : remote2);
> 
> Apparently, but honestly with such short expressions clearly having no
> side effects I think it's not helping readability.

I think even the ternary operator itself isn't helpful much, but that's 
a matter of taste, and I don't have a better suggestion which would 
improve the readability either (I tried to expand it into if()... but 
that looks bad too).

No need to change anything.

[...]

Thanks for the patch.
