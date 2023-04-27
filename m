Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8526F0A44
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbjD0QwI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 12:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbjD0QwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:52:06 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729BE53;
        Thu, 27 Apr 2023 09:52:05 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-94ea38c90ccso257174466b.1;
        Thu, 27 Apr 2023 09:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614324; x=1685206324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvcbD3dea1VXhYTRxoOIHuehyvAfbvA2NIEtdoBYTSA=;
        b=FQGQh/svT2ORpkGeB0ZFfnVqYg/TBpcH3ULIO9I+2/8rMPCeZhNtxyOU4lbQQ6rM+3
         HrZvHmniUVp4Qkvluua51H0MrgigUYXUtazBJOosNqeYstFcNLGa9gaCYq+xJx0E4Qe9
         UhVTvaOf275muEskp3TSuxzruJ0z0QqmukmBk1O5HqzHUp7rTnhhXoErhro/AXuVkF+a
         3vAP4hVUXDU1aLqJjKZLmVVPQgpK4s+LChVIKb5LJEQnS5+IDsm6Ipz3C+Ybsp64TdhL
         eZ56MArRN57H2aCt6IoTgIRDZTlInDzRiBweowyGkbOTze4pg3sxQsnx3BQEq/SYVM/o
         7GGA==
X-Gm-Message-State: AC+VfDwaG69EbQ3IWyF8ruCer/qH3HlSrp8HSIpxSDl2dmsGtYKEgEsN
        JUGJemADAD2/E+wo9QrBhoK4XV15IL1JrneFzz4=
X-Google-Smtp-Source: ACHHUZ7foY3qa/lhqYHWPYHMFlohzn9HpC6fAXvaMf+7yCEBoT61d9qAeve6bzo5KVOanK3QJkSnBqMm1TSgd6J5wmk=
X-Received: by 2002:a17:906:738a:b0:94a:5f0d:d9d6 with SMTP id
 f10-20020a170906738a00b0094a5f0dd9d6mr2120242ejl.4.1682614323815; Thu, 27 Apr
 2023 09:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230424-acpi-prop-v1-1-ffa9a300b1cd@marcan.st>
In-Reply-To: <20230424-acpi-prop-v1-1-ffa9a300b1cd@marcan.st>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Apr 2023 18:51:52 +0200
Message-ID: <CAJZ5v0hGyiUztmKkhZe9Hp4jaS0_iyOgnpVBRv8SLAre2nTOmw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / property: Support strings in Apple _DSM props
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.kernel.dev,
        Lukas Wunner <lukas@wunner.de>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 8:47 AM Hector Martin <marcan@marcan.st> wrote:
>
> The Wi-Fi module in x86 Apple machines has a "module-instance" device
> property that specifies the platform type and is used for firmware
> selection. Its value is a string, so add support for string values in
> acpi_extract_apple_properties().
>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/acpi/x86/apple.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/x86/apple.c b/drivers/acpi/x86/apple.c
> index 8812ecd03d55..45d0f16f374f 100644
> --- a/drivers/acpi/x86/apple.c
> +++ b/drivers/acpi/x86/apple.c
> @@ -71,13 +71,16 @@ void acpi_extract_apple_properties(struct acpi_device *adev)
>
>                 if ( key->type != ACPI_TYPE_STRING ||
>                     (val->type != ACPI_TYPE_INTEGER &&
> -                    val->type != ACPI_TYPE_BUFFER))
> +                    val->type != ACPI_TYPE_BUFFER &&
> +                    val->type != ACPI_TYPE_STRING))
>                         continue; /* skip invalid properties */
>
>                 __set_bit(i, valid);
>                 newsize += key->string.length + 1;
>                 if ( val->type == ACPI_TYPE_BUFFER)
>                         newsize += val->buffer.length;
> +               else if (val->type == ACPI_TYPE_STRING)
> +                       newsize += val->string.length + 1;
>         }
>
>         numvalid = bitmap_weight(valid, numprops);
> @@ -119,6 +122,12 @@ void acpi_extract_apple_properties(struct acpi_device *adev)
>                 newprops[v].type = val->type;
>                 if (val->type == ACPI_TYPE_INTEGER) {
>                         newprops[v].integer.value = val->integer.value;
> +               } else if (val->type == ACPI_TYPE_STRING) {
> +                       newprops[v].string.length = val->string.length;
> +                       newprops[v].string.pointer = free_space;
> +                       memcpy(free_space, val->string.pointer,
> +                              val->string.length);
> +                       free_space += val->string.length + 1;
>                 } else {
>                         newprops[v].buffer.length = val->buffer.length;
>                         newprops[v].buffer.pointer = free_space;
>
> ---

Applied as 6.4-rc material, thanks!
