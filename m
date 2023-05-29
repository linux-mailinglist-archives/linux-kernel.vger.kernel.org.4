Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178BA714D58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjE2Prn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjE2Prl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EA7CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685375211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L//detjb5kBzA6uy4kwewHuN6E7xSSi6zXOv7sevG+4=;
        b=A7BM+VIG0MxfwIvCEcjM4kZsefyx7WzxQQPOgLRMemGiIKfHegr/aTcoe8Li8godZ8ZlTK
        ugkISzlEze3ndQ6r0Gt7SBKGHoLrN42NzkOzLIFRuha91hwCYSVfcbRYOjMxAOO7bB950M
        kWcDMD1fACZ/+TVy8IsXWeVdqsYKUOI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-KLwHRl7-OqSyOdTCZs-_DA-1; Mon, 29 May 2023 11:46:50 -0400
X-MC-Unique: KLwHRl7-OqSyOdTCZs-_DA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a348facbbso379952666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685375209; x=1687967209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L//detjb5kBzA6uy4kwewHuN6E7xSSi6zXOv7sevG+4=;
        b=kF1k1jh2REfm+uwUzi0DTd1UHot8p9J+veALKOEkmMfCxX4+3JIJ2FZwdIQ42zwDc8
         CygiVggbGyZR5sZSdhzp9vDOjbimwdm/iTN3MFv/697FBTUJ8LzFYCLVFH6LG5JTzjnq
         Ifo07/PowQKU2pBq9XDhyFCjHtgCyucgwNg/x3T6E2bnX21YrWlvJR9l1C4LINO6AaGt
         Cb8ZuRFrfi5OM+MS/hiISlHOZM4IAw+WyzDEeXm8ab0XMQmjtAkhBkCg2Sclp4q05QSa
         pEq8oSdWBKUom50lGgf7EYaliRmCRfEyjfeAYaBePLuap0aSROsY2N5knSzVCkoJBimc
         XM1A==
X-Gm-Message-State: AC+VfDwPhLEqTt/E19ZjZLPKGPLcyNwvOBduwuM6zm96TFnnPcksXfV3
        69cwNzItwMpULH/Qi0JyZQRRn3vvWWxneeUCH0LFnzUJopyLXPfBDp0htvQBbop9n/k4ezdXMJc
        iImo4oDVvAGQiUFpZID8EFX/v
X-Received: by 2002:a17:907:3e05:b0:96f:a0ee:1143 with SMTP id hp5-20020a1709073e0500b0096fa0ee1143mr13247547ejc.10.1685375209224;
        Mon, 29 May 2023 08:46:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GZizdSYZfJqAuOr5D0uR5PMymoysOKV0L9yImtEO4qPtPNfJP3Crhn7/pA8LegetXJY1m3g==
X-Received: by 2002:a17:907:3e05:b0:96f:a0ee:1143 with SMTP id hp5-20020a1709073e0500b0096fa0ee1143mr13247524ejc.10.1685375208880;
        Mon, 29 May 2023 08:46:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090643d700b0095850aef138sm6050097ejn.6.2023.05.29.08.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:46:48 -0700 (PDT)
Message-ID: <ef8e411b-c326-9d24-c4f0-96cd183a9d1f@redhat.com>
Date:   Mon, 29 May 2023 17:46:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] media: atomisp: move the sanity checks before variable
 dereferences
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230529152136.11719-1-dzm91@hust.edu.cn>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230529152136.11719-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/29/23 17:21, Dongliang Mu wrote:
> Smatch reports:
> 
> sh_css_load_firmware() warn: variable dereferenced before check 'fw_data'
> 
> The variable fw_data can be NULL in sh_css_load_firmware, resulting in
> NULL pointer dereference.
> 
> Fix this by moving the sanity checks before variable dereferences.
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Thank you for your patch, but the same patch has already been submitted
and merged into my media-atomisp branch about a week ago:

https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/commit/?h=media-atomisp&id=c09907049eea9f12e959fb88c02a483a4c5eee89

> ---
>  drivers/staging/media/atomisp/pci/sh_css_firmware.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_firmware.c b/drivers/staging/media/atomisp/pci/sh_css_firmware.c
> index e7ef578db8ab..38b757c3df0a 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_firmware.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css_firmware.c
> @@ -229,6 +229,10 @@ sh_css_load_firmware(struct device *dev, const char *fw_data,
>  	struct sh_css_fw_bi_file_h *file_header;
>  	int ret;
>  
> +	/* some sanity checks */
> +	if (!fw_data || fw_size < sizeof(struct sh_css_fw_bi_file_h))
> +		return -EINVAL;
> +
>  	firmware_header = (struct firmware_header *)fw_data;
>  	file_header = &firmware_header->file_header;
>  	binaries = &firmware_header->binary_header;
> @@ -243,10 +247,6 @@ sh_css_load_firmware(struct device *dev, const char *fw_data,
>  		IA_CSS_LOG("successfully load firmware version %s", release_version);
>  	}
>  
> -	/* some sanity checks */
> -	if (!fw_data || fw_size < sizeof(struct sh_css_fw_bi_file_h))
> -		return -EINVAL;
> -
>  	if (file_header->h_size != sizeof(struct sh_css_fw_bi_file_h))
>  		return -EINVAL;
>  

