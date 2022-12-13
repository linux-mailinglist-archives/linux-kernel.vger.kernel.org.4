Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0368664B200
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiLMJNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiLMJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D07C115E;
        Tue, 13 Dec 2022 01:09:59 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 72FB36602C2F;
        Tue, 13 Dec 2022 09:09:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670922597;
        bh=O7J/BSi0dbHIU33pWdlPZo0iXo43ZFxCG6/Ttxq4/ck=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i+K4L1Oph/RgbQBE0z/4ckzGYkFAG8RaTNi/LDc8P6hK/etjso8EfpuR/atFD+Rr/
         BJFy9PZiYYMQiXvGob/kwdmmqEynZ2r5WexpfOKTqWgbvmsgD+fX29O57qh7y+g13n
         wfF+rXmODa/2YpgE0XnRlEE7k7SkFaTqAIcc4gpkT9IR9AiNBZ7oAyv03dQlJcgbAb
         sJzelPcYLLqLAezFwq7Bm6qoCdbDdV2Cca5J7599+NpBs/Axk9sWE7XSAtKcaQYqD9
         YB0fGL0ZvcYp3zayeCGXcKw+UQuAPg+H0qjEsPTw7kUM9+19NRgIZBbsKyghrpVdiA
         xW/7ORMf4netQ==
Message-ID: <7e668b90-e3e6-5d25-e894-f754662405af@collabora.com>
Date:   Tue, 13 Dec 2022 10:09:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/5] media: mediatek: vcodec: add params to record lat and
 core lat_buf count
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221210073218.17350-1-yunfei.dong@mediatek.com>
 <20221210073218.17350-2-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221210073218.17350-2-yunfei.dong@mediatek.com>
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

Il 10/12/22 08:32, Yunfei Dong ha scritto:
> Using lat_buf to share decoder information between lat and core work
> queue, adding params to record the buf count.
> 
> Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../platform/mediatek/vcodec/vdec_msg_queue.c | 32 ++++++++++++++++++-
>   .../platform/mediatek/vcodec/vdec_msg_queue.h |  9 ++++++
>   2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> index dc2004790a47..af7ddba1923a 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> @@ -52,6 +52,30 @@ static struct list_head *vdec_get_buf_list(int hardware_index, struct vdec_lat_b
>   	}
>   }
>   
> +static void vdec_msg_queue_inc(struct vdec_msg_queue *msg_queue, int hardware_index)
> +{
> +	mutex_lock(&msg_queue->list_cnt_mutex);

I doubt that you need to use this mutex, as you're using atomics...

> +
> +	if (hardware_index == MTK_VDEC_CORE)
> +		atomic_inc(&msg_queue->core_list_cnt);
> +	else
> +		atomic_inc(&msg_queue->lat_list_cnt);
> +

This branch (with the relevant appropriate changes) can be simplified as

	atomic_inc(&msg_queue->list_cnt[hardware_index]);

...where list_cnt is an array, and hardware_index is an enumeration.	

> +	mutex_unlock(&msg_queue->list_cnt_mutex);
> +}
> +
> +static void vdec_msg_queue_dec(struct vdec_msg_queue *msg_queue, int hardware_index)
> +{
> +	mutex_lock(&msg_queue->list_cnt_mutex);
> +
> +	if (hardware_index == MTK_VDEC_CORE)
> +		atomic_dec(&msg_queue->core_list_cnt);
> +	else
> +		atomic_dec(&msg_queue->lat_list_cnt);

Same here.

> +
> +	mutex_unlock(&msg_queue->list_cnt_mutex);
> +}
> +

Regards,
Angelo

