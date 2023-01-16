Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C164766B8FF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjAPIXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjAPIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:23:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271C869F;
        Mon, 16 Jan 2023 00:23:20 -0800 (PST)
Received: from [192.168.15.130] (unknown [194.152.46.21])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D266B6602BBC;
        Mon, 16 Jan 2023 08:23:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673857398;
        bh=0oEXBLaXBkw2yiI3T0rNElgIM6GXeR/1APFK7PWIKIU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q+wx2+LaBSyOuWoLDAuOqnRo3FT0DXhpU5z+BeOun7NQL7t5MKyLPaRPrXPahTtbV
         4ydtz5i9RsPiNd6DcB0TEaPfqdrMtXc3YfYRnOJh+F5JavHNarSJIVjo18WURIYu0i
         lSePYzJero/OMjWKuhybnqZ+hFHtzDbVVFPNywfIxa+TQ3RskXNPmmB5Eq99QM95no
         aWYb0qFUqqjKYTHHovbRVOHIXLn59HsnCMyKebLdWV2z59Ngq11GMQlIRl5RFWPWTx
         2bswoAW69vApp9Vg1FjHNFKIrpzafbLg+Fc6GK98qAAUywoJjQD3gbrNPklP/djusa
         00/t98Xosq+uA==
Message-ID: <e154b22c-1cb4-dbb1-40e0-91fad130363d@collabora.com>
Date:   Mon, 16 Jan 2023 09:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 04/12] staging: media: rkvdec: Block start streaming
 until both queues run
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
 <20230101-patch-series-v2-6-2-rc1-v2-4-fa1897efac14@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-4-fa1897efac14@collabora.com>
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

Hi Sebastian,

Ezequiel and Dan have had some comments, they need addressing.

If, as a result, the logic of this patch remains in place then:

W dniu 12.01.2023 o 13:56, Sebastian Fricke pisze:
> Ensure that both the CAPTURE and the OUTPUT queue are running (e.g. busy
> -> have buffers allocated) before starting the actual streaming process.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>   drivers/staging/media/rkvdec/rkvdec.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index c849f6c20279..e0e95d06e216 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -562,6 +562,13 @@ static int rkvdec_start_streaming(struct vb2_queue *q, unsigned int count)
>   	if (V4L2_TYPE_IS_CAPTURE(q->type))
>   		return 0;
>   
> +	/*
> +	 * Make sure that both the output and the capture queue are running
> +	 */
> +	if (rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) == 0 ||
> +	    rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) == 0)

if you convert to a macro in PATCH 03/12 then the conditions can be rewritten as

!rkvdec_queue_busy(.....)

instead of comparing to 0. (actually, this can be done regardless, but makes 
more sense if the result of rkvdec_queue_busy() is boolean which it is when
it becomes a macro as suggested)

Then you can optionally follow De Morgan's law:

if (!(rkvdec_queue_busy() && rkvdec_queue_busy()))
	return -EAGAIN;

and you get one negation less.

Regards,

Andrzej

> +		return -EAGAIN;
> +
>   	desc = ctx->coded_fmt_desc;
>   	if (WARN_ON(!desc))
>   		return -EINVAL;
> 

