Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82DC61186A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJ1Q5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiJ1Q4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:56:43 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA011EB56B;
        Fri, 28 Oct 2022 09:56:16 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id r19so3820921qtx.6;
        Fri, 28 Oct 2022 09:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDfK2H1aBftmwIp77bKuXrrx29hMSNAG+g0WQdlgDPo=;
        b=GLZznfFYDpdyS5bB46y/wQetcZkKqEa6NmLfYlz3egVlqF4OmTEKv0SRxbffJNsIXq
         SRJXPpgwOH2d9jUroR5S4zITCId8K1SuhgnRjBSF+EpTgMjFVBaI7poX+NZn0sDr3tOm
         z57nybwksEVWTqBwGXJ3BhbjGKNCsUj/v5/Zv5KaWpN3SWPNIeFJS7lw03DkBUyHAk3C
         Rvo7sTtQmyFK4Kk7V0FhaVmz1dNup/dx/Dlb+93RQxmPD5hZlfKB6DzQBZ0ADrj5mMfw
         kIxwwtyHxJS/99aJQnvQF2jipy5cvV1+PuUomf8JhJmvBeN0lwFZ7CSxNN+tzjn0dt8s
         j2yQ==
X-Gm-Message-State: ACrzQf3lfR/Y5nTD6vGLVcv1Ay6z6CP9ItCI2a3dXoKzgrrRyLc7yeYa
        Z31lAod95xf7Fyj8AdLmA9AtVg9y1adMKzOLznw=
X-Google-Smtp-Source: AMsMyM67fuSLwLA17n2MGGaxc8z04FhqqGkYApd52+dq8IDxDDRCv84+9RgjLd5vQBMN1zc6dJQersxY5xtKY6PLFlU=
X-Received: by 2002:a05:622a:1a25:b0:39c:b862:7318 with SMTP id
 f37-20020a05622a1a2500b0039cb8627318mr350823qtb.147.1666976174432; Fri, 28
 Oct 2022 09:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221027150525.753064657@goodmis.org> <20221027150926.006142977@goodmis.org>
In-Reply-To: <20221027150926.006142977@goodmis.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 18:56:03 +0200
Message-ID: <CAJZ5v0gbhc-03JwS7T2sKKhNQWa56UUOYGtgc2Zc8nM-Max7jA@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 05/31] timers: ACPI: Use del_timer_shutdown()
 before freeing timer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 5:09 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Before a timer is freed, del_timer_shutdown() must be called.
>
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Please add "APEI: ghes:" to the subject after "ACPI:".

Apart from this

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 80ad530583c9..916b952b14d0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1405,7 +1405,7 @@ static int ghes_remove(struct platform_device *ghes_dev)
>         ghes->flags |= GHES_EXITING;
>         switch (generic->notify.type) {
>         case ACPI_HEST_NOTIFY_POLLED:
> -               del_timer_sync(&ghes->timer);
> +               del_timer_shutdown(&ghes->timer);
>                 break;
>         case ACPI_HEST_NOTIFY_EXTERNAL:
>                 free_irq(ghes->irq, ghes);
> --
> 2.35.1
