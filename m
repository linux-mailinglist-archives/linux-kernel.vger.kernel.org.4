Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2F5719F39
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjFAOJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjFAOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:09:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245DE6D;
        Thu,  1 Jun 2023 07:08:49 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:7d6d:c387:79e6:807d] (unknown [IPv6:2a01:e0a:120:3210:7d6d:c387:79e6:807d])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DF5A6602B7B;
        Thu,  1 Jun 2023 15:08:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685628495;
        bh=2JX/h/DWYtco3A+ZzzUhtQVY2buJesqRTANDsE9Karg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=AdhYBi04g2Qg9LTs2O+2XUaB4NuEQ6mmKE8Pn5mgMBKmFuR0XyMlkKJXGGpGzCqxJ
         lUsf0TsUjT3YfNnfHc5uHxa3F+ikAhbvlbSKWJT3vD4IHXs2yGWhX5x1ZYcmoN27Ht
         4yi4jTd8GoevXhBfh8gn6PLEfgvjqQO6nCN5IBBGOE/27ehPYEaVOmxlhl/Xjop4J/
         u2jvhYI5QQWTvF9sUT0ZsUqwY7ONrTmRVKiRBOumAq/E0k/QfhxMTUtVcGaN6RYZu1
         KGsBWERn+kdZHs/wbdnJmEY8tTy4QsQMFGFUIAoQVi6PldcoJBMjulsYv/2+1nFgjE
         ZGWwZiBkHBGXQ==
Message-ID: <2a892e71-f1be-41eb-5397-87484db7d592@collabora.com>
Date:   Thu, 1 Jun 2023 16:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
Content-Language: en-US
To:     Michael Tretter <m.tretter@pengutronix.de>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, m.szyprowski@samsung.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        kernel@pengutronix.de, nicolas.dufresne@collabora.com,
        didi.debian@cknow.org, hverkuil-cisco@xs4all.nl
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
 <20230601132749.GA31313@pengutronix.de>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20230601132749.GA31313@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 01/06/2023 à 15:27, Michael Tretter a écrit :
> Hi Benjamin,
>
> On Thu, 13 Apr 2023 12:47:56 +0200, Benjamin Gaignard wrote:
>> ctx->vpu_dst_fmt is no more initialized before calling hantro_try_fmt()
>> so assigne it to vpu_fmt led to crash the kernel.
>> Like for decoder case use 'fmt' as format for encoder and clean up
>> the code.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst formats in reset functions")
>> ---
>> version 2:
>> - Remove useless vpu_fmt.
>>
>>   drivers/media/platform/verisilicon/hantro_v4l2.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index 8f1414085f47..d71f79471396 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -275,7 +275,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
>>   			  struct v4l2_pix_format_mplane *pix_mp,
>>   			  enum v4l2_buf_type type)
>>   {
>> -	const struct hantro_fmt *fmt, *vpu_fmt;
>> +	const struct hantro_fmt *fmt;
>>   	bool capture = V4L2_TYPE_IS_CAPTURE(type);
>>   	bool coded;
>>   
>> @@ -295,11 +295,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
>>   
>>   	if (coded) {
>>   		pix_mp->num_planes = 1;
>> -		vpu_fmt = fmt;
>> -	} else if (ctx->is_encoder) {
>> -		vpu_fmt = ctx->vpu_dst_fmt;
>> -	} else {
>> -		vpu_fmt = fmt;
>> +	} else if (!ctx->is_encoder) {
>>   		/*
>>   		 * Width/height on the CAPTURE end of a decoder are ignored and
>>   		 * replaced by the OUTPUT ones.
>> @@ -311,7 +307,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
>>   	pix_mp->field = V4L2_FIELD_NONE;
>>   
>>   	v4l2_apply_frmsize_constraints(&pix_mp->width, &pix_mp->height,
>> -				       &vpu_fmt->frmsize);
>> +				       &fmt->frmsize);
> This causes a regression on the OUTPUT device of the encoder. fmt->frmsize is
> only valid for coded ("bitstream") formats, but fmt on the OUTPUT of an
> encoder will be a raw format. This results in width and height to be clamped
> to 0.
>
> I think the correct fix would be to apply the frmsize constraints of the
> currently configured coded format, but as ctx->vpu_dst_fmt is not initialized
> before calling this code, I don't know how to get the coded format.

if ctx->dst_fmt is correctly set (and it should be) then doing:

pix_mp->width = ctx->dst_fmt.width;
pix_mp->height = ctx->dst_fmt.height;

should solve the issue.

Benjamin

>
> Michael
>
>>   
>>   	if (!coded) {
>>   		/* Fill remaining fields */
>> -- 
>> 2.34.1
>>
