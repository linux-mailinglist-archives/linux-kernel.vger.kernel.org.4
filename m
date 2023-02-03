Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206CB689AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjBCN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjBCN52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:57:28 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE558A2A76;
        Fri,  3 Feb 2023 05:54:49 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id gr7so15513160ejb.5;
        Fri, 03 Feb 2023 05:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OemsrAqP9x0H9P+t2x9gMccQSvNjPhA2hT8xJ8/gamY=;
        b=5+eWaA4Xidpr6geqixRPAxVZantVbMncdneumkSjz5Ag1IF14LF09QUceWh7NWtKlM
         LQY8a0mCm1EcUyh3jKvoh3clQ3mP0+8bPMo5iK9Cwo8Xd9pQ5BFHrOmL1CMomIO50dMG
         eAOpZ0Ojv6fbZE85laFyBcx+ZAqlXvjsyTo8egGsRZPCv4cSYwx812kqoFUmEWeHAjbc
         NwvmMZYAIMx2vZ8LVltSasJRiEhc5qkvyZ8B+Ht2qPQQHNcFhPicnR7bvXZ68zmAZjKm
         4CnWSbX9te/U2cH/2fBRUG6rmEUAeBIplYV9uwG3gyfuMpV/7RzxugdbSDjv8ugKNv47
         9dug==
X-Gm-Message-State: AO0yUKVF4xp65P7Mk/QIg14E4CqkTUsFSCcUPmMnaYCgNbDUHW3+OYnf
        kfVGcVYl3PA3F0/7qqlxiEgxcAQeU88utUVHlkZD8mOZ
X-Google-Smtp-Source: AK7set873Gbdt3HNkt0rgib8UrCFsds7W4lAbSmGQCoKc2oXUwf7ube+rnmt02kuwORIk+46f2Ckm52gpSGNG/uV+eE=
X-Received: by 2002:a17:906:9bd4:b0:87f:575a:9b67 with SMTP id
 de20-20020a1709069bd400b0087f575a9b67mr3244674ejc.274.1675432382946; Fri, 03
 Feb 2023 05:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20230203123516.2501755-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230203123516.2501755-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Feb 2023 14:52:50 +0100
Message-ID: <CAJZ5v0gYvjT_=TADaFBHkYP7LGKE-SZVMYFFnCAj539JeJ3G5A@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel_powerclamp: Add dependency on CPU_IDLE
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 1:35 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Fix error:
>    WARNING: unmet direct dependencies detected for IDLE_INJECT
>      Depends on [n]: POWERCAP [=y] && CPU_IDLE [=n]
>      Selected by [y]:
>      - INTEL_POWERCLAMP [=y] && THERMAL [=y] && (X86 [=y] ||
> X86_INTEL_QUARK [=n] || COMPILE_TEST [=y]) && X86 [=y] && CPU_SUP_INTEL [=y]
>
> Since IDLE_INJECT depends on CPU_IDLE, add that to INTEL_POWERCLAMP.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

I have folded this into the original patch that introduced the issue.

> ---
> This is for kernel
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
>
>  drivers/thermal/intel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index b346a646fffb..b5808f92702d 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -3,6 +3,7 @@ config INTEL_POWERCLAMP
>         tristate "Intel PowerClamp idle injection driver"
>         depends on X86
>         depends on CPU_SUP_INTEL
> +       depends on CPU_IDLE
>         select POWERCAP
>         select IDLE_INJECT
>         help
> --
> 2.39.1
>
