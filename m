Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890AA5BCC47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiISM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiISM43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6433EE096
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663592187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBjmtOJBVrvCkDxZNegQRrlno9ip0hHfVuVwFPIj78k=;
        b=jWCVBMaH8HfX14RmCmDG9JpOMJYCOb6FfMIAst+usxA0DnjSwrxpBAFu37zk4wecACYD7J
        zo0gUcxTyD85WJdSF9om9da6FugYNUQpdtsSyABBE6a9BIdtciGqRZaeY6Z+PvsFfPLuZN
        wAOL4TztApzy1h5J0d5sloDmPf76ZZ8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-BwH8D6luOOCzfKXowdxZ9Q-1; Mon, 19 Sep 2022 08:56:26 -0400
X-MC-Unique: BwH8D6luOOCzfKXowdxZ9Q-1
Received: by mail-ed1-f70.google.com with SMTP id f18-20020a056402355200b0045115517911so19907837edd.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KBjmtOJBVrvCkDxZNegQRrlno9ip0hHfVuVwFPIj78k=;
        b=qfsgFxTcQsbhn86MkuUilgUmUD4bCen5orj/X9qKde2DOLy2avITA5lvwhGxLsXOn5
         fjM7FXNm+1iBQoVUQIWtZu3h9n1e6Vi0+S8gjf8RMDwWbuUlt+w53jEBj24D5ynfhmId
         m5+GqiKOM+2dbZ9ARfAyGTIp7RxzVpfx+zvlaVnidHxOxCLjtiXCk7+JQeYym95APBTr
         G5SBYu0SbviH+SezD84JjJV4S0HwhuO8bPdwoHqzOYDK3xTfP/pYgp3oVJCidkA1psmh
         hcAAqFndS4UFHyGPQmnmWLSGHub8n1Qp3NJd5QliKeoYfLAKSqRmywZMELJtyiWHjYKP
         wU2g==
X-Gm-Message-State: ACrzQf0BkNHx439oLOTWBtfX8c4juGoxug8H81i+lvwHnhccwGSoqRGA
        Zs1t/uZLzgd54KYu72QYMaRAZpwPz7q/3YaDouHWjv+mV0S5Mm+FlDkGuJ1thuIXDXNHIelgtHx
        EUSc3hDThFOd4F0MwvgdEE8gL
X-Received: by 2002:a17:907:7fac:b0:780:ec98:af85 with SMTP id qk44-20020a1709077fac00b00780ec98af85mr7737541ejc.641.1663592185338;
        Mon, 19 Sep 2022 05:56:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6EC97w2aNxIRzaoRnpvQieGkNUwuQejTM0orqeHPsjccPsu2mOGsAfu35iwEAr6AXJ3eAmLA==
X-Received: by 2002:a17:907:7fac:b0:780:ec98:af85 with SMTP id qk44-20020a1709077fac00b00780ec98af85mr7737525ejc.641.1663592185160;
        Mon, 19 Sep 2022 05:56:25 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090604d100b00773f3ccd989sm939584eja.68.2022.09.19.05.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 05:56:24 -0700 (PDT)
Message-ID: <13edebe5-2bb6-2de5-8352-a4737c9465d5@redhat.com>
Date:   Mon, 19 Sep 2022 13:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] drivers/platform: toshiba_acpi: Remove duplicate include
Content-Language: en-US
To:     Yihao Han <hanyihao@vivo.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919111519.19491-1-hanyihao@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220919111519.19491-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/19/22 12:15, Yihao Han wrote:
> Remove duplicate include in toshiba_acpi.c
> 
> Signed-off-by: Yihao Han <hanyihao@vivo.com>

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
>  drivers/platform/x86/toshiba_acpi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 43cc25351aea..b62a08ec5f45 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -39,7 +39,6 @@
>  #include <linux/workqueue.h>
>  #include <linux/i8042.h>
>  #include <linux/acpi.h>
> -#include <linux/dmi.h>
>  #include <linux/uaccess.h>
>  #include <linux/miscdevice.h>
>  #include <linux/rfkill.h>

