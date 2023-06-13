Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83072DF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbjFMKd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbjFMKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AF41BC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686652235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtFniqYVRWMEpsXPIuYLeHJpQKDGK9zBkiTPOmVhdUk=;
        b=APrBjujysAtrSAbT3Yz4w3f/21oTv8rYdtnOkc3huxqX2Zu35NWxpYvm2NfjyDgYK6IqEH
        Rre6OEBMbz0or2+gzki/pqX7sBAW3B1r6xx5g4rdmYDtJgX8qYo0o1qyGwXwYYnO5rydOM
        HbHJNUYWN+crzEc82SkK7Kan5lhlHRY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-iW8VodnaP8qAuglH6jZXdw-1; Tue, 13 Jun 2023 06:30:34 -0400
X-MC-Unique: iW8VodnaP8qAuglH6jZXdw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5187a7016edso179284a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686652233; x=1689244233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtFniqYVRWMEpsXPIuYLeHJpQKDGK9zBkiTPOmVhdUk=;
        b=FKitr/pTUu+rugMNQbsj0llY6de/hFnSXc8XjJl5xnbL4EGT+txqCJpQX0NU1kWlX8
         hNySy2FobyF0DHY3Y7jjindv+q0CH+6/fXbCHC/0YBE5fJOyN+2SyAR+QP0BnQqrzt70
         7DMFUcsHXpMb6ObI5N0jt472W+xSTblkhskp+MvGr6MVnAjwmxV54ViryT9kzni03k3J
         Hs/TruDjiUDxot9SIdhEkFfHovjuIy7i/i5vaG7l3Vs/crM/+UIqnvFZ9sB9GBEppRnT
         O6IVU4KJFUim7w9trx6416oPaZx393n1FPokKOV7MpXEGWyM5VhulqFSRInjKILd103t
         NENQ==
X-Gm-Message-State: AC+VfDyikAq480vowBEIvnqgKyGOI0j2bFpp7orhb0zjLfU9whM3/8wp
        2Q1IQYeSANpUrlViJfj3EgqnKOHsYaLmabzPYvtqSz2Y9lfMI4STzmbVRI7Ua1gLSlkuT6Bq+yX
        50NHDGIzefVXVaGAxQK6y9c8J
X-Received: by 2002:a05:6402:2043:b0:514:9e1b:d21c with SMTP id bc3-20020a056402204300b005149e1bd21cmr7463885edb.31.1686652233228;
        Tue, 13 Jun 2023 03:30:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/Y29S9aQjMs+gtG+knj6OgXfbVfIXs9gcirih+Hhf3RdhlmvbR9BrKu3D/GlIZawOA/+nVg==
X-Received: by 2002:a05:6402:2043:b0:514:9e1b:d21c with SMTP id bc3-20020a056402204300b005149e1bd21cmr7463872edb.31.1686652232901;
        Tue, 13 Jun 2023 03:30:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c9d0000000b0050d83a39e6fsm6269779edt.4.2023.06.13.03.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 03:30:32 -0700 (PDT)
Message-ID: <934466a0-f519-cd43-7af8-bc744cc746b4@redhat.com>
Date:   Tue, 13 Jun 2023 12:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 1/2] platform/x86/intel/pmc: Add resume callback
Content-Language: en-US, nl
To:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     markgross@kernel.org, irenic.rajneesh@gmail.com,
        ilpo.jarvinen@linux.intel.com, xi.pardee@intel.com,
        rajvi.jingar@linux.intel.com
References: <20230607233849.239047-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230607233849.239047-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/8/23 01:38, David E. Box wrote:
> Add a resume callback to perform platform specific functions during resume
> from suspend.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 
> V2 - Change resume_fixup to just resume and use it a a replacement for
>      the regular resume flow (now called pmc_core_resume_common) if it
>      exist. Suggested by Ilpo.


Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans





>  drivers/platform/x86/intel/pmc/core.c | 14 ++++++++++++--
>  drivers/platform/x86/intel/pmc/core.h |  3 +++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index da6e7206d38b..bb2f11251f73 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1223,11 +1223,11 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
>  	return false;
>  }
>  
> -static __maybe_unused int pmc_core_resume(struct device *dev)
> +int pmc_core_resume_common(struct pmc_dev *pmcdev)
>  {
> -	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>  	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
>  	int offset = pmcdev->map->lpm_status_offset;
> +	struct device *dev = &pmcdev->pdev->dev;
>  
>  	/* Check if the syspend used S0ix */
>  	if (pm_suspend_via_firmware())
> @@ -1257,6 +1257,16 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static __maybe_unused int pmc_core_resume(struct device *dev)
> +{
> +	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> +
> +	if (pmcdev->resume)
> +		return pmcdev->resume(pmcdev);
> +
> +	return pmc_core_resume_common(pmcdev);
> +}
> +
>  static const struct dev_pm_ops pmc_core_pm_ops = {
>  	SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
>  };
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 9ca9b9746719..7c95586e742b 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -327,6 +327,7 @@ struct pmc_reg_map {
>   * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
>   * @lpm_req_regs:	List of substate requirements
>   * @core_configure:	Function pointer to configure the platform
> + * @resume:		Function to perform platform specific resume
>   *
>   * pmc_dev contains info about power management controller device.
>   */
> @@ -345,6 +346,7 @@ struct pmc_dev {
>  	int lpm_en_modes[LPM_MAX_NUM_MODES];
>  	u32 *lpm_req_regs;
>  	void (*core_configure)(struct pmc_dev *pmcdev);
> +	int (*resume)(struct pmc_dev *pmcdev);
>  };
>  
>  extern const struct pmc_bit_map msr_map[];
> @@ -398,6 +400,7 @@ extern const struct pmc_reg_map mtl_reg_map;
>  extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
>  extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
>  
> +int pmc_core_resume_common(struct pmc_dev *pmcdev);
>  void spt_core_init(struct pmc_dev *pmcdev);
>  void cnp_core_init(struct pmc_dev *pmcdev);
>  void icl_core_init(struct pmc_dev *pmcdev);
> 
> base-commit: 86f67fe2db439867f9476c9b78ea3ebd4a06a123

