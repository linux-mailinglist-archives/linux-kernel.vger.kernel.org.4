Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C613667EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbjALTRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbjALTQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB005833D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673550307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9oBega5Sph1st/mXi3WO8B1H9BUTQ8Ui3g3n+U1VVY=;
        b=hBkhpQJDrlYm9Gi55jE3Y6bSULTCFzLU54MBYOtldczOppUoNakT1bxXexjhAorcQ7zphM
        AdsxwV5chFlIXhjljrgQCr2TJDiJRGYRtZPDN9MX3nxf0aSmsY+NEZ+Jnw5SkuEnl/2jMG
        lmrkzXw8aSRtqfj3314zGDh159BSkUM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-MjAVTSArNcexNyVQ78SXOQ-1; Thu, 12 Jan 2023 14:05:05 -0500
X-MC-Unique: MjAVTSArNcexNyVQ78SXOQ-1
Received: by mail-ej1-f69.google.com with SMTP id qb2-20020a1709077e8200b00842b790008fso13531450ejc.21
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9oBega5Sph1st/mXi3WO8B1H9BUTQ8Ui3g3n+U1VVY=;
        b=D7+eQuTPoJOxnUQHOH4xRREGq3NlC+9hFaIg2whVw64pUXoU+fudZNHIP9P0aP9uXu
         UKeRb7ozhV3BcFk8IagyJ7VNPOzSyAqrp56g9/5pSoz40CiP6kz7BhSd1VaFA+Q/8JMc
         ExkvPEXa8bfHcn9IIfLKQf/Sm+jyF+ErNaHC+dLSO/UfnNN4vLEnkCmDFF+lGSA+agfp
         CAwAFzYKeq+QrDY8HpW5GmZDyPc2A+L6A53bPSSYuLpuyJc+KiGGri84GOJmmNJAlP//
         CIeoOuq0bpwMMCvpePvZDc3FAxjtEzYc75U5EV3nYQEMXftn+yrJtIB6A+MMT4ZKTlM/
         Nd3A==
X-Gm-Message-State: AFqh2ko3e58Feiuv3f0bqWuAo8T7Gu1stwoUofObJ9b8N3qWwHQm+6pf
        5KehiNo78jxC15aHeu3s2WvRcY3Ht9KIuQMbjWGTtKhWGnp7IBCJ43uT/CRUOAuLl1zIIq1Dzu3
        h1bo3VjlkU3FAdXw4gdypFTBo
X-Received: by 2002:a17:907:a802:b0:84d:430a:5e5c with SMTP id vo2-20020a170907a80200b0084d430a5e5cmr18298875ejc.32.1673550304605;
        Thu, 12 Jan 2023 11:05:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXulu9RP740rsg0+nbBN9s2zM92cTC0wGiIRVMtxxayqDWIEPBPLkKHUBX5ueeGSu7SPvXC1ng==
X-Received: by 2002:a17:907:a802:b0:84d:430a:5e5c with SMTP id vo2-20020a170907a80200b0084d430a5e5cmr18298858ejc.32.1673550304428;
        Thu, 12 Jan 2023 11:05:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090653c500b007ae32daf4b9sm7752623ejo.106.2023.01.12.11.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 11:05:03 -0800 (PST)
Message-ID: <c4842482-7be0-0042-b476-0f21125c79c2@redhat.com>
Date:   Thu, 12 Jan 2023 20:05:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] platform/x86/amd: Fix refcount leak in amd_pmc_probe
Content-Language: en-US, nl
To:     Miaoqian Lin <linmq006@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Gross <markgross@kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221229072534.1381432-1-linmq006@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221229072534.1381432-1-linmq006@gmail.com>
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

On 12/29/22 08:25, Miaoqian Lin wrote:
> pci_get_domain_bus_and_slot() takes reference, the caller should release
> the reference by calling pci_dev_put() after use. Call pci_dev_put() in
> the error path to fix this.
> 
> Fixes: 3d7d407dfb05 ("platform/x86: amd-pmc: Add support for AMD Spill to DRAM STB feature")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans


> ---
>  drivers/platform/x86/amd/pmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
> index 439d282aafd1..8d924986381b 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -932,7 +932,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
>  	if (enable_stb && (dev->cpu_id == AMD_CPU_ID_YC || dev->cpu_id == AMD_CPU_ID_CB)) {
>  		err = amd_pmc_s2d_init(dev);
>  		if (err)
> -			return err;
> +			goto err_pci_dev_put;
>  	}
>  
>  	platform_set_drvdata(pdev, dev);

