Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0706B7893
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjCMNNL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 09:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCMNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:13:05 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086C5268E;
        Mon, 13 Mar 2023 06:13:01 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id ek18so17392239edb.6;
        Mon, 13 Mar 2023 06:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678713179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kbugMu59+voxwo0pZv00WwvJOfGL2olexh1yeovl2g=;
        b=CyFzHVau9ItsYN2AywHIsLSQGHUQtWpFfZvpYJljeIxxM54x3R86a2S91t8hXD610U
         ygNlAVcouzn4B0n2XxhVZLnfjh4nZuJehRxgi/g7u0JT5jiRcc3gvr6v4c3hGDfVWASE
         6wBUzmIiW20vcFCTnIAnaAznSXWaGB2RGt7GNpEbvuxVaqoYO7gG7AUVtKtdYn0RFS2M
         L5jfs9SNKEy6oXnw+2Btl474kxjAmO6c1pPoNoEgzdbf1XMOAmTRRtdSRfRdHhhx8GG1
         e81VplA6eZ8274H6rM2A431mMNi09ZbxAprfklJDzZpbxwC52VrZ/K2Q/SXVeTllG9rD
         wSlA==
X-Gm-Message-State: AO0yUKWOgIawlv1Ed2c1CHqJ4gO2E2fbgpK1/Sy/BXfVQ2rB5550V4wX
        c5fJfSoH7BAvIkACsijttffZxM18v+U57RcUJe0=
X-Google-Smtp-Source: AK7set9iYgLCphYV3E3ZfzciQDuoUKFHKSdKnEEB+ZfErmcBsRtLwjVEpjALojIlxTqt9MROnLmmSz/1nlam6TeAkLo=
X-Received: by 2002:a17:906:13c2:b0:8b1:7aec:c8e6 with SMTP id
 g2-20020a17090613c200b008b17aecc8e6mr17974239ejc.2.1678713179451; Mon, 13 Mar
 2023 06:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230313125344.2893-1-simon@invisiblethingslab.com>
In-Reply-To: <20230313125344.2893-1-simon@invisiblethingslab.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Mar 2023 14:12:45 +0100
Message-ID: <CAJZ5v0jahjt58nP6P5+xRdtD_ndYPvq4ecMVz6nfGu9tf5iaUw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: s2idle: Don't ignore error when enabling wakeup IRQ
To:     Simon Gaiser <simon@invisiblethingslab.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 1:54 PM Simon Gaiser
<simon@invisiblethingslab.com> wrote:
>
> enable_irq_wake() can fail. Previously acpi_s2idle_prepare() silently
> ignored it's return code, potentially leaving a system that never wakes
> up.
>
> Discovered when trying to go into s2idle under Xen. This leads to a
> system that can't be woken, since xen-pirq currently doesn't support
> setting wakeup IRQs. Real s2idle support for Xen is another topic, but
> now at least the user gets an error and the system doesn't needs an hard
> reset.
>
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
> ---
>
> Note that I'm unfamiliar with the code so when reviewing please
> carefully check if ignoring the error was indeed unintended.

No, it wasn't.

First, in the majority of cases in which ACPI SCI is used, the IRQ
chip in question has IRQCHIP_SKIP_SET_WAKE set, so enable_irq_wake()
cannot fail for it.

Second, even if it could fail, it is preferred to let the system
suspend anyway, as long as there is at least one other wakeup source
in it and that is the case as a rule (for example, wakeup is enabled
for the PS/2 keyboard IRQ for all systems that have it).

> If there are indeed cases where the error should be ignored I would
> submit a patch that at least logs the error, although the error message
> would be hard to see with broken wakeup.

Logging an error would be fine, but failing suspend may not be.  Of
course, suspend should be aborted if there are no other usable (and
enabled) wakeup sources, but currently there's no infrastructure for
verifying that.

>  drivers/acpi/sleep.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 4ca667251272..c69dd3731126 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -714,7 +714,15 @@ int acpi_s2idle_begin(void)
>  int acpi_s2idle_prepare(void)
>  {
>         if (acpi_sci_irq_valid()) {
> -               enable_irq_wake(acpi_sci_irq);
> +               int error;
> +
> +               error = enable_irq_wake(acpi_sci_irq);
> +               if (error) {
> +                       pr_err("Failed to enable wakeup from IRQ %d: %d\n",
> +                              acpi_sci_irq,
> +                              error);
> +                       return error;
> +               }
>                 acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
>         }
>
> --
> 2.39.2
>
