Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41AD6D4180
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjDCKDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjDCKDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF22D50
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680516177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjmzd/YE21ORQOPGQC93EsHd4KdzCGtkIKV/EHIywtI=;
        b=iigfHDu0REgVzskNoAQ3Z592sHpZKLBaOi/xlGyLseOGgvectEXCrRIi3FKECCngHXC49z
        RYgXNKbDuQbJxFZFto5/m6aM6TamhXg6Ywl43J194UAl4z+YSwugxA8BFf6gYBQ8Hphd0R
        6QMkr0Pk6CLy1P6ypai9AceWtSzHTEY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-O0cHSy3NNritxFiiYG3Xjw-1; Mon, 03 Apr 2023 06:02:56 -0400
X-MC-Unique: O0cHSy3NNritxFiiYG3Xjw-1
Received: by mail-ed1-f71.google.com with SMTP id a27-20020a50c31b000000b0050047ecf4bfso40546977edb.19
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 03:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680516175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjmzd/YE21ORQOPGQC93EsHd4KdzCGtkIKV/EHIywtI=;
        b=4biZU09DExvli7ZoIPFB/LeYs3R64ugibpoGEwdBqmxRy64lU7s01e4EIYTUK7513E
         8jWIxxg0HMHTISqQ/P6zRDZ3SuoGdv4rzaRJP9f4+nMBGQZyMMeBVpKfydvJ99D/34qg
         lg1Em1Cd5QPe7aY1NYWZ06rdF+GPe4SkzGMZzUI19yUCzgTsk5vUJqlXydB6t3nVXYCU
         DjJ/yYIjQrINrbRTq06vXZQAzlkwjLvof1dhndqZe7zydF5YxYoUFXK8ZCb6qJdVkbEB
         8s34hmYFpI0fPXIfOC6sNbfIUAyVwglTUKG/Q7jOFgDmnJScqOst2y6pQm/YyauyGeFR
         TW4Q==
X-Gm-Message-State: AAQBX9ef7NftYW+ePOKips6kI7tNAcVOuRvJjFnfN/KDE47ejyuopFRX
        rpCUKvXtrKG2Xk34QsbddwzK0SwDRSSc2nen+o1duP87gsK3TWtDXkE4jb9DQ9O8xOe9QUiOPsG
        TKkAm07vtgHp4DX/V+Gl+VBlp
X-Received: by 2002:a17:906:2350:b0:8a9:e330:3a23 with SMTP id m16-20020a170906235000b008a9e3303a23mr33600701eja.26.1680516175801;
        Mon, 03 Apr 2023 03:02:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350agIn0Z0BbxQrKaHifZIEBKc5yhaJP+oZ1IQ62dW0fNCJWsj/pNyk/lJ7Zxx4QPY7mHa5cEMw==
X-Received: by 2002:a17:906:2350:b0:8a9:e330:3a23 with SMTP id m16-20020a170906235000b008a9e3303a23mr33600677eja.26.1680516175495;
        Mon, 03 Apr 2023 03:02:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m24-20020a17090679d800b00946c1068b14sm4248587ejo.120.2023.04.03.03.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:02:54 -0700 (PDT)
Message-ID: <12a26960-1cc8-80df-e284-d0fa4768f558@redhat.com>
Date:   Mon, 3 Apr 2023 12:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add missing T14s Gen1 type
 to s2idle quirk list
Content-Language: en-US, nl
To:     Benjamin Asbach <asbachb.kernel@impl.it>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <markpearson@lenvo.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230331232447.37204-1-asbachb.kernel@impl.it>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230331232447.37204-1-asbachb.kernel@impl.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/1/23 01:24, Benjamin Asbach wrote:
>> Lenovo laptops that contain NVME SSDs across a variety of generations have
>> trouble resuming from suspend to idle when the IOMMU translation layer is
>> active for the NVME storage device.
>>
>> This generally manifests as a large resume delay or page faults. These
>> delays and page faults occur as a result of a Lenovo BIOS specific SMI
>> that runs during the D3->D0 transition on NVME devices.
> 
> Link: https://lore.kernel.org/all/20220503183420.348-1-mario.limonciello@amd.com/
> 
> As Lenovo distributes T14s Gen1 laptops with different product names
> a missing one is added by this patch.
> 
> Note: Based on lenovo support page there might be some more variants which
> are not represented in s2idle quirk list.

Can you provide some more in info on this? Then Mark can maybe check
if we need to add more models ?

Mark, generally speaking it may help to do a DMI_EXACT_MATCH on
DMI_PRODUCT_VERSION with ThinkPads ? That contains the human
readable model string instead of things like "20UJ", and I guess
that we want to e.g. apply the s2idle quirk to all "T14s Gen1 AMD"
ThinkPads.

> 
> Signed-off-by: Benjamin Asbach <asbachb.kernel@impl.it>
> Tested-by: Benjamin Asbach <asbachb.kernel@impl.it>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans





> 
> Link: https://bbs.archlinux.org/viewtopic.php?pid=2084655#p2084655
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 32c10457399e..57428d7a392d 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -4478,6 +4478,15 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "20UH"),
>  		}
>  	},
> +	{
> +		.ident = "T14s Gen1 AMD",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "20UJ"),
> +		}
> +	},
> +
>  	{
>  		.ident = "P14s Gen1 AMD",
>  		.driver_data = &quirk_s2idle_bug,

