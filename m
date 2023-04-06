Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA50E6D9454
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbjDFKpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjDFKpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD804EE2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680777874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjBeC5ttXVWU6637sM9DbdFklYW1fd4puIgmp2kM1PM=;
        b=aSOx4gUxbXzfjwQjPxESMNJ6qCt9S60xTSmsFVtwhM2kpaVqcol8cP7BvpGzki+pfgP2/p
        KCWSwasyD6q7RAk8XeRfZXTXtvOMHz5yKY84pcegFm1e53ucds03gOyX3238cXtc/x57dl
        5UXqBkfKVyy6DeTFQHizwOxiRU063Lg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-SZNGZtiyM0CrKCX3eOJxrA-1; Thu, 06 Apr 2023 06:44:32 -0400
X-MC-Unique: SZNGZtiyM0CrKCX3eOJxrA-1
Received: by mail-ej1-f69.google.com with SMTP id 28-20020a170906019c00b009343596918cso47364ejb.16
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 03:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777872; x=1683369872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjBeC5ttXVWU6637sM9DbdFklYW1fd4puIgmp2kM1PM=;
        b=Io68tvl8upE5jZgcDZ6sBNZZYpsW6JMpaNySd9QJcUZ4xkPgGhE/25sVPiHbDLle0G
         /7atsSAtLfMtH89p14gLnL1ts1PuG+TDBJdYupMFe9ZlOWaLkRJqik9NKyYLUcqz4Gv1
         5Qy2sbrB4izXu4jjw1a9Yh97P+oX59N/wnfccvkDLnGRlDe1Vha68tZZJD/v2Lmoda+g
         PtyVlY++q4HKiPzPqHEwqbqkEOnQ37Mhfoq6wZ8/7yX+klNJOVh7V70OWY1NRqbyxw1t
         CGTIL6IFcNYMvBHgaywUhmmZmQ3brCCMPerbz7+zjUBDmJW7bkuJG8NWG8Vt67Vfk3Yt
         pH9A==
X-Gm-Message-State: AAQBX9dTd7mg7IJGIGwU8dyjY5hiY5RcQcB5hUoElX/IUDM9s2kBOr3H
        6S+K3IYCnBECLfVzPl+d7ww3e3y7gM50MWq/1sXaMtPQCsKPqJenJwvUs+JHi1E6Cb1Xffvbl2g
        P2H4R8+0EnVYXMIWfpmmH3zS0
X-Received: by 2002:a17:906:5383:b0:939:4c86:d47b with SMTP id g3-20020a170906538300b009394c86d47bmr5936475ejo.19.1680777871848;
        Thu, 06 Apr 2023 03:44:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350YKw5d9sAnmrCv7+iF3IpuymujbqUnc6kSfxderJa9L09/Chkn5ceYeFPalKsTfyG9jc8ZvEw==
X-Received: by 2002:a17:906:5383:b0:939:4c86:d47b with SMTP id g3-20020a170906538300b009394c86d47bmr5936465ejo.19.1680777871569;
        Thu, 06 Apr 2023 03:44:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id rj13-20020a1709076c8d00b00947ccb6150bsm520220ejc.102.2023.04.06.03.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 03:44:30 -0700 (PDT)
Message-ID: <c12fcff3-d9aa-2d8d-7053-224207defc26@redhat.com>
Date:   Thu, 6 Apr 2023 12:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86: think-lmi: Remove unnecessary casts for
 attributes
Content-Language: en-US, nl
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230329-think-lmi-attrs-v1-1-5794f2367cc2@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230329-think-lmi-attrs-v1-1-5794f2367cc2@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/29/23 06:50, Thomas Weißschuh wrote:
> These casts are unnecessary and could break if structure layouts are
> randomized or implementation details change.
> Use the proper syntax that works without casts.
> 
> Also remove some unnecessary braces that checkpatch complains about.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

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
>  drivers/platform/x86/think-lmi.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index c816646eb661..02bfd6e3fed2 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -862,19 +862,18 @@ static umode_t auth_attr_is_visible(struct kobject *kobj,
>  	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
>  
>  	/* We only want to display level and index settings on HDD/NVMe */
> -	if ((attr == (struct attribute *)&auth_index) ||
> -			(attr == (struct attribute *)&auth_level)) {
> +	if (attr == &auth_index.attr || attr == &auth_level.attr) {
>  		if ((setting == tlmi_priv.pwd_hdd) || (setting == tlmi_priv.pwd_nvme))
>  			return attr->mode;
>  		return 0;
>  	}
>  
>  	/* We only display certificates on Admin account, if supported */
> -	if ((attr == (struct attribute *)&auth_certificate) ||
> -			(attr == (struct attribute *)&auth_signature) ||
> -			(attr == (struct attribute *)&auth_save_signature) ||
> -			(attr == (struct attribute *)&auth_cert_thumb) ||
> -			(attr == (struct attribute *)&auth_cert_to_password)) {
> +	if (attr == &auth_certificate.attr ||
> +	    attr == &auth_signature.attr ||
> +	    attr == &auth_save_signature.attr ||
> +	    attr == &auth_cert_thumb.attr ||
> +	    attr == &auth_cert_to_password.attr) {
>  		if ((setting == tlmi_priv.pwd_admin) && tlmi_priv.certificate_support)
>  			return attr->mode;
>  		return 0;
> 
> ---
> base-commit: fcd476ea6a888ef6e6627f4c21a2ea8cca3e9312
> change-id: 20230329-think-lmi-attrs-994abb757e98
> 
> Best regards,

