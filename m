Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599E0640CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiLBSEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiLBSEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:04:46 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2DAF030;
        Fri,  2 Dec 2022 10:04:45 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id fp23so5983684qtb.0;
        Fri, 02 Dec 2022 10:04:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSNlZGuxFTjHy+mvg3CfUFdIORUFrFfti24llF9FbFQ=;
        b=0IV4vn/oXs4ALuugcY4yr/nP5RPtEiHYsmlMIhoL/+aZAMNdIltNBnTal+l882DwCP
         zWaKWDMso8dKunP90Y8XPpsHq4kh4MB0qMakg2GoQscxizYlF+PcL0QHPF5ZGeU1FWF0
         xzAru3p3AmVZbavIFkRHHhGBhMpkIoV0CHiQsbnaPUyKPKYEHYfuM3cyclU/c0q5rQ5O
         PwCuw3M/Hz1rIGB/GbNCF4e8xerNkntVmzg+1OE9gF/QFX+PD/ukRdtrcPm1ypiu8MVq
         2g8bdVZRReQKuvkMIgRFaDF8vQxeK7oIGklIWV7LddtRxWRINNTtwtnqk7+5UZVWbMTL
         iP1w==
X-Gm-Message-State: ANoB5pkgz+cRX7X9BDVEfubA5Oqlad0laxcQH7iQhC2PnUdNlHNlUihg
        JH+cWoJgIlBzN6oTk1HtKuuI9ZxPY65Cfb/AmgA=
X-Google-Smtp-Source: AA0mqf4p11RLa3BDka7CrWRvSwFgbHNRA7OcIY7yBU9aPOKL2QvM8JsP0dPjrxTZjAZzs63/lQYxns31puKNubhq+wY=
X-Received: by 2002:ac8:7dcb:0:b0:3a6:8dd0:4712 with SMTP id
 c11-20020ac87dcb000000b003a68dd04712mr11252979qte.411.1670004284736; Fri, 02
 Dec 2022 10:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20221202153454.83185-1-bart@gpxbv.nl>
In-Reply-To: <20221202153454.83185-1-bart@gpxbv.nl>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 19:04:33 +0100
Message-ID: <CAJZ5v0hCa75oSXUsTyr5XWx6TftjwGA2qqzve3KO_YVh-Y3owQ@mail.gmail.com>
Subject: Re: [PATCH] acpi: allow usage of acpi_tad without PRW
To:     "Bart Groeneveld | GPX Solutions B.V" <bart@gpxbv.nl>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Dec 2, 2022 at 4:36 PM Bart Groeneveld | GPX Solutions B.V
<bart@gpxbv.nl> wrote:
>
> From: "Bart Groeneveld | GPX Solutions B.V." <bart@gpxbv.nl>
>
> Not all tads have the PRW capability, which is totally OK,
> according to the ACPI spec [1]:
>
> > _PRW is only required for devices that have the ability to wake
> > the system from a system sleeping state.

No, the ACPI TAD definition in Section 9.17 (ACPI 6.5) specifically
requires _PRW to be present unless the system is hardware-reduced.

Anyway, the RTC part can still be supported without _PRW, but then the
wakeup-related attributes should not be present in such cases.

> This partially solves [2] and [3].
>
> [1]: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_4_Jan22.pdf
> [2]: https://bugzilla.kernel.org/show_bug.cgi?id=212313
> [3]: https://github.com/linux-surface/linux-surface/issues/415
>
> Signed-off-by: Bart Groeneveld | GPX Solutions B.V. <bart@gpxbv.nl>
> ---
>  drivers/acpi/acpi_tad.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index e9b8e8305e23..67f71fa4362f 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -604,11 +604,6 @@ static int acpi_tad_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>
> -       if (!acpi_has_method(handle, "_PRW")) {
> -               dev_info(dev, "Missing _PRW\n");
> -               return -ENODEV;
> -       }
> -

This may be sufficient for the RTC part alone to work, but making the
wakeup-related attributes available doesn't really make sense in the
_PRW absent case, so they all should be made optional.

>         dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
>         if (!dd)
>                 return -ENOMEM;
> --
