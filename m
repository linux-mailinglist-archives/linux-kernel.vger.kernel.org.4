Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9529677AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjAWM3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjAWM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FCFCA02
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674476895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwrB5DR4dppCP7zf2C5pSCDKiFcT+mCcVne59nz/EJE=;
        b=ZuErYm+tY5FfKg0MkORnKlkTn1JlpMMTfxwWaPLIvvZH5gdGrYKaTU28GR80Mk/q1xxCzr
        OcyQuVZOYuoUbPHWw+dSlmF2mYvBtXALdaL41cd3uAB3G9lbpVyi2tgLVrGdqNf8dizGdR
        2R6wWep0Bfl7Z9pw7o5Qvjmd3M7XkSQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-Z9Cr2uagPbGWSJp9NXwIhw-1; Mon, 23 Jan 2023 07:28:13 -0500
X-MC-Unique: Z9Cr2uagPbGWSJp9NXwIhw-1
Received: by mail-ed1-f71.google.com with SMTP id m7-20020a056402510700b00488d1fcdaebso8291835edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwrB5DR4dppCP7zf2C5pSCDKiFcT+mCcVne59nz/EJE=;
        b=IctjJkACJlv+oEF6yjll4nAFhWTDozJkhsvHNH5opVFoqH1IhhJBtcunBPJHQYcqSq
         G0LVGs3+FRv540bUK88sUj3lSw55Axnvhrqy9+sYk7m87c91BPFOcy6Ua/ToDnUrteEM
         954uIJq0y/ccs0KzPBfNlGIL9WbVQi5g5r5bZoXSWRuBsTYBWvXjUleyMDBouB7h2a0T
         MwBnVEl5PVl7sF2y79bvDmsUP33DJtlJ/BTW7BdV1QrRcwfHQ3etcpY0lkYiTk8ZMDJt
         QoXPkbG+ZjVeBJcaex8Y3RXzFwJEzwIwpsBVV1egbc71HPBA5ysu3QInQq6W+vqNaNzh
         dkmA==
X-Gm-Message-State: AFqh2krJckaCC2XxwubzD2m128+f0myNqqfH/VmJG8UOMsU4Wvkqhevs
        dpYN5h8W5GGehcQM0QQB6EhSHvtLB17Vq3CiNAh4kyE+TyJ41cAXUJHiAR/Y0+on+KrFm4vEDZT
        +ne+tHSiY2rhnqZVPYb8NgV7b
X-Received: by 2002:a17:906:3399:b0:84d:335e:d136 with SMTP id v25-20020a170906339900b0084d335ed136mr23997580eja.48.1674476892778;
        Mon, 23 Jan 2023 04:28:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvQIwGSVLqQBoMnlXQtKDLtQ8NDu9qs6GSx+/a/164XlynrR6nfDHixx1XgKfxSkS9HfswF0A==
X-Received: by 2002:a17:906:3399:b0:84d:335e:d136 with SMTP id v25-20020a170906339900b0084d335ed136mr23997570eja.48.1674476892561;
        Mon, 23 Jan 2023 04:28:12 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b0073d796a1043sm21781931eju.123.2023.01.23.04.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 04:28:12 -0800 (PST)
Message-ID: <e72e4f4b-4e07-a57c-2a09-cbc93cfd89dc@redhat.com>
Date:   Mon, 23 Jan 2023 13:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] media: atomisp: pci: sh_css: Inline single invocation
 of macro STATS_ENABLED()
Content-Language: en-US
To:     Brent Pappas <bpappas@pappasbrent.com>, error27@gmail.com
Cc:     andy.shevchenko@gmail.com, andy@kernel.org, colin.i.king@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        mchehab@kernel.org, sakari.ailus@linux.intel.com
References: <Y8lZreSphK6DIkJg@kadam>
 <20230120171408.16099-1-bpappas@pappasbrent.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230120171408.16099-1-bpappas@pappasbrent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/23 18:14, Brent Pappas wrote:
> Inline the single invocation of the macro STATS_ENABLED().
> The macro abstraction is not necessary because the logic behind it is only
> used once.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>


Thank you.

I have added this to my personal git tree now and I will include
this in the atomisp driver pull-req which I will send to the
media-subsystem maintainer in a couple of weeks.

Regards,

Hans



> ---
> Changelog:
> V1 -> V2: Inline macro instead of replacing it with a function.
> 
> V2 -> V3: Remove unnecessary check that stage is non-null.
> 
>  drivers/staging/media/atomisp/pci/sh_css.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
> index 726cb7aa4ecd..93789500416f 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css.c
> @@ -97,9 +97,6 @@
>   */
>  #define JPEG_BYTES (16 * 1024 * 1024)
>  
> -#define STATS_ENABLED(stage) (stage && stage->binary && stage->binary->info && \
> -	(stage->binary->info->sp.enable.s3a || stage->binary->info->sp.enable.dis))
> -
>  struct sh_css my_css;
>  
>  int  __printf(1, 0) (*sh_css_printf)(const char *fmt, va_list args) = NULL;
> @@ -3743,7 +3740,9 @@ ia_css_pipe_enqueue_buffer(struct ia_css_pipe *pipe,
>  			 * The SP will read the params after it got
>  			 * empty 3a and dis
>  			 */
> -			if (STATS_ENABLED(stage)) {
> +			if (stage->binary && stage->binary->info &&
> +			    (stage->binary->info->sp.enable.s3a ||
> +			     stage->binary->info->sp.enable.dis)) {
>  				/* there is a stage that needs it */
>  				return_err = ia_css_bufq_enqueue_buffer(thread_id,
>  									queue_id,

