Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF556C0EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCTKcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCTKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13724C91
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4n8bWb2KiPyIVO86ZuijbXpENsFMRvDrfBE+34gfo+A=;
        b=CJp8Ld/mBKBdKqtJ9cZ8mA7GpdZgqJEi8NEkBA9g3Xo8aFi2VZZW7VwDqI8JVBSGVbK6Z3
        KiSKhGDuJqecSw44m24ujz3s/OuutK8Ht7lo5oxLH/l7NJ1jK+6Rpe/VnTNvz2dzachm4V
        oJ3jHwgMkbR4r8eiWMBG4b9MZKoHfz4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-5NtG5tAxOCyIXGP4aVmacA-1; Mon, 20 Mar 2023 06:31:37 -0400
X-MC-Unique: 5NtG5tAxOCyIXGP4aVmacA-1
Received: by mail-ed1-f69.google.com with SMTP id dn8-20020a05640222e800b004bd35dd76a9so16912314edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4n8bWb2KiPyIVO86ZuijbXpENsFMRvDrfBE+34gfo+A=;
        b=XlioekxOTJaVdbfoN03ySbBZEIpKE22cDmz1+SDhkXsRW1VtuobcfXpf6PROT+/cX1
         tBMldsHr1CKxMgomcMBMozBezFsfSvF6rzjeBq0NteNYjQxlnqujDR1StJCAzCrxxirU
         iQ4E5E5Tf4pHuZAFPKf9l53eyUA03YyvlObDIjteOoDD5+FguhL3JeQ3t8EHYacgIfvd
         UpzL3kcRMFIhAf9niZI7/rkj77UpQ9ehA3RP6PmlP1kTeo26Ycllgi72BlIrhcbPXC+7
         7dN6xcvAgyId303pMJ5Fu993wwmmFZQiUksdFpEPF4Z20jFX4FTfPEqDPWvh3VQZeoTg
         5uzQ==
X-Gm-Message-State: AO0yUKWD3dVM581UXxMx12y783tWREzKD/UZdUxZc+ScxYQWlXhKUt/M
        qHOV8MmkcGgHRfazW9HF4k3SSDlQ6Ia4Kj66uHOl6KVDDp6cOrUhfF8/LSaYcS8N+OQECHk4aUS
        Uk/b28043bdnmV9Hk+TC6WiGn
X-Received: by 2002:a05:6402:12cd:b0:4ac:bd6f:cacc with SMTP id k13-20020a05640212cd00b004acbd6fcaccmr10464114edx.12.1679308296359;
        Mon, 20 Mar 2023 03:31:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set9yBLrsEsykYPmr6XCzfvBz9SvvmrPLdLpPO5whLop5rGfWnUA7uTMS/kJmgfpCC7qBPWJAfg==
X-Received: by 2002:a05:6402:12cd:b0:4ac:bd6f:cacc with SMTP id k13-20020a05640212cd00b004acbd6fcaccmr10464097edx.12.1679308296106;
        Mon, 20 Mar 2023 03:31:36 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id c14-20020a509f8e000000b005003fd12eafsm4552816edf.63.2023.03.20.03.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:31:35 -0700 (PDT)
Message-ID: <2ce0b1cc-f595-1fab-3f4d-d0891d04347b@redhat.com>
Date:   Mon, 20 Mar 2023 11:31:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH linux-next v2 3/3] drivers/platform/x86/intel: fix a
 memory leak in intel_vsec_add_aux
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
 <20230309040107.534716-4-dzm91@hust.edu.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230309040107.534716-4-dzm91@hust.edu.cn>
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

On 3/9/23 05:01, Dongliang Mu wrote:
> The first error handling code in intel_vsec_add_aux misses the
> deallocation of intel_vsec_dev->resource.
> 
> Fix this by adding kfree(intel_vsec_dev->resource) in the error handling
> code.
> 
> Reviewed-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Thank you for your patch, I've applied this patch (as first patch
in the series) to my review-hans branch:
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
>  drivers/platform/x86/intel/vsec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index 13decf36c6de..2311c16cb975 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -154,6 +154,7 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
>  	ret = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
>  	mutex_unlock(&vsec_ida_lock);
>  	if (ret < 0) {
> +		kfree(intel_vsec_dev->resource);
>  		kfree(intel_vsec_dev);
>  		return ret;
>  	}

