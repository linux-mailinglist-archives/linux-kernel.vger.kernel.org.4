Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D36681531
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjA3Pgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjA3Pgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D311BE38A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675092959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J22bQo7ekUFPlpddDChM1+4GkBeFMomcqAM4Usr4RF8=;
        b=GTQLCRHjrZlb/Ioav9+Kakpnf/PfiDd2LRj988XMQhX5w3bQfSDsCZTfcfn0J05yPMgqbu
        +laqdVR0+MIHcJazm8FxJI0Plx65lkqhmSKMYL/lptivwy1bnL78DJd41zIHbWOXgWt6oK
        ClBMyf/bWGCH9u8H+ln53eiyUP5ntR0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-144-CFPTo40jM-6p5PlGYtaVGg-1; Mon, 30 Jan 2023 10:35:57 -0500
X-MC-Unique: CFPTo40jM-6p5PlGYtaVGg-1
Received: by mail-ej1-f69.google.com with SMTP id sc9-20020a1709078a0900b0086910fdf624so7704472ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J22bQo7ekUFPlpddDChM1+4GkBeFMomcqAM4Usr4RF8=;
        b=Pdot6d75zdEttbvJvF3U6M9rL9qbH2NCfCBZoNXUid4JA5LUcPMaK3qM6m+mNYCr+/
         wF+MmP8ERqLQFFlWGAt4Yr3sjnjqiGtly+FV798nPWfdJwIp9Ld5NZUnDpQ/gZGuiHj4
         t/C50pZqzfgOK6yDToKEjpuYyeDjrVgJuOB4kwpIzK64N/E2GE/HohRuydsXNsDrtkGK
         MsxPa8TbMAXad+ktZSKNgpstm9IaKYvvs55uszP3Iz0fIVo/ycpvJjhZingm1RJv7ral
         6O6l+FM7nTC7ZU/3UVepF08Ob1Bryy6PllTKZHyMHhGBARInySTkEx6kTmxwBl+minBy
         rBGQ==
X-Gm-Message-State: AO0yUKV0mke1REMVyixGoPtjM2rVtH1q2D1zTF6iSAYwvXekVJDh/T4F
        Rw270A4dG8OmHGq6fgS2GmjaNzZFmCBARZ7RmFzjY9ncvufs2XjnSp1WCa52U/QLdDNKn2l6NIa
        6ODse5eB6tGWUoyFtYVfPMBLy
X-Received: by 2002:a17:906:6a01:b0:889:58bd:88a3 with SMTP id qw1-20020a1709066a0100b0088958bd88a3mr3959183ejc.68.1675092956016;
        Mon, 30 Jan 2023 07:35:56 -0800 (PST)
X-Google-Smtp-Source: AK7set+vuk6aVI6Hzanw0RfJOx1sp1qcgF6NUmFvNme5r/+ylv8ryvmrDHuz1qarimzBs7muJ2+gog==
X-Received: by 2002:a17:906:6a01:b0:889:58bd:88a3 with SMTP id qw1-20020a1709066a0100b0088958bd88a3mr3959166ejc.68.1675092955791;
        Mon, 30 Jan 2023 07:35:55 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170906f9c800b007c14ae38a80sm3288560ejb.122.2023.01.30.07.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:35:55 -0800 (PST)
Message-ID: <c78060ae-1fac-acd3-1963-9b1382cf6fd6@redhat.com>
Date:   Mon, 30 Jan 2023 16:35:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] platform/x86: think-lmi: Use min_t() for comparison and
 assignment
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y9QupEMPFoZpWIiM@ubun2204.myguest.virtualbox.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y9QupEMPFoZpWIiM@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/27/23 21:05, Deepak R Varma wrote:
> Simplify code by using min_t helper macro for logical evaluation
> and value assignment. Use the _t variant of min macro since the
> variable types are not same.
> This issue is identified by coccicheck using the minmax.cocci file.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>

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
>  drivers/platform/x86/think-lmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index a01a92769c1a..caa862506ed3 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -317,8 +317,8 @@ static int tlmi_get_pwd_settings(struct tlmi_pwdcfg *pwdcfg)
>  		return -EIO;
>  	}
>  
> -	copy_size = obj->buffer.length < sizeof(struct tlmi_pwdcfg) ?
> -		obj->buffer.length : sizeof(struct tlmi_pwdcfg);
> +	copy_size = min_t(size_t, obj->buffer.length, sizeof(struct tlmi_pwdcfg));
> +
>  	memcpy(pwdcfg, obj->buffer.pointer, copy_size);
>  	kfree(obj);
>  

