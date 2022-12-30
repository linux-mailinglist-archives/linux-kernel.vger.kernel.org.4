Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB2C659B18
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiL3Rul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiL3Rui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:50:38 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C621A380;
        Fri, 30 Dec 2022 09:50:37 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id z10so3341016ilq.8;
        Fri, 30 Dec 2022 09:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IEfMatbjzZlz8Idd3KgEL3jiVKDqXFTfbe1i1sqjtY=;
        b=nGENo+jauz2Caj09xgXKeTbXidScM0KbwApr0uhTwFCYpuzb50beOQXAwxYNbpAebn
         LIUm5DMmhh2Cg1bNrPXxUY9mucY+hgPva53xeRfnl9T2Tfl6RrYBy9jT3XhhKD9euh0q
         ZPuYpQLdFnFMWtK4ChUb7LPRl/bQUB2aO4fGhK19zXe12i/dVS3MERsaOUQPGmnsTxUZ
         /Ohzz7nEGEW1fV3BwwyHabyvXlD6sW4QNAyk8/PjypkgVxXB6hbKgABEf9simF2GbP6b
         2FVsR6Z9TmjGsgN91SZIQeiJ58OhL5PMDrQ84cqgp7mX5/F0B5fo+zy3DvHEo5Uue9tz
         h4dQ==
X-Gm-Message-State: AFqh2krje6XCqHWLJMOyWbmO7kkgWqj8cgj9mB/8/wZdKXfccsFS46LP
        82P8mFVJcaONp0XHiH1fxoRCnXi8/LXY3oibqbs=
X-Google-Smtp-Source: AMrXdXt+ZInYlM52yCvJPZfD+On4paDXqxx3zOvPsUhY0Nab/7GCaCvBg1HOUehcaYL8JniIUA7hEBG2FZp7dx1uOFA=
X-Received: by 2002:a92:d988:0:b0:30c:2ff1:ae45 with SMTP id
 r8-20020a92d988000000b0030c2ff1ae45mr403731iln.131.1672422636513; Fri, 30 Dec
 2022 09:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20221215155120.2276-1-mario.limonciello@amd.com>
In-Reply-To: <20221215155120.2276-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 18:50:24 +0100
Message-ID: <CAJZ5v0j2AxY48wg9BnSev86d1Sg2poxVyOHdPjrfEGLQvLyCYg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Drop port I/O validation for some regions
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lin Ming <ming.m.lin@intel.com>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 4:51 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Microsoft introduced support in Windows XP for blocking port I/O
> to various regions.  For Windows compatibility ACPICA has adopted
> the same protections and will disallow writes to those
> (presumably) the same regions.
>
> On some systems the AML included with the firmware will issue 4 byte
> long writes to 0x80.  These writes aren't making it over because of this
> blockage. The first 4 byte write attempt is rejected, and then
> subsequently 1 byte at a time each offset is tried. The first at 0x80
> works, but then the next 3 bytes are rejected.
>
> This manifests in bizarre failures for devices that expected the AML to
> write all 4 bytes.  Trying the same AML on Windows 10 or 11 doesn't hit
> this failure and all 4 bytes are written.
>
> Either some of these regions were wrong or some point after Windows XP
> some of these regions blocks have been lifted.
>
> In the last 15 years there doesn't seem to be any reports popping up of
> this error in the Windows event viewer anymore.  There is no documentation
> at Microsoft's developer site indicating that Windows ACPI interpreter
> blocks these regions. Between the lack of documentation and the fact that
> the writes actually do work in Windows 10 and 11, it's quite likely
> Windows doesn't actually enforce this anymore.
>
> So to help the issue, only enforce Windows XP specific entries if the
> latest _OSI supported is Windows XP. Continue to enforce the
> ALWAYS_ILLEGAL entries.
>
> Link: https://github.com/acpica/acpica/pull/817
> Fixes: 7f0719039085 ("ACPICA: New: I/O port protection")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/acpica/hwvalid.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
> index 915b26448d2c..0d392e7b0747 100644
> --- a/drivers/acpi/acpica/hwvalid.c
> +++ b/drivers/acpi/acpica/hwvalid.c
> @@ -23,8 +23,8 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width);
>   *
>   * The table is used to implement the Microsoft port access rules that
>   * first appeared in Windows XP. Some ports are always illegal, and some
> - * ports are only illegal if the BIOS calls _OSI with a win_XP string or
> - * later (meaning that the BIOS itelf is post-XP.)
> + * ports are only illegal if the BIOS calls _OSI with nothing newer than
> + * the specific _OSI strings.
>   *
>   * This provides ACPICA with the desired port protections and
>   * Microsoft compatibility.
> @@ -145,7 +145,8 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
>
>                         /* Port illegality may depend on the _OSI calls made by the BIOS */
>
> -                       if (acpi_gbl_osi_data >= port_info->osi_dependency) {
> +                       if (port_info->osi_dependency == ACPI_ALWAYS_ILLEGAL ||
> +                           acpi_gbl_osi_data == port_info->osi_dependency) {
>                                 ACPI_DEBUG_PRINT((ACPI_DB_VALUES,
>                                                   "Denied AML access to port 0x%8.8X%8.8X/%X (%s 0x%.4X-0x%.4X)\n",
>                                                   ACPI_FORMAT_UINT64(address),
> --

Applied as 6.3 material, thanks!
