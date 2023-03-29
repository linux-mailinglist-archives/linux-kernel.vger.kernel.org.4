Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BC06CF268
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjC2Snt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 14:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2Sns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:43:48 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F0510D3;
        Wed, 29 Mar 2023 11:43:47 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id i5so67374841eda.0;
        Wed, 29 Mar 2023 11:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IiUWBvQSZiUOLFDdU4Pxf+fx5anScSeaRxeHGvAu+o=;
        b=sgIciGKb00dstgq4Lqx0OIr6vrYxm6l2Tv3HHpdAGOi2GfC2oSkeT4wSOVSxTY+ccn
         UqBQoe9XNqWeCla8+2Kz3ojkXSmTmLrv3/DOhKHkQ6qq3DBLX7rnXe4O2lBvp0/4uLv+
         dY2cckbDxbbvwqWS7z9WhHWY7HhPOYeXvW64zBS1AqsNSozV2PHK3KwqMrPnLDoWqUel
         bMI/15UysAAB97RuEDljZPyoFVJ/oTzKpZUf25AA4xQ+aUKFBDXbEhN3aXMj0j+02eHJ
         2w4c8LXIa8kA7RlYYH1SRLvH+rmuV3HklmqRM67s7janZUrbbVEXgTxYEy+aLhmJELFy
         98ew==
X-Gm-Message-State: AAQBX9csDBB/l5ZUXYUtMiJu9J5sEasVvlCyB4fN3zksqIxOTx2eHZrd
        un2/NLLAD/J8oiOYl7T9urPRW3AFf/isUWQ5k+g=
X-Google-Smtp-Source: AKy350az84m1cD4JZ01Gspx8tJ2F4yjIhOkbLUkane7R0GJdtdgPDveTH7vHlgznOxae6dxBC/1fYKBghkOrnBBL8q8=
X-Received: by 2002:a50:d49e:0:b0:502:148d:9e1e with SMTP id
 s30-20020a50d49e000000b00502148d9e1emr10219719edi.3.1680115425745; Wed, 29
 Mar 2023 11:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
In-Reply-To: <20230328193846.8757-1-yang@os.amperecomputing.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 20:43:34 +0200
Message-ID: <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
To:     Yang Shi <yang@os.amperecomputing.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        scott@os.amperecomputing.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 9:39 PM Yang Shi <yang@os.amperecomputing.com> wrote:
>
> When testing CPPC cpufreq on our platform, we noticed the error may be quite
> high and the high error may happen quite often.  For example, on a platform
> with a maximum frequency of 2.8GHz when the CPUs were fully loaded (100% load),
> we saw cpuinfo_cur_freq may show 4GHz, it means the error is > 40%.  And the
> high error (> 1%) happened 256 times out of 2127 samples (sampled every 3
> seconds) in an approximate 2hrs test.

The description above is a bit cryptic IMV.  For example, it is not
particularly clear what "high error" means.

> We tried to enlarge the delay, and tested with 100us, 1ms and 10ms.  The
> below is the results.
>
> 100us:
> The highest error is 4GHz, 22 times out of 3623 samples
>
> 1ms:
> The highest error is 3.3GHz, 3 times out of 2814 samples
>
> 10ms:
> No high error anymore
>
> Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to avoid
> high measurement errors.
>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 022e3555407c..c2bf65448d3d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -851,7 +851,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>         if (ret)
>                 return ret;
>
> -       udelay(2); /* 2usec delay between sampling */
> +       mdelay(10); /* 10msec delay between sampling */

This function can be called with interrupts off, so it cannot spin for 10 ms.

>         ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>         if (ret)
> --
