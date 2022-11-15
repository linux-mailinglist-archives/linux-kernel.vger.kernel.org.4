Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9E5629E37
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiKOP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiKOP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715C72DAB6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668527744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPjmVSvbKB40CCR5+G61PkEf4Ba+oFIdDkT9Qj5RB98=;
        b=PIaAHZQ1AG3n9/vVQwLPA5nrdcAdsbwBaysva+ZfswmR/y4hQjZoC6UPcn8vaif2yTNJqj
        6xGFX/QIzOih/oIBrmfLLeukbRQG/w6mMJ97+NoQ56d/WPolyNv4a+ErR1xTJmrihP+oSG
        L4fwn+P9dTwkvMTdcsss9GSDKem0PsA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-jtjRl75cMC-j36hYyDpDpQ-1; Tue, 15 Nov 2022 10:55:43 -0500
X-MC-Unique: jtjRl75cMC-j36hYyDpDpQ-1
Received: by mail-ed1-f69.google.com with SMTP id b13-20020a056402350d00b00464175c3f1eso10173913edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPjmVSvbKB40CCR5+G61PkEf4Ba+oFIdDkT9Qj5RB98=;
        b=Sg6r3noIFKZ5LslVKeC3DdYsButoYwOQIFkFUtHVKhE9aBNIGNqtxv2wipidQRPUKQ
         ycgP2ivQftcNp6xIeWZf6Qi9CSEP36iEAkfcR1c8ftmZbiUSXm9LhZcwphlNCQ7j4iJp
         HFFVEQZVKTgm/+juJ1+SKZ25rX/eetc1yZgep1IoVNAlmcLbo6gM/2edkFsmsWUEfAQa
         lPECH0azT+CFWetn2pbNlCWI4llNP6XNBdVITdtNPLwZ2lZCTRUDn1Vrc1x3qd7dckVK
         vdkttA79kfesZ3WgiM1xVrIScmOZ9Yx3+TylTM83W/pZAcjiMYFUKryPosYKfViS6hKx
         0wJw==
X-Gm-Message-State: ANoB5plqifR3Wws2F2O6+IWJMjsMeRqDGRGvBMN/B81doGbSLxN30vPG
        V/5SIDEXpSlWFO331q0Xw0RE0ZNGqAeUh5z/JYuz6ofrQqstlwVgAREBkYnNRfho1Y7q47QSVsO
        2O/Z7cqmrMvxUSdbv3IPji8+k
X-Received: by 2002:a50:fe13:0:b0:461:565e:8779 with SMTP id f19-20020a50fe13000000b00461565e8779mr15869006edt.387.1668527742099;
        Tue, 15 Nov 2022 07:55:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf62LnypI8+D6I1dwsExAn0tS+t62csKAA7KiPjW0+QdBxIexBU16E3VPnjUKKjLqOCYwTe88w==
X-Received: by 2002:a50:fe13:0:b0:461:565e:8779 with SMTP id f19-20020a50fe13000000b00461565e8779mr15868982edt.387.1668527741895;
        Tue, 15 Nov 2022 07:55:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b25-20020a17090630d900b0078d38cda2b1sm5602709ejb.202.2022.11.15.07.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:55:41 -0800 (PST)
Message-ID: <8f28a8dd-5a0c-c233-217c-0e610b830406@redhat.com>
Date:   Tue, 15 Nov 2022 16:55:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3] platform/x86: don't unconditionally attach Intel PMC
 when virtualized
Content-Language: en-US, nl
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        "David E . Box" <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
References: <20221110163145.80374-1-roger.pau@citrix.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221110163145.80374-1-roger.pau@citrix.com>
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

On 11/10/22 17:31, Roger Pau Monne wrote:
> The current logic in the Intel PMC driver will forcefully attach it
> when detecting any CPU on the intel_pmc_core_platform_ids array,
> even if the matching ACPI device is not present.
> 
> There's no checking in pmc_core_probe() to assert that the PMC device
> is present, and hence on virtualized environments the PMC device
> probes successfully, even if the underlying registers are not present.
> Previous to 21ae43570940 the driver would check for the presence of a
> specific PCI device, and that prevented the driver from attaching when
> running virtualized.
> 
> Fix by only forcefully attaching the PMC device when not running
> virtualized.  Note that virtualized platforms can still get the device
> to load if the appropriate ACPI device is present on the tables
> provided to the VM.
> 
> Make an exception for the Xen initial domain, which does have full
> hardware access, and hence can attach to the PMC if present.
> 
> Fixes: 21ae43570940 ('platform/x86: intel_pmc_core: Substitute PCI with CPUID enumeration')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Acked-by: David E. Box <david.e.box@linux.intel.com>

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
> Changes since v2:
>  - Don't split condition line.
> 
> Changes since v1:
>  - Use cpu_feature_enabled() instead of boot_cpu_has().
> ---
>  drivers/platform/x86/intel/pmc/pltdrv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/pltdrv.c b/drivers/platform/x86/intel/pmc/pltdrv.c
> index 15ca8afdd973..ddfba38c2104 100644
> --- a/drivers/platform/x86/intel/pmc/pltdrv.c
> +++ b/drivers/platform/x86/intel/pmc/pltdrv.c
> @@ -18,6 +18,8 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  
> +#include <xen/xen.h>
> +
>  static void intel_pmc_core_release(struct device *dev)
>  {
>  	kfree(dev);
> @@ -53,6 +55,13 @@ static int __init pmc_core_platform_init(void)
>  	if (acpi_dev_present("INT33A1", NULL, -1))
>  		return -ENODEV;
>  
> +	/*
> +	 * Skip forcefully attaching the device for VMs. Make an exception for
> +	 * Xen dom0, which does have full hardware access.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !xen_initial_domain())
> +		return -ENODEV;
> +
>  	if (!x86_match_cpu(intel_pmc_core_platform_ids))
>  		return -ENODEV;
>  

