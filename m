Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4505272CD2C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbjFLRrC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjFLRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:47:00 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F298;
        Mon, 12 Jun 2023 10:46:59 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-974604c1394so128467166b.0;
        Mon, 12 Jun 2023 10:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592017; x=1689184017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjJbSwslWkQldlYMFCzjVzvCkhaWvNh1QgWklkyhORc=;
        b=bdYQk16wd1vJ8w4HlCbcCaGXJh4Avvsh3VbJDzsAzx6djTLFt94/Na8nZc8x93hu70
         bcWg8nS5b6K4L+x8/5c1vcDKsl9vcuicv0BMDNwYJfcJcurbiXM8v27cMVNkck8jtHYH
         VTqsj7oeJnyr4hnc7KxGHFCrU+d01ocpT8ByGbF+6+iV1S2deaBvKqWgZ4l7lICsi7nu
         JRYmXInl7Hxv7tdOydMKJLPnRG+UEK57eEFrPHPfQtwSHHIZYIPYNVxJEc7l0aqLfSxZ
         ElEyhCVDDFQWqXxKqY6zaYjMZ8fQJedgwWHbICU4xI+8hlqZVU6Dk2/x1mhOwrg67rcg
         is9g==
X-Gm-Message-State: AC+VfDxQgjPlvMNfx/LUXTZ+199OvFQLrCKVhzsS50PjzPdM7LKcbqpg
        yLf47uqIjDb1UiGR0SdEtMizle+qReZTbXXeeDY=
X-Google-Smtp-Source: ACHHUZ4WB6ovXzy+ZcFdfAJDvy8rRi41eejRTXep9+in6f8BE0dfI8JEVZNzXbr8LL9mWN9CMaDtLcAqNmH5DzpcYv4=
X-Received: by 2002:a17:906:535e:b0:974:571f:23f3 with SMTP id
 j30-20020a170906535e00b00974571f23f3mr8498378ejo.0.1686592017089; Mon, 12 Jun
 2023 10:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230608023006.12836-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20230608023006.12836-1-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:46:46 +0200
Message-ID: <CAJZ5v0hYQ77JZPa_X8+v6UW3tPT3MWun=wReDeCOpc7Hb=zqQg@mail.gmail.com>
Subject: Re: [PATCH] powercap: RAPL: fix invalid initialization for
 pl4_supported field
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Dave and the x86 maintainers

On Thu, Jun 8, 2023 at 4:44 AM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> The current initialization of the struct x86_cpu_id via
> pl4_support_ids[] is partial and wrong. It is initializing
> "stepping" field with "X86_FEATURE_ANY" instead of "feature" field.
>
> Use X86_MATCH_INTEL_FAM6_MODEL macro instead of initializing
> each field of the struct x86_cpu_id for pl4_supported list of CPUs.
> This X86_MATCH_INTEL_FAM6_MODEL macro internally uses another macro
> X86_MATCH_VENDOR_FAM_MODEL_FEATURE for X86 based CPU matching with
> appropriate initialized values.
>
> Reported-by: Dave Hansen <dave.hansen@intel.com>
> Closes: https://lore.kernel.org/lkml/28ead36b-2d9e-1a36-6f4e-04684e420260@intel.com/
> Fixes: eb52bc2ae5b8 ("powercap: RAPL: Add Power Limit4 support for Meteor Lake SoC")
> Fixes: b08b95cf30f5 ("powercap: RAPL: Add Power Limit4 support for Alder Lake-N and Raptor Lake-P")
> Fixes: 515755906921 ("powercap: RAPL: Add Power Limit4 support for RaptorLake")
> Fixes: 1cc5b9a411e4 ("powercap: Add Power Limit4 support for Alder Lake SoC")
> Fixes: 8365a898fe53 ("powercap: Add Power Limit4 support")
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/powercap/intel_rapl_msr.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index a27673706c3d..7be7561f5ad6 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -137,14 +137,14 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
>
>  /* List of verified CPUs. */
>  static const struct x86_cpu_id pl4_support_ids[] = {
> -       { X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
> -       { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
> -       { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
> -       { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_N, X86_FEATURE_ANY },
> -       { X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
> -       { X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE_P, X86_FEATURE_ANY },
> -       { X86_VENDOR_INTEL, 6, INTEL_FAM6_METEORLAKE, X86_FEATURE_ANY },
> -       { X86_VENDOR_INTEL, 6, INTEL_FAM6_METEORLAKE_L, X86_FEATURE_ANY },
> +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
>         {}
>  };
>
> --

Tentatively applied as 6.5 material, thanks!
