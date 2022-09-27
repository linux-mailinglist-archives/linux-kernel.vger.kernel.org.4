Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1FF5EB753
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiI0CBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiI0CBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:01:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2D67C95;
        Mon, 26 Sep 2022 19:01:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso14272765pjk.0;
        Mon, 26 Sep 2022 19:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=14/7xaPNJVGIb6l6sz37+DnxUg7Jl23Ck+bNit2j3/I=;
        b=KYxub2H+TlzZas8lnX/d2lMlgAHHIMrnh9cbvw2JX9stxGfUHWYupu0iEnstFW4Vqy
         kb/MEkisnExCbOX0DJ7Nxb16iQWikBy2MIvMO74l0sMf+cURI0gp3eas2ROnjGekMz1z
         xb2NhfX+BFre+1+zaBEru+X4mzzZHFjUb4tKjMATuCbtCDLTkMvhf4iTIcCKq4xzT/m6
         KsoqJ8IKXEFLr1JeBgdT+InzOLBbNjLk8M+VKCGCEmg4zDH9Hs8g1QA5VFaVhCAxKuNy
         izaoxcNurV5gRJB2JetnG7AHuvFP3AnaQBgobeY0uegVzHbGy2SqFm2mivX5OADYVQQ0
         pf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=14/7xaPNJVGIb6l6sz37+DnxUg7Jl23Ck+bNit2j3/I=;
        b=yFVC0FU4gpyfTQD371tfwcLn20bqpH0retE/tkmVbjTYtz4Y57++gSH3CMe/v8pDPV
         Rku/B4D+lwITjs0MesgfjPTXQ+1HP+XFxxvsBVK3gM+dLNWa42Vxpu3Cy+VDKLn9i/5m
         RsYhECflkEc54POjJPK0Q/oJfoQGrdX20seWFonbrIaUOxkr9TlBlFmClfEcaIDtH2CK
         FQ0Aa4uKcNUMDaJu5hCWHkPxCRMRkYLVT/MHa9JufBccd3qDzpAI2vV/fvHLEZqcwsIT
         L64doWht6CgZoSpcJ/iZz2hXTlYWz2N8HAcgaW/k7LY7hAml2pkqd+1JCJcCY0G4V+sL
         T/Hg==
X-Gm-Message-State: ACrzQf2NgxZMCmH9KgCnU4kMV9YKcp/gf/rgO616ZIT/yLjXcVfG/WYG
        Pr+RGOqzYyvR2muHTFO/tB5S5r5SpK45vmxB
X-Google-Smtp-Source: AMsMyM6jfTXNSrocHv1AOOWcHkhVyiuMuRiQ6V5g6dfHdc2HeYzrWAJFX4BWQs8QmOemPZXlDC/IMA==
X-Received: by 2002:a17:90a:cf92:b0:202:ae52:43a4 with SMTP id i18-20020a17090acf9200b00202ae5243a4mr1767228pju.141.1664244078126;
        Mon, 26 Sep 2022 19:01:18 -0700 (PDT)
Received: from [192.168.50.247] ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id 1-20020a630101000000b0043dc4ee8d9esm147206pgb.87.2022.09.26.19.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 19:01:17 -0700 (PDT)
Message-ID: <b4b52911-e135-38b6-ab2e-4580e1ac0302@gmail.com>
Date:   Tue, 27 Sep 2022 10:01:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] media: dvb_vb2: fix possible out of bound access
Content-Language: en-US
To:     mchehab@kernel.org, senozhatsky@chromium.org,
        cai.huoqing@linux.dev, hverkuil-cisco@xs4all.nl,
        sw0312.kim@samsung.com, satendra.t@samsung.com,
        jh1009.sung@samsung.com, nenggun.kim@samsung.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220519021743.8295-1-hbh25y@gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220519021743.8295-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/5/2022 10:17, Hangyu Hua wrote:
> vb2_core_qbuf and vb2_core_querybuf don't check the range of b->index
> controlled by the user.
> 
> Fix this by adding range checking code before using them.
> 
> Fixes: 57868acc369a ("media: videobuf2: Add new uAPI for DVB streaming I/O")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
> 
> v2:
> 1. fix inappropriate use of dprintk.
> 2. add "fixes" tag
> 
>   drivers/media/dvb-core/dvb_vb2.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
> index a1bd6d9c9223..909df82fed33 100644
> --- a/drivers/media/dvb-core/dvb_vb2.c
> +++ b/drivers/media/dvb-core/dvb_vb2.c
> @@ -354,6 +354,12 @@ int dvb_vb2_reqbufs(struct dvb_vb2_ctx *ctx, struct dmx_requestbuffers *req)
>   
>   int dvb_vb2_querybuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
>   {
> +	struct vb2_queue *q = &ctx->vb_q;
> +
> +	if (b->index >= q->num_buffers) {
> +		dprintk(1, "[%s] buffer index out of range\n", ctx->name);
> +		return -EINVAL;
> +	}
>   	vb2_core_querybuf(&ctx->vb_q, b->index, b);
>   	dprintk(3, "[%s] index=%d\n", ctx->name, b->index);
>   	return 0;
> @@ -378,8 +384,13 @@ int dvb_vb2_expbuf(struct dvb_vb2_ctx *ctx, struct dmx_exportbuffer *exp)
>   
>   int dvb_vb2_qbuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
>   {
> +	struct vb2_queue *q = &ctx->vb_q;
>   	int ret;
>   
> +	if (b->index >= q->num_buffers) {
> +		dprintk(1, "[%s] buffer index out of range\n", ctx->name);
> +		return -EINVAL;
> +	}
>   	ret = vb2_core_qbuf(&ctx->vb_q, b->index, b, NULL);
>   	if (ret) {
>   		dprintk(1, "[%s] index=%d errno=%d\n", ctx->name,

Hi guys,

Looks like this patch was forgotten to to merge into master branch. This 
bug still in:
https://git.linuxtv.org/media_tree.git/tree/drivers/media/dvb-core/dvb_vb2.c#n355
and
https://git.linuxtv.org/media_tree.git/tree/drivers/media/dvb-core/dvb_vb2.c#n379

Thanks,
Hangyu
