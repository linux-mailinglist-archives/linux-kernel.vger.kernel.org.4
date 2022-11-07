Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90161F132
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKGKu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiKGKu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D86F1082
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667818203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8xCaDjq+dyP2Kfrhc9Kj718Mofe9WPQnaMWa6lVbPk=;
        b=bqngmtVMMvRjUzxV6Z8CuhrNhMHrHW2oUUitM8xx0fuqMq3JXEOhhb2i+yUGI8DzHLmg5n
        C5YZ6fpcBtqnCH5bizZTNJ9cY7DU9NKUxOX0+qRqY/cq+vPZHBXWxPDEIZyc0xuMn5FQyL
        h3xnXwvFAohXCq4m5Zzi1tCJEyofcg0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-383-EK4EMgEOOyyfO03Kh8SL_w-1; Mon, 07 Nov 2022 05:50:02 -0500
X-MC-Unique: EK4EMgEOOyyfO03Kh8SL_w-1
Received: by mail-ej1-f71.google.com with SMTP id qa14-20020a170907868e00b007ae24f77742so5259636ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8xCaDjq+dyP2Kfrhc9Kj718Mofe9WPQnaMWa6lVbPk=;
        b=mRyQDCd+fpqJHtrIbEDOp/YV4gI593MstlYTSBzcIIPIIzXU/gZc4NUkGgdMtuKG+0
         4tQxCqFc3PH0ote96bHPt/E+1H7RRmAv2JKbxKvZ52a+Y7ObTZbs/X0mAjL0D9HAfWHk
         KEzAxZ5/VVePlvfOoxMEDAoiOuuMyuB5UbgAxRhyhrNeLYOY5iSiX3bL9H/HXSX9fM6X
         OC4ifjNBdHJZuS8hrrgm9ZwJkCQRdufAbDEo56LMwllgw67gLEMTDEtt+I6lGDMoJAPa
         9iiNN72RMlkltClRK1xPFQbUpL8f849b7X6v8YfUvyNfE7G0hjVBnTULX0//ghLRu2f3
         jakQ==
X-Gm-Message-State: ACrzQf2IJuHQesX3XMPO6hQaQ8mtPsQ5/pMjpIREEbIfXi9VGjHjFnQc
        rFFcShf+RX78NbP56teTjZebF5+BQ8fZMH00r55KVz1lKTROK8UvDll74xSi/pv92T3DUonaKr6
        eX4Y9lpoZbgv85SGQGyej6rLF
X-Received: by 2002:a17:907:6d12:b0:7ae:3b9b:4554 with SMTP id sa18-20020a1709076d1200b007ae3b9b4554mr14650155ejc.307.1667818201092;
        Mon, 07 Nov 2022 02:50:01 -0800 (PST)
X-Google-Smtp-Source: AMsMyM78WGHQOvUieOQpSHURTNyNPuY81hBiDH1LV7kd+Av1VjZAyI9TLNT2XS7dlczJAu3c/+QR+g==
X-Received: by 2002:a17:907:6d12:b0:7ae:3b9b:4554 with SMTP id sa18-20020a1709076d1200b007ae3b9b4554mr14650145ejc.307.1667818200918;
        Mon, 07 Nov 2022 02:50:00 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ca21-20020aa7cd75000000b004580862ffdbsm4015075edb.59.2022.11.07.02.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:50:00 -0800 (PST)
Message-ID: <ece4214d-cec5-940d-eb9d-837ca9f413cd@redhat.com>
Date:   Mon, 7 Nov 2022 11:49:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] platform/x86/intel: hid: add some ACPI device IDs
Content-Language: en-US
To:     Ivan Hu <ivan.hu@canonical.com>, alex.hung@amd.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221102020548.5225-1-ivan.hu@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221102020548.5225-1-ivan.hu@canonical.com>
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

On 11/2/22 03:05, Ivan Hu wrote:
> Add INTC1076 (JasonLake), INTC1077 (MeteorLake) and INTC1078 (RaptorLake)
> devices IDs.
> 
> Signed-off-by: Ivan Hu <ivan.hu@canonical.com>

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
>  drivers/platform/x86/intel/hid.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
> index 79cff1fc675c..b6313ecd190c 100644
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -27,6 +27,9 @@ static const struct acpi_device_id intel_hid_ids[] = {
>  	{"INTC1051", 0},
>  	{"INTC1054", 0},
>  	{"INTC1070", 0},
> +	{"INTC1076", 0},
> +	{"INTC1077", 0},
> +	{"INTC1078", 0},
>  	{"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, intel_hid_ids);

