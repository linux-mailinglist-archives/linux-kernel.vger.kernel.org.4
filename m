Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB8C62C8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiKPTFY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Nov 2022 14:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKPTFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:05:21 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B137F58BCC;
        Wed, 16 Nov 2022 11:05:20 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id x18so12327060qki.4;
        Wed, 16 Nov 2022 11:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA8iKCKn4O1Q18CU0TSTND69z7YWyz51vYHXQhnNEd4=;
        b=mqpsawtTaxfglQR1WzIaQnAETUFwcNaI34vBQleLqqrj70glDRjAzTPgHz+Vid1pvk
         D8TtgUWTAVH+jehesClh0lq9EBDJz+WFSxrrimHfEAk7bR4mej290/D4CcYNeiWUlUIM
         z0j+bniijgeKRsDtW+Ev78WTsJrNf4HX2Rq/xRNKRMqUIqrwoNqgiZgjf9MckktWxD4p
         2m0GpStRSeq+iKge4L1F5QZBAiOSy7TZY3HoRNqFz2hO6587w3eqbCEsmsQPLI8upMUZ
         KsPS4QBrUNgMq8VDDxkpWYnGis/nZWa4C1m/VHmCwounfzrBV4xhwz2oXCo3lzBSM6rm
         oAhg==
X-Gm-Message-State: ANoB5pmkKS1Jhq8Lw7vhjO4Qm65Etu2VKtdmhhpxThGpUMmspvWjrig/
        C/EO+rPTQQIhydMbg3i7C30NRF4CKh7n6pHBLn8=
X-Google-Smtp-Source: AA0mqf6i2onAqra3g5dliKGfix1fSmbBTMqBTqTzX46H+0vpXmMPcKcyPUWNaPCtOwyZp5WDQjCMMABQ1+jtSclRb1I=
X-Received: by 2002:a05:620a:b15:b0:6fa:af7e:927c with SMTP id
 t21-20020a05620a0b1500b006faaf7e927cmr19935437qkg.443.1668625519821; Wed, 16
 Nov 2022 11:05:19 -0800 (PST)
MIME-Version: 1.0
References: <20221116152258.28772-1-skhan@linuxfoundation.org>
In-Reply-To: <20221116152258.28772-1-skhan@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Nov 2022 20:05:08 +0100
Message-ID: <CAJZ5v0jsSmfMAdtTfhGxD7LP0WoCT8sSeCJ6BRY3ncRuj4yTmQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix sprintf() INT_MAX -Wformat-truncation= warn
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 4:23 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> utprint module is included in tools/acpidump and when acpidump is built,
> the following warning occurs.
>
>  CC       tools/acpidump/utprint.o
> /usr/include/x86_64-linux-gnu/bits/stdio2.h: In function ‘sprintf’:
> ../../../../../drivers/acpi/acpica/utprint.c:602:18: warning: specified bound 4294901760 exceeds ‘INT_MAX’ [-Wformat-truncation=]
>   602 |         length = vsnprintf(string, ACPI_UINT32_MAX-ACPI_UINT16_MAX,
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   603 |                         format, args);
>       |                         ~~~~~~~~~~~~~
>
> Fix sprintf() to use ACPI_UINT32_MAX/2 to get rid of the truncate problem.
> This change is inline other sprintf() implementations.
>
> If using ACPI_UINT32_MAX is necessary in the kernel, acpidump might require
> special case to get rid of this truncate problem.

As ACPICA material, this should be submitted to the upstream project
on GitHub and honestly I'm not sure if it is going to be resolved this
way there.

> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/acpi/acpica/utprint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
> index d5aa2109847f..02cff16c8f77 100644
> --- a/drivers/acpi/acpica/utprint.c
> +++ b/drivers/acpi/acpica/utprint.c
> @@ -599,7 +599,7 @@ int sprintf(char *string, const char *format, ...)
>         int length;
>
>         va_start(args, format);
> -       length = vsnprintf(string, ACPI_UINT32_MAX, format, args);
> +       length = vsnprintf(string, ACPI_UINT32_MAX/2, format, args);
>         va_end(args);
>
>         return (length);
> --
> 2.34.1
>
