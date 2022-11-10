Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6996244EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiKJO6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiKJO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:57:59 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5503B140EB;
        Thu, 10 Nov 2022 06:57:58 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id z30so1181994qkz.13;
        Thu, 10 Nov 2022 06:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDkz7bbVWR+GgxxGkF8vR//X45oBZt+X3AVSEGxGVU8=;
        b=WgohCPeevFJ0279jZ5S9Lfh/4MV4XS6mU0N+pLLTk1DOUq8zehQG4RD57gxTse1g2j
         OobK+jjzXrXgzzC48Qjrd8gH5HMTW8nogUYpRi3qKp6t3bk1kwclAqanRlDwe1WlSTYo
         WDlv2ggzh3Im83boildgCn2uagwCZP8yxf0+IqNLjtMFNB/ZioRU2RcmAfZOHhMcRSqS
         hgvNtC911/yDrtWM99WYjn2Pl+LDWnclG4wAba7xe95Zh3DlVV9GMGUu+eItACbkdrhq
         uI9oQ9ZhOsr2/NSRYHvYaGkGqAsg3GSQvjApITs1Z/56UZ8RYAM6z97YuRMyJpxkLIbc
         ENAg==
X-Gm-Message-State: ACrzQf2DJX0eCFfyKb0WBD0/9iGB+RQhvyC+LQqHpa6c83jLypMnzYmT
        4BU/MC9bj5MD8G+bYWmv+/O7gBJGpjsZJvvGEZPLJx1n
X-Google-Smtp-Source: AMsMyM47eRjAfLOkZckNfJo2f4YcfTMlNMz7S4jLXyQo3C0XtTVcaHQmgGGmobmtLZtvyDyfRk8ne8iVGCNYr4nt11c=
X-Received: by 2002:a05:620a:1476:b0:6fa:4c67:83ec with SMTP id
 j22-20020a05620a147600b006fa4c6783ecmr35621745qkl.23.1668092277397; Thu, 10
 Nov 2022 06:57:57 -0800 (PST)
MIME-Version: 1.0
References: <20221107175705.2207842-1-Perry.Yuan@amd.com> <20221107175705.2207842-3-Perry.Yuan@amd.com>
In-Reply-To: <20221107175705.2207842-3-Perry.Yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 15:57:46 +0100
Message-ID: <CAJZ5v0hfy2RnCfgaXyX629GxwPyn3Nh4WcMg9cxAisVYELqrYA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] Documentation: amd-pstate: add EPP profiles introduction
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, ray.huang@amd.com,
        viresh.kumar@linaro.org, Deepak.Sharma@amd.com,
        Mario.Limonciello@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Nov 7, 2022 at 7:02 PM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> The patch add AMD pstate EPP feature introduction and what EPP
> preference supported for AMD processors.
>
> User can get supported list from
> energy_performance_available_preferences attribute file, or update
> current profile to energy_performance_preference file
>
> 1) See all EPP profiles
> $ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
> default performance balance_performance balance_power power
>
> 2) Check current EPP profile
> $ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
> performance
>
> 3) Set new EPP profile
> $ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"
>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 8f3d30c5a0d8..78c6525d5a49 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
>  <perf_cap_>`_.)
>  This attribute is read-only.
>
> +``energy_performance_available_preferences``
> +
> +All the supported EPP preference could be selected, List of the strings that
> +can be set to the ``energy_performance_preference`` attribute
> +those different profiles represent different energy vs efficiency hints provided
> +to low-level firmware
> +however, the ``default`` represents the epp value is set by platform firmware
> +This attribute is read-only.
> +
> +``energy_performance_preference``
> +
> +The current energy performance preference can be read from this attribute.
> +and user can change current preference according to energy or performance needs
> +Please get all support profiles list from
> +``energy_performance_available_preferences`` attribute, all the profiles are
> +integer values defined between 0 to 255 when EPP feature is enabled by platform
> +firmware, if EPP feature is disabled, driver will ignore the written value
> +This attribute is read-write.
> +
>  Other performance and frequency values can be read back from
>  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>
> --

So the interface is the same as for intel_pstate AFAICS, which is
good, because it is all consistent.

However, there is some code duplication introduced in the subsequent
patches and that may be a problem from the perspective of maintaining
that consistency in the future.

Have you at least considered introducing a common EPP support header
file that could be used by both intel_pstate and amd_pstate?
