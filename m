Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA716C1E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjCTRhW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 13:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjCTRgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:36:49 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D221963;
        Mon, 20 Mar 2023 10:32:57 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id cn12so4209337edb.4;
        Mon, 20 Mar 2023 10:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/gEhKA00bjwamqnWg3JcLBNsDvdrIyq5BZphTgJnKs=;
        b=jDnnFsknTXFlzj/rrd1tdtyxQ6Kmo7ndg0nalJ/oaRvVmWPpkOg0pB0RVAe2PMzX0e
         ao/gTsOE80bX+wHe7XLj6FSYhKvVQ7HuSnbH+PArBz/bhY6Clm1Z2t30cVheID2YXmnS
         Dg0wLIHgT2wZcm1mAcGcpdyqAjJ3HUImicQQZRc6otjn/FUxJ4jq0zsPx76aYMukJGW0
         3BEyhuFbGTrRrd1IhZcLppj60qHoKHZXDKPD/qePE4RP/HECCZANlNvh9JzFHxBFnsu9
         I3lzsHNs8KXVwQg50EjofphmlaoJNCI8mgzbMUikdq4hRHH0LZJDsfxGQ0+wCFWjVeoE
         ifKQ==
X-Gm-Message-State: AO0yUKUA72A0wdSNlnNLbDpgi7N+i6e8CSvE6pgyeQ6UygY7tNi5GXHR
        t196nOFSESFKWhC+TKKUMipUIL94lw60wKY2iB5vVn6M
X-Google-Smtp-Source: AK7set8/uEUjjJH2FQiJmYi0oMT1AU+uX+FiCxy7coDWOYgUH8lJnf4+Xp5ufdqBCug28iqCCH+Pfn1RQ2/hOmgm/bw=
X-Received: by 2002:a50:c3cf:0:b0:4fb:2593:846 with SMTP id
 i15-20020a50c3cf000000b004fb25930846mr173009edf.3.1679333533209; Mon, 20 Mar
 2023 10:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230313144710.3516-1-simon@invisiblethingslab.com>
In-Reply-To: <20230313144710.3516-1-simon@invisiblethingslab.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:32:02 +0100
Message-ID: <CAJZ5v0idjCBRWU2SuOmoVgR847zNisPX65dqycoHdEO0W+C9zA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: s2idle: Log when enabling wakeup IRQ fails
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

On Mon, Mar 13, 2023 at 3:47 PM Simon Gaiser
<simon@invisiblethingslab.com> wrote:
>
> enable_irq_wake() can fail. Previously acpi_s2idle_prepare() silently
> ignored it's return code. Based on [1] we should try to continue even in
> case of an error, so just log a warning for now.
>
> Discovered when trying to go into s2idle under Xen. This leads to a
> system that can't be woken, since xen-pirq currently doesn't support
> setting wakeup IRQs [2]. With this you get at least some helpful log
> message if you have access to console messages.
>
> Link: https://lore.kernel.org/linux-acpi/20230313125344.2893-1-simon@invisiblethingslab.com/ # v1
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0jahjt58nP6P5+xRdtD_ndYPvq4ecMVz6nfGu9tf5iaUw@mail.gmail.com/ # [1]
> Link: https://lore.kernel.org/xen-devel/20230313134102.3157-1-simon@invisiblethingslab.com/ # [2]
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
> ---
> v2:
>  - Based on feedback switched to only logging a warning instead of
>    returning an error.
> ---
>  drivers/acpi/sleep.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 4ca667251272..6b30dea94fae 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -714,7 +714,13 @@ int acpi_s2idle_begin(void)
>  int acpi_s2idle_prepare(void)
>  {
>         if (acpi_sci_irq_valid()) {
> -               enable_irq_wake(acpi_sci_irq);
> +               int error;
> +
> +               error = enable_irq_wake(acpi_sci_irq);
> +               if (error)
> +                       pr_warn("Warning: Failed to enable wakeup from IRQ %d: %d\n",
> +                               acpi_sci_irq,
> +                               error);
>                 acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
>         }
>
> --

Applied (with a minor white space adjustment) as 6.4 material, thanks!
