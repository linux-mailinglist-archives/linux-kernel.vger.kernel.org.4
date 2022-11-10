Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830FA624A84
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiKJTUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKJTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:20:32 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E642E0FA;
        Thu, 10 Nov 2022 11:20:31 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id c8so2082624qvn.10;
        Thu, 10 Nov 2022 11:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YBGKTfu6TLq6OsvTGJR+t71TVt0vJcs9iDhz7OHA1o=;
        b=h/TnhlQit3+0usG12PwpjxiOc/IYbJ4ADi73QrZbk1W3sLJJd+2DxuuHf4S/w2DbNA
         8eqUI+lPEzIsAEJJEr72Qtr72A9BmYmgSTvGXOpkUiFnhmFOGIDNj42vpbTlRElsJDo8
         ZC2WfCUjqe+QrTGcLmd0j5+asYKVvM5WlX51oceakKqQZ5jMkKC/kMoDUL+Dwpwg1ETM
         hsJMRVJa9FUoGuY7wwJhN/zyO5ALWgetMzBiuPa/MrAd05BPyUxdqoFRbdk/jFZ+L8wE
         KOmhOjcjluO4pMbGG0dTLV8DeOtuFtdYsZ3Lwk7WKPKQcejwRjH1EmTDbYWkLfZLv8Wa
         xLIw==
X-Gm-Message-State: ACrzQf1v9gOQUj3Rl6/DvY7GVS1qzgDFQJcmFAgWukCG0NJ2okcEo3fB
        XnAbyN6fYH6qP9JrZRTEKmNcAQnkKrL+e/udBvYgjWS1
X-Google-Smtp-Source: AMsMyM4xM18mDWQ0LwAfP6WGTfoheXlOQYA+bO6ijx+JQvmLhV27lg76GbEN1QhBxndCxvdihVHsKKErxaEF/KmDcsA=
X-Received: by 2002:a05:6214:4517:b0:4b1:a9ac:21de with SMTP id
 oo23-20020a056214451700b004b1a9ac21demr1706384qvb.119.1668108030271; Thu, 10
 Nov 2022 11:20:30 -0800 (PST)
MIME-Version: 1.0
References: <1667792089-4904-1-git-send-email-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <1667792089-4904-1-git-send-email-TonyWWang-oc@zhaoxin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 20:20:19 +0100
Message-ID: <CAJZ5v0ggQOYdCEosCSFFd=09fsH6BbFSgwurDuoBhW+fRKSAqA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/acpi/cstate: Optimize ARB_DISABLE on Centaur CPUs
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, CobeChen@zhaoxin.com,
        TimGuo@zhaoxin.com, LindaChai@zhaoxin.com, LeoLiu@zhaoxin.com
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

On Mon, Nov 7, 2022 at 4:35 AM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>
> On all recent Centaur platforms, ARB_DISABLE is handled by PMU
> automatically while entering C3 type state. No need for OS to
> issue the ARB_DISABLE, so set bm_control to zero to indicate that.
>
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or x86 maintainers please let me know if you want me to take care of this.

Thanks!

> ---
> Changes in V2:
>  - fix typo in comments.
> ---
>  arch/x86/kernel/acpi/cstate.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 7945eae..da71679 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -52,17 +52,25 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>         if (c->x86_vendor == X86_VENDOR_INTEL &&
>             (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
>                         flags->bm_control = 0;
> -       /*
> -        * For all recent Centaur CPUs, the ucode will make sure that each
> -        * core can keep cache coherence with each other while entering C3
> -        * type state. So, set bm_check to 1 to indicate that the kernel
> -        * doesn't need to execute a cache flush operation (WBINVD) when
> -        * entering C3 type state.
> -        */
> +
>         if (c->x86_vendor == X86_VENDOR_CENTAUR) {
>                 if (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f &&
> -                   c->x86_stepping >= 0x0e))
> -                       flags->bm_check = 1;
> +                   c->x86_stepping >= 0x0e)) {
> +                       /*
> +                        * For all recent Centaur CPUs, the ucode will make sure that each
> +                        * core can keep cache coherence with each other while entering C3
> +                        * type state. So, set bm_check to 1 to indicate that the kernel
> +                        * doesn't need to execute a cache flush operation (WBINVD) when
> +                        * entering C3 type state.
> +                        */
> +                       flags->bm_check = 1;
> +                       /*
> +                        * For all recent Centaur platforms, ARB_DISABLE is a nop.
> +                        * Set bm_control to zero to indicate that ARB_DISABLE is
> +                        * not required while entering C3 type state.
> +                        */
> +                       flags->bm_control = 0;
> +               }
>         }
>
>         if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
> --
> 2.7.4
>
