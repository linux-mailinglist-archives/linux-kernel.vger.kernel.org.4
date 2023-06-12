Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E6172B95C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjFLH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjFLH5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:57:00 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B63AA5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:56:14 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-56cf32f5bf8so20103477b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686556573; x=1689148573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM8cSNzatRt7iVDLhS9loK+hrwWt39XACb17rH3wM/U=;
        b=Cl4Wr3MRDQNbLJcJ0IAA3/fTrIaRij5is+0VBx2HXILQz2M6OYkKwmhvbWnhACuThb
         lgrjoqXJvTsJZhQl/2cbHcnRTDN/FRDK2voedmtAWxqqTntRxvWa/aB1y0pc3lmytOFP
         Oqm6dbmCf9hqNsGUJiU1X/SMDc+yg6vquIvyZLmTdo/OE4IEwoOXxDzjabsQ+6mjvN/9
         +Qc89QdqvDMR9r9IQCp3ZtUVkCMiTpP8vnjpewPABiDp8nmqtiZvo+n1a9Nd8lKb/TQX
         NL4D2ljBqDPNV8/edgBS6ZN2ZI8CBpJEgZKHjfpFWgNPanYakCKtSIcfYBTj0Jf9NwQX
         4rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686556573; x=1689148573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM8cSNzatRt7iVDLhS9loK+hrwWt39XACb17rH3wM/U=;
        b=kNdIQONoOBpejq2Fdc41VQxwV/+UYFkgSNWadHZmymdh5Ft+p3M/n66/CAfmNW6Kea
         P0Qtp6wwvi/Ew0nSoKRMD3wAYLpdklwqYfjs+RjcKNKooPaoDzrkbtu94Z4tKiBYInfM
         tizAQnyGNZTMmwdZ2V709z28bmHYuoa2K9YDFGuSreiftXbeFIse8rHkKzQDiGrmfcor
         qZczYxd7b56FeMGQooW9eO5WCBBWMv3e2wZ3IX80GwTFp0eeQPwvn3hwVoJziJXFWiHK
         Oy+OhIav/d7RNGKm8uwVdCYNm9FX4+MVLG1e/S2SdbF9IosGg69QxThEwMKFnhuhJCP6
         nVxQ==
X-Gm-Message-State: AC+VfDy+6AhUlfFXE4i7PViz+tolDweV44LQrHpHHm9YBHi+LeYMZghi
        FEBHllskoH+gjicmieizJoYvIV4MR80Zq6BGusg=
X-Google-Smtp-Source: ACHHUZ6WULGFh7chtEHb1ZkZQmmJTBWrb+YD5bXXWBH3s//Zr0f4h/gIzkRgc7zjKizyLWEJh8ckSg==
X-Received: by 2002:a05:6a20:a20d:b0:10b:d70d:f96b with SMTP id u13-20020a056a20a20d00b0010bd70df96bmr6884057pzk.3.1686554790361;
        Mon, 12 Jun 2023 00:26:30 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78d01000000b0065418efa5ebsm6259308pfe.155.2023.06.12.00.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 00:26:29 -0700 (PDT)
Date:   Mon, 12 Jun 2023 12:56:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Mario.Limonciello@amd.com, Deepak.Sharma@amd.com,
        Wyes.Karny@amd.com, gautham.shenoy@amd.com, Sunpeng.Li@amd.com,
        Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: amd-pstate: Set default governor to schedutil
Message-ID: <20230612072627.5wzmsfp64jho3bdj@vireshk-i7>
References: <20230612030321.3097627-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612030321.3097627-1-perry.yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-23, 23:03, Perry Yuan wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The Kconfig currently defaults the governor to schedutil on x86_64
> only when intel-pstate and SMP have been selected.
> 
> If the kernel is built only with amd-pstate, the default governor
> should also be schedutil.
> 
> Cc: Sun Peng (Leo) Li <sunpeng.li@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Leo Li <sunpeng.li@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Tested-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2c839bd2b051..a1c51abddbc5 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -38,7 +38,7 @@ choice
>  	prompt "Default CPUFreq governor"
>  	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1110_CPUFREQ
>  	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
> +	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if (X86_INTEL_PSTATE || X86_AMD_PSTATE) && SMP
>  	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
>  	help
>  	  This option sets which CPUFreq governor shall be loaded at

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
