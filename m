Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C185C64B247
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbiLMJYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbiLMJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:24:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD051901B;
        Tue, 13 Dec 2022 01:23:26 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D6436602C2F;
        Tue, 13 Dec 2022 09:23:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670923405;
        bh=NEsi8KQywjHxAG3DdhqLjHkZ/d1IiwmZ6zmi+VlLtcw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KctJwJ6KsRFgvpHGEq0eeV2UHvpMrmsXMwjDUjsJDmsGlM8Vy3FPm1MQXNo+OJD2Z
         NHmKfB9OgUz1K2JIWk9WEzWLq/zO4cC46s0d0xERo3YjUH1b9kYWXUBQjjRBgEZLVh
         0tTDHOniz5PZxxqpdMmVQWlAn2DIpv5Jk9YA6Sn+M/3iTHfi9wrAFnBrHsQ0DkdtxK
         nj9sa9YkrtMRVbzykZVJuD3uPy91CVRB/vX2rB4rjys4u97gc6iVmcKIRjdZ+XxbtP
         qY0jdaBJJJWCA2jqR1MbjpUAooBMv08YhMGE54VqJQva4DaXs4itMGgf6Oz871YIwT
         ymHHrh9nxSjpQ==
Message-ID: <a48dec82-5944-ff3d-8e0d-dc0b58139c83@collabora.com>
Date:   Tue, 13 Dec 2022 10:23:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/5] media: mediatek: vcodec: move lat_buf to the top of
 core list
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
 <20221210073218.17350-4-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221210073218.17350-4-yunfei.dong@mediatek.com>
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
> Current instance will decode done when begin to wait lat buf full,
> move the lat_buf of current instance to the top of core list to make
> sure current instance's lat_buf will be used firstly.
> 
> Fixes: 365e4ba01df4 ("media: mtk-vcodec: Add work queue for core hardware decode")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../platform/mediatek/vcodec/vdec_msg_queue.c    | 16 ++++++++++++++++
>   .../platform/mediatek/vcodec/vdec_msg_queue.h    |  2 ++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> index 2b88065d4d2a..6275536d5063 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> @@ -182,9 +182,24 @@ void vdec_msg_queue_update_ube_wptr(struct vdec_msg_queue *msg_queue, uint64_t u
>   
>   bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
>   {
> +	struct vdec_lat_buf *buf, *tmp;
> +	struct vdec_msg_queue_ctx *core_ctx;
>   	long timeout_jiff;
>   	int ret;
>   
> +	core_ctx = &msg_queue->ctx->dev->msg_queue_core_ctx;
> +	spin_lock(&core_ctx->ready_lock);
> +	list_for_each_entry_safe(buf, tmp, &core_ctx->ready_queue, core_list) {
> +		if (buf && buf->ctx == msg_queue->ctx) {
> +			spin_lock(&msg_queue->lat_ctx.ready_lock);
> +			list_move(&buf->core_list, &core_ctx->ready_queue);
> +			spin_unlock(&msg_queue->lat_ctx.ready_lock);
> +			queue_work(buf->ctx->dev->core_workqueue,
> +				   &buf->ctx->msg_queue.core_work);
> +		}
> +	}
> +	spin_unlock(&core_ctx->ready_lock);
> +
>   	timeout_jiff = msecs_to_jiffies(1000 * (NUM_BUFFER_COUNT + 2));
>   	ret = wait_event_timeout(msg_queue->lat_ctx.ready_to_use,
>   				 msg_queue->lat_ctx.ready_num == NUM_BUFFER_COUNT,
> @@ -268,6 +283,7 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
>   	vdec_msg_queue_init_ctx(&msg_queue->lat_ctx, MTK_VDEC_LAT0);
>   	INIT_WORK(&msg_queue->core_work, vdec_msg_queue_core_work);
>   
> +	msg_queue->ctx = ctx;

I'd move that at the beginning of this function, even before calling
vdec_msg_queue_init_ctx(), as this assignment is not at all expensive.

In any case,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
