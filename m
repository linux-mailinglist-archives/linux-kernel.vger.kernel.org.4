Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF7D705155
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjEPO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjEPO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:56:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2444AD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:56:00 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A21EF66058F7;
        Tue, 16 May 2023 15:55:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684248958;
        bh=A4ghUFGtUYGU+mfPLHdDtAdikMKuNk5QXqN5HGiifkY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l6JzNxYnLdBMJMUF7phZbXums/Tk1uG/m1vOZ+yGslG8K6suBMltTmgy0f35wA90W
         +iGuvufTJpHwl7SXtpg71EXlFI8gUmQsEAuyiqqsSulAjKHFu8IA80zRPnx3efsx1N
         ArNSFASWlfNvx/XJ5v2sWNM7lb32+lpEHeZnCkpntR3Ol84e1kfFQqwSJ+F9bT182Q
         hcx3VaLjAN1XekVoYBPF+PKSTnMdWkhro/zHqX6dvYJJbmMTiz331iV0Wt6Z5t2gZH
         J1MiLGewZMe3gB4bEbfIDhfDbWESRQ2ayLWN9SrKDVVsSu3CUhd/x33oEtCXW9bG7R
         MmvNPXmgEsE0g==
Message-ID: <de62cddc-affe-297c-f020-425f80e683fe@collabora.com>
Date:   Tue, 16 May 2023 16:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/2] phy: mtk-mipi-csi: add driver for CSI phy
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        chunkuang.hu@kernel.org, linux-mediatek@lists.infradead.org,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-3-jstephan@baylibre.com>
 <cd6067b2-660a-8f2c-697d-26814a9dc131@collabora.com>
 <b2nk4jw2hpy4ndoq4cojazkn6h3tra2zjffhiswb7aqryabf7q@mkbtzhzcbivv>
 <54e6923c-729a-49de-8395-fbd0b8443aa8@collabora.com>
 <shthzc3zekvm2mrcch6vexsq5djpoxwupvdmmovhrz2ack3wxx@s4ptfhq7iwvi>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <shthzc3zekvm2mrcch6vexsq5djpoxwupvdmmovhrz2ack3wxx@s4ptfhq7iwvi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/05/23 11:30, Julien Stephan ha scritto:
> On Mon, May 15, 2023 at 04:32:42PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 15/05/23 16:07, Julien Stephan ha scritto:
>>> On Mon, May 15, 2023 at 02:22:52PM +0200, AngeloGioacchino Del Regno wrote:
>>>>> +#define CSIxB_OFFSET		0x1000
>>>>
>>>> What if we grab two (or three?) iospaces from devicetree?
>>>>
>>>> - base (global)
>>>> - csi_a
>>>> - csi_b
>>>>
>>>> That would make it possible to maybe eventually extend this driver to more
>>>> versions (older or newer) of the CSI PHY IP without putting fixes offsets
>>>> inside of platform data structures and such.
>>>>
>>> Hi Angelo,
>>> The register bank of the CSI port is divided into 2:
>>> * from base address to base + 0x1000 (port A)
>>> * from base + 0x1000 to base +0x2000 (port B)
>>> Some CSI port can be configured in 4D1C mode (4 data + 1 clock) using
>>> the whole register bank from base to base + 0x2000 or in 2D1C mode (2 data +
>>> 1 clock) and use either port A or port B.
>>>
>>> For example  mt8365 has CSI0 that can be used either in 4D1C mode or in
>>> 2 * 2D1C and CSI1 which can use only 4D1C mode
>>>
>>> 2D1C mode can not be tested and is not implemented in the driver so
>>> I guess adding csi_a and csi_b reg value may be confusing?
>>>
>>> What do you think?
>>
>> Ok so we're talking about two data lanes per CSI port... it may still be
>> beneficial to split the two register regions as
>>
>> reg-names = "csi-a", "csi-b"; (whoops, I actually used underscores before,
>>                                 and that was a mistake, sorry!)
>>
>> ....but that would be actually good only if we are expecting to get a CSI
>> PHY in the future with four data lanes per port.
>>
>> If you do *not* expect at all such a CSI PHY, or you do *not* expect such
>> a PHY to ever be compatible with this driver (read as: if you expect such
>> a PHY to be literally completely different from this one), then it would
>> not change much to have the registers split in two.
>>
>> Another case in which it would make sense is if we were to get a PHY that
>> provides more than two CSI ports: in that case, we'd avoid platform data
>> machinery to check the number of actual ports in the IP, as we would be
>> just checking how many register regions we were given from the devicetree,
>> meaning that if we got "csi-a", "csi-b", "csi-c", "csi-d", we have four
>> ports.
>>
>> Besides, another thing to think about is... yes you cannot test nor implement
>> 2D1C mode in your submission, but this doesn't mean that others won't ever be
>> interested in this and that other people won't be actually implementing that;
>> Providing them with the right initial driver structure will surely make things
>> easier, encouraging other people from the community to spend their precious
>> time on the topic.
>>
> Hi Angelo,
> Ok, I see your point, but for future potential upgrade to support A/B
> ports I was thinking of something else: adding independent nodes for csixA
> and csixB such as:
> 
> csi0_rx: phy@11c10000 {
>    reg = <0 0x11C10000 0 0x2000>;
>    mediatek,mode = <4D1c>;
>    ...
> };
> 
> csi0a_rx: phy@11c10000 {
>    reg = <0 0x11C10000 0 0x1000>;
>    mediatek,mode = <2D1c>;
>    ...
> };
> csi0b_rx: phy@11c11000 {
>    reg = <0 0x11C11000 0 0x1000>;
>    mediatek,mode = <2D1c>;
>    ...
> };
> 
> giving the correct register range. One thing I did not mention is that if
> csi0_rx is used csi0a_rx and csi0b_rx cannot be used (they share same
> physical lanes as csio_rx), but csi0a_rx and csi0b_rx can be used simultaneously.
> So platform device will enable only the node(s) it needs and enabling
> csi0_rx and csioa/b_rx will fail because they share the same register
> region and map will fail and it does not have any sense because you
> either have a camera using the whole port or sub port but you cannot have
> both plugged in. What do you think about it?
> 

Your description of the hardware makes me even more confident in pushing for
having one single node with multiple iospaces.

You could have a node such as:

csi0_rx: phy@11c10000 {
	compatible = ....
	reg = <0 0x11c10000 0 0x1000>, <0 0x11c20000 0 0x1000>;
	reg-names = "csi-a", "csi-b";
	/* 4 means 4D1C */
	num-lanes = <4>;
		or
	/* 2 means 2D1C */
	num-lanes = <2>;
};

You would then reference the csi0_rx node as:

	/* PHY is configured as 4 lanes (4D1C) */
	something = <&csi0_rx 0>;

	or

	/* First two lanes (CSI0 PORT-A) */
	something = <&csi0_rx 0>;
	/* Second two lanes (CSI0 PORT-B) */
	something = <&csi0_rx 1>;

Preferrably, you should (or shall?) use a graph to describe such connections,
anyway.

This is because overriding the number of lanes on a per-board basis becomes
*otherwise* difficult, in the sense of human readability issues, other than
duplicated nodes being a real issue.

Regards,
Angelo

