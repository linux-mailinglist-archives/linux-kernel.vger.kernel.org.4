Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF47673A72
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjASNg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjASNej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:34:39 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3336C7E6A9;
        Thu, 19 Jan 2023 05:34:37 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id v6so5697057ejg.6;
        Thu, 19 Jan 2023 05:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58Cix+5iRcNAm7+Mebt4ukWRjiEsHxfA5Phv7jZQzQg=;
        b=jOpnkeMLnjPPnVQY67O7NWMM5JDUB621yOfExSDntzSP0ZzrTl58QjJhnptbM060zu
         ELYBvE9TSDUoxUYEirxSDFIi2fuard97n5IjYIGaGHlj8nRG/0z3s1kigjW23Kba9RkN
         Z4FEoZTy3vuPCctbTu8rDhQkXGRapNGcKRkyS2P0gLRt8Y1VSZUNbCKzoJkM1iIzd/WQ
         95NQJ8+8L0eZ/H9QXYlZJBssZfYjlSbYFjDaxZwn2MbFL2BIGsAAwfHimxC0YYDp84kW
         mEDas/0vYOKHhj+oOukXMO+28QNqAV8gxIav8sz2LqKQXlleHBZjLiG6pDLsGo9HDR83
         gpAQ==
X-Gm-Message-State: AFqh2krQCKfJXMay07u6W3RPmxcOcGyouYVjMviT0VOmma6/ht5frGGh
        hONTLx20gmQePW97K6GV0/evnkxFMSQIPpm05Og=
X-Google-Smtp-Source: AMrXdXsZYHp3zJIym04pHVHKz9PxTjsbQ3vfb2LfMZDaevE58+t3Eeltfi9qXgOXQoAs86oTN2iShX+5tdjCHcMOV4c=
X-Received: by 2002:a17:906:64a:b0:84d:3c6a:4c55 with SMTP id
 t10-20020a170906064a00b0084d3c6a4c55mr1459533ejb.509.1674135276370; Thu, 19
 Jan 2023 05:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20230114085053.72059-1-W_Armin@gmx.de> <20230114085053.72059-2-W_Armin@gmx.de>
In-Reply-To: <20230114085053.72059-2-W_Armin@gmx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 14:34:25 +0100
Message-ID: <CAJZ5v0j6FMzHRhegQ-hQBmrrkHA=4rH6AeQOSmfTn5BcBW5dsw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPI: battery: Fix missing NUL-termination with large strings
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 9:51 AM Armin Wolf <W_Armin@gmx.de> wrote:
>
> When encountering a string bigger than the destination buffer (32 bytes),
> the string is not properly NUL-terminated, causing buffer overreads later.
>
> This for example happens on the Inspiron 3505, where the battery
> model name is larger than 32 bytes, which leads to sysfs showing
> the model name together with the serial number string (which is
> NUL-terminated and thus prevents worse).
>
> Fix this by using strscpy() which ensures that the result is
> always NUL-terminated.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index f4badcdde76e..fb64bd217d82 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -440,7 +440,7 @@ static int extract_package(struct acpi_battery *battery,
>
>                         if (element->type == ACPI_TYPE_STRING ||
>                             element->type == ACPI_TYPE_BUFFER)
> -                               strncpy(ptr, element->string.pointer, 32);
> +                               strscpy(ptr, element->string.pointer, 32);
>                         else if (element->type == ACPI_TYPE_INTEGER) {
>                                 strncpy(ptr, (u8 *)&element->integer.value,
>                                         sizeof(u64));
> --

Applied as 6.3 material, thanks!

Please do not include this one in the next version of the series.
