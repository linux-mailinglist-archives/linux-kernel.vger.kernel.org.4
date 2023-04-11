Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733386DD5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjDKInS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDKInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:43:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB62E6A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681202549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBm1DJo+O34kGFp5j7ZIGRS2RcBv14D2xSf4Qhrz/60=;
        b=JTpe1v93qhIk0im1BnqiwhhMMOUELts1l7pdSSkWmA5QWWEVbxChaq5qEjT1YetJc3yCX7
        U3rgA8Dhkecjw5EbKsFvnf0bpsTYvwcv83cPbw75vMZoin96hVZNsgfq+LhyYoUJZnyNF5
        i4u66oNm+sWeYszUnoPmkBaCC2lPbz0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-xBEcbnzSMPyV_7c1QPgm-Q-1; Tue, 11 Apr 2023 04:42:28 -0400
X-MC-Unique: xBEcbnzSMPyV_7c1QPgm-Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5048993067dso5783351a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681202547; x=1683794547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBm1DJo+O34kGFp5j7ZIGRS2RcBv14D2xSf4Qhrz/60=;
        b=6OUU1goOajvew/556TPB5arwlNvKa8yQPcL8Bxc5wRUzEa6iXUYA7bJ6INsSe1Gmu+
         H3/YxtnqdXGM30ub2rq2ihmGe4si8KmVTXg+luQWy04h5bpUovDEoe4nJ9uyMPimb17K
         FzTaCz6U2Y4McVtIQda6M3kbzJ7hBd5dFIkqgfxCurtPxg38DxGA5P45LMB4Ooo7zyWv
         1H5aNDTxt7y5TH8TTwd+I4WspVyTT1i9qBCLHpKa+HlaXqCHX5v2yTGSxnINtU2YmJGn
         ZXnU/vpFjnRhRRpuklsWhh+V2hfYAGNbSH6SEpl4TZbpXiUuMa7U41eE16mfwOEOndYq
         stlQ==
X-Gm-Message-State: AAQBX9fYbX7Qm5DvUeTCXNfU/bIaopmNeNfHN2pG2XI6zXRPsTJ+8M8Y
        ryqDwXshbKbrSVMZG72fa/k712xzzNHdKG/qCwAjezse6/jxeAwiw+StFZQzPciH+I0y9XhTEZv
        87OYXrBM8yBUDYcP+gHX4xzUc
X-Received: by 2002:a05:6402:3550:b0:504:6f39:8d1e with SMTP id f16-20020a056402355000b005046f398d1emr14162223edd.0.1681202547285;
        Tue, 11 Apr 2023 01:42:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350aIUSinhP/9bUwKFEOSeh/E3DYXxAQfvWzJdnl5A9NC/jcS/NRd1jzjEnDwQu+FF+CX3e0fAQ==
X-Received: by 2002:a05:6402:3550:b0:504:6f39:8d1e with SMTP id f16-20020a056402355000b005046f398d1emr14162212edd.0.1681202546909;
        Tue, 11 Apr 2023 01:42:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fy36-20020a1709069f2400b00927f6c799e6sm5839867ejc.132.2023.04.11.01.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:42:26 -0700 (PDT)
Message-ID: <ed988e83-ad6b-f648-4555-d78500fea3b1@redhat.com>
Date:   Tue, 11 Apr 2023 10:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2] platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in
 D3
Content-Language: en-US, nl
To:     "David E. Box" <david.e.box@linux.intel.com>,
        srinivas.pandruvada@linux.intel.com, irenic.rajneesh@gmail.com,
        david.e.box@intel.com, markgross@kernel.org, rjw@rjwysocki.net
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230409192535.914540-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230409192535.914540-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/9/23 21:25, David E. Box wrote:
> On Meteor Lake, the GNA, IPU, and VPU devices are booted in D0 power state
> and will block the SoC from going into the deepest Package C-state if a
> driver is not present. Put each device in D3hot if no driver is found.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> 
> V2 - Fix missing static reported by lkp

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




> 
>  drivers/platform/x86/intel/pmc/mtl.c | 31 ++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index eeb3bd8c2502..33aa98b54049 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -8,6 +8,7 @@
>   *
>   */
>  
> +#include <linux/pci.h>
>  #include "core.h"
>  
>  const struct pmc_reg_map mtl_reg_map = {
> @@ -45,8 +46,38 @@ void mtl_core_configure(struct pmc_dev *pmcdev)
>  	pmc_core_send_ltr_ignore(pmcdev, 3);
>  }
>  
> +#define MTL_GNA_PCI_DEV	0x7e4c
> +#define MTL_IPU_PCI_DEV	0x7d19
> +#define MTL_VPU_PCI_DEV	0x7d1d
> +static void mtl_set_device_d3(unsigned int device)
> +{
> +	struct pci_dev *pcidev;
> +
> +	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL, device, NULL);
> +	if (pcidev) {
> +		if (!device_trylock(&pcidev->dev)) {
> +			pci_dev_put(pcidev);
> +			return;
> +		}
> +		if (!pcidev->dev.driver) {
> +			dev_info(&pcidev->dev, "Setting to D3hot\n");
> +			pci_set_power_state(pcidev, PCI_D3hot);
> +		}
> +		device_unlock(&pcidev->dev);
> +		pci_dev_put(pcidev);
> +	}
> +}
> +
>  void mtl_core_init(struct pmc_dev *pmcdev)
>  {
>  	pmcdev->map = &mtl_reg_map;
>  	pmcdev->core_configure = mtl_core_configure;
> +
> +	/*
> +	 * Set power state of select devices that do not have drivers to D3
> +	 * so that they do not block Package C entry.
> +	 */
> +	mtl_set_device_d3(MTL_GNA_PCI_DEV);
> +	mtl_set_device_d3(MTL_IPU_PCI_DEV);
> +	mtl_set_device_d3(MTL_VPU_PCI_DEV);
>  }
> 
> base-commit: 4f59630a5ed0a4e7d275bd7e5d253a8f5a425c5a

