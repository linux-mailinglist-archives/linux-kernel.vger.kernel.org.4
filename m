Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EAB632CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiKUTYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKUTYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:24:07 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB96C83E9B;
        Mon, 21 Nov 2022 11:24:05 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id a27so7899002qtw.10;
        Mon, 21 Nov 2022 11:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kbe2rrFrE8iqIK4HOHO2Z5jIsXR7SbwqXE/dnI/lSJc=;
        b=l0nL01/00rALQo/1Gr/kMRdKau7IctZmFMl8JIosGqGxLBzKA37Reqi/96d8AdcPJs
         5x6YMYYePKNF3ViOHUj8flL2BDRgZKzmzfuoaH3Q9oS44Qyal5sUEfDl+OdUDetDlWj1
         F2agUXXLIPVKfyd26IG3B9GPEn6q7iy6yBJmxa0HgfuaxmkShgRPvHpPITIOvgON6UEw
         5U6MBMrbUyNbx7FKfN1NVt2irk7dRCvY8edVkvqdjNqpFsIss9tbiTjSVx2MGfLgcKS9
         bE5/gLGVNBIuNl6GlqJODeis/EkVCr4CGwmxansyNEoR79xYZwbVxNNfS5ky/bXqc/Xm
         kn9g==
X-Gm-Message-State: ANoB5pmX9OV9cOQVRD86B/JHhYQd8ihgJcYNHGrKf85tPryWk8gCmqqN
        JPTw0KtdOpKB9hIRFzNPO6RFbohSqK9bmE3HhDI=
X-Google-Smtp-Source: AA0mqf76HmMbcxJ/PVpJ8gzxxii/dOkbT1+CwiN0eW640s4fyz/ap7xut7oHOZ/8Zqld52IvNGk2fCKQtkXlSKnfS14=
X-Received: by 2002:ac8:1482:0:b0:3a5:1e6f:7e05 with SMTP id
 l2-20020ac81482000000b003a51e6f7e05mr1269302qtj.357.1669058644889; Mon, 21
 Nov 2022 11:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20221117073541.3350600-1-Perry.Yuan@amd.com>
In-Reply-To: <20221117073541.3350600-1-Perry.Yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Nov 2022 20:23:54 +0100
Message-ID: <CAJZ5v0gZxQOmHsx6=rwuKQbhi-tUTW1nvHk2wY3xpSEJgh+AVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] AMD Pstate driver Urgent Change
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, ray.huang@amd.com,
        viresh.kumar@linaro.org, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Deepak.Sharma@amd.com, Shimmer.Huang@amd.com, Li.Meng@amd.com,
        Xiaojian.Du@amd.com, wyes.karny@amd.com, gautham.shenoy@amd.com,
        ananth.narayan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 8:36 AM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> The patchset changed amd-pstate driver as built-in type to resolve the
> driver loading sequence problem, otherwise the acpi-cpufreq driver will
> be loaded as the default cpufreq scaling driver instead of amd-pstate.
>
> Some new kernel parameters are added to allow user to disable pstate driver
> and load driver with passive mode which use governors to do the
> frequency scaling control.
>
> * `amd_pstate=disabled` or no parameters will not load pstate driver.
> * `amd_pstate=passive` will load pstate driver with passive mode.
>
> Set the `amd_pstate` driver disabled by default because of performance
> degradation on a number of AMD ASICs in the passive mode driver,
> especially the shared memory support processors.
>
> EPP support for the amd_pstate driver is under review. With EPP support,
> the said performance issue is resolved. Once that gets upstream,
> the `active` mode amd_pstate_epp driver may be enabled by default.
>
> Changes from v2:
>  * pick up Acked-by flag of Huang Rui
>  * fix typo in the cover letter
>
> Changes from v1:
>  * fix commit info in v1 patch PATCH 4/5
>  * pick up Reviewed-by flag of Gautham R. Shenoy
>  * pick up Tested-by flag of  Wyes Karny
>
> v2: https://lore.kernel.org/lkml/20221117071910.3347052-1-Perry.Yuan@amd.com/
> v1: https://lore.kernel.org/lkml/20221117024955.3319484-1-Perry.Yuan@amd.com/
>
> Perry Yuan (4):
>   cpufreq: amd-pstate: change amd-pstate driver to be built-in type
>   cpufreq: amd-pstate: add amd-pstate driver parameter for mode
>     selection
>   Documentation: amd-pstate: add driver working mode introduction
>   Documentation: add amd-pstate kernel command line options
>
> Wyes Karny (1):
>   cpufreq: amd-pstate: cpufreq: amd-pstate: reset MSR_AMD_PERF_CTL
>     register at init
>
>  .../admin-guide/kernel-parameters.txt         | 11 +++++
>  Documentation/admin-guide/pm/amd-pstate.rst   | 30 +++++-------
>  drivers/cpufreq/Kconfig.x86                   |  2 +-
>  drivers/cpufreq/amd-pstate.c                  | 49 +++++++++++++------
>  4 files changed, 59 insertions(+), 33 deletions(-)
>
> --

I have applied this series as 6.1-rc7 material.

Please let me know if you'd rather want to defer it till 6.2-rc1.

Thanks!
