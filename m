Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DE865450B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiLVQX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLVQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:23:54 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B90E23BDF;
        Thu, 22 Dec 2022 08:23:53 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id d2so1528158qvp.12;
        Thu, 22 Dec 2022 08:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6F4Pdl1w0uJ/Dj5PshnD7dKmjPpVZhf3+ujj3GIsvkc=;
        b=QrUrlL0glPYAh7QSMkWy9mJk5uKLkgmzrLnpwQjic6ABSc28VRx5h9b+IBj0DBzxPW
         4KrIdPlrbCLnIXE3m9FnrBmmKCQgPy48gmofYjIZpewevdbsnnGWjj3dMMkUpBqKsW2+
         f4oz5i0GQ+bBDFR4OKGU1nWZlGeNhSB0ZU4m3tfJ0m+nvxw6XFDGUQ1KhWHTDifFUOCS
         RhFhjlEs2tdIgd33aH5E52d3fvbii84qY/Uvvh5HFHoKDCiPcNN/GCsvtjcfLY77LRB2
         2szDTccKM3ocLDli6tVXQx2xF3nr3lE8aqR1JN4O8eHBf4fPVhL6B2/DHbJj/IR3DI7B
         R6lw==
X-Gm-Message-State: AFqh2kqj2xnsHKKqiplICiMmiZzHm5kGW3D0sQHQMbx/H45wPqpTuzRs
        w01eceWEK2b54IcQAWKEDTVdjGxdvIb366qVnKi/HCtL
X-Google-Smtp-Source: AMrXdXurfuRqQTflDUkqlaJ6hSuTf3f6g7DGp7yvtz9AE6HsJKpctve7bbgi+dRkkUmDQqQUupj2l7oq2Y7cbFDnK2w=
X-Received: by 2002:a0c:c345:0:b0:4c7:27cf:dfca with SMTP id
 j5-20020a0cc345000000b004c727cfdfcamr268581qvi.3.1671726232692; Thu, 22 Dec
 2022 08:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20221221155203.11347-1-ptyadav@amazon.de> <20221221155203.11347-2-ptyadav@amazon.de>
In-Reply-To: <20221221155203.11347-2-ptyadav@amazon.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Dec 2022 17:23:41 +0100
Message-ID: <CAJZ5v0i-mrt57=2ROywn4Na_N3YVk+3D869QpHWqp9eo2NtGAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi: processor: allow fixing up the frequency for a
 performance state
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 4:52 PM Pratyush Yadav <ptyadav@amazon.de> wrote:
>
> In some cases the ACPI table can have an incorrect frequency populated
> for a performance state. For example, in Intel platforms, the Turbo
> frequency is just listed as +1 MHz above the max non-turbo frequency.

Which is a known convention based on compatibility with some older OSes.

> The frequency can actually go much higher based on various factors like
> temperature, voltage, etc.

It can.

> Allow drivers like intel_pstate to fix up performance state frequencies
> with the actual maximum value.

Why do you want to do that?

> While at it, also update the QoS
> constraints if needed to match the new frequency values.
>
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> ---
>  drivers/acpi/processor_perflib.c | 40 ++++++++++++++++++++++++++++++++
>  include/acpi/processor.h         |  2 ++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index 970f04a958cd..4958aee4c024 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -766,3 +766,43 @@ void acpi_processor_unregister_performance(unsigned int cpu)
>         mutex_unlock(&performance_mutex);
>  }
>  EXPORT_SYMBOL(acpi_processor_unregister_performance);
> +
> +int acpi_processor_fixup_perf_state(unsigned int cpu, unsigned int state,
> +                                   unsigned int frequency)
> +{
> +       struct acpi_processor *pr;
> +       int ret;
> +
> +       mutex_lock(&performance_mutex);
> +
> +       pr = per_cpu(processors, cpu);
> +       if (!pr) {
> +               mutex_unlock(&performance_mutex);
> +               return -ENODEV;
> +       }
> +
> +       if (!pr->performance) {
> +               mutex_unlock(&performance_mutex);
> +               return -EINVAL;
> +       }
> +
> +       if (state >= pr->performance->state_count) {
> +               mutex_unlock(&performance_mutex);
> +               return -EINVAL;
> +       }
> +
> +       pr->performance->states[state].core_frequency = frequency;
> +
> +       if (ignore_ppc != 1 && state == pr->performance_platform_limit &&
> +           freq_qos_request_active(&pr->perflib_req)) {
> +               ret = freq_qos_update_request(&pr->perflib_req,
> +                                             frequency * 1000);
> +               if (ret < 0)
> +                       pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
> +                               pr->id, ret);
> +       }
> +
> +       mutex_unlock(&performance_mutex);
> +       return 0;
> +}
> +EXPORT_SYMBOL(acpi_processor_fixup_perf_state);
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 94181fe9780a..daff978cfa7d 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -258,6 +258,8 @@ extern int acpi_processor_preregister_performance(struct
>  extern int acpi_processor_register_performance(struct acpi_processor_performance
>                                                *performance, unsigned int cpu);
>  extern void acpi_processor_unregister_performance(unsigned int cpu);
> +extern int acpi_processor_fixup_perf_state(unsigned int cpu, unsigned int state,
> +                                          unsigned int frequency);
>
>  int acpi_processor_pstate_control(void);
>  /* note: this locks both the calling module and the processor module
> --
> 2.38.1
>
