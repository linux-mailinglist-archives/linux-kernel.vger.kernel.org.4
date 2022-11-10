Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D7624C66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiKJVE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKJVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D07DD9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668114241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1QfUTLoo8KZyk/UmwYhDRfw7upAhiWcoYA8QgblVYZo=;
        b=hyNLPTMjUrXewJBI4PsanyCrF9MudGC5rUKCzdwPQhEa0xCQH3mIGJzuq+Xk3plMzTLVjw
        wXYl0n+80dKzlikyar8+PLSSJmK11Z2lTzjPX81O2tRwgxsEYB0rfeq3jiBs9qWgyJF+w3
        mzV8pTbsjRdLozqvZDr5WF2NO+Bhe8Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-41-oCSOwqi-Md6tc4zUq1RO7g-1; Thu, 10 Nov 2022 16:04:00 -0500
X-MC-Unique: oCSOwqi-Md6tc4zUq1RO7g-1
Received: by mail-ed1-f71.google.com with SMTP id z15-20020a05640240cf00b00461b253c220so2295434edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QfUTLoo8KZyk/UmwYhDRfw7upAhiWcoYA8QgblVYZo=;
        b=DUrX/aLLEmfD8PLeGcryiReQbXP8T8gnvNuztc4aSSGL2JWMvTUt3SaCVdea3+m7EZ
         g/dwlvwKVYZf6/WE7UJRa3PeuOSphygK7kb2CfoCG9gi5hjeu8hp2Q5FtDspJuDdn8+c
         vVcEapJuCGVvaptwelfbTsgJehr7DyWALdOSozxuiix8fJu31sBv2kNc8wJBBeq1oojJ
         n5EQXN2lrpbVR39Q+XYv84FgQWUnwJO8NTi5FTlRUez46ApUWPUo8TXYYMH4xrjblTeR
         M36v83hzaByGwAg3m1/RRnNlZ2qdxU6lF6Ihw/01mR6DLTUJbJlRoKVQfikYD/7IKXs0
         8bHg==
X-Gm-Message-State: ACrzQf2ijtTqwa04gHA0oIto/eMjP8fsFzfMYXkN2ZXU0kh0A7jS37bp
        DgqDu3STaVgYmN7zwy6dqKj/LE3ukU5N0a5JI3lLlNaPLMHmU5MFIpZcVgp2B8+1iMF2EY42nx4
        TNjLAwP6Kt85Eu7PTE+f25Z7y
X-Received: by 2002:a50:ec8f:0:b0:461:f919:caa4 with SMTP id e15-20020a50ec8f000000b00461f919caa4mr3484895edr.255.1668114239100;
        Thu, 10 Nov 2022 13:03:59 -0800 (PST)
X-Google-Smtp-Source: AMsMyM60lzCeZXfSRx4OZ88TfurkkBOoWJgHUAZxFcNaBDri3o3LrZKlUiOtI33RvYqQwthK2FbxCg==
X-Received: by 2002:a50:ec8f:0:b0:461:f919:caa4 with SMTP id e15-20020a50ec8f000000b00461f919caa4mr3484876edr.255.1668114238922;
        Thu, 10 Nov 2022 13:03:58 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id oz36-20020a1709077da400b007ae4717bef1sm155820ejc.15.2022.11.10.13.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 13:03:58 -0800 (PST)
Message-ID: <6798b3bc-125a-220d-3f37-71dcdf522f0d@redhat.com>
Date:   Thu, 10 Nov 2022 22:03:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 01/14] platform/x86/intel/ifs: Remove unused selection
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
 <20221107225323.2733518-2-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221107225323.2733518-2-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/7/22 23:53, Jithu Joseph wrote:
> CONFIG_INTEL_IFS_DEVICE is not used anywhere. The selection in
> Kconfig is therefore pointless. Delete it.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/platform/x86/intel/ifs/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
> index c341a27cc1a3..89152d46deee 100644
> --- a/drivers/platform/x86/intel/ifs/Kconfig
> +++ b/drivers/platform/x86/intel/ifs/Kconfig
> @@ -4,7 +4,6 @@ config INTEL_IFS
>  	# Discussion on the list has shown that the sysfs API needs a bit
>  	# more work, mark this as broken for now
>  	depends on BROKEN
> -	select INTEL_IFS_DEVICE
>  	help
>  	  Enable support for the In Field Scan capability in select
>  	  CPUs. The capability allows for running low level tests via

