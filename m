Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B095677AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjAWM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjAWM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:28:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74182BBA2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674476887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TR4irgtY7ztL5sSFlKEb+j+Ijhp2vw5PzeO8p8ZDAa0=;
        b=MJP5ttFrNEcYpwRw0mnB3Kcsl2hmTe7AoB6Z7wOoON7P9oaz4Sj86fTtduIbKW6xGB8eza
        /k2FfwUKZX+7qfcdSpLHcm9NNj9ZrzlQsDlOMO7NsAflRu13/DuZ+uRvfCRhXBCUpiJ3D4
        2dVCzlT7MViiF9p1rvi/gP9YE5DNcis=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-gZPTNsAKP-Wt07PD95pd1Q-1; Mon, 23 Jan 2023 07:28:05 -0500
X-MC-Unique: gZPTNsAKP-Wt07PD95pd1Q-1
Received: by mail-ed1-f72.google.com with SMTP id h18-20020a056402281200b0049e5078a6c3so8368933ede.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TR4irgtY7ztL5sSFlKEb+j+Ijhp2vw5PzeO8p8ZDAa0=;
        b=RnOjE/8Ho6LzgbZxONl1GMdrybGme1akNMrgcSH9PjbAqj3UyroKSOtDT/eGSxNZqL
         MmqRwjGcVAhyiQhJqvEwlRVwqmu9inhSVoegxr2mWjlDlHGU0xhWxPfLZa8j6YWoVukE
         cdgQ80jba0NMWpGLH6Ty438q/2J9Gzth7G51QNpfxZL/TYJMXCF3sxINvaIhY0BxD2gm
         huEbB7pIJfvJEweDPN9HSg9oOqS4fsvjWZpJkQaJR+MLPVfUb/q/pU+KohCvJs1BghYE
         C/D1Nh5ZNpjYOefaD6lfRV5LHyeQmhxprlpCoBONuHsvYf+KS7WmbKe1fd9YGnZtYuHS
         0MIQ==
X-Gm-Message-State: AFqh2kpWpZZUMzcS56kFO+9QSkcdlVdPZQawu+eKQUuKFV4amzE/f6BC
        Mt/Sx43MxJhYute/Onbhu7xCNFQQEZGpDBcFOBr5KGczUfkLr9HoFbksstdoYmHXbEfvi4Vu+mD
        QUIzUvFrLdYVa8enGZxc7Bk5v
X-Received: by 2002:a05:6402:1394:b0:49e:a107:268e with SMTP id b20-20020a056402139400b0049ea107268emr14854315edv.3.1674476883676;
        Mon, 23 Jan 2023 04:28:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu/uKBFGucXnQ0693oDy3k7J+PIivVmahE2diYnaWUnpUSOqQPxQSuMCPkm3VVn8RK3rSu1Lg==
X-Received: by 2002:a05:6402:1394:b0:49e:a107:268e with SMTP id b20-20020a056402139400b0049ea107268emr14854302edv.3.1674476883484;
        Mon, 23 Jan 2023 04:28:03 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b11-20020a05640202cb00b00499b3d09bd2sm443623edx.91.2023.01.23.04.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 04:28:02 -0800 (PST)
Message-ID: <5860bf02-6b55-a885-742b-cd1477c7b1aa@redhat.com>
Date:   Mon, 23 Jan 2023 13:28:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media: atomisp: pci: hive_isp_css_common: host: vmem:
 Replace SUBWORD macros with functions
Content-Language: en-US
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230120182625.23227-1-bpappas@pappasbrent.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230120182625.23227-1-bpappas@pappasbrent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/23 19:26, Brent Pappas wrote:
> Replace the macros SUBWORD() and INV_SUBWORD() with functions to comply
> with Linux coding style standards.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>


Thank you.

I have added this to my personal git tree now and I will include
this in the atomisp driver pull-req which I will send to the
media-subsystem maintainer in a couple of weeks.

Regards,

Hans



> ---
> I am not sure if it would better to inline SUBWORD() or turn it into
> a function.
> On the one hand, SUBWORD() is only invoked once, so it may be better to
> to inline it.
> On the other hand, the macro defined beside it, INV_SUBWORD() should be
> turned into to a function because it is invoked multiple times, so it
> may make sense to turn SUBWORD() into a function as well.
> I have opted to turn SUBWORD() into a function.
> 
>  .../pci/hive_isp_css_common/host/vmem.c       | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
> index 6620f091442f..316abfb72a83 100644
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
> +++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
> @@ -28,10 +28,19 @@ typedef hive_uedge *hive_wide;
>  /* Copied from SDK: sim_semantics.c */
>  
>  /* subword bits move like this:         MSB[____xxxx____]LSB -> MSB[00000000xxxx]LSB */
> -#define SUBWORD(w, start, end)     (((w) & (((1ULL << ((end) - 1)) - 1) << 1 | 1)) >> (start))
> +static inline hive_uedge
> +subword(hive_uedge w, unsigned int start, unsigned int end)
> +{
> +	return (w & (((1ULL << (end - 1)) - 1) << 1 | 1)) >> start;
> +}
>  
>  /* inverse subword bits move like this: MSB[xxxx____xxxx]LSB -> MSB[xxxx0000xxxx]LSB */
> -#define INV_SUBWORD(w, start, end) ((w) & (~(((1ULL << ((end) - 1)) - 1) << 1 | 1) | ((1ULL << (start)) - 1)))
> +static inline hive_uedge
> +inv_subword(hive_uedge w, unsigned int start, unsigned int end)
> +{
> +	return w & (~(((1ULL << (end - 1)) - 1) << 1 | 1) |
> +		    ((1ULL << start) - 1));
> +}
>  
>  #define uedge_bits (8 * sizeof(hive_uedge))
>  #define move_lower_bits(target, target_bit, src, src_bit) move_subword(target, target_bit, src, 0, src_bit)
> @@ -50,18 +59,18 @@ move_subword(
>  	unsigned int start_bit  = target_bit % uedge_bits;
>  	unsigned int subword_width = src_end - src_start;
>  
> -	hive_uedge src_subword = SUBWORD(src, src_start, src_end);
> +	hive_uedge src_subword = subword(src, src_start, src_end);
>  
>  	if (subword_width + start_bit > uedge_bits) { /* overlap */
>  		hive_uedge old_val1;
> -		hive_uedge old_val0 = INV_SUBWORD(target[start_elem], start_bit, uedge_bits);
> +		hive_uedge old_val0 = inv_subword(target[start_elem], start_bit, uedge_bits);
>  
>  		target[start_elem] = old_val0 | (src_subword << start_bit);
> -		old_val1 = INV_SUBWORD(target[start_elem + 1], 0,
> +		old_val1 = inv_subword(target[start_elem + 1], 0,
>  				       subword_width + start_bit - uedge_bits);
>  		target[start_elem + 1] = old_val1 | (src_subword >> (uedge_bits - start_bit));
>  	} else {
> -		hive_uedge old_val = INV_SUBWORD(target[start_elem], start_bit,
> +		hive_uedge old_val = inv_subword(target[start_elem], start_bit,
>  						 start_bit + subword_width);
>  
>  		target[start_elem] = old_val | (src_subword << start_bit);

