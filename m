Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D8D658E39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiL2PHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiL2PHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:07:07 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2516913DE1;
        Thu, 29 Dec 2022 07:06:50 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so11259176pjk.3;
        Thu, 29 Dec 2022 07:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTJkG9x3God2II1jVKdydXSgUoyIekASVKY7SpXt4ug=;
        b=iwLZ9Hd+92HKnxIqbDZlYTHzJK9e4yF0Ru3n2gF2xtzewo2vjQFWMFphFkWRslYQU9
         hK1fJ9H0V9jH1PwmOhUgeq7YBIH/seXxFQEH/6wOX3KS2qmWxYVU/7a3rzOCaHhz+KB8
         QuEaBPR0P9zdlg9tCwXH+rtI9mD299w2dD0DL84AcY2eipAwAD3KeSxZsXZk6kkwSJLI
         2Ai3DsGyDIOMbPH297UEvtnraW9PJA5Z1bbJV8xV97nIcfz3SDixNMr4mSj+JhjtD4h9
         pkaPZ1DmVGIYdoD+Gq6WuwsqnsYCdf2J51ke7+5LahQXIDq97y1fwBQGBv7xo4PzvIIo
         gQHQ==
X-Gm-Message-State: AFqh2kphKAVTMYwv+iYS1/GHb528KBkbRYxiw6jl/s3ddf1ccn4Ec12Y
        lEf+pcd3h/MpYKOzZglBpP0=
X-Google-Smtp-Source: AMrXdXsiCcxYJCXw8juZUfTXSvDXwzqQz39j+sP+02zeB0gRxX6A0NB2XEDoeFz1tBYQh/LCzztvag==
X-Received: by 2002:a17:90a:1b2d:b0:225:c9d4:9cd9 with SMTP id q42-20020a17090a1b2d00b00225c9d49cd9mr22266039pjq.32.1672326401876;
        Thu, 29 Dec 2022 07:06:41 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h19-20020a17090adb9300b0021806f631ccsm11471537pjv.30.2022.12.29.07.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 07:06:40 -0800 (PST)
Message-ID: <82272e6d-e175-ad46-e66b-7eb5e51964c3@acm.org>
Date:   Thu, 29 Dec 2022 07:06:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] scsi: ufs: core: Add hibernation callbacks
Content-Language: en-US
To:     Anjana Hari <quic_ahari@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        konrad.dybcio@linaro.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_narepall@quicinc.com,
        quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com
References: <20221221171222.19699-1-quic_ahari@quicinc.com>
 <20221221171222.19699-2-quic_ahari@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221221171222.19699-2-quic_ahari@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/22 09:12, Anjana Hari wrote:
> Add hibernation call backs - freeze, restore and thaw.
> Add the respective prototypes.
> 
> Signed-off-by: Anjana Hari <quic_ahari@quicinc.com>
> ---
>   drivers/ufs/core/ufshcd.c | 80 +++++++++++++++++++++++++++++++++++++++
>   include/ufs/ufshcd.h      |  6 +++
>   2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index bda61be5f035..c216a97dc1dd 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -9453,6 +9453,25 @@ static int ufshcd_resume(struct ufs_hba *hba)
>   
>   	/* enable the host irq as host controller would be active soon */
>   	ufshcd_enable_irq(hba);
> +
> +	if (hba->restore) {
> +		/* Configure UTRL and UTMRL base address registers */
> +		ufshcd_writel(hba, lower_32_bits(hba->utrdl_dma_addr),
> +			      REG_UTP_TRANSFER_REQ_LIST_BASE_L);
> +		ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
> +			      REG_UTP_TRANSFER_REQ_LIST_BASE_H);
> +		ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
> +			      REG_UTP_TASK_REQ_LIST_BASE_L);
> +		ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
> +			      REG_UTP_TASK_REQ_LIST_BASE_H);
> +		/* Commit the registers */
> +		mb();
> +	}

The comment above the mb() call is wrong. No matter the type of a 
barrier, a barrier controls the order in which load, store and/or MMIO 
operations happen. A barrier does not "commit" register writes.

The comment above mb() should explain which load, store and/or MMIO 
accesses are ordered and also why the ordering is necessary.

> +	/*
> +	 * Ensure no runtime PM operations take
> +	 * place in the hibernation and restore sequence
> +	 * on successful freeze operation.
> +	 */
> +	if (!ret)
> +		pm_runtime_disable(hba->dev);

I think the power management core already serializes system-wide power 
management state transitions and runtime power management and hence that 
the above code can be left out.

> +	/*
> +	 * Now any runtime PM operations can be
> +	 * allowed on successful restore operation
> +	 */
> +	if (!ret)
> +		pm_runtime_enable(hba->dev);

Same comment for the above code.

> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_system_restore);
> +
> +int ufshcd_system_thaw(struct device *dev)
> +{
> +
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = ufshcd_system_resume(dev);
> +	if (!ret)
> +		pm_runtime_enable(hba->dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_system_thaw);

Also here, please remove the code related to runtime power management.

> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 5cf81dff60aa..dadb3c732be4 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -978,6 +978,9 @@ struct ufs_hba {
>   #endif
>   	u32 luns_avail;
>   	bool complete_put;
> +
> +	/* Distinguish between resume and restore */
> +	bool restore;
>   };

Please convert this member variable into a function argument. This 
probably will require adding an argument to existing functions.

Thanks,

Bart.

