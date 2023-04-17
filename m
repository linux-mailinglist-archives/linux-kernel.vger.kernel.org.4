Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440876E4405
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDQJgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjDQJgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:36:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B21526D;
        Mon, 17 Apr 2023 02:35:39 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B68B16603050;
        Mon, 17 Apr 2023 10:35:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681724137;
        bh=QbaAg8NSbQhZf+R83qw59tCN5hywaWcaUrmWKWZXTyU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HVjqv50rUaQjAKGVeiL4GIggSCWrywwXkSBKv4hPhGrFXDt+vIPS+IfPfzAVz9naa
         DNGl31fkP2Pu0NAaB9QS6GV9HxZfbvhsWrEzVD24UVeWUvcmg1LQejIhWi4+kzJ4Rb
         6IDUpwIEvmbsr0t5A+gwU5LMNhG3xX0+LYumN/7wcg9zGCPdwY2ShdlTq0yo0cShMU
         9aMeRmhaUy7zEazoIuicOn1T+pQUbrML12lyttXfyRzoDPSB7REkmVqdhjKGtGyXvd
         BXg3Pk75kpM6PPGu/Ec+I4kTMmHTt/m2UzNXAqUCFP1R1/uPvuIjkIVc8+qqbPZuAN
         44K0Jvb5n0MLA==
Message-ID: <c1533e76-b8a2-70e6-d144-d53b26c9b952@collabora.com>
Date:   Mon, 17 Apr 2023 11:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/6] media: mediatek: vcodec: move core context from
 device to each instance
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
References: <20230417054816.17097-1-yunfei.dong@mediatek.com>
 <20230417054816.17097-6-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417054816.17097-6-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/04/23 07:48, Yunfei Dong ha scritto:
> There are so many lat buffer in core context list, some instances
> maybe be scheduled for a very long time. Moving the core context to
> each instance, it only be used to control lat buffer of each instance.
> And the core work queue of each instance is scheduled by system.
> 
> Fixes: 2cfca6c1bf80 ("media: mediatek: vcodec: move lat_buf to the top of core list")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  1 -
>   .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  2 -
>   .../vcodec/vdec/vdec_h264_req_multi_if.c      |  4 +-
>   .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  2 +-
>   .../platform/mediatek/vcodec/vdec_msg_queue.c | 53 +++++++------------
>   .../platform/mediatek/vcodec/vdec_msg_queue.h |  6 ++-
>   6 files changed, 25 insertions(+), 43 deletions(-)
> 

..snip..

> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> index a80b9853cec9..ae37d020a1bd 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
> @@ -83,10 +83,11 @@ struct vdec_lat_buf {
>    * @wdma_wptr_addr: ube write point
>    * @core_work: core hardware work
>    * @lat_ctx: used to store lat buffer list
> - * @ctx: point to mtk_vcodec_ctx
> + * @core_ctx: used to store core buffer list
>    *
>    * @lat_list_cnt: used to record each instance lat list count
>    * @core_list_cnt: used to record each instance core list count
> + * @flush_done: core flush done status
>    * @empty_lat_buf: the last lat buf used to flush decode
>    * @core_dec_done: core work queue decode done event
>    * @status: current context decode status for core hardware
> @@ -100,10 +101,11 @@ struct vdec_msg_queue {
>   
>   	struct work_struct core_work;
>   	struct vdec_msg_queue_ctx lat_ctx;
> -	struct mtk_vcodec_ctx *ctx;
> +	struct vdec_msg_queue_ctx core_ctx;
>   
>   	atomic_t lat_list_cnt;
>   	atomic_t core_list_cnt;
> +	bool flush_done;

flush_done is used in patch [6/6]: this does not belong to this patch,
please move the addition of this member in the same patch where you use it.

Regards,
Angelo
