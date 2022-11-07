Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A3761F1C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiKGLY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKGLYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A4117419
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667820228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hutdt2b2zeKy7OYI4K1JmV0ps00YTwE6Wdz0pL2yeQU=;
        b=RXQtYYQygLA64im3EMI57MD/6vjEFZ89Q4DLZksQQktUYsiBKJVRpErjtGhqmM2DKknYXD
        gscbZ6IoX4UTEWg4t0VU6CkvOnpmluKxt3Cg4gJ6YoAZBvUavsgCKtOZe3AAj9ABYpane+
        YznekDf5F0Hbw9WKla0PfUYJ3TopmvQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-258-fLa7UBDUNqaTpMZqtv0FxQ-1; Mon, 07 Nov 2022 06:23:47 -0500
X-MC-Unique: fLa7UBDUNqaTpMZqtv0FxQ-1
Received: by mail-ed1-f71.google.com with SMTP id x18-20020a05640226d200b00461e027f704so8012669edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 03:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hutdt2b2zeKy7OYI4K1JmV0ps00YTwE6Wdz0pL2yeQU=;
        b=lDiS8ldT4uWE420/p1iFpX00HxTrpM8iY+tPacyYOiIrDpuWqD659rxgvrixy1q2Fj
         L+Xor1tP5FzfjfW4OvqwkXN45JGtA17C6YZSvwzyQxGd9zp2CpkANORvdd0DZjLcDsNb
         UruqOFPUfpXNxgUjeN2grmpue2Xt2pVgWSAkwjANq62nb4zXOSj07bWojjS9JfpRG5N/
         vJ2N6CPajfgoFOA+JmJxjJKkf+t6i6rDZ/bICL7Qh5lHNUUHF317E+95TgxuN90HlCxT
         ILuvAF1rBg5fzMAHruUrJiQDD2HnrcbCf6lvawiljUxAVh43xzUfxbmOe2ccizf0SK8M
         rOug==
X-Gm-Message-State: ACrzQf3MvPmb+bbVgXgWviFFgb+GKiydqbjrV8Ic9b+J5FnwIZz5oqIB
        cxxWkcCeJxOBEI0C/9J2eX0gSLWl5bZQnOUjs6+HnEsS49Nfqf8Cyaxqi+cTljoehXRftGbhoda
        PUg0WdCYUPIhX0JrALVv4FJex
X-Received: by 2002:a50:cc07:0:b0:453:4427:a918 with SMTP id m7-20020a50cc07000000b004534427a918mr50041935edi.121.1667820226210;
        Mon, 07 Nov 2022 03:23:46 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4fYJi1/SwA6LMBqIMykwtjeej5rPZlI3rCD0qmPp5eOIKxD3rIsrNsqe5MZuK5MVHNiJ9ycg==
X-Received: by 2002:a50:cc07:0:b0:453:4427:a918 with SMTP id m7-20020a50cc07000000b004534427a918mr50041920edi.121.1667820226040;
        Mon, 07 Nov 2022 03:23:46 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id qw8-20020a1709066a0800b0073d7ab84375sm3340770ejc.92.2022.11.07.03.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 03:23:45 -0800 (PST)
Message-ID: <dbc29603-30f6-e8ea-83d9-5b776daa7dea@redhat.com>
Date:   Mon, 7 Nov 2022 12:23:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 1/1] platform/x86: p2sb: Don't fail if unknown CPU is
 found
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
References: <20221104154916.35231-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221104154916.35231-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/4/22 16:49, Andy Shevchenko wrote:
> We have accessing P2SB from a very few places for quite known hardware.
> 
> When a new SoC appears in intel-family.h it's not obvious that it needs
> to be added to p2sb.c as well. Instead, provide default BDF and refactor
> p2sb_get_devfn() to always succeed. If in the future we would need to
> exclude something, we may add a list of unsupported IDs.
> 
> Without this change the iTCO on Intel Commet Lake SoCs became unavailable:
> 
>   i801_smbus 0000:00:1f.4: failed to create iTCO device
> 
> Fixes: 5c7b9167ddf8 ("i2c: i801: convert to use common P2SB accessor")
> Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks. I've merged this now, with the Commet Lake spelling error
fixed and with Jarko's Tested-by added.

I'll include this in my upcoming fixes pull-req to Linus.

Regards,

Hans




> ---
>  drivers/platform/x86/p2sb.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
> index 384d0962ae93..1cf2471d54dd 100644
> --- a/drivers/platform/x86/p2sb.c
> +++ b/drivers/platform/x86/p2sb.c
> @@ -19,26 +19,23 @@
>  #define P2SBC			0xe0
>  #define P2SBC_HIDE		BIT(8)
>  
> +#define P2SB_DEVFN_DEFAULT	PCI_DEVFN(31, 1)
> +
>  static const struct x86_cpu_id p2sb_cpu_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	PCI_DEVFN(13, 0)),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	PCI_DEVFN(31, 1)),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	PCI_DEVFN(31, 1)),
> -	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		PCI_DEVFN(31, 1)),
> -	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		PCI_DEVFN(31, 1)),
> -	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		PCI_DEVFN(31, 1)),
> -	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		PCI_DEVFN(31, 1)),
>  	{}
>  };
>  
>  static int p2sb_get_devfn(unsigned int *devfn)
>  {
> +	unsigned int fn = P2SB_DEVFN_DEFAULT;
>  	const struct x86_cpu_id *id;
>  
>  	id = x86_match_cpu(p2sb_cpu_ids);
> -	if (!id)
> -		return -ENODEV;
> +	if (id)
> +		fn = (unsigned int)id->driver_data;
>  
> -	*devfn = (unsigned int)id->driver_data;
> +	*devfn = fn;
>  	return 0;
>  }
>  

