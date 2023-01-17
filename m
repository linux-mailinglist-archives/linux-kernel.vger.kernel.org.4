Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014FB66E11A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjAQOnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjAQOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:43:10 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2193EFD2;
        Tue, 17 Jan 2023 06:42:59 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id s21so1144417edi.12;
        Tue, 17 Jan 2023 06:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2v3DeE/W1CyFIMPERqc2eH5GXaew0PxtCjey83Glkpo=;
        b=F500R2DA4hfN4Q9Ab88lRMDDvXA55DBb6XDwbqoPNVU08487hvErtNYe6coxcTyI02
         3ZHJ2nO2dgDdXdawOdZMdgAKcf3Pjd2MtJC8Ug09KIfa5N6ows4alhQIqKnFEo6NLpO3
         SxxMyqJtdLsyfH7q+QPtQUwAuQmZCCOmQejKYvAWgxOjOyGw20QL2A5InbaQypBnM/sR
         eFgL40qEsPg7vwNJ/IKseftSZ+bxC3GOCbY3S0pRfN09VLFSZ7qmU3Y5sPUfEfViWQvo
         by+xpl3Z1IGangPGAv98VaaKhI+hLAU6sh//zGtOTo5E4xJsOInvGBRPkQPzRVCLE6Fg
         oqIQ==
X-Gm-Message-State: AFqh2kqAyoJkLSHLV+bFj19nxvwqzjZJsn8USbtcE6IhJlO7quz+hOEL
        DiFO1HrqqQnwd8ZVi7BB4LQcCTVl5zE2Wk233zU=
X-Google-Smtp-Source: AMrXdXu0u3xs/+YV3YMRYrpNqWAU0nj7Wt67fy9jHr9Yafdj60bi6i3q07gGUPOSgLKihNUiwE6RW1pLci344OEi1ac=
X-Received: by 2002:a05:6402:1392:b0:46d:731c:2baf with SMTP id
 b18-20020a056402139200b0046d731c2bafmr372874edv.280.1673966577778; Tue, 17
 Jan 2023 06:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20230114085053.72059-1-W_Armin@gmx.de> <20230114085053.72059-3-W_Armin@gmx.de>
In-Reply-To: <20230114085053.72059-3-W_Armin@gmx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 15:42:46 +0100
Message-ID: <CAJZ5v0h2vTAUovMoEoWVX2gJQiJS6C9PSYzMqQMtxPusgdHBMQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: battery: Fix buffer overread if not NUL-terminated
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, Jan 14, 2023 at 9:51 AM Armin Wolf <W_Armin@gmx.de> wrote:
>
> If the buffer containing string data is not NUL-terminated
> (which is perfectly legal according to the ACPI specification),
> the acpi battery driver might not honor its length.

Note that this is about extracting package entries of type ACPI_TYPE_BUFFER.

And please spell ACPI in capitals.

> Fix this by limiting the amount of data to be copied to
> the buffer length while also using strscpy() to make sure
> that the resulting string is always NUL-terminated.

OK

> Also use '\0' instead of a plain 0.

Why?  It's a u8, not a char.

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/battery.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index fb64bd217d82..9f6daa9f2010 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -438,15 +438,24 @@ static int extract_package(struct acpi_battery *battery,
>                 if (offsets[i].mode) {
>                         u8 *ptr = (u8 *)battery + offsets[i].offset;

I would add

u32 len = 32;

>
> -                       if (element->type == ACPI_TYPE_STRING ||
> -                           element->type == ACPI_TYPE_BUFFER)
> +                       switch (element->type) {

And here I would do

case ACPI_TYPE_BUFFER:
        if (len > element->buffer.length + 1)
                len = element->buffer.length + 1;

        fallthrough;
case ACPI_TYPE_STRING:
        strscpy(ptr, element->buffer.pointer, len);
        break;
case ACPI_TYPE_INTEGER:

and so on.

> +                       case ACPI_TYPE_STRING:
>                                 strscpy(ptr, element->string.pointer, 32);
> -                       else if (element->type == ACPI_TYPE_INTEGER) {
> -                               strncpy(ptr, (u8 *)&element->integer.value,
> -                                       sizeof(u64));
> +
> +                               break;
> +                       case ACPI_TYPE_BUFFER:
> +                               strscpy(ptr, element->buffer.pointer,
> +                                       min_t(u32, element->buffer.length + 1, 32));
> +
> +                               break;
> +                       case ACPI_TYPE_INTEGER:
> +                               strncpy(ptr, (u8 *)&element->integer.value, sizeof(u64));
>                                 ptr[sizeof(u64)] = 0;
> -                       } else
> -                               *ptr = 0; /* don't have value */
> +
> +                               break;
> +                       default:
> +                               *ptr = '\0'; /* don't have value */
> +                       }
>                 } else {
>                         int *x = (int *)((u8 *)battery + offsets[i].offset);
>                         *x = (element->type == ACPI_TYPE_INTEGER) ?
> --
