Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4B5BB856
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIQNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIQNDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8AA33A16
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663419809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFKTAY2KdmvVhG4mVk5ksHM9On8VSZSUeVOe+Zo5PYw=;
        b=HwLSgwFgnoc3Wqsq4uBAvG8yH83cdh8/iYiphyn+x+XMHMzaR5Pd/X3MnlV0KmVlknqrXc
        HWVxzXoLrvU6z5ULygKZY8swps6cyKSApM0GgWsQageZmGzUD8J+OJhIj7+jIKy2pQcik+
        EkBCYI4/wXY78iD4SnSlLcTFKiPsOyU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-Qr3zdEhNP9CsXXtGT2kH_Q-1; Sat, 17 Sep 2022 09:03:28 -0400
X-MC-Unique: Qr3zdEhNP9CsXXtGT2kH_Q-1
Received: by mail-ej1-f69.google.com with SMTP id sa22-20020a1709076d1600b0077bab1f70a3so7697463ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WFKTAY2KdmvVhG4mVk5ksHM9On8VSZSUeVOe+Zo5PYw=;
        b=LZQiI/3TWNkp6Gqrqtuy7PqZ7lwhKoAt0Xh0eGUzVB4IGa8DPcS40a7DNg7TfZD1lf
         EHW11l5dUTPmn5xHzLw+95ZHxLzWOYE7tBfBKcN/B8EcbaI4e3lATVEw/JBTXwBbSkoF
         ScCGE5xs8nZavfzHQ6zAaikPqtMCJELA+VzwojR9tVetRlko34m5uKxRwfmvJpmbOVP6
         fM19mm6tRUQoQcZ0x3aa6mWrx4sNhHhpnlc7sNmLj02/H/7ItlJS5Gu1MdI5XGLFJPXj
         ufyCDg/I+T7QzxOKaasbhUykqdOBjQO1h5ECF7uQX7DrINob3xoIdZscSAtQ1G+Hmhhq
         b6VQ==
X-Gm-Message-State: ACrzQf1OE+wb1XIJWBLPZ8dePLLcmIJf7ItPG24kCmG3E7pd4x9V+n+0
        rtOs//J4wPJl0zr4emN5BTxwIGg59u/eTPGcBsMCrng1l81tjLjIRW4s7n2G1y+TBZH34MA3lkt
        eldAAbh3o0NEZdEfTOVLm7Nm3
X-Received: by 2002:a05:6402:1a4f:b0:44e:f731:f7d5 with SMTP id bf15-20020a0564021a4f00b0044ef731f7d5mr7674565edb.357.1663419806894;
        Sat, 17 Sep 2022 06:03:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6TW9DUcujFVXamr90lXX/vora3cXH38exH0amphyAyGDcARckDksaj8d4kVVegyUocYnJKGg==
X-Received: by 2002:a05:6402:1a4f:b0:44e:f731:f7d5 with SMTP id bf15-20020a0564021a4f00b0044ef731f7d5mr7674555edb.357.1663419806755;
        Sat, 17 Sep 2022 06:03:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906364b00b007803cffd31fsm5100377ejb.215.2022.09.17.06.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 06:03:26 -0700 (PDT)
Message-ID: <83c3c020-40e3-3114-ca77-997e0c1d2579@redhat.com>
Date:   Sat, 17 Sep 2022 15:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: drm/vboxvideo: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220824130226.33980-1-yuanjilin@cdjrlc.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220824130226.33980-1-yuanjilin@cdjrlc.com>
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

On 8/24/22 15:02, Jilin Yuan wrote:
> Delete the redundant word 'the'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Thanks I have added this patch to my local drm-misc-next branch.

I will push this out to the official drm-misc-next branch after
running some local tests.

Regards,

Hans



> ---
>  drivers/gpu/drm/vboxvideo/vboxvideo.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo.h b/drivers/gpu/drm/vboxvideo/vboxvideo.h
> index a5de40fe1a76..f60d82504da0 100644
> --- a/drivers/gpu/drm/vboxvideo/vboxvideo.h
> +++ b/drivers/gpu/drm/vboxvideo/vboxvideo.h
> @@ -43,7 +43,7 @@
>   * VBE_DISPI_INDEX_VBOX_VIDEO is used to read the configuration information
>   * from the host and issue commands to the host.
>   *
> - * The guest writes the VBE_DISPI_INDEX_VBOX_VIDEO index register, the the
> + * The guest writes the VBE_DISPI_INDEX_VBOX_VIDEO index register, the
>   * following operations with the VBE data register can be performed:
>   *
>   * Operation            Result

