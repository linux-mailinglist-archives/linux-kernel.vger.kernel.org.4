Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47BF679ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjAXN45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjAXN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:56:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19CA4957A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674568418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jzhp5GTvCnm87v95hcZhee+HdP47wlxjbdCTpIobfbk=;
        b=PdPMnuYbRE0M3rL3NtqA49ykv9+lzvVJSMEzaNieVC3bhdp63kQJbdtJKgGRDEijO4KdHs
        X2vmcH0NN9CNhwQT9/WrAHN6Pzifqx8EgBEIlCv6tzsZ+cVnkSBrxaVk3SEMjrO2yUx5yG
        j5jZK5OoIthbxzV+VdKi7crGwiby2vo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-7Apijmr2NyeMYciZenKGXg-1; Tue, 24 Jan 2023 08:53:37 -0500
X-MC-Unique: 7Apijmr2NyeMYciZenKGXg-1
Received: by mail-ed1-f69.google.com with SMTP id s3-20020a50ab03000000b0049ec3a108beso8198723edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jzhp5GTvCnm87v95hcZhee+HdP47wlxjbdCTpIobfbk=;
        b=EKp8t4in3gtSphGi8Y906+k7kTDHRgxZQfKvWZY1KU8P6LA2fkilE/87Jfa/e3CUjq
         mFoE9eUQYIGy2zXNkzcYllgUWWb6eug7HFpAMVP6LXPQITDP4SpU48ql5+O2h39IL7vt
         1iL0xgkYL12uBkLBUx4INjmIU63Rge7m9KOXBYxQYEKsps3VEk0dH1sE0UJGZ/eHnOFw
         rgmXFG8mvY5Cfqu7aiXH5tsnVI+LccIGDMBMrMfUxZOYgmOOmUQ3ErviXwjXRPwbwshc
         uQGSJJy1/ekDkZw90oHPPRWlfmjOMEfL4hY/EjHOacHUnPuqLwkoj9X3cen1pzrMMD4a
         RHyg==
X-Gm-Message-State: AFqh2krXihB18n9ZFHs1zsFGZV3HONsAqENAjT6LuUw5QSfCgq5lfe78
        saAKIxeuNFvSIy5ARrZK4NcJFI9MG+YVskDYMFKRJbvPnPxa22TrlbYRToMTHX3ztjxGmRoLzOt
        avuWOTwVQZJhFXpKfkWo2rXjP
X-Received: by 2002:a17:906:8293:b0:870:3f5c:6a8f with SMTP id h19-20020a170906829300b008703f5c6a8fmr27486326ejx.27.1674568415904;
        Tue, 24 Jan 2023 05:53:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsmCjRqyw6mGDPEiA4HQ6cK2RZWOJnPKfzV28l+uxaqUnuJPBcFUsJmLeedQQrQLfTQD7wqoQ==
X-Received: by 2002:a17:906:8293:b0:870:3f5c:6a8f with SMTP id h19-20020a170906829300b008703f5c6a8fmr27486313ejx.27.1674568415708;
        Tue, 24 Jan 2023 05:53:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ec8-20020a170906b6c800b00864d20e5401sm913400ejb.196.2023.01.24.05.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 05:53:35 -0800 (PST)
Message-ID: <67cf4353-5bf5-d132-0b64-76533e6f3216@redhat.com>
Date:   Tue, 24 Jan 2023 14:53:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media: atomisp: fix build error, use vb2 interfaces
Content-Language: en-US, nl
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
References: <20230124013014.23578-1-rdunlap@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230124013014.23578-1-rdunlap@infradead.org>
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

Hi Randy,

On 1/24/23 02:30, Randy Dunlap wrote:
> The atomisp driver uses functions that are provided by VIDEOBUF2_VMALLOC
> instead of VIDEOBUF_VMALLOC, so change the 'select' so that the correct
> interfaces are built.
> 
> ld: drivers/staging/media/atomisp/pci/atomisp_fops.o: in function `atomisp_init_pipe':
> drivers/staging/media/atomisp/pci/atomisp_fops.c:649: undefined reference to `vb2_vmalloc_memops'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 9d4fa1a16b28 ("media: atomisp: cleanup directory hierarchy")
> Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: linux-media@vger.kernel.org

Thank you for the patch, the same patch was already posted by Arnd
a while ago:

https://lore.kernel.org/linux-media/20230104082212.3770415-1-arnd@kernel.org/

but this has unfortunately not found its way to Linus' tree yet.

Regards,

Hans


> ---
>  drivers/staging/media/atomisp/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
> --- a/drivers/staging/media/atomisp/Kconfig
> +++ b/drivers/staging/media/atomisp/Kconfig
> @@ -14,7 +14,7 @@ config VIDEO_ATOMISP
>  	depends on VIDEO_DEV && INTEL_ATOMISP
>  	depends on PMIC_OPREGION
>  	select IOSF_MBI
> -	select VIDEOBUF_VMALLOC
> +	select VIDEOBUF2_VMALLOC
>  	select VIDEO_V4L2_SUBDEV_API
>  	help
>  	  Say Y here if your platform supports Intel Atom SoC
> 

