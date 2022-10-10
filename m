Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68095F9803
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiJJGAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJJGAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:00:38 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB6E22527
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:00:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 129so9506375pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 23:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oDcZ6XrkCz+D/dAyJUEiNRSpCMVbOwinoaCkgsqNcx0=;
        b=nXFCmfgMVA28LXsKRlEZ41pj7NLm8J6VAnx4xLauh8ci6+981nde+uyN2txiKsRv4A
         DAsHJx7XCh3p4aKF1fc7TICgMGRb25RlvXYB63I1RtUf22UYRuuqa/NVmUoi0LZbBbFc
         2fmlnZz1z7b+/BvB5riLJT234wJc0PidEajIatYK3DfcaZt/wh3evp5JwFIWdpphUHAD
         SHNpX65imo1p880UgZRabtsqwcVKxxru2J/v/Tu6UKO+A9NjMjY0tLDzdd+9f+rrX8nY
         ymeyeKGZE1mK9HRVU/L2l7ErlqmdlGWkKUc9IITfebzSJF2Iil5iVTzDeGlLWnEEBVVD
         MPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDcZ6XrkCz+D/dAyJUEiNRSpCMVbOwinoaCkgsqNcx0=;
        b=sEydb90SPmQhKEHwNg9fxXqLfj6CF4CMl6U3plnWQPBBga6mbRQeRqc8BwpTACF/UY
         IVwjG1iYSv8uyCEbW7D5T0iMknH19Xu/437w6RXq2KU5fjXWBwsz61k1zGd8SLSwS5jf
         RBSmeCTWG99i7bQBDeIBa1G7fvPJskLp22NUOgFv1IgGNpg/s3ntZgEOWqi3hCDMHbYP
         QfUfHLBpluX5YWy+z4MHn+DzbGXZj/iiwee3QiQZOv96xbXQZoUagls9CR/heTG7ppKU
         l9HPwHNJTK2Ot5lWyqunZ85R4nM7jLNneswfd0AgMpNvL270u3xLSfjIcUTDgsWqcoRr
         K+lw==
X-Gm-Message-State: ACrzQf0z39b/jVjodo2tqI1oawNkrFGd7lbiKiYRbxIU/qms55pfgIhW
        t6WaFlELpPK9mdorYcKdU1BojA==
X-Google-Smtp-Source: AMsMyM5mc4TuX/P+ibYfEZi+dk0sWiJ7gO3mGpLYfFjFzqZ8cfa0qHdIF4N+nC8mLQXsr3LlAkU8fA==
X-Received: by 2002:a63:e74d:0:b0:440:6c50:eab7 with SMTP id j13-20020a63e74d000000b004406c50eab7mr14924503pgk.308.1665381636665;
        Sun, 09 Oct 2022 23:00:36 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090a6c9600b0020ad46d277bsm8375405pjj.42.2022.10.09.23.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 23:00:36 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:30:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Fabien Parent <fabien.parent@linaro.org>
Cc:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cpufreq: qcom: fix writes in read-only memory region
Message-ID: <20221010060034.wgs7w4onkadoseeb@vireshk-i7>
References: <20221001171027.2101923-1-fabien.parent@linaro.org>
 <20221001171027.2101923-3-fabien.parent@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001171027.2101923-3-fabien.parent@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-10-22, 19:10, Fabien Parent wrote:
> This commit fixes a kernel oops because of a write in some read-only memory:
> 
> 	[    9.068287] Unable to handle kernel write to read-only memory at virtual address ffff800009240ad8
> 	..snip..
> 	[    9.138790] Internal error: Oops: 9600004f [#1] PREEMPT SMP
> 	..snip..
> 	[    9.269161] Call trace:
> 	[    9.276271]  __memcpy+0x5c/0x230
> 	[    9.278531]  snprintf+0x58/0x80
> 	[    9.282002]  qcom_cpufreq_msm8939_name_version+0xb4/0x190
> 	[    9.284869]  qcom_cpufreq_probe+0xc8/0x39c
> 	..snip..
> 
> The following line defines a pointer that point to a char buffer stored
> in read-only memory:
> 
> 	char *pvs_name = PVS_NAME;
> 
> This pointer is meant to hold a template "speedXX-pvsXX-vXX" where the
> XX values get overridden by the qcom_cpufreq_krait_name_version function. Since
> the template is actually stored in read-only memory, when the function
> executes the following call we get an oops:
> 
> 	snprintf(*pvs_name, sizeof(PVS_NAME), "speed%d-pvs%d-v%d",
> 		 speed, pvs, pvs_ver);
> 
> To fix this issue, we instead store the template name onto the stack by
> using the following syntax:
> 
> 	char pvs_name_buffer[] = PVS_NAME;
> 
> Because the `pvs_name` needs to be able to be assigned to NULL, the
> template buffer is stored in the pvs_name_template and not under the
> pvs_name variable.
> 
> Signed-off-by: Fabien Parent <fabien.parent@linaro.org>

No Fixes or Cc:Stable for this ? This looks like a bug fix and this
should be sent before patch 2/3 so it can be back ported properly.

> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 64ce077a4848..3e097262f612 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -269,7 +269,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
> -	char *pvs_name = PVS_NAME_TEMPLATE;
> +	char pvs_name_buffer[] = PVS_NAME_TEMPLATE;
> +	char *pvs_name = pvs_name_buffer;
>  	unsigned cpu;
>  	const struct of_device_id *match;
>  	int ret;
> -- 
> 2.37.2

-- 
viresh
