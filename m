Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B91731917
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbjFOMkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245385AbjFOMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3142117
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686832758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmc8Ck1KZ4R9DlYnilDnSEU0pLAKRoigq9cruYYQA/o=;
        b=M+KsUjVyfbF6ADQV4HbPMES9GGB04JjXIjopnkfXKPsImd2x3MPIpowbr/P62pJFpV0uUS
        loLxbO+Qg9BAcB09WIJa7Ez1b4CdoxDtXHk/1rVv2Em4tPmEM+Cfw+IHU15awG6kxSG+KC
        M1pKHNiRE6WpXx9fJ5WDaaiCEQgalj4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-_jcuIAA3NhO4pzhhq_OxLA-1; Thu, 15 Jun 2023 08:39:15 -0400
X-MC-Unique: _jcuIAA3NhO4pzhhq_OxLA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-982b9212008so30794766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686832754; x=1689424754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmc8Ck1KZ4R9DlYnilDnSEU0pLAKRoigq9cruYYQA/o=;
        b=PS6A1ebAXGPLClzPgieidoTIUb93XStpU8oBP9IcF+Fz5lUTR5EwQab/mwtja5wYxK
         Iia8/fEpjLcxeZrl7FwCAAvaVvYPRvnHznVY57Yv1cyWi9de9uiIlFroc1lzkG0vfI0v
         +3aHXK5Go5Xuvc9YfW7+MPCXRLdpMhWA9lFtK6y87GG4c3LssIGsHBWCkMhL52mJP8Jt
         /Pbk/si9guB6+NlZScfk3HXDvyXSfFkR1AvwrsK+U1FWBy/JT72eUE+8bGDF3jILsWJ7
         7e2Tu7WOtQMO4J/KxZjilYmmTdC6IjROGz+xE8VUjsu2bRjzQt6P7BG4NC5adxTADELB
         tNbw==
X-Gm-Message-State: AC+VfDy0YuTgvA5qiwduiHzcqxlxF/dCdbeEXvPE7Jamhzbh6a0a1CNR
        CyXtoP68GREOBtiiFMwO4HUOB3DPN7UiwH2MkZT5LILam1Ba3I6BsvmC1JH6q3OBnBtoNiIpj5+
        wU+kNWBmkgr9fxCSmQTnAs5/EiPFfzHUX
X-Received: by 2002:a17:907:25c4:b0:94f:250b:2536 with SMTP id ae4-20020a17090725c400b0094f250b2536mr18895894ejc.28.1686832753883;
        Thu, 15 Jun 2023 05:39:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ODhxLRSqIoM4pF+MPEyxi7vHBGJThemb+HbIkSCbRLXTqcqPHXwd41AD7IWcDiDLk3Y/sag==
X-Received: by 2002:a17:907:25c4:b0:94f:250b:2536 with SMTP id ae4-20020a17090725c400b0094f250b2536mr18895889ejc.28.1686832753717;
        Thu, 15 Jun 2023 05:39:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709066d5500b00978897577c6sm9253027ejt.44.2023.06.15.05.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 05:39:12 -0700 (PDT)
Message-ID: <aba1cfd5-e78c-ccbf-b8be-d4e668c5a589@redhat.com>
Date:   Thu, 15 Jun 2023 14:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] platform/x86: apple-gmux: don't use be32_to_cpu and
 cpu_to_be32
Content-Language: en-US, nl
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230614064931.3263-2-orlandoch.dev@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230614064931.3263-2-orlandoch.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/14/23 08:49, Orlando Chamberlain wrote:
> Sparce doesn't seem to like using be32_to_cpu and cpu_to_be32 to convert
> values for the MMIO gmux to/from the host architecture.
> 
> Instead use iowrite32be and ioread32be to always convert, which should be
> fine because apple-gmux is only used on x86 with is always little endian.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305161712.5l3f4iI4-lkp@intel.com/
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>

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
>  drivers/platform/x86/apple-gmux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index e02b4aea4f1e..cadbb557a108 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -278,7 +278,7 @@ static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
>  	iowrite8(GMUX_MMIO_READ | sizeof(val),
>  		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
>  	gmux_mmio_wait(gmux_data);
> -	val = be32_to_cpu(ioread32(gmux_data->iomem_base));
> +	val = ioread32be(gmux_data->iomem_base);
>  	mutex_unlock(&gmux_data->index_lock);
>  
>  	return val;
> @@ -288,7 +288,7 @@ static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
>  			       u32 val)
>  {
>  	mutex_lock(&gmux_data->index_lock);
> -	iowrite32(cpu_to_be32(val), gmux_data->iomem_base);
> +	iowrite32be(val, gmux_data->iomem_base);
>  	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
>  	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
>  		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);

