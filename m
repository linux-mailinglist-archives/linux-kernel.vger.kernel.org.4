Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96935F2FD9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJCLxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJCLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A933ED4B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664797971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nr6+vnW8DvOFip9yfzTRKftATIpSoYVhrZMNiUm1YqI=;
        b=fzm7QFXA907ki/Qk0Be6Gf3VVUGIInDTSyT2FFTAzxiHBx+THynO0e+gYN9qfgkI6O2vg5
        ITRupv9dpiwCiCyMz6sylQtA379EYRPKq/Bmw+scPu7atekQl5V/C59gSVmhmji5tyJOnq
        iUcjaEPtuqJP33UXrUXOPtz6XL/46K4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-ZYshAPxkOgqfDN4Y8hFpUA-1; Mon, 03 Oct 2022 07:52:48 -0400
X-MC-Unique: ZYshAPxkOgqfDN4Y8hFpUA-1
Received: by mail-ed1-f70.google.com with SMTP id r11-20020a05640251cb00b004516feb8c09so8602815edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 04:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Nr6+vnW8DvOFip9yfzTRKftATIpSoYVhrZMNiUm1YqI=;
        b=uxedhSj8R2mXQ4/ysR8c8norDcS0b5yk2JywGzcauxuBhsPdI5eFkwr14dQnkFk7y2
         yEYgzZ4uQEblQsUpqAdEJu7eCJ6DjLSPlPQnkYm4LgyvV2gCacpJ8sl9FNIryfflqA3+
         Ls8aIoHDkRmN/RH27M8hgGuDM0H8meAQ3KSWNrcUebfK0CayFmECWDEPxSWQYllQxcbf
         tjEi+oNK2iejRUpWu8Gez7TIF9lZXaD1zsT2qVX9YMVDfopliJVt9SDQT5KnPESbYFx1
         HhberJPJb23tYPPJYA+B8n7lxz3lIWOvcK2CbY1rl8n6NZCwSOuYHStqG5kRGnL9DyiR
         tZqw==
X-Gm-Message-State: ACrzQf1r/AXINAe9xNOpLcTPMoUvsxvc8LDv3urmrCrCZVBkUqs6dSRw
        Nwno9bEK/hBPkMlr/kyv5M1c80Evttgi9Dm+dtrEVcrpLGHZWg15r1SDXalFiIRaH11GmHADK6B
        RNCOPYuuXowJe93Z180ui7TPu
X-Received: by 2002:a17:907:271b:b0:789:fbc5:c4aa with SMTP id w27-20020a170907271b00b00789fbc5c4aamr6315160ejk.443.1664797967274;
        Mon, 03 Oct 2022 04:52:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6hNEZuGzto1WGGrP0h9867sUWNMdIwEq6zQeCMRdNZYdzgF1VcwF2VNhtVjTlmyrtK6C1m6Q==
X-Received: by 2002:a17:907:271b:b0:789:fbc5:c4aa with SMTP id w27-20020a170907271b00b00789fbc5c4aamr6315145ejk.443.1664797967093;
        Mon, 03 Oct 2022 04:52:47 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ek12-20020a056402370c00b004587f9d3ce8sm6817071edb.56.2022.10.03.04.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 04:52:46 -0700 (PDT)
Message-ID: <e6fe6c86-134d-e27b-2153-5ce81d26f19c@redhat.com>
Date:   Mon, 3 Oct 2022 13:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] platform/x86/amd: pmc: Dump idle mask during "check"
 stage instead
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220929215042.745-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220929215042.745-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/22 23:50, Mario Limonciello wrote:
> The idle mask is dumped during the "prepare" and "restore" stage
> right now, which helps to demonstrate issues only related to the
> first s2idle entry.
> 
> If the system has entered s2idle once, but was woken up never
> breaking the s2idle loop but also never went back to sleep we
> might still have another issue to deal with however.
> 
> Move the dynamic debugging message here so that we'll catch it on
> each iteration.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216516
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

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
>  drivers/platform/x86/amd/pmc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
> index 047e47449ff93..ce859b300712b 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -719,8 +719,6 @@ static void amd_pmc_s2idle_prepare(void)
>  		}
>  	}
>  
> -	/* Dump the IdleMask before we send hint to SMU */
> -	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
>  	msg = amd_pmc_get_os_hint(pdev);
>  	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
>  	if (rc) {
> @@ -738,6 +736,9 @@ static void amd_pmc_s2idle_check(void)
>  	struct amd_pmc_dev *pdev = &pmc;
>  	int rc;
>  
> +	/* Dump the IdleMask before we add to the STB */
> +	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
> +
>  	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_CHECK);
>  	if (rc)
>  		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
> @@ -757,9 +758,6 @@ static void amd_pmc_s2idle_restore(void)
>  	/* Let SMU know that we are looking for stats */
>  	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
>  
> -	/* Dump the IdleMask to see the blockers */
> -	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
> -
>  	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_RESTORE);
>  	if (rc)
>  		dev_err(pdev->dev, "error writing to STB: %d\n", rc);

