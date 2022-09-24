Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E675E8EFB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiIXRed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIXRe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:34:29 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8ED5F13D;
        Sat, 24 Sep 2022 10:34:28 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id g4so1953543qvo.3;
        Sat, 24 Sep 2022 10:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4NKVQm5+gPk97+fTxA5IogZyj0x078QM4McdZgTzSus=;
        b=FoPM+2pFtHF/swIAvtU2jVg8m0rUrZf88rBBSpP36irONk0FKkTUHddfpseC8m7HcW
         1LGIxAr5G3sg7bKabiQibzg1ffS9bed8ZGPBLuUyVPFyDVby6vZsHgaX72F4uOJ4JOkh
         XNx8i7eP+jES5SvJJ3AQwrOQJUDNr0EIog/L962uu7qkO9tQj/eCRcm2SMNfb42nQ0ms
         aeyaUXY8BUUqorit3NG5VDTdkWhIYfwLq+N3ZxPGkypzANmQk9BNXszVzR9lIMUBbYZI
         oacHg4Pjtid+GwXLENlBMnxcTV8L6Ttaly9OJsyGN3xG/0PP5NO6NoiW/cykCgO0dv+5
         FFNQ==
X-Gm-Message-State: ACrzQf2B+TzlxqsgBzg8Z34BY9eWbCu1poyJU9bNKAzhmksKKCTlslRr
        24TI0M7701qGf1WaD3ccw3vy0MY+124BuBw7nGM=
X-Google-Smtp-Source: AMsMyM7rjAEH5MFY6rzj6ABQ2aeHnRXAUZ3VKJTzUS/hx0hQe+AhmaDLkivzhofaw85caCHDKcDTSlldTyc3t72cg4E=
X-Received: by 2002:a05:6214:d8d:b0:4ad:5d9d:bda8 with SMTP id
 e13-20020a0562140d8d00b004ad5d9dbda8mr11450858qve.85.1664040867821; Sat, 24
 Sep 2022 10:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220924054738.12076-1-rui.zhang@intel.com> <20220924054738.12076-2-rui.zhang@intel.com>
In-Reply-To: <20220924054738.12076-2-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 19:34:17 +0200
Message-ID: <CAJZ5v0gQpdoSPwCeuM3eDHB_rs63GN9_24iM3tCvzhSR99tj4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] powercap: intel_rapl: Use standard Energy Unit for
 SPR Dram RAPL domain
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
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

On Sat, Sep 24, 2022 at 7:45 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Intel Xeon servers used to use a fixed energy resolution (15.3uj) for
> Dram RAPL domain. But on SPR, Dram RAPL domain follows the standard
> energy resolution as described in MSR_RAPL_POWER_UNIT.
>
> Remove the SPR dram_domain_energy_unit quirk.
>
> Fixes: 2d798d9f5967 ("powercap: intel_rapl: add support for Sapphire Rapids")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Wang Wendy <wendy.wang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 949eb90f5733..d8eaa04bf2af 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1035,7 +1035,6 @@ static const struct rapl_defaults rapl_defaults_spr_server = {
>         .check_unit = rapl_check_unit_core,
>         .set_floor_freq = set_floor_freq_default,
>         .compute_time_window = rapl_compute_time_window_core,
> -       .dram_domain_energy_unit = 15300,
>         .psys_domain_energy_unit = 1000000000,
>         .spr_psys_bits = true,
>  };
> --

Applied as 6.1 material, thanks!
