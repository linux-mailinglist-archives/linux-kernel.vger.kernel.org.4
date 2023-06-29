Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A03742434
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjF2KtJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 06:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjF2Ksw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:48:52 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40011E6C;
        Thu, 29 Jun 2023 03:48:51 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-98de322d11fso15068166b.1;
        Thu, 29 Jun 2023 03:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035730; x=1690627730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8zOdiEV6AM9voeBO+/JtBD2h7O8pc56trtKT86vorg=;
        b=LZBm3E5yEgUbY/SHvULv0xs5twqiFYk7xBTBdPRWz5fgB/dNZxEhwRy7IzEgyFLO6L
         Eshd6pdxz5Y15I2PCzrPThTJUqtJmDqIXaFO1wVE60HnRw4tpr89pmCF8mQnFUkg6vyz
         aGPNkBKQkMlKpFoEH24pqpQ/jkDmLS0L6TYo0HnZA8pQvswbLnoHYF6U7AYyLqXO3y1P
         Y8P/SpYVRpg7jxTxg15DsH3O1ZT0Lw3t+2O3KPtvhnYC4+s91t37AjjPi/VCDQvw4zZr
         DsrcdyG7Sgj6lDAtK1F49FiAO+k4X5VeXwhsCv+u+1I8HSKRc4jn1E5arJrv6QV3BV7E
         hRGw==
X-Gm-Message-State: AC+VfDwFe2lTSqRF0Yr0wpJKqJJMWggtGAe2c9poHc3QfsyoNR4dAHkH
        vtI9soG0d0Q0alfeQJBuX8+t2CnOvSBNbVBw8ng=
X-Google-Smtp-Source: ACHHUZ4VO+Eftv5Do3pkmbGF2NR+7KFwPE4oGz9V9boImW03fmvNEUzFwmhnW7touMA42vqT1KCmYearmdPLBGMG1Js=
X-Received: by 2002:a17:906:74da:b0:976:50a4:ac40 with SMTP id
 z26-20020a17090674da00b0097650a4ac40mr30824496ejl.0.1688035729518; Thu, 29
 Jun 2023 03:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230613161034.3496047-1-michal.wilczynski@intel.com> <20230613161034.3496047-3-michal.wilczynski@intel.com>
In-Reply-To: <20230613161034.3496047-3-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 12:48:38 +0200
Message-ID: <CAJZ5v0gfvkhw1+QJkvaURn609oNYc_2c=CKk+fEvfjZvu4zN=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] acpi: Refactor arch_acpi_set_pdc_bits()
To:     Michal Wilczynski <michal.wilczynski@intel.com>, x86@kernel.org
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@intel.com, artem.bityutskiy@linux.intel.com,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, lenb@kernel.org, jgross@suse.com,
        linux-kernel@vger.kernel.org
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

On Tue, Jun 13, 2023 at 6:12 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Capabilities buffer modified by the arch_acpi_set_pdc_bits() is not
> _PDC specific, as it is used by _OSC method as well. Change function
> name to better reflect it's independence from PDC. Change function
> expected argument to pass capability buffer directly without any
> offset, as the offset differ among _OSC and _PDC methods.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Any objections to this from the x86 arch side?  if not, I will route
it via ACPI along with the rest of the series.

> ---
>  arch/ia64/include/asm/acpi.h |  4 ++--
>  arch/x86/include/asm/acpi.h  | 10 +++++-----
>  drivers/acpi/processor_pdc.c |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
> index 87927eb824cc..43797cb44383 100644
> --- a/arch/ia64/include/asm/acpi.h
> +++ b/arch/ia64/include/asm/acpi.h
> @@ -69,9 +69,9 @@ extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
>  #endif
>
>  static inline bool arch_has_acpi_pdc(void) { return true; }
> -static inline void arch_acpi_set_pdc_bits(u32 *buf)
> +static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
>  {
> -       buf[2] |= ACPI_PDC_EST_CAPABILITY_SMP;
> +       *cap |= ACPI_PDC_EST_CAPABILITY_SMP;
>  }
>
>  #ifdef CONFIG_ACPI_NUMA
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index 8eb74cf386db..6a498d1781e7 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -100,23 +100,23 @@ static inline bool arch_has_acpi_pdc(void)
>                 c->x86_vendor == X86_VENDOR_CENTAUR);
>  }
>
> -static inline void arch_acpi_set_pdc_bits(u32 *buf)
> +static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
>  {
>         struct cpuinfo_x86 *c = &cpu_data(0);
>
> -       buf[2] |= ACPI_PDC_C_CAPABILITY_SMP;
> +       *cap |= ACPI_PDC_C_CAPABILITY_SMP;
>
>         if (cpu_has(c, X86_FEATURE_EST))
> -               buf[2] |= ACPI_PDC_EST_CAPABILITY_SWSMP;
> +               *cap |= ACPI_PDC_EST_CAPABILITY_SWSMP;
>
>         if (cpu_has(c, X86_FEATURE_ACPI))
> -               buf[2] |= ACPI_PDC_T_FFH;
> +               *cap |= ACPI_PDC_T_FFH;
>
>         /*
>          * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
>          */
>         if (!cpu_has(c, X86_FEATURE_MWAIT))
> -               buf[2] &= ~(ACPI_PDC_C_C2C3_FFH);
> +               *cap &= ~(ACPI_PDC_C_C2C3_FFH);
>  }
>
>  static inline bool acpi_has_cpu_in_madt(void)
> diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
> index 5596862e6fea..ce3acd86dd12 100644
> --- a/drivers/acpi/processor_pdc.c
> +++ b/drivers/acpi/processor_pdc.c
> @@ -24,7 +24,7 @@ static void acpi_set_pdc_bits(u32 *buf)
>         buf[2] = ACPI_PDC_SMP_T_SWCOORD;
>
>         /* Twiddle arch-specific bits needed for _PDC */
> -       arch_acpi_set_pdc_bits(buf);
> +       arch_acpi_set_proc_cap_bits(&buf[2]);
>  }
>
>  static struct acpi_object_list *acpi_processor_alloc_pdc(void)
> --
> 2.41.0
>
