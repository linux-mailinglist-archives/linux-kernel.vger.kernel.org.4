Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355B36D0C62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjC3RL7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 13:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjC3RLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:11:54 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96581EC43;
        Thu, 30 Mar 2023 10:11:45 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id x3so79163266edb.10;
        Thu, 30 Mar 2023 10:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCMgmjS8UFODcJkt3kQqePHkaAGXDwpBFfXsthPJWVE=;
        b=6AqLo7oyinTlwYtuBjkTD2rmHnp/tTidJhQQBP+82ypMWw6nkItfazgxyFEYxxB8Zc
         P/EkyO/Gk0kGNFUY7dFlGuevUhGsyJF//AOUvAghdh4qbWpg+J2NQuvdUL67sUUWjeKj
         TRSXJHCBpdg6MOJV6HOsu9/XobeynCoAvCLw36VbpyhJJOUd2Fc9VudIo/zRK3riWaoG
         UnOdsjcD/OveAiIwpk+3buDoDSljp6+SMIekoWvsJlkiv7hNAKMvitVnwP0XE2T7OjeJ
         Aa0w5i21JPPchL1K6t9BTpWDtOyQP+jZuxf75KvSKT6MZUKCa7ewPdH9PAwoaKFy9qXO
         0QBA==
X-Gm-Message-State: AAQBX9fqZ/blFWaFNYxEAtpPhFDG3/RLDxqDRF4JnapcUITyrZ0rTQAf
        G0qwwE60e+0ELgHhajhzxkx4g2OdjhmbtMmMH30=
X-Google-Smtp-Source: AKy350YBLRVolaiG33XGszgunLQdNg89+CaDaO897cYvuvF61kL6SrANpgugsvFce4XT0ADWSXp1bAr/WzCrjymkPxw=
X-Received: by 2002:a50:9fe3:0:b0:502:62ba:865b with SMTP id
 c90-20020a509fe3000000b0050262ba865bmr3180693edf.3.1680196303944; Thu, 30 Mar
 2023 10:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230328031629.202268-1-yijiangshan@kylinos.cn>
In-Reply-To: <20230328031629.202268-1-yijiangshan@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Mar 2023 19:11:32 +0200
Message-ID: <CAJZ5v0hPbH9BMOLbrGOKcy1sGAXbq=7OTyFECA966i37wBp_AQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: replace ternary operator with min_t()
To:     Jiangshan Yi <yijiangshan@kylinos.cn>
Cc:     rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        13667453960@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 5:17 AM Jiangshan Yi <yijiangshan@kylinos.cn> wrote:
>
> Fix the following coccicheck warning:

This is not a fix, because the current code is correct AFAICS.

It merely makes the code follow the coccicheck recommendation, which
is a cleanup (although arguably a good one).

But because the new code is way more readable, I've applied this as
6.4 material (with edits in the changelog).

Thanks!

> drivers/acpi/thermal.c:422: WARNING opportunity for min().
>
> min_t() macro is defined in include/linux/minmax.h. It avoids multiple
> evaluations of the arguments when non-constant and performs strict
> type-checking.
>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/acpi/thermal.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 0b4b844f9d4c..179f41196a9d 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -419,10 +419,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>                                          * the next higher trip point
>                                          */
>                                         tz->trips.active[i-1].temperature =
> -                                               (tz->trips.active[i-2].temperature <
> -                                               celsius_to_deci_kelvin(act) ?
> -                                               tz->trips.active[i-2].temperature :
> -                                               celsius_to_deci_kelvin(act));
> +                                               min_t(unsigned long,
> +                                                     tz->trips.active[i-2].temperature,
> +                                                     celsius_to_deci_kelvin(act));
>
>                                 break;
>                         } else {
> --
> 2.25.1
>
