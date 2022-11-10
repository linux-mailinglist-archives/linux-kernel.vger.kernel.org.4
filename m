Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAEE624D18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiKJVfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiKJVfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:35:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE2012AF7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668116050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGq2aqvFk/urSwdIN4KIfJO6NUgNb1K5ak9OotOPtfU=;
        b=iQwNJIBeL8zlWttCIb2Y3/ySyBCY+RafzWYO9oG/KC8UhHPrgzNoIujV1KNp94LOWgaIoB
        5jP2qsZsXQtkk9SrxOLH+zRFMlyJfsYm9l2FFMwrBGVLhk270zT4iYbafGHsPf+x77vIc4
        pVYagXDZ/Wp47ZQx8rN9K4Fy79aIibY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-s0-OufY1PAqWUP4enqI09g-1; Thu, 10 Nov 2022 16:34:08 -0500
X-MC-Unique: s0-OufY1PAqWUP4enqI09g-1
Received: by mail-ej1-f71.google.com with SMTP id gt15-20020a1709072d8f00b007aaac7973fbso1922485ejc.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:34:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGq2aqvFk/urSwdIN4KIfJO6NUgNb1K5ak9OotOPtfU=;
        b=TVkmSuFXCxK1y/Ck1FypTk49JPyg2UlnyuN67Ad27HD6pJOheBCA0BWMyxmKByZjEm
         5kGX0atMRTBv9DKqnFNbqM/XyZ8s2EV1z6KsqPKWPjqrJ/xVnZxb0XyR/VaJ5RJXJdBZ
         rpN6II6A4ybo4aPXQ/8VcROXBvq/6HaFXXZCXf3t/p7XxXTSvaGCaTP8Ke3xMbOBQS2J
         95RpinM2KuH02Gt1ACxJkFFbk7lTJScbrFe7v+kebxOAYnGp1mC+Ez8gD+/X5sVxQkRN
         2hKl8KYdFPt7ZZVH+Q6wM09u1xI0vxY+Izsj8uCjom4lJ72r5Ej6M1HfHNQ+nuGGlxXB
         01cA==
X-Gm-Message-State: ACrzQf3yqUWFsnScs9OMREVdBPHvs85xLfEMOx9WZ2w/RmhJLWt7QatP
        RWgT0TVVcKVnTkhFmoPcI2XyAAnEcGCtH95LBDrXlhcVeLwhuFZ8J0uH6WpbKLGI+bySrr5jOD/
        zN34dsZUbcxKULMn5ZmOqEAkZ
X-Received: by 2002:a05:6402:c8d:b0:460:7413:5d46 with SMTP id cm13-20020a0564020c8d00b0046074135d46mr3579574edb.47.1668116045462;
        Thu, 10 Nov 2022 13:34:05 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4GapEdBzGG5QBFJAeIp0VGj5YCHVjerCZbIsaJ0p+/SU6lOYT9dCpExb/V2/Jl3tN20W345A==
X-Received: by 2002:a05:6402:c8d:b0:460:7413:5d46 with SMTP id cm13-20020a0564020c8d00b0046074135d46mr3579556edb.47.1668116045249;
        Thu, 10 Nov 2022 13:34:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id lb17-20020a170907785100b00734bfab4d59sm139507ejc.170.2022.11.10.13.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 13:34:04 -0800 (PST)
Message-ID: <72b7481b-8b69-d091-a097-ee6c9fbb92f8@redhat.com>
Date:   Thu, 10 Nov 2022 22:34:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 14/14] Revert "platform/x86/intel/ifs: Mark as BROKEN"
Content-Language: en-US, nl
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-15-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221107225323.2733518-15-jithu.joseph@intel.com>
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

On 11/7/22 23:53, Jithu Joseph wrote:
> Issues with user interface [1] to load scan test images
> has been addressed, so the following can be reverted.
> commit c483e7ea10fa ("platform/x86/intel/ifs: Mark as BROKEN")
> 
> Link: https://lore.kernel.org/lkml/26102aca-a730-ddf8-d024-2e7367696757@redhat.com/ [1]
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/platform/x86/intel/ifs/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
> index 89152d46deee..3eded966757e 100644
> --- a/drivers/platform/x86/intel/ifs/Kconfig
> +++ b/drivers/platform/x86/intel/ifs/Kconfig
> @@ -1,9 +1,6 @@
>  config INTEL_IFS
>  	tristate "Intel In Field Scan"
>  	depends on X86 && CPU_SUP_INTEL && 64BIT && SMP
> -	# Discussion on the list has shown that the sysfs API needs a bit
> -	# more work, mark this as broken for now
> -	depends on BROKEN
>  	help
>  	  Enable support for the In Field Scan capability in select
>  	  CPUs. The capability allows for running low level tests via

