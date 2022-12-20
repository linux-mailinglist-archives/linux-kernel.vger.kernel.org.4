Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19A165214C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiLTNNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLTNNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:13:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4AA192B0;
        Tue, 20 Dec 2022 05:13:47 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:bf7d:b502:d93b:e4e3] (unknown [IPv6:2a01:e0a:120:3210:bf7d:b502:d93b:e4e3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AD3A6602CA4;
        Tue, 20 Dec 2022 13:13:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671542026;
        bh=B49queDa5Hv1Scgi/pvOGhJ49f7aCFvsnQ7cCCmDOM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kK/eCDrCNcfH/VAKEXOHroHL8DWwcOSHQ8YBBOlmEqheVCDSHhe0ZWUVFtnGQk0vi
         tpS/i/rkULzAwNYwrP01Xr/EGVXP4f9feDpqwzHs4X8/tjnKxdfxtArJ1i6YlAgY24
         Y+B6CRMmJQ+xk8qvOx1ViEsOkNACgloJ6r8NWq8bpJSy9QOSWJrfsCGCfSijg3gET4
         YhsK9GVR9qnZG6jyM45CDY07ad/aHTXWccGoc+8AV7errJNmDeAwj3TqS5uAoIduoE
         YNbhEVirYrHC8v58kW5nfuJ9ja1Ese9TFIOk/cQf0zYDFpOH8PqjTeyZSfrP1GzTT9
         4RF0zMs4UV/6Q==
Message-ID: <56054a90-4c1e-fa08-ad2c-43109d68f599@collabora.com>
Date:   Tue, 20 Dec 2022 14:13:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 5/9] media: verisilicon: Compute motion vectors size
 for AV1 frames
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
 <20221219155616.848690-6-benjamin.gaignard@collabora.com>
 <44b06c15410e184e8e856a4a882d1b42a02fa8d2.camel@ndufresne.ca>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <44b06c15410e184e8e856a4a882d1b42a02fa8d2.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 19/12/2022 à 21:42, Nicolas Dufresne a écrit :
> Le lundi 19 décembre 2022 à 16:56 +0100, Benjamin Gaignard a écrit :
>> Compute the additional required to store motion vectors at
> requires *space*, requires *buffer* ? I think this is missing a word.
>
>> the end of the frames buffers.
>>
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/platform/verisilicon/hantro_hw.h      | 13 +++++++++++++
>>   .../media/platform/verisilicon/hantro_postproc.c    |  3 +++
>>   drivers/media/platform/verisilicon/hantro_v4l2.c    |  5 +++++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
>> index e83f0c523a30..8b3bc7e31395 100644
>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
>> @@ -417,6 +417,19 @@ hantro_hevc_mv_size(unsigned int width, unsigned int height)
>>   	return width * height / 16;
>>   }
>>   
>> +static inline unsigned short hantro_av1_num_sbs(unsigned short dimension)
>> +{
>> +	return DIV_ROUND_UP(dimension, 64) + 1;
> Why plus one ? I've tested locally with the logical DIV_ROUND_UP(dimension, 64),
> and didn't see any difference. It then match hantro_vp_num_sbs(), so can't this
> be shared ?

MPP code use plus one so I keep it like that.

>
>> +}
>> +
>> +static inline size_t
>> +hantro_av1_mv_size(unsigned int width, unsigned int height)
>> +{
>> +	size_t num_sbs = hantro_av1_num_sbs(width) * hantro_av1_num_sbs(height);
>> +
>> +	return ALIGN(num_sbs * 384, 16) + 512;
> Shall the magic numbers be turned into defines ?

MPP code is:
dir_mvs_size = MPP_ALIGN(num_sbs * 24 * 128 / 8, 16);
and 512 is added later by another piece of code.

I have no clue about the meaning of those values, sorry.

>
>> +}
>> +
>>   int hantro_g1_mpeg2_dec_run(struct hantro_ctx *ctx);
>>   int rockchip_vpu2_mpeg2_dec_run(struct hantro_ctx *ctx);
>>   void hantro_mpeg2_dec_copy_qtable(u8 *qtable,
>> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
>> index 09d8cf942689..7dc39519a2ee 100644
>> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
>> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
>> @@ -213,6 +213,9 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>>   	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_HEVC_SLICE)
>>   		buf_size += hantro_hevc_mv_size(pix_mp.width,
>>   						pix_mp.height);
>> +	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_AV1_FRAME)
>> +		buf_size += hantro_av1_mv_size(pix_mp.width,
>> +					       pix_mp.height);
> nit: Time to turn into a switch or use an ops ?
>
>>   
>>   	for (i = 0; i < num_buffers; ++i) {
>>   		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index 2c7a805289e7..d41dcb108a6d 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -334,6 +334,11 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
>>   			pix_mp->plane_fmt[0].sizeimage +=
>>   				hantro_hevc_mv_size(pix_mp->width,
>>   						    pix_mp->height);
>> +		else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_AV1_FRAME &&
>> +			 !hantro_needs_postproc(ctx, fmt))
>> +			pix_mp->plane_fmt[0].sizeimage +=
>> +				hantro_av1_mv_size(pix_mp->width,
>> +						   pix_mp->height);
>>   	} else if (!pix_mp->plane_fmt[0].sizeimage) {
>>   		/*
>>   		 * For coded formats the application can specify
