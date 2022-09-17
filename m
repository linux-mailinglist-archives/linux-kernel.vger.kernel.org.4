Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324955BBA23
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 21:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIQTjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 15:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIQTi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 15:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC9D286CC
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663443533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LC4UOafPXERXQgNVhU6ZMx3kqWnd3sEpFwg5xWjV1vY=;
        b=ObNF6/85KJkvqq3euVgMmcOLFf33263rIaGLLK+tUlNGLqVcE/cnl2rpqE03CnTodavWLo
        ZnQrEVJb3LXtZxi33e/AdtFY6nrsodjgLMSih3KiZRHNxXkvjiqmtODs+zZ1n71AyP3faZ
        UOrNnXrsSLYHBrNJJ6yDs3gccsjHTEU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-g7ECNYHcORmk4O6yN_pX5A-1; Sat, 17 Sep 2022 15:38:52 -0400
X-MC-Unique: g7ECNYHcORmk4O6yN_pX5A-1
Received: by mail-ed1-f71.google.com with SMTP id i17-20020a05640242d100b0044f18a5379aso17684629edc.21
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 12:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LC4UOafPXERXQgNVhU6ZMx3kqWnd3sEpFwg5xWjV1vY=;
        b=jVfSWHYKC6KfEOXBAiOBuN0bVeJ51tenzi4vNqUULbREzEYd5o3ciGAnfXc6cZhPkC
         ma54BjMiucXZ0YJereVHPr5m47bVzepqmjCYtB8NcIdAGu2nop/F9y7Ux6r5mDeHF0I2
         pN9ktdWn2+FRdz0Fp6kw0Z1W78PmySQ+TbRyqW5XbpAxGnXnpRfyEq9skOSlh0DE7Vwd
         ph/ac/5+cOvbTcM6UlN/9Fv9zLLMU68IaIu9nD9g1qp2tCfi84n2CXndoyRuXAY9PHlW
         6cAiQedTBYO3ipph81UZallazRZXRCA0uAh1N2ZwlyUplWDnZbXz/jT5JStR5X6jKFK8
         O92Q==
X-Gm-Message-State: ACrzQf0/s3BtfJSNuD/Nl6o04nvwmGeM4CSJqxjlnBdmSAt/sShGpy/N
        TxdtzLGBdUXFmZ5ccb98q3kZQGzebb7WYctcEo0lljxUpR5+lW9yZwVymlsqnGi751ebAaMpueC
        XpzWD66/etS8Cc5T1cjEcnArl
X-Received: by 2002:a17:907:1ca9:b0:77c:99cc:2d84 with SMTP id nb41-20020a1709071ca900b0077c99cc2d84mr7546482ejc.308.1663443530669;
        Sat, 17 Sep 2022 12:38:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5YBU+dTJ7Q+EVaTQ+qfJhnJ2sT5x1uXDwMWbfgt7sGx5POujj8MyXXASYh898qmB+dDQuJfA==
X-Received: by 2002:a17:907:1ca9:b0:77c:99cc:2d84 with SMTP id nb41-20020a1709071ca900b0077c99cc2d84mr7546473ejc.308.1663443530491;
        Sat, 17 Sep 2022 12:38:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id tl1-20020a170907c30100b0077fde38993asm7591012ejc.152.2022.09.17.12.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 12:38:49 -0700 (PDT)
Message-ID: <2ef10724-553b-6f90-22ce-0ce3606f69ad@redhat.com>
Date:   Sat, 17 Sep 2022 21:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/2] staging: rtl8723bs: Fix coding style issue in block
 comment
Content-Language: en-US
To:     Kang Minchul <tegongkang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220917181130.3237159-1-tegongkang@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220917181130.3237159-1-tegongkang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/17/22 20:11, Kang Minchul wrote:
> This patch removes the following warning generated by checkpatch.pl
> 
>   WARNING: Block comments use * on subsequent lines
>   #206: FILE: rtw_recv.c:206:
>   +/*
>   +signed int     rtw_enqueue_recvframe(union recv_frame *precvframe, struct __queue *queue)
> 
>   WARNING: Block comments use * on subsequent lines
>   #216: FILE: rtw_recv.c:216:
>   +/*
>   +caller : defrag ; recvframe_chk_defrag in recv_thread  (passive)
> 
> Signed-off-by: Kang Minchul <tegongkang@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index d8d394b67eeb..ad6fb6c3d1f0 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -203,22 +203,22 @@ signed int rtw_enqueue_recvframe(union recv_frame *precvframe, struct __queue *q
>  }
>  
>  /*
> -signed int	rtw_enqueue_recvframe(union recv_frame *precvframe, struct __queue *queue)
> -{
> -	return rtw_free_recvframe(precvframe, queue);
> -}
> -*/
> + * signed int	rtw_enqueue_recvframe(union recv_frame *precvframe, struct __queue *queue)
> + * {
> + * 	return rtw_free_recvframe(precvframe, queue);
> + * }
> + */
>  
>  
>  
>  
>  /*
> -caller : defrag ; recvframe_chk_defrag in recv_thread  (passive)
> -pframequeue: defrag_queue : will be accessed in recv_thread  (passive)
> -
> -using spinlock to protect
> -
> -*/
> + * caller : defrag ; recvframe_chk_defrag in recv_thread  (passive)
> + * pframequeue: defrag_queue : will be accessed in recv_thread  (passive)
> + *
> + * using spinlock to protect
> + *
> + */
>  
>  void rtw_free_recvframe_queue(struct __queue *pframequeue,  struct __queue *pfree_recv_queue)
>  {

