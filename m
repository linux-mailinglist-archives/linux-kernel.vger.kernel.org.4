Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175E473EC56
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjFZVAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:00:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6840125
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:00:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b539d2f969so25224375ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687813230; x=1690405230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2MUcsZ88kPdTbL0Fe0KdqzeRsWZygh3lDlry3EOanc=;
        b=WKpFul2gO3dFDbv8X5ODsWp3Otko64uAHXcUw1f5agmYOJIbyApBjNBk8M0FYxsXod
         r967gu/emFI5KThUGI+gaghbS0KV814KU8kn0+VP2KmT3E4UgxKl+2BfVPauM/z5Gqkx
         Dr7EIvacf86mJvd3fdOV4eFzxxTvgtrMgCvbsL2yFSNx1Y66+jIVOKnKyMU6LRRVzo2y
         CunzIs3lsddHrgqkxSsZp8RolNmlxBWGTQdfkAXrCUMOqnaQ+qYKTsNARwkH8BJTr/Ux
         ICAAIKsfbE/y78MrPRuZx3kbUyns0EOqtk3AE9po1RbYearlQx//l8tXISF7yVhsVP3h
         x90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687813230; x=1690405230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z2MUcsZ88kPdTbL0Fe0KdqzeRsWZygh3lDlry3EOanc=;
        b=B6Hw65DuHf0di9RY3YIzfhacPhk+Lmb4fNogvS3htBnpSeAtWlTxgBTKfgYIa048iB
         f+2iZNMzJemy1ScogZFQZ2rJUwNj5DhiuuHfa1YzbhAlaxy1ErqrGhDSyXaUxmoMWODi
         h/k1cMKoVaLBmc+3rUQrMu2IMRqPrUSevK5bnN/8hmCJ+/GU4hE4XTUCElur9IGq64au
         +jNEciS+36cm0+OUNU0Wkmv+MGwjFrl4AOYtGycBCZNNU7c2x9tP5sqweaMPcodlCKRA
         y4bW/W8UKLbogPkvK2l4AAYC5Z0Ukqzmtwy5+2firMT4Sv4Xndf3jGIHyZd2Xl0QDUcI
         ZMvQ==
X-Gm-Message-State: AC+VfDxvryP5hEGjY+8wAwtm5AhPdKiKL7z/ivNHntAgkJUSopGmuw2j
        gUa8w5dbJwkGKnFTrPSPwP253D3om0qD2w==
X-Google-Smtp-Source: ACHHUZ7ynH/Mknjuodq+G3WqxMIh2eJPjqltj6jNnWLWcHavwor+eI/ZGGIwt14ifOWmY+ZOuCHBcg==
X-Received: by 2002:a17:903:1245:b0:1af:e302:123 with SMTP id u5-20020a170903124500b001afe3020123mr11955222plh.3.1687813229782;
        Mon, 26 Jun 2023 14:00:29 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c10300b0019aaab3f9d7sm4607903pli.113.2023.06.26.14.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 14:00:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jun 2023 11:00:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net,
        zwp10758@gmail.com
Subject: Re: [PATCH v3] workqueue: add cmdline parameter
 `workqueue_unbound_cpus` to further constrain wq_unbound_cpumask at boot
 time
Message-ID: <ZJn8bQd6EdHolayS@slm.duckdns.org>
References: <20230623073033.GA6584@didi-ThinkCentre-M930t-N000>
 <20230625031502.GA22708@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625031502.GA22708@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Jun 25, 2023 at 11:15:02AM +0800, tiozhang wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a465d5242774..7f2fe8c60d5c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6780,6 +6780,14 @@
>  			disables both lockup detectors. Default is 10
>  			seconds.
>  
> +	workqueue_unbound_cpus=

Please use workqueue.unbound_cpus for consistency.

> +			[KNL,SMP]
> +			Format: <cpu-list>
> +			Specify to constrain one or some CPUs to use in
> +			unbound workqueues.
> +			By default, all online CPUs are available for
> +			unbound workqueues.

and flow the paragraph.

>  	workqueue.watchdog_thresh=
>  			If CONFIG_WQ_WATCHDOG is configured, workqueue can
>  			warn stall conditions and dump internal state to
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 7cd5f5e7e0a1..c247725b0873 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -329,6 +329,9 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
>  /* PL: allowable cpus for unbound wqs and work items */
>  static cpumask_var_t wq_unbound_cpumask;
>  
> +/* for further constrain wq_unbound_cpumask by cmdline parameter*/
> +static cpumask_var_t wq_cmdline_cpumask;
> +
>  /* CPU where unbound work was last round robin scheduled from this CPU */
>  static DEFINE_PER_CPU(int, wq_rr_cpu_last);
>  
> @@ -6006,6 +6009,10 @@ void __init workqueue_init_early(void)
>  	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
>  	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
>  
> +	if (!cpumask_empty(wq_cmdline_cpumask))
> +		cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, wq_cmdline_cpumask);
> +	free_bootmem_cpumask_var(wq_cmdline_cpumask);

If workqueue_unbound_cpus_setup() wasn't called during boot because the
parameter wasn't set, the above would end up trying to access and fre
wq_cmdline_cpumask which hasn't been allocated. Let's just use statically
allocated __initdata struct cpumask so that we don't have to worry about
allocation and freeing during early boot.

> +static int __init workqueue_unbound_cpus_setup(char *str)
> +{
> +	cpumask_var_t cpumask;
> +
> +	alloc_bootmem_cpumask_var(&wq_cmdline_cpumask);
> +	alloc_bootmem_cpumask_var(&cpumask);
> +	if (cpulist_parse(str, cpumask) < 0)
> +		pr_warn("workqueue_unbound_cpus: incorrect CPU range\n");
> +	else
> +		cpumask_copy(wq_cmdline_cpumask, cpumask);

You can just parse direclty into wq_cmdline_cpumask and then clear it on
error.

Thanks.

-- 
tejun
