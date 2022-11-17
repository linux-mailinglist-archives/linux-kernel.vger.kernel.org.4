Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8270C62DD87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbiKQOGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiKQOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9B159147
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668693956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5G4ZLhF2j04MzQ5GAb0CM4oR5WeLJ1CW66YIXLiHoY=;
        b=PoPEli1PRyyMFJZRa/Ev1bFJMZwjPcuVJ0SL/9a2fcIldv3FeIfKOGl3b+TXOpNfbjRTAR
        le0gfPig3N2repIN/HJkmjIWVSbpFxDNPYwxQn1Xf5CiYZZROKXbvqW/XMy0TKCn03ndvY
        IXYTTxb3MKapZcFc3eVzUT4DioZ4hXg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-156-5ByY2NKnNzifOckmVfGVOg-1; Thu, 17 Nov 2022 09:05:54 -0500
X-MC-Unique: 5ByY2NKnNzifOckmVfGVOg-1
Received: by mail-ej1-f72.google.com with SMTP id sh31-20020a1709076e9f00b007ae32b7eb51so1157110ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5G4ZLhF2j04MzQ5GAb0CM4oR5WeLJ1CW66YIXLiHoY=;
        b=oAH0ISOlvqWFXHQWoVUOWfSQQpT1nS+wPz91VWnGSUHQNP6+YFu7oc1/b+o8b/JamH
         DzBrud3LReEhRdpVGOSl8cABlqxMFgUIfseSghR/y27QsSqhfCM/HrquWUbgSeqzX7Ao
         3LyLHkTqEQ2jG3aTgtxt+DDpl+Li/iOb6DcbofTzxwehgSjKmNkLYvSLDF3hfiHNUvQS
         J2aGsKDL6jt+k60LhHOzHiFAEIMKUvQ9gmETG2jqfBIfT0FSAWGfORRA48W9PeJcipxw
         5SDU8fOSLseidwQqKpuwGODm5AotBkQICG3g2UaZDalxJ9hXLacJa7US6OlFknjwWTBv
         OSTQ==
X-Gm-Message-State: ANoB5pkXJJYsFawRVOvG7FHq1bU/isQ0v25HE/N5Om9YqDKG51y5bNER
        8Xvl6AzMySvmocby/4cgix9EhyB7mwuOc2pYddEOduZXTzSgQUiQt3n+XnK3lQeYk8Uy3H0/v2H
        vYZkuEYaB6ypGVNeA39LlyHML
X-Received: by 2002:a17:906:2352:b0:7ad:a030:487e with SMTP id m18-20020a170906235200b007ada030487emr2309267eja.508.1668693953015;
        Thu, 17 Nov 2022 06:05:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf42t0gUWuTI4ch3d9Nr7j6RpgaKip+YuBhA1CK2l/ih2OuZNbRe1g1U99ZF0P2IntPUDryhlA==
X-Received: by 2002:a17:906:2352:b0:7ad:a030:487e with SMTP id m18-20020a170906235200b007ada030487emr2309256eja.508.1668693952836;
        Thu, 17 Nov 2022 06:05:52 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b0074134543f82sm413507ejf.90.2022.11.17.06.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 06:05:52 -0800 (PST)
Message-ID: <0d9f8f8c-3b45-dd6a-008b-6d9ffe8ccc93@redhat.com>
Date:   Thu, 17 Nov 2022 15:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] platform/x86/amd: pmc: Add a workaround for an s0i3 issue
 on Cezanne
Content-Language: en-US, nl
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>,
        Raul Rangel <rrangel@chromium.org>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221116154341.13382-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221116154341.13382-1-mario.limonciello@amd.com>
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

Hi Mario,

On 11/16/22 16:43, Mario Limonciello wrote:
> Cezanne platforms under the right circumstances have a synchronization
> problem where attempting to enter s2idle may fail if the x86 cores are
> put into HLT before hardware resume from the previous attempt has
> completed.
> 
> To avoid this issue add a 10-20ms delay before entering s2idle another
> time. This workaround will only be applied on interrupts that wake the
> hardware but don't break the s2idle loop.
> 
> Cc: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>
> Cc: "Raul Rangel" <rrangel@chromium.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Please let me know if it important to get this as a fix into 6.1,
I wasn't really planning on doing any more fixes pull-reqs for 6.1,
but I can do one if necessary.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/amd/pmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
> index ef4ae977b8e0..439d282aafd1 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -739,8 +739,14 @@ static void amd_pmc_s2idle_prepare(void)
>  static void amd_pmc_s2idle_check(void)
>  {
>  	struct amd_pmc_dev *pdev = &pmc;
> +	struct smu_metrics table;
>  	int rc;
>  
> +	/* CZN: Ensure that future s0i3 entry attempts at least 10ms passed */
> +	if (pdev->cpu_id == AMD_CPU_ID_CZN && !get_metrics_table(pdev, &table) &&
> +	    table.s0i3_last_entry_status)
> +		usleep_range(10000, 20000);
> +
>  	/* Dump the IdleMask before we add to the STB */
>  	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
>  

