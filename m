Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7968BEA2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjBFNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBFNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67277265A0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675691142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7t65WL/jguZZnvFepWV6wM1ypQrRb0SSpUcwmA5Ktc=;
        b=Vf0FMceI8EWlM/OI9BLznjn9a4hxASU4iKEbmj0LuOe1k4YicpYHC1ooS0B2ZmJ61Ee04H
        UqESsPPYe5IHuaSTfAplbkmDmEU6xBQKWtYB5tEbTL7H/R4Yf0Aq3m1WuKLf5AXwglRRYd
        HQoZFKrEygTRxjQjlSPR/OvtfnVRSYQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-AdH8WaYvO5CLixqXXUhz_w-1; Mon, 06 Feb 2023 08:45:41 -0500
X-MC-Unique: AdH8WaYvO5CLixqXXUhz_w-1
Received: by mail-ej1-f69.google.com with SMTP id qn8-20020a170907210800b0088eda544bd6so8747769ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7t65WL/jguZZnvFepWV6wM1ypQrRb0SSpUcwmA5Ktc=;
        b=xdvqOulBT/Ehz2fadG211Ur3JzeY33Z5TnCBxmRplsrMSyN31eZ1VyVdZEczr3FbtO
         Vad4B97IIHvdKwvM1I4towxPyX+hCTdxcUykeTkRCnV56CYIICKMjqkSrlHJBDF+xFfy
         SifFg8IDQWcQfHNi3sX0EoCV/hiWyQFk4PGTNu6e5DA+4yn4RSAaj1hhY/dQjmw6Ds9A
         Yry9LnurQz3Mno/9IasZmJTKQVCtyQeifbcN9pG5u7KqcUSZ2re3uepRPRev/r6V/RJY
         0kr24asU3YH9cT+ln9iiPBHpYsHIh5T9TAUTTBT3LLnFxt2v60VmX1F3vWgTRq/wIBwD
         m4TA==
X-Gm-Message-State: AO0yUKWj7jSP3lgIszcz2HhiQmGGicwYURhkopJAB+vAbAT0OE8afKK2
        WyO/J9hEqxd12LZ/GZabYzejU4E/Zwgnodc9IhgazJcI21bgxinyQmI1Um44/9Enj4n7TZwwjVd
        TxY0g9sFiAblSP5MOyZnh4kEE
X-Received: by 2002:a17:906:e98:b0:88f:926c:c0a7 with SMTP id p24-20020a1709060e9800b0088f926cc0a7mr11557097ejf.18.1675691140269;
        Mon, 06 Feb 2023 05:45:40 -0800 (PST)
X-Google-Smtp-Source: AK7set86XRrP83rvXQCoeK/Ex8ajzpm8ZEVJuSpFk7kKwIKoYnKcr9beQmjxwhE+5bkHKpF3iE8MRw==
X-Received: by 2002:a17:906:e98:b0:88f:926c:c0a7 with SMTP id p24-20020a1709060e9800b0088f926cc0a7mr11557084ejf.18.1675691140142;
        Mon, 06 Feb 2023 05:45:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kd21-20020a17090798d500b008857fe10c5csm5422405ejc.126.2023.02.06.05.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 05:45:39 -0800 (PST)
Message-ID: <a6108a64-8318-6156-d205-f7f401b4ad6d@redhat.com>
Date:   Mon, 6 Feb 2023 14:45:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86/intel/vsec: Add support for Meteor Lake
Content-Language: en-US, nl
To:     "David E. Box" <david.e.box@linux.intel.com>, markgross@kernel.org
Cc:     Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230203011716.1078003-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230203011716.1078003-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/3/23 02:17, David E. Box wrote:
> From: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> 
> Add Meteor Lake PMT telemetry support.
> 
> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

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
>  drivers/platform/x86/intel/vsec.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index 07ae77a3bbe4..bc38fe4962b2 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -419,14 +419,23 @@ static const struct intel_vsec_platform_info dg1_info = {
>  	.quirks = VSEC_QUIRK_NO_DVSEC | VSEC_QUIRK_EARLY_HW,
>  };
>  
> +/* MTL info */
> +static const struct intel_vsec_platform_info mtl_info = {
> +	.quirks = VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG,
> +};
> +
>  #define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
>  #define PCI_DEVICE_ID_INTEL_VSEC_DG1		0x490e
> +#define PCI_DEVICE_ID_INTEL_VSEC_MTL_M		0x7d0d
> +#define PCI_DEVICE_ID_INTEL_VSEC_MTL_S		0xad0d
>  #define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
>  #define PCI_DEVICE_ID_INTEL_VSEC_RPL		0xa77d
>  #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
>  static const struct pci_device_id intel_vsec_pci_ids[] = {
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
> +	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_M, &mtl_info) },
> +	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_S, &mtl_info) },
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &(struct intel_vsec_platform_info) {}) },
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
>  	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },

