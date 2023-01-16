Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E49166BBAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjAPK2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjAPK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:28:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB5213D45;
        Mon, 16 Jan 2023 02:28:01 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 80C0F6602B33;
        Mon, 16 Jan 2023 10:27:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673864880;
        bh=3YLQCWLBDRjQgJbSK/lpCAaa+L3SonN+5HslDLGB3qM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mlb+R+XkZQ7rJVx4ylunSEEY3pqJ6rmMgXpP5RyVBHZHqv0+77TabesSr8ck1IIjw
         Ycdoh0WMX7DvIi6cM2jpTHXWPUil+ASzoLG0fAaiKaGgtuIk83T3Di8BlnjBroZ4uP
         Rt7JMdwlFIU+lSKYnJILJUB4RB/IQKHO9rO6f9BRCWFtNnjYkc86DyqBd86UYG8YCY
         +Gu7sP9H4yped3+Yn5Iwnbvl6PhIuvnxQgXt2Sx7flNuFaMQqyY4t2sfxhsCECdl5b
         dzEGo8sTY8gX84ZfJjxrQoL5eYLb1o7TkedgJbiTWmRXjaHBBdv/ZenHOxTPJaTVY6
         sbP6LWFyR7BPQ==
Message-ID: <4d2347e4-7732-1352-5009-791362596e0b@collabora.com>
Date:   Mon, 16 Jan 2023 11:27:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 07/12] staging: media: rkvdec: Add a routine to fetch
 SPS attributes as a callback
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
 <20230101-patch-series-v2-6-2-rc1-v2-7-fa1897efac14@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-7-fa1897efac14@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

W dniu 12.01.2023 o 13:56, Sebastian Fricke pisze:
> Add a callback for each codec variant, that fetches basic information
> like resolution, bit-depth and sub-sampling from a SPS structure. This
> data is used to verify whether a new SPS structure is valid.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>   drivers/staging/media/rkvdec/rkvdec.c | 10 ++++++++++
>   drivers/staging/media/rkvdec/rkvdec.h | 10 ++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index a46f918926a2..e8c750a7343a 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -52,6 +52,16 @@ static int rkvdec_get_valid_fmt(struct rkvdec_ctx *ctx)
>   	return ctx->coded_fmt_desc->decoded_fmts[0];
>   }
>   
> +static int rkvdec_get_sps_attributes(struct rkvdec_ctx *ctx, void *sps,
> +				     struct sps_attributes *attributes)
> +{
> +	const struct rkvdec_coded_fmt_desc *coded_desc = ctx->coded_fmt_desc;
> +
> +	if (coded_desc->ops->get_sps_attributes)
> +		return coded_desc->ops->get_sps_attributes(ctx, sps, attributes);
> +	return 0;

It seems that if there's no ->get_sps_attributes(), then even though
"attributes" won't be filled in, the result is a success (as suggested
by the returned 0). That's maybe confusing to potential users, especially,
if they don't e.g. memset the attributes struct to zero - the function will
report "success" but the struct will contain random data.

In PATCH 09/12 you call the implementation directly (not through the ops
struct), and there you actually ignore the return value.

Regards,

Andrzej

> +}
> +
>   static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>   {
>   	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
> index e353a4403e5b..7b6702c360fd 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.h
> +++ b/drivers/staging/media/rkvdec/rkvdec.h
> @@ -63,10 +63,20 @@ vb2_to_rkvdec_decoded_buf(struct vb2_buffer *buf)
>   			    base.vb.vb2_buf);
>   }
>   
> +struct sps_attributes {
> +	unsigned int width;
> +	unsigned int height;
> +	unsigned int luma_bitdepth;
> +	unsigned int chroma_bitdepth;
> +	unsigned int subsampling;
> +};
> +
>   struct rkvdec_coded_fmt_ops {
>   	int (*adjust_fmt)(struct rkvdec_ctx *ctx,
>   			  struct v4l2_format *f);
>   	u32 (*valid_fmt)(struct rkvdec_ctx *ctx);
> +	int (*get_sps_attributes)(struct rkvdec_ctx *ctx, void *sps,
> +				  struct sps_attributes *attributes);
>   	int (*start)(struct rkvdec_ctx *ctx);
>   	void (*stop)(struct rkvdec_ctx *ctx);
>   	int (*run)(struct rkvdec_ctx *ctx);
> 

