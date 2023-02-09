Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD1F690959
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBIM4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBIM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:56:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A653CA08;
        Thu,  9 Feb 2023 04:56:51 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B4E7766020C1;
        Thu,  9 Feb 2023 12:56:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675947410;
        bh=B5hP3G6FgIwkwEQg0vRoKUhdtFs0lIrWXYoejF8e8E8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DpNy81Y8cZBUImPcWpwdydIZDClrhB11oZkdB51NOK1gdJxTSZKa17INB6Y1qOA/e
         1aBmlAIARNWb05savxMJ34bL1fEHn13Xxc2YLaIrQK8HWlxrjKDZij9GO45nzBQhjn
         YuxI0QTVwSzZKW62zvUvRnd5b1OwwIaIQd1LXWLo9UqM6F2Dg7DC1x4ApKe9+oBk4i
         loSoUCPgPnZO/w/0yMqrEpm7uOa3/TKrOhHzgLVSznM7Y8xdZqd9UvMzpOEZwyxxKg
         /YA1Dvjh27HhPl18JDBra/T38K5VUZLdfPcVnwlcnllMegylMsh3zyO8az1Q3genrP
         LELxvgOf5mSQA==
Message-ID: <28f167b7-c468-8752-29d1-2a122e8142dd@collabora.com>
Date:   Thu, 9 Feb 2023 13:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] media: mediatek: vcodec: Force capture queue format to
 MM21
Content-Language: en-US
To:     Tommaso Merciai <tomm.merciai@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230209074025.1816-1-yunfei.dong@mediatek.com>
 <Y+S1cA4PXT1MVJm8@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Y+S1cA4PXT1MVJm8@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/02/23 09:57, Tommaso Merciai ha scritto:
> Hi Yunfei Dong,
> 
> On Thu, Feb 09, 2023 at 03:40:25PM +0800, Yunfei Dong wrote:
>> In order to conver the format of capture queue from mediatek MM21 to
>> standard yuv420 with Libyuv, need to force capture queue format to
>> MM21 for Libyuv can't covert mediatek MT21 format.
> 
> Sorry, just some clarifications on my side, just to understand :)
> The problem is that libyuv can't convert mm21 format into yuv420
> than you need to use mm21 (forcing this).
> Did I understand correctly?
> 

vcodec can output either MM21 or MT21C; libyuv can't handle the MT21C format,
at least for now, hence he is forcing vcodec to always give MM21 for things
to actually work... at a later time, I hope and suppose that this driver will
change to not force anything anymore.

> Thanks in advance,
> Tommaso
> 

Yunfei, since this is required to get "basic" functionality, this commit needs
a Fixes tag: can you please add the right one?

Thanks!
Angelo


