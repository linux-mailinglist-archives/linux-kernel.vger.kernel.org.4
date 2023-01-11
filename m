Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CD16664A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjAKUPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjAKUPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:15:10 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FCFB6A;
        Wed, 11 Jan 2023 12:15:08 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id gh17so39740746ejb.6;
        Wed, 11 Jan 2023 12:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sghTIEgreaXF5UzDGON1scQuNrZYlIWs9BXZ0rZ8Sk=;
        b=UhbihVEbLervRiJMnPTXajSrKgdp4JJr5k6WeigQu4bxNf+LxaLZj1c7LaNf/gXxxM
         j2fbbgjAaaMMMxfUDqT52naoysTMXIlJ84oyaEh/tiXkmxgDYdbPqS5Iy9dMfnfWIqeu
         hekMCk43Iq6KupE2Rpkp2VIkOJK6btVjnukaROZJdc5NhKuz6w1Da6TIO6hEWqXyNFYU
         Gc2mkhwQLYmgXxT9am3bAYuM9OZtNJ0UA3FwGe/YaOWNP8kHnBAXw94ZPVp2UO+OjGPP
         Qes2GmjP0YqAswOwmESFwugC+91N+HtQR7NepUnLYvGSCE7MYFcFmuLf2XcRK7u+27nS
         jYHA==
X-Gm-Message-State: AFqh2kq9NopqBw0aS8dBdDKue6LUIkMeBSaokRBRUPVmoddUlw/5QRXy
        cXs9el1soIcLe7MlqEIg4GOZKO0lNuhZbt0Q3tQ=
X-Google-Smtp-Source: AMrXdXsi1h2Dg4p4Ligs+NfvJLXWv52gI/i1dCmWvrFzunVhVRYh6eUKJarICVWp1SkiL3ReRzAOJeKC1qUNbeOwD+k=
X-Received: by 2002:a17:907:8d0e:b0:7b2:7b45:2cd2 with SMTP id
 tc14-20020a1709078d0e00b007b27b452cd2mr6499649ejc.615.1673468107048; Wed, 11
 Jan 2023 12:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20230106235308.99999-1-d-tatianin@yandex-team.ru>
In-Reply-To: <20230106235308.99999-1-d-tatianin@yandex-team.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 21:14:55 +0100
Message-ID: <CAJZ5v0goj3DYEbVa5PkeFBtNNvYb0wJU_dwooWdxgEyrT8yZqQ@mail.gmail.com>
Subject: Re: [PATCH v0] ACPICA: nsrepair: handle cases without a return value correctly
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
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

On Sat, Jan 7, 2023 at 12:54 AM Daniil Tatianin
<d-tatianin@yandex-team.ru> wrote:
>
> Previously acpi_ns_simple_repair() would crash if expected_btypes
> contained any combination of ACPI_RTYPE_NONE with a different type,
> e.g | ACPI_RTYPE_INTEGER because of slightly incorrect logic in the
> !return_object branch, which wouldn't return AE_AML_NO_RETURN_VALUE
> for such cases.
>
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
>
> Link: https://github.com/acpica/acpica/pull/811
> Fixes: 61db45ca2163 ("ACPICA: Restore code that repairs NULL package elements in return values.")
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  drivers/acpi/acpica/nsrepair.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
> index 367fcd201f96..ec512e06a48e 100644
> --- a/drivers/acpi/acpica/nsrepair.c
> +++ b/drivers/acpi/acpica/nsrepair.c
> @@ -181,8 +181,9 @@ acpi_ns_simple_repair(struct acpi_evaluate_info *info,
>          * Try to fix if there was no return object. Warning if failed to fix.
>          */
>         if (!return_object) {
> -               if (expected_btypes && (!(expected_btypes & ACPI_RTYPE_NONE))) {
> -                       if (package_index != ACPI_NOT_PACKAGE_ELEMENT) {
> +               if (expected_btypes) {
> +                       if (!(expected_btypes & ACPI_RTYPE_NONE) &&
> +                           package_index != ACPI_NOT_PACKAGE_ELEMENT) {
>                                 ACPI_WARN_PREDEFINED((AE_INFO,
>                                                       info->full_pathname,
>                                                       ACPI_WARN_ALWAYS,
> @@ -196,14 +197,15 @@ acpi_ns_simple_repair(struct acpi_evaluate_info *info,
>                                 if (ACPI_SUCCESS(status)) {
>                                         return (AE_OK); /* Repair was successful */
>                                 }
> -                       } else {
> +                       }
> +
> +                       if (expected_btypes != ACPI_RTYPE_NONE) {
>                                 ACPI_WARN_PREDEFINED((AE_INFO,
>                                                       info->full_pathname,
>                                                       ACPI_WARN_ALWAYS,
>                                                       "Missing expected return value"));
> +                               return (AE_AML_NO_RETURN_VALUE);
>                         }
> -
> -                       return (AE_AML_NO_RETURN_VALUE);
>                 }
>         }
>
> --

Applied as 6.3 material, thanks!
