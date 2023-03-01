Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643CC6A6E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCAO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCAO0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:26:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E11C367E8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677680734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p1xxA/g3d/XLIXQnPY6ZiljHHG+9A/r9H/glUwgfKBk=;
        b=f5jd66099AzyFBldBmmoYB96T9njD33tw10faBzZqopOtsiWzpUzbtTAQ2m/cr7MNyI3FP
        kQ7IlyklfElaGOgSO6NleFe8sVmnzx42Acw4uwmb9f1CMoGQKqJFaBvVNRwtVcip7ssw10
        WVPHk/eUFZto/hSunDsc/+AjuCIKBeM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-stUPJNA3PcKeQbwq2tvDXQ-1; Wed, 01 Mar 2023 09:25:32 -0500
X-MC-Unique: stUPJNA3PcKeQbwq2tvDXQ-1
Received: by mail-ed1-f72.google.com with SMTP id y24-20020aa7ccd8000000b004be3955a42eso1204801edt.22
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1xxA/g3d/XLIXQnPY6ZiljHHG+9A/r9H/glUwgfKBk=;
        b=nzlZijjuHxvZIaITUVRHQnxP3eFY14QFT4UUwTw1k7Hl1XaHZxY1vUtJf3ABZr9zt9
         n4Z8jcneBfo8JSFiCS9gGe1rgMccbgcKzYFZo7Qel70U5IZe4dDAA8PegI7V9SfgBHUB
         Rc5q5dJCq5b3kuoxrISOOkvIn4i5/4Y4wnKJtoL2qxZzxgooqLlkjnnV0v4FgQgmzb8h
         EFO+WM0sOWYY4t7oasq0u9rxuPOi5vY6mZLtJr1TMmcyJozWDEcGe+U6TWSL4JEJ8Cie
         QaNahvozI5US4wYfBShdqsvnQmYclAFeuzd+VgT80YMhImux5ZuSVkvVRCJ3ThBROA2h
         xsvw==
X-Gm-Message-State: AO0yUKW/J6DbuaGv2GCLSvsKtVr8e+X2SK+uJ7rSkeQfqEOQPd4HOxFx
        qTEI24JU8kL5MhNdtPEF9khrXB6u0eFXvC8yXWAYNgJfLHvik9w7FvoLlEzFd2bboHEykQ1+P9A
        E63ixun9DI8BsS2s3ZYHLXnfB
X-Received: by 2002:a17:907:c608:b0:905:a46b:a725 with SMTP id ud8-20020a170907c60800b00905a46ba725mr2774092ejc.16.1677680730733;
        Wed, 01 Mar 2023 06:25:30 -0800 (PST)
X-Google-Smtp-Source: AK7set9O9aIsAVHbHJ0KNun3k2X/WekzbOYA7pyJYE471Sn/lRHGrI+BPd/P2LWqrh/xnInfa0huMQ==
X-Received: by 2002:a17:907:c608:b0:905:a46b:a725 with SMTP id ud8-20020a170907c60800b00905a46ba725mr2774079ejc.16.1677680730423;
        Wed, 01 Mar 2023 06:25:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id n27-20020a170906089b00b008be5b97ca49sm5861092eje.150.2023.03.01.06.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:25:29 -0800 (PST)
Message-ID: <b82fa9d1-fcd6-b214-f0f3-532e7f7d8a00@redhat.com>
Date:   Wed, 1 Mar 2023 15:25:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 02/12] platform/x86: ISST: Add TPMI target
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
 <20230211063257.311746-3-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230211063257.311746-3-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/11/23 07:32, Srinivas Pandruvada wrote:
> Add TPMI as one of the device type which can be registered with ISST
> common driver.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thank I've applied this patches 2-4 to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

These patches are intended for the next rc1. This branch will get
rebased to the next rc1 when it is out and after the rebasing the
contents of review-hans will be pushed to
the platform-drivers-x86/for-next branch.

Please base the next version of this series (minus patches 1-4)
on pdx86/review-hans or if patches 1-4 have landed there on
platform-drivers-x86/for-next .

Regards,

Hans



> ---
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
> index 35ff506b402e..967c338e83c5 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
> @@ -30,7 +30,8 @@
>  
>  #define ISST_IF_DEV_MBOX	0
>  #define ISST_IF_DEV_MMIO	1
> -#define ISST_IF_DEV_MAX		2
> +#define ISST_IF_DEV_TPMI	2
> +#define ISST_IF_DEV_MAX		3
>  
>  /**
>   * struct isst_if_cmd_cb - Used to register a IOCTL handler

