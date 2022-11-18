Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C686B62F4BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbiKRM1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbiKRM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:27:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787F8CFE6;
        Fri, 18 Nov 2022 04:26:30 -0800 (PST)
Received: from [192.168.15.130] (unknown [194.152.46.21])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABEF96602AB2;
        Fri, 18 Nov 2022 12:26:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668774388;
        bh=j00aZO+NDvxxNv4Ex5q1J/k6GVW5ZjtAsEcGyBIHILI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=XvGN1rr80SkGZAX41h1EW5AQp/607Z4LBayXwxrsqjLq3fFJRCAzUCQhWEbOh5LqB
         41iQMd56+70Ria0SVmZgI5nmuIRHdiuS25l3GhW/fUG6BlJkTxhq+yVYlVx1DvMJ/G
         iiYnpRhcbEgmiFfBs7oSp6hUux5nML+DTWrQPBH9034LNSEaiU9PeKbolyCeMkq4I+
         1hSKvku6osLUPK760X8GD6acGejQa3AakDoNNc6DNDVQxiYxFgMWsiTOpokEYh5XRT
         Fb8iyAsIR/2/Y2PdVsC38pdikcIWIolD27LAEAlAxmuFgjGLYG5LUaDh3yKyJ3oQhO
         Bo6YV2enLcirQ==
Message-ID: <64f08478-16a7-1d33-e520-9f0fbcab47b9@collabora.com>
Date:   Fri, 18 Nov 2022 13:26:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v6] media: mediatek: vcodec: support stateless AV1
 decoder
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221117061742.29702-1-xiaoyong.lu@mediatek.com>
 <0672e801-1489-f222-2143-e0e7317d7eaf@collabora.com>
In-Reply-To: <0672e801-1489-f222-2143-e0e7317d7eaf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

W dniu 17.11.2022 o 13:42, Andrzej Pietrasiewicz pisze:
> Hi Xiaoyong Lu,
> 
> Sorry about chiming in only at v6. Please see inline below.
> 
> Andrzej
> 
> W dniu 17.11.2022 o 07:17, Xiaoyong Lu pisze:
>> Add mediatek av1 decoder linux driver which use the stateless API in
>> MT8195.
>>
>> Signed-off-by: Xiaoyong Lu<xiaoyong.lu@mediatek.com>
>> ---
>> Changes from v5:
>>
>> - change av1 PROFILE and LEVEL cfg
>> - test by av1 fluster, result is 173/239
>>
>> Changes from v4:
>>
>> - convert vb2_find_timestamp to vb2_find_buffer
>> - test by av1 fluster, result is 173/239
>>
>> Changes from v3:
>>
>> - modify comment for struct vdec_av1_slice_slot
>> - add define SEG_LVL_ALT_Q
>> - change use_lr/use_chroma_lr parse from av1 spec
>> - use ARRAY_SIZE to replace size for loop_filter_level and 
>> loop_filter_mode_deltas
>> - change array size of loop_filter_mode_deltas from 4 to 2
>> - add define SECONDARY_FILTER_STRENGTH_NUM_BITS
>> - change some hex values from upper case to lower case
>> - change *dpb_sz equal to V4L2_AV1_TOTAL_REFS_PER_FRAME + 1
>> - test by av1 fluster, result is 173/239
>>
>> Changes from v2:
>>
>> - Match with av1 uapi v3 modify
>> - test by av1 fluster, result is 173/239
>>
>> ---
>> Reference series:
>> [1]: v3 of this series is presend by Daniel Almeida.
>>       message-id: 20220825225312.564619-1-daniel.almeida@collabora.com
>>
>>   .../media/platform/mediatek/vcodec/Makefile   |    1 +
>>   .../vcodec/mtk_vcodec_dec_stateless.c         |   47 +-
>>   .../platform/mediatek/vcodec/mtk_vcodec_drv.h |    1 +
>>   .../vcodec/vdec/vdec_av1_req_lat_if.c         | 2234 +++++++++++++++++
>>   .../platform/mediatek/vcodec/vdec_drv_if.c    |    4 +
>>   .../platform/mediatek/vcodec/vdec_drv_if.h    |    1 +
>>   .../platform/mediatek/vcodec/vdec_msg_queue.c |   27 +
>>   .../platform/mediatek/vcodec/vdec_msg_queue.h |    4 +
>>   8 files changed, 2318 insertions(+), 1 deletion(-)
>>   create mode 100644 
>> drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
>>

<snip>

>> +
>> +static void *vdec_av1_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
>> +{
>> +    struct v4l2_ctrl *ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl, id);
>> +
>> +    if (!ctrl)
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    return ctrl->p_cur.p;
>> +}
> 
> I see we keep repeating this kind of a v4l2_ctrl_find() wrapper in drivers.
> The only reason this code cannot be factored out is the "context" struct pointer
> pointing at structs of different types. Maybe we could
> 
> #define v4l2_get_ctrl_ptr(ctx, member, id) \
>      __v4l2_get_ctrl_ptr((ctx), offsetof(typeof(*ctx), (member)), (id))
> 
> void *__v4l2_get_ctrl_ptr(void *ctx, size_t offset, u32 id)
> {
>      struct v4l2_ctrl_handler *hdl = (struct v4l2_ctrl_handler *)(ctx + offset);
>      struct v4l2_ctrl *ctrl = v4l2_ctrl_find(hdl, id);
> 
>      if (!ctrl)
>          return ERR_PTR(-EINVAL);
> 
>      return ctrl->p_cur.p;
> }
> 
> and reuse v4l2_get_ctrl_ptr() in drivers?
> 
> A similar kind of void* arithmetic happens in container_of, only with '-'.
> 

When I think of it it seems a bit over-engineered to me now, it would
be better to give up the macro and simply pass struct v4l2_ctrl_handler *hdl.

Another second thought is that including such a wrapper in this patch
would make it too noisy if all potential users were to be updated.
A separate series would make more sense.

Regards,

Andrzej

