Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB03F67EF05
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjA0UAp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Jan 2023 15:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjA0UAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:00:18 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3CA22786;
        Fri, 27 Jan 2023 11:58:37 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id v6so16578147ejg.6;
        Fri, 27 Jan 2023 11:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcJtKSdMHqKdE8xqcb2pgFpWxs4VqUhIIxfqfsB0zUM=;
        b=F1bQVxBWUNIjEI0dJrKTYHQ9g2n+obfBFifI6FlNZFgZnBPlM/X0vYxkT4YpstW/hH
         tloabLQVynLe127ufYInwicxmRPLzzi6RMoGD1n/a3r+MfhqyqNcfSI9Usin+ElREzvB
         Xs80uGYXQrS17EPm/5P7Zmi7oStLBux0vZtQZJGulfeaEVvW6noK6tD69YWyBm0aupau
         7RUuCIatet0tqESHArrsXJpPEiQtRjeCLX8HRI0ipOQXJEt+K2yyvlilyrsXtxrfT+MQ
         +VwIBL1qggh2nQJ1aWZHq91+A2NSQWN9fgGopjXkZoo8gxdVOeMJ4dgpiv5hA9VTZBiE
         gn1g==
X-Gm-Message-State: AFqh2koJcHajiMLmEK2hgQXs4uxOxCHr6ERx4yu7Qd72cBO7xN2i4WUK
        /kwiY8W01/GlrBSFThF+xQbSu09UKlFpCoCvwKkpsbxuHew=
X-Google-Smtp-Source: AMrXdXuf4OnaEqJZeR4LpMLoedXEpZt4yq8U0HTUgh2Pm7TIwN3glp3b9onlDGb8CPzpm16l7usvTqPiSNpQjRdMNJo=
X-Received: by 2002:a17:907:d10f:b0:872:be4b:1b65 with SMTP id
 uy15-20020a170907d10f00b00872be4b1b65mr6650176ejc.125.1674848601884; Fri, 27
 Jan 2023 11:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20230127191621.gonna.262-kees@kernel.org>
In-Reply-To: <20230127191621.gonna.262-kees@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Jan 2023 20:43:05 +0100
Message-ID: <CAJZ5v0iV5wK4gsoadmWOyof_vzaAOx8oX0DJu+1-bCQNdNJtBQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: Replace fake flexible arrays with flexible
 array members
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 8:16 PM Kees Cook <keescook@chromium.org> wrote:
>
> One-element arrays (and multi-element arrays being treated as
> dynamically sized) are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
>
> Replace one-element array with flexible-array member in struct
> acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> padding in a union with a flexible-array member in struct
> acpi_pci_routing_table.
>
> This results in no differences in binary output.
>
> Link: https://github.com/acpica/acpica/pull/813
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> v2: include stddef.h and switch to __DECLARE_FLEX_ARRAY()
> v1: https://lore.kernel.org/lkml/20221118181538.never.225-kees@kernel.org/
> ---
>  include/acpi/acrestyp.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
> index a7fb8ddb3dc6..250046a7c870 100644
> --- a/include/acpi/acrestyp.h
> +++ b/include/acpi/acrestyp.h
> @@ -10,6 +10,8 @@
>  #ifndef __ACRESTYP_H__
>  #define __ACRESTYP_H__
>
> +#include <linux/stddef.h>
> +
>  /*
>   * Definitions for Resource Attributes
>   */
> @@ -332,7 +334,7 @@ struct acpi_resource_extended_irq {
>         u8 wake_capable;
>         u8 interrupt_count;
>         struct acpi_resource_source resource_source;
> -       u32 interrupts[1];
> +       u32 interrupts[];
>  };
>
>  struct acpi_resource_generic_register {
> @@ -679,7 +681,10 @@ struct acpi_pci_routing_table {
>         u32 pin;
>         u64 address;            /* here for 64-bit alignment */
>         u32 source_index;
> -       char source[4];         /* pad to 64 bits so sizeof() works in all cases */
> +       union {
> +               char pad[4];    /* pad to 64 bits so sizeof() works in all cases */
> +               __DECLARE_FLEX_ARRAY(char, source);
> +       };
>  };
>
>  #endif                         /* __ACRESTYP_H__ */
> --

With this applied I get:

rafael@gratch:~/work/linux-pm/tools/power/acpi> make
 DESCEND tools/acpidbg
 MKDIR    include
 CP       include
 CC       tools/acpidbg/acpidbg.o
In file included from
/scratch/rafael/work/linux-pm/tools/power/acpi/include/acpi/acpi.h:27:0,
                from acpidbg.c:9:
/scratch/rafael/work/linux-pm/tools/power/acpi/include/acpi/acrestyp.h:686:3:
error: expected specif
ier-qualifier-list before ‘__DECLARE_FLEX_ARRAY’
  __DECLARE_FLEX_ARRAY(char, source);
  ^~~~~~~~~~~~~~~~~~~~
make[1]: *** [../../Makefile.rules:25:
/scratch/rafael/work/linux-pm/tools/power/acpi/tools/acpidbg/
acpidbg.o] Error 1
make: *** [Makefile:18: acpidbg] Error 2

The tools build successfully without it.
