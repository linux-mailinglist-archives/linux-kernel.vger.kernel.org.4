Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F086C0D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCTJhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjCTJhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:37:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE391E9F3;
        Mon, 20 Mar 2023 02:36:58 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB726660304E;
        Mon, 20 Mar 2023 09:36:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679305016;
        bh=Uo+9AluIFHmPV3bJSGzE3eP0NjmNNQjHzY/90Htnz0U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mTXafobedk+s9r3j4lM/QrT5+exwAA+jAg5UooCsd1nu3MU3dRYE0pzqgfJDfarOi
         pRuDPUTnkT/bpQP9TWNrWKrrmzfgDbqaTofFggCsya6Cz0U6q2aP9HyWLelcSVvOX3
         3TbKxlwgOYvHsD23rudl02BlL90W9Yc+i9+6kId61Zkdyf/nJ/b1lJKFc5Pfn+yN+P
         EsDCYFwcmVwYNb16VWQf37oOJBegUvkhNmLGHrnEXyVGcO1xDco1gBqnmsmcGsZs7e
         7MnWBnvu/mEsyX2eTjjYZ4xdlERGxhqCU8WZOQj0pBq7Euz2dgiFcFGesYS++1jX0p
         QxC2TmuGh6bfA==
Message-ID: <a284ec03-1cc7-a109-8548-6afc434681ee@collabora.com>
Date:   Mon, 20 Mar 2023 10:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5,2/2] media: mediatek: vcodec: Force capture queue
 format to MM21
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230318035651.27454-1-yunfei.dong@mediatek.com>
 <20230318035651.27454-2-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230318035651.27454-2-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/03/23 04:56, Yunfei Dong ha scritto:
> While the decoder can produce frames in both MM21 and MT21C formats, only MM21
> is currently supported by userspace tools (like gstreamer and libyuv). In order
> to ensure userspace keeps working after the SCP firmware is updated to support
> both MM21 and MT21C formats, force the MM21 format for the capture queue.
> 
> This is meant as a stopgap solution while dynamic format switching between
> MM21 and MT21C isn't implemented in the driver.
> 
> Fixes: 7501edef6b1f ("media: mediatek: vcodec: Different codec using different capture format")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: Nicolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nicolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


