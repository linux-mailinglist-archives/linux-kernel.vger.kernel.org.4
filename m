Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B4667EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbjALTKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjALTJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:09:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515A61E3CB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673549476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQT6kbVnh7LGmchU/CgBL+HDXmd5H1kHabNR2ns9vnw=;
        b=SDKuUe5rjPQk5gYVyB4AdIIVN9tzWJujx2sml5rlLYyxJKGfVx1NkunPNO6oHyMCREXfqp
        38SEYumvjx1LwyqVS9ysWbc8IwKqcu/FmoD2KVQXF84G68OtdwJ/kWj2bo8vq0Q4i+xhJg
        zYU/Cl62pOe4n7pqlaQaiO4fRFa+ccs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-MkWDhD3pN4iSuJpj1rl0BA-1; Thu, 12 Jan 2023 13:51:14 -0500
X-MC-Unique: MkWDhD3pN4iSuJpj1rl0BA-1
Received: by mail-ed1-f69.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so13053808edz.21
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQT6kbVnh7LGmchU/CgBL+HDXmd5H1kHabNR2ns9vnw=;
        b=I78+oQz+BSgHw/4uO0gn01vGpyq6zfMqpkOysZHD6+kJQMsFiiWg6XntXFlBzPA0qh
         MARkAFPUoBQrcbklDxtD9sUiWYXtAGmcqT2SdoZZ2Az2HgCR214p2VOQcyYVhLNjh1yx
         GWm974dvZP1050Ou7mbwqCcSveT5SJUAPe3ltYehS6eGUrbRpDVF1Eas001/b7Us+rPG
         tUTRobVQEaSnF43Yx5v77Mc+gqtpkKmHqsxfLHSXnH7m+yJm63jmOb7NuywIRtYBR/AF
         9iRvaruV9226Kc7kFxLtg2Qu2WW07NJ+Q4r9lD6Ms9komFp9ObqYUsoFtsCJmMEqsIZz
         5b/A==
X-Gm-Message-State: AFqh2kq4tVPgLZloDXV80LRViJpJGmrU2hBdXtPaPMwt1tEmuY7OLcSI
        gbtSOku9irTqNxiYEAl8Z1AqCyPjTqnyWgMnUxJ5265Bf3GUA+rKBomttvGNvIqp2dZIbRSapHR
        p1o5PNWq4BBStLLIXI1WmfNBm
X-Received: by 2002:a17:906:308e:b0:860:c12c:14f9 with SMTP id 14-20020a170906308e00b00860c12c14f9mr6014664ejv.40.1673549473420;
        Thu, 12 Jan 2023 10:51:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuyMGMWxPO0+4Fa/LRiHJC3qvn0L2hSTyjEeeBxblQnjaAfDuZkcxAIY91oMKAl3HAwlTAj1Q==
X-Received: by 2002:a17:906:308e:b0:860:c12c:14f9 with SMTP id 14-20020a170906308e00b00860c12c14f9mr6014658ejv.40.1673549473290;
        Thu, 12 Jan 2023 10:51:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906310f00b00738795e7d9bsm7620034ejx.2.2023.01.12.10.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 10:51:12 -0800 (PST)
Message-ID: <a2fbf35d-7275-7f49-9e87-ec5cdd243719@redhat.com>
Date:   Thu, 12 Jan 2023 19:51:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] platform/x86: intel/pmc/core: Add Meteor Lake mobile
 support
Content-Language: en-US, nl
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        David E Box <david.e.box@linux.intel.com>
References: <20221228230553.2497183-1-gayatri.kammela@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221228230553.2497183-1-gayatri.kammela@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 12/29/22 00:05, Gayatri Kammela wrote:
> Add Meteor Lake mobile support to pmc core driver. Meteor Lake mobile
> parts reuse all the Meteor Lake PCH IPs.
> 
> Cc: David E Box <david.e.box@linux.intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans


> ---
>  drivers/platform/x86/intel/pmc/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index f1d802f6ec3f..3a15d32d7644 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1029,6 +1029,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	adl_core_init),
>  	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,          mtl_core_init),
> +	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	mtl_core_init),
>  	{}
>  };
>  
> 
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2

