Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBD6B810C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjCMSrX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 14:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCMSrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:47:12 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B85A1FE8;
        Mon, 13 Mar 2023 11:46:40 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id ek18so21499741edb.6;
        Mon, 13 Mar 2023 11:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678733146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUfs2k47yRWM3aIik3Zq+XHDi6CmZG0zXGMfcz75sWk=;
        b=uiBxQGHfQ1rREEtzcVsCYCkC0UlQWmLGp7CwmLYW/Kck+1HNKQtGRBF8CJywjn9b4j
         ylB64dsEeQJ5dGrMp1eskMTc+uZb/Ix8aLSOU5/1IEhlxQJCvPuhnUT7Lt+NoCi1l3Pa
         Xo9iI8IBjz6diPiGIeIiHr1j40wmc57vBklGufGtUY0GMjx8k9ESiPNOYy7IDjC1yQCC
         CUanhY+ARNeQzcvbzYnTH2RXuNjyyQX5l2ZC/qLLSWTxVSqsDy9oK+hqeO9hR//o1o8w
         zR7KAqr2dU0F8DURySaWfO8KXkZJ+rlglHgpBKtuTqutHIFxPLocFwU7scao4Wcb+rrr
         /4JA==
X-Gm-Message-State: AO0yUKUjGhSonFuUB/wf7779syXmnsLtics5pdixwavNnWRwmX1JV0QV
        I96hDom70Ro4BCQ5VhgpsxdoQOXUiM5XWp1zufTMuy/w
X-Google-Smtp-Source: AK7set9Pp4y5qZydk6rfFBK64FJzPD/08E/X1kJ9euGcRh0PI/wnXy3wsLoSlDBZ9wJtVrqYS//hkScDQZ31F7TF4GY=
X-Received: by 2002:a50:d59a:0:b0:4fb:f19:881 with SMTP id v26-20020a50d59a000000b004fb0f190881mr3584874edi.3.1678733145842;
 Mon, 13 Mar 2023 11:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org> <20230313182918.1312597-3-gregkh@linuxfoundation.org>
In-Reply-To: <20230313182918.1312597-3-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Mar 2023 19:45:34 +0100
Message-ID: <CAJZ5v0iaR7mqdKqCL-WH+GXa=pxnV+r_tta+UqX1aVgEysYu9Q@mail.gmail.com>
Subject: Re: [PATCH 03/36] cpufreq: move to use bus_get_dev_root()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 7:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.
>
>  drivers/cpufreq/cpufreq.c      | 7 ++++++-
>  drivers/cpufreq/intel_pstate.c | 7 +++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6d8fd3b8dcb5..6ad3119b8e15 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2932,11 +2932,16 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
>  static int __init cpufreq_core_init(void)
>  {
>         struct cpufreq_governor *gov = cpufreq_default_governor();
> +       struct device *dev_root;
>
>         if (cpufreq_disabled())
>                 return -ENODEV;
>
> -       cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
> +       dev_root = bus_get_dev_root(&cpu_subsys);
> +       if (dev_root) {
> +               cpufreq_global_kobject = kobject_create_and_add("cpufreq", &dev_root->kobj);
> +               put_device(dev_root);
> +       }
>         BUG_ON(!cpufreq_global_kobject);
>
>         if (!strlen(default_governor))
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 48a4613cef1e..102cf7f0ac63 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1473,10 +1473,13 @@ static struct kobject *intel_pstate_kobject;
>
>  static void __init intel_pstate_sysfs_expose_params(void)
>  {
> +       struct device *dev_root = bus_get_dev_root(&cpu_subsys);
>         int rc;
>
> -       intel_pstate_kobject = kobject_create_and_add("intel_pstate",
> -                                               &cpu_subsys.dev_root->kobj);
> +       if (dev_root) {
> +               intel_pstate_kobject = kobject_create_and_add("intel_pstate", &dev_root->kobj);
> +               put_device(dev_root);
> +       }
>         if (WARN_ON(!intel_pstate_kobject))
>                 return;
>
> --
> 2.39.2
>
