Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E336DB9BE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDHI6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHI6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9B9B45E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680944280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1R8c71HI2AgSEc0HQ9JQ5sIFN8ou94zk5KUQ+KTMNII=;
        b=J1GL6IWfsHBbRPZgeczJsMXgxz81p10i2cztBEBIkfxhk//rZBi/nrsyHzKovuiXl25rw/
        nu8yCKkJhSm8zUzR3Mc3c+g5/b5lJwWFrpTb32GpZXPuOfxtHJJrL1sJxOCyez/ng+2HAQ
        Bcx4uBUovKpFhEflxINjacCaRktf+rQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-P0ZrOxNYMNyJNE5-71GULA-1; Sat, 08 Apr 2023 04:57:56 -0400
X-MC-Unique: P0ZrOxNYMNyJNE5-71GULA-1
Received: by mail-ed1-f70.google.com with SMTP id y95-20020a50bb68000000b004fd23c238beso529357ede.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 01:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680944275; x=1683536275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1R8c71HI2AgSEc0HQ9JQ5sIFN8ou94zk5KUQ+KTMNII=;
        b=woe20KXpD988HKbiu9tHYc2Q/xHMqooaeDM1CVc3f/5gx14LCjFiBxGTuS8K8va/aO
         TiXRdTpSmp1itochsjOtCTGI8CO4sgvquUwg7kL9CgyBo19PDrkZSBSpUCPwEYrVVXhZ
         ZZwbWHTVE9+PBtFQS4ne2dvht4ObcWy5pXVoXMcR9yBjNhDEE5dA2rjMDbOXV9YQQ29v
         GZXs4jROxmvOghTlbY/nN3lNSyqeqXEXPpyTrS/KEkw/5g3RI13gCQ2fBKQO+TttcAY0
         GabmgVliEWhAboHfvAm/GhTMp5WhHNtAeE+9NhmjNqGYxDHwBTDnv8Ev0uxStHuJOyYJ
         PBKg==
X-Gm-Message-State: AAQBX9eqy+9tGg1GytOuHFLSEzT+KuBYw7yX+LxegLGeMAAZk3k2CmtY
        vO5Oev3WVGSnvBrGVUREEHv4xbv9VwgiNqmzwGPYoySMjlqpRujxgmk4QDqKBne0b+pTieJKoFM
        MsAaYcINqT/G7gedOtFveYayQ
X-Received: by 2002:a17:907:c687:b0:930:6e31:3c11 with SMTP id ue7-20020a170907c68700b009306e313c11mr1202143ejc.70.1680944275393;
        Sat, 08 Apr 2023 01:57:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350bg2uMwBGGgDUP9grVKm1lqHJHzxKU+Dny9OoS3jZl0c+ej5ew61PGz1MrsubxpYz+0ks9hsQ==
X-Received: by 2002:a17:907:c687:b0:930:6e31:3c11 with SMTP id ue7-20020a170907c68700b009306e313c11mr1202134ejc.70.1680944275063;
        Sat, 08 Apr 2023 01:57:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gx2-20020a1709068a4200b00930d22474dbsm2950402ejc.97.2023.04.08.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 01:57:54 -0700 (PDT)
Message-ID: <f7a20a10-3871-8b2d-251f-35b0136d684d@redhat.com>
Date:   Sat, 8 Apr 2023 10:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in D3
To:     "David E. Box" <david.e.box@linux.intel.com>,
        srinivas.pandruvada@linux.intel.com, irenic.rajneesh@gmail.com,
        david.e.box@intel.com, markgross@kernel.org, rjw@rjwysocki.net
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230408022629.727721-1-david.e.box@linux.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230408022629.727721-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 4/8/23 04:26, David E. Box wrote:
> On Meteor Lake, the GNA, IPU, and VPU devices are booted in D0 power state
> and will block the SoC from going into the deepest Package C-state if a
> driver is not present. Put each device in D3hot if no driver is found.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
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
> +void mtl_set_device_d3(unsigned int device)

As pointed out by "kernel test robot <lkp@intel.com>" this needs to
be static. Otherwise this LGTM. With this fixed please add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

to version 2 of the patch.

Regards,

Hans




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

