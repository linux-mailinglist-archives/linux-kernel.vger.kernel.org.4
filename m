Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741BD6F3BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjEBBGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjEBBGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:06:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634723C38;
        Mon,  1 May 2023 18:06:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24deb9c5ffcso1458622a91.1;
        Mon, 01 May 2023 18:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682989563; x=1685581563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+lSO/8LcuzTpil2mDcDfzMXywH3IDiwphyL36ayya6U=;
        b=c2jhRIEEXVY8jhJDIA5ikrMDQGR34IpLS8C2qoA0NQe/Eg938kMpP8VAytGGUwWXcH
         7ytjNYKi0wCacuhQbC9fY4ZpE/v7bU8US0OSe0uuzOqWwsdb9ZYC17xEVBb/8/bmXv3N
         iz+c6AV7+rMf4PjXCM4dt4uKAAvPzAcKf0bIN2uEQlZ2P2brEOQrKKRcDwoVLWcHeuw7
         fK4WBnnLDSk3icSXejWn7fU+Tze+ZdRe7dpa5NK0XAJVMEoGaPoj+UIAm2xPQlW/ZrIi
         zpO2HLhLmOEGoLgadMYTOAdSXSafG7lI8pyLxvxCbSaCUW9zObFwy5ebshhpwaF1Yx17
         Qc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989563; x=1685581563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lSO/8LcuzTpil2mDcDfzMXywH3IDiwphyL36ayya6U=;
        b=USpPnOPXo73lSs8zV8aJmZUBEXi5d6Z7xH/WBIdYLPyk2WTh1yum7JRwbyeel1invR
         f8XPhXpZ0C1ARBlv0oou1LWwdHlgMfP/pU0tDSThslBakTfsPlTDiYgXk37leD+IZy9a
         ptpv+w9ag0BG6XeRt6TP3diqVhVcaTEFPAHZogU+mKX9/r6hcUk9sWXW/0qVXNg7iNgW
         drIlYjPo/cluSyqVOZbJ2fHxLdRulB6WLmKNxq85E4BYg+jHftNFe+7m32rsc9Y24e71
         mUOaRAeFXkLXUmHK+2IlgfS6EomJp38KegJA+bat3aPYxnq88yc0vTX6JeedA2ek3b8m
         zeXQ==
X-Gm-Message-State: AC+VfDwU3mnbyQ4Mai4oUIiEQtpsdbRYi8nVkn27B9V1pHi40rz4olKf
        QSDmSoNBeyYvtYzQjvVlraA=
X-Google-Smtp-Source: ACHHUZ7G8197k6a+XDAjuKJXKHZWRoJ3jpVaTgu8Oyidq4oY4RlxtUs07MeK/S5AeKFrzPKX1kmawQ==
X-Received: by 2002:a17:90b:190d:b0:24e:9e6:7067 with SMTP id mp13-20020a17090b190d00b0024e09e67067mr3873335pjb.7.1682989562632;
        Mon, 01 May 2023 18:06:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090abd1600b00246b7b8b43asm6362938pjr.49.2023.05.01.18.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:06:01 -0700 (PDT)
Date:   Mon, 1 May 2023 18:05:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Biswarup Pal <biswarupp@google.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     kernel-team@android.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Call input_set_timestamp for events injected using uinput
Message-ID: <ZFBh948No3IAV2hf@google.com>
References: <20230427000152.1407471-1-biswarupp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427000152.1407471-1-biswarupp@google.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 12:01:51AM +0000, Biswarup Pal wrote:
> Currently, uinput doesn't use the input_set_timestamp API, so any
> event injected using uinput is not accurately timestamped in terms of
> measuring when the actual event happened. Hence, call the
> input_set_timestamp API from uinput in order to provide a more
> accurate sense of time for the event. Propagate only the timestamps
> which are a) positive, b) within a pre-defined offset (10 secs) from
> the current time, and c) not in the future.

This makes sense to me. Peter, do you see any issues?

Thanks!

> 
> Signed-off-by: Biswarup Pal <biswarupp@google.com>
> ---
>  drivers/input/misc/uinput.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index f2593133e524..d98212d55108 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -33,6 +33,7 @@
>  #define UINPUT_NAME		"uinput"
>  #define UINPUT_BUFFER_SIZE	16
>  #define UINPUT_NUM_REQUESTS	16
> +#define UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS 10
>  
>  enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_CREATED };
>  
> @@ -569,11 +570,40 @@ static int uinput_setup_device_legacy(struct uinput_device *udev,
>  	return retval;
>  }
>  
> +/*
> + * Returns true if the given timestamp is valid (i.e., if all the following
> + * conditions are satisfied), false otherwise.
> + * 1) given timestamp is positive
> + * 2) it's within the allowed offset before the current time
> + * 3) it's not in the future
> + */
> +static bool is_valid_timestamp(const ktime_t timestamp)
> +{
> +	ktime_t zero_time;
> +	ktime_t current_time;
> +	ktime_t min_time;
> +	ktime_t offset;
> +
> +	zero_time = ktime_set(0, 0);
> +	if (ktime_compare(zero_time, timestamp) >= 0)
> +		return false;
> +
> +	current_time = ktime_get();
> +	offset = ktime_set(UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS, 0);
> +	min_time = ktime_sub(current_time, offset);
> +
> +	if (ktime_after(min_time, timestamp) || ktime_after(timestamp, current_time))
> +		return false;
> +
> +	return true;
> +}
> +
>  static ssize_t uinput_inject_events(struct uinput_device *udev,
>  				    const char __user *buffer, size_t count)
>  {
>  	struct input_event ev;
>  	size_t bytes = 0;
> +	ktime_t timestamp;
>  
>  	if (count != 0 && count < input_event_size())
>  		return -EINVAL;
> @@ -588,6 +618,10 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
>  		if (input_event_from_user(buffer + bytes, &ev))
>  			return -EFAULT;
>  
> +		timestamp = ktime_set(ev.input_event_sec, ev.input_event_usec * NSEC_PER_USEC);
> +		if (is_valid_timestamp(timestamp))
> +			input_set_timestamp(udev->dev, timestamp);
> +
>  		input_event(udev->dev, ev.type, ev.code, ev.value);
>  		bytes += input_event_size();
>  		cond_resched();
> -- 
> 2.40.1.495.gc816e09b53d-goog
> 

-- 
Dmitry
