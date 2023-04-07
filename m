Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B486DAAA7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbjDGJIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjDGJIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:08:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6BD10E5;
        Fri,  7 Apr 2023 02:08:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A51566031A4;
        Fri,  7 Apr 2023 10:08:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680858526;
        bh=U1+DDX+dU1UQ6EiNs+o75B5KM0xLmP6jEneF+ome3Es=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n81grpCBm+3ZpgR/kR+EEDuOAoXfVthUK/CXHhTiYphnIlXQZ/zbL4jlLROIMoQvH
         cpktvJHTLT8wMJ1su/G7ZWHcJDUHB/LT04F3+qgc65dGhU0zyJrNGuwkKPEoqZmIyy
         V18PJBQhX0h5xLOb+THujMP4XtFAqDgSCiD6FIRQbhEaac1M30KFzXZpItmqdo7Oou
         xU0mZYEBpcnFJhaP9JmIvDDwB2JEFfksQZ/2HW5u3AsINqCjqAT3VHQLHiK9X79Pdv
         i46RnWYKyGHr7WkDwism4VALjRTxFGZ8HA2u4eQLZT8B03Vds2V4KX6dV3pgAzUfqO
         1jmLo7mJSK2XA==
Message-ID: <3f2ba861-10f1-cc5c-caec-6f798486d9cb@collabora.com>
Date:   Fri, 7 Apr 2023 11:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/7] usb: mtu3: fix KE at qmu transfer done irq handler
Content-Language: en-US
To:     =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        =?UTF-8?B?VGlhbnBpbmcgRmFuZyAo5pa55aSp5bmzKQ==?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
 <20230403025230.25035-3-chunfeng.yun@mediatek.com>
 <1cfde490-40a4-c83b-3bd5-c9baeba5187d@collabora.com>
 <40ed6eb5c664b624e85576f957625a61d9615530.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <40ed6eb5c664b624e85576f957625a61d9615530.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/04/23 09:59, Chunfeng Yun (云春峰) ha scritto:
> On Mon, 2023-04-03 at 14:31 +0200, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Il 03/04/23 04:52, Chunfeng Yun ha scritto:
>>> When handle qmu transfer irq, it will unlock @mtu->lock before give
>>> back
>>> request, if another thread hanlde disconnect event at the same
>>> time, and
>>> try to disable ep, it may lock @mtu->lock and free qmu ring, then
>>> qmu
>>> irq hanlder may get a NULL gpd, avoid the KE by checking gpd's
>>> value before
>>
>> KE == Kernel Error? I think you wanted to say KP == Kernel Panic
>> instead.
>>
>> Also, s/hanlder/handler/g.
> Ok, will modify it
>>
>>> handling it.
>>>
>>> e.g.
>>> qmu done irq on cpu0                 thread running on cpu1
>>>
>>> qmu_done_tx()
>>>     handle gpd [0]
>>>       mtu3_requ_complete()        mtu3_gadget_ep_disable()
>>>         unlock @mtu->lock
>>>           give back request         lock @mtu->lock
>>>                                       mtu3_ep_disable()
>>>                                         mtu3_gpd_ring_free()
>>>                                      unlock @mtu->lock
>>>         lock @mtu->lock
>>>       get next gpd [1]
>>>
>>> [1]: goto [0] to handle next gpd, and next gpd may be NULL.
>>
>>   >
>>   > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>
>> This is a fix and needs a Fixes tag.
> I usually add Fixes tag when the issue introduced by a patch except the
> original one when the driver applied.
> 

If this patch is a fix for the "original driver", you shall still add a
Fixes tag which advertises that this fixes the first commit, so the driver
was broken from the very beginning.

Thanks,
Angelo.

