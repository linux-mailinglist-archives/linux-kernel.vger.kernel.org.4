Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3C61F127
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiKGKtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiKGKsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C38718B21
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667818076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6uB+o4Cfcmanq/bCzxYHPJLa/HX+1EYHUXSVCbX6GIY=;
        b=AMIp3fltF8R4ZnVhQ28FghEz+NRbThpWv+q8y8GOkP6aDjV+tZhIrDyAKMgtSudq6Ilst6
        utzznhgABX0Gnd3WWdRQMcPHfgz/pS9cxKyZ87x7KdWz1QR/zlrUToYk0olJ4Vs64aK3D1
        vG/1OR6wBdUk+EPTOqVrhTL6vfsYtcw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-qTzQBzZZPjqG2ss7a9Cujw-1; Mon, 07 Nov 2022 05:47:55 -0500
X-MC-Unique: qTzQBzZZPjqG2ss7a9Cujw-1
Received: by mail-ed1-f71.google.com with SMTP id dz9-20020a0564021d4900b0045d9a3aded4so8147314edb.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uB+o4Cfcmanq/bCzxYHPJLa/HX+1EYHUXSVCbX6GIY=;
        b=7EZiAt+BPXBPEslWkIrzoLbUV3DyX98GA+lRtYeT6rToZ9kAM5zmXcEb0yCGfHcmAW
         lMhSL94jN61eT5NNBLVzggwb3ZYVqY6XHWqMqvGSOagDNDhX1yi4OmDs/ZzaHo369lnr
         W1zrfhpVf7p2jwX4smCwIBtNxmTQBiHDO6F4SxG4F4Suex0rTSS32CxAcAIfzQySp3WU
         vyerYGlNwwIYC0PL8KgdSijkybd+Coj3RQVOsXj2sP0E3hoOP+Sz+bAy/lELmV34rh2A
         CzC9Tl+0fhymV2CQpU8SojBgJcoTpTUFqDpUo9MgDkBTx1yvbl0paopQUrMKaYzcJjqK
         K13g==
X-Gm-Message-State: ACrzQf2xRjOMTLm4n+QMb7Q56WRVwNDnl+1xF1WYd/4Vs0oY14ricw7j
        dzCT9/sOSJ7bUHs3yAevYTalLVRY9gpzQhqdwc5kvOXJTBmO6supZtQI9UWsDOFecI00GlZ0RR+
        C5YWjx3P2NHtAZpLoyDZTH/wK
X-Received: by 2002:a17:906:cc0e:b0:7ad:a4c4:8745 with SMTP id ml14-20020a170906cc0e00b007ada4c48745mr47653820ejb.175.1667818073863;
        Mon, 07 Nov 2022 02:47:53 -0800 (PST)
X-Google-Smtp-Source: AMsMyM71LlJLwbmqYAfeJQNC0P54b8z/PFnDDLzAmDlLXlICaNUz/YJAACHxPlDuK3fRa72CphMkVg==
X-Received: by 2002:a17:906:cc0e:b0:7ad:a4c4:8745 with SMTP id ml14-20020a170906cc0e00b007ada4c48745mr47653808ejb.175.1667818073664;
        Mon, 07 Nov 2022 02:47:53 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id en6-20020a056402528600b0044e937ddcabsm4021222edb.77.2022.11.07.02.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:47:53 -0800 (PST)
Message-ID: <6d660c14-d7ad-e7d7-31e6-8891b48491a6@redhat.com>
Date:   Mon, 7 Nov 2022 11:47:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] platform/x86/intel/pmt: Sapphire Rapids PMT errata fix
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221105034228.1376677-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221105034228.1376677-1-david.e.box@linux.intel.com>
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

On 11/5/22 04:42, David E. Box wrote:
> On Sapphire Rapids, due to a hardware issue affecting the PUNIT telemetry
> region, reads that are not done in QWORD quantities and alignment may
> return incorrect data. Use a custom 64-bit copy for this region.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

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
>  drivers/platform/x86/intel/pmt/class.c | 31 +++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index 53d7fd2943b4..46598dcb634a 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
>  #include <linux/pci.h>
> @@ -19,6 +20,7 @@
>  #define PMT_XA_START		0
>  #define PMT_XA_MAX		INT_MAX
>  #define PMT_XA_LIMIT		XA_LIMIT(PMT_XA_START, PMT_XA_MAX)
> +#define GUID_SPR_PUNIT		0x9956f43f
>  
>  bool intel_pmt_is_early_client_hw(struct device *dev)
>  {
> @@ -33,6 +35,29 @@ bool intel_pmt_is_early_client_hw(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
>  
> +static inline int
> +pmt_memcpy64_fromio(void *to, const u64 __iomem *from, size_t count)
> +{
> +	int i, remain;
> +	u64 *buf = to;
> +
> +	if (!IS_ALIGNED((unsigned long)from, 8))
> +		return -EFAULT;
> +
> +	for (i = 0; i < count/8; i++)
> +		buf[i] = readq(&from[i]);
> +
> +	/* Copy any remaining bytes */
> +	remain = count % 8;
> +	if (remain) {
> +		u64 tmp = readq(&from[i]);
> +
> +		memcpy(&buf[i], &tmp, remain);
> +	}
> +
> +	return count;
> +}
> +
>  /*
>   * sysfs
>   */
> @@ -54,7 +79,11 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
>  	if (count > entry->size - off)
>  		count = entry->size - off;
>  
> -	memcpy_fromio(buf, entry->base + off, count);
> +	if (entry->guid == GUID_SPR_PUNIT)
> +		/* PUNIT on SPR only supports aligned 64-bit read */
> +		count = pmt_memcpy64_fromio(buf, entry->base + off, count);
> +	else
> +		memcpy_fromio(buf, entry->base + off, count);
>  
>  	return count;
>  }
> 
> base-commit: 225469d4acbcb873358d7618bad6e0203b67b964

