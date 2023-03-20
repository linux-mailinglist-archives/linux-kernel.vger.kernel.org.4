Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F296C0EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCTKeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjCTKdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9457A9D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvqAZJKHoZRFU+5gUHofojPGgePG+fCPesUMDb0Y0X4=;
        b=IAPum0VBPBiAS8PfdORGwW32RYcDoJsZ6WHOISuNj+vSiDW228+hIBiVEB84LHFvBZ1VrI
        QJuTFK0x6jleN/H+bpUsGVNpztRot9V99kpsv7ii/RJQM7x/SY/kpHxdqpIbn3iYLGVrlP
        rjI+kjKarTEu0c6WMz3bYN/68cIq81A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-Mu0FJSmhM8GnskbowG9xIA-1; Mon, 20 Mar 2023 06:32:47 -0400
X-MC-Unique: Mu0FJSmhM8GnskbowG9xIA-1
Received: by mail-ed1-f72.google.com with SMTP id es16-20020a056402381000b004fa3e04c882so16684707edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvqAZJKHoZRFU+5gUHofojPGgePG+fCPesUMDb0Y0X4=;
        b=juWOLYhFnph9weaP2qQx8tJLiHLHkv4dvJGw9zj3dTd8OARJ9tBHe+pcCa+38f8jix
         S8BwBlCtmV1TpUyzfB+fiHqvc2WaWTgIU00V1WUnWCkk5anJhStBBrTttrbiAn29FHy1
         oiV48RSFuGFfU2AmRRQDvnA85MLQxJP9TE8HOIYLW49DcpTA+NYbvrbYen9RzGOG5BBI
         R4FAAinbGCfNo3OySeBwAIy+QPkKdq4l4AhrbWA4bezfQFAejrlsSS5I1F2a8KjGsgA4
         kQqTgHro+PUpq2lNeqzjTNQxOh8BSE1QfzfTevDq7rPyYpP1tRxi9wVKk5HzltqQdoY0
         2c5g==
X-Gm-Message-State: AO0yUKWk70SqH5nmpbZ8hr6gbIC20785N9KyOGmlXiohKLvNhfGjmNDB
        LWz8bdwI9KXNYpbKCHZAd2wdlXMSpXkzbQsTxYTUfUN1HCL55EhbpHT/2TU/OyM3j9vEIb8Okf3
        tMYPCa7gz1FyMIZ6WUygkw0UU
X-Received: by 2002:a17:906:454c:b0:8b1:4b6d:c57a with SMTP id s12-20020a170906454c00b008b14b6dc57amr7743673ejq.21.1679308366363;
        Mon, 20 Mar 2023 03:32:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set+yapuJjlvFpWtvTArVTrSFPyqqbNwPxwS2XItWam54NawfLMwaPbkP98VrcZl3j87CcMQQKA==
X-Received: by 2002:a17:906:454c:b0:8b1:4b6d:c57a with SMTP id s12-20020a170906454c00b008b14b6dc57amr7743660ejq.21.1679308366113;
        Mon, 20 Mar 2023 03:32:46 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a50cdd7000000b004fe924d16cfsm4697070edj.31.2023.03.20.03.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:32:45 -0700 (PDT)
Message-ID: <8f289b0c-6a5e-64ae-a26d-11d948e727e8@redhat.com>
Date:   Mon, 20 Mar 2023 11:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH linux-next v2 1/3] platform/x86/intel/tpmi: Fix double
 free in tpmi_create_device()
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
 <20230309040107.534716-2-dzm91@hust.edu.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230309040107.534716-2-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/9/23 05:01, Dongliang Mu wrote:
> The previous commit 6a192c0cbf38 ("platform/x86/intel/tpmi: Fix
> double free reported by Smatch") incorrectly handle the deallocation of
> res variable. As shown in the comment, intel_vsec_add_aux handles all
> the deallocation of res and feature_vsec_dev. Therefore, kfree(res) can
> still cause double free if intel_vsec_add_aux returns error.
> 
> Fix this by adjusting the error handling part in tpmi_create_device,
> following the function intel_vsec_add_dev.
> 
> Fixes: 6a192c0cbf38 ("platform/x86/intel/tpmi: Fix double free reported by Smatch")
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Note this patch causes the following compiler warnings:

  CC [M]  drivers/platform/x86/intel/tpmi.o
drivers/platform/x86/intel/tpmi.c: In function ‘tpmi_create_device’:
drivers/platform/x86/intel/tpmi.c:206:13: warning: unused variable ‘ret’ [-Wunused-variable]
  206 |         int ret, i;
      |             ^~~

I have fixed this and squashed the fix into the patch while applying it,
so there is no need to send a new version:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/intel/tpmi.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
> index c999732b0f1e..882fe5e4763f 100644
> --- a/drivers/platform/x86/intel/tpmi.c
> +++ b/drivers/platform/x86/intel/tpmi.c
> @@ -215,8 +215,8 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
>  
>  	feature_vsec_dev = kzalloc(sizeof(*feature_vsec_dev), GFP_KERNEL);
>  	if (!feature_vsec_dev) {
> -		ret = -ENOMEM;
> -		goto free_res;
> +		kfree(res);
> +		return -ENOMEM;
>  	}
>  
>  	snprintf(feature_id_name, sizeof(feature_id_name), "tpmi-%s", name);
> @@ -242,17 +242,8 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
>  	 * feature_vsec_dev memory is also freed as part of device
>  	 * delete.
>  	 */
> -	ret = intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev->auxdev.dev,
> -				 feature_vsec_dev, feature_id_name);
> -	if (ret)
> -		goto free_res;
> -
> -	return 0;
> -
> -free_res:
> -	kfree(res);
> -
> -	return ret;
> +	return intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev->auxdev.dev,
> +				  feature_vsec_dev, feature_id_name);
>  }
>  
>  static int tpmi_create_devices(struct intel_tpmi_info *tpmi_info)

