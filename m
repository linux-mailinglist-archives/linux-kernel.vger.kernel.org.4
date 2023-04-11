Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6AD6DE45D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDKSyY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 14:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDKSyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:54:21 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E59558B;
        Tue, 11 Apr 2023 11:54:19 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id dm2so23000475ejc.8;
        Tue, 11 Apr 2023 11:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681239258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4sDlaAqhvNysrKAM2xiktRjb3nWENL9FOHGuHRar+k=;
        b=WbFSEJdKAA0kDYyzTzxkQhzhUOUTJNGxoWUFzlEx7XS1Thkncmjy+8mlHQ27e9Wetu
         57Ei17qs7IKxRKrVWBzXcN/hPydA+tRel170GK4o7CnsKg42kAiwzrVxg+gp9hayQ/Om
         fQ9Un5qouxqpDvSSKyXBfjIkwbAGShwTU8hpfI1afnZai2tvao4ID4WVH/rKfp9g3qtg
         8pjgSRwIE6uT9JGOdOwlipJ7UPIftP8XowJcYPGuPYnVjHO+fX+zFmRYJ6uPI4phW6B3
         1TfDEKD8f3jzaBr3CgrsIKXE7NI2nJBvNrxmq1VhNPZukqJMcEQugsgBr0Iqtxx8D9hl
         10mQ==
X-Gm-Message-State: AAQBX9dV0NibdzrLb863Lj8xjNymwGeBZzqSG1NEwQ7yLsgEDWKmfqaE
        PtUn0nXCT1kibx/wllsCUtKIKy3dGdYrmJhXBkI9i4En
X-Google-Smtp-Source: AKy350bQ4dy15N9Thf6G6/SVmVqW42B1BAnNkqNB9HpbL1DOl2z8zAqczCGktsApBM+OL29mEeGQa64OBmo3ymUJ4Ao=
X-Received: by 2002:a17:907:8a0e:b0:94e:7ce:4d1f with SMTP id
 sc14-20020a1709078a0e00b0094e07ce4d1fmr1950390ejc.2.1681239258238; Tue, 11
 Apr 2023 11:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230411183144.6932-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20230411183144.6932-1-pmenzel@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Apr 2023 20:54:07 +0200
Message-ID: <CAJZ5v0hbWerXrBG0K20xHEOajhYunqxNs+R6awA03tYpCwRKKg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CBA
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, lore982@yahoo.com,
        Tamim Khan <tamim@fusetak.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 8:32 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Like the ASUS ExpertBook B2502CBA and various ASUS Vivobook laptops, the
> ASUS ExpertBook B1502CBA has an ACPI DSDT table that describes IRQ 1 as
> ActiveLow while the kernel overrides it to Edge_High.
>
>     $ sudo dmesg | grep DMI
>     DMI: ASUSTeK COMPUTER INC. ASUS EXPERTBOOK B1502CBA_B1502CBA/B1502CBA, BIOS B1502CBA.300 01/18/2023
>     $ grep -A 40 PS2K dsdt.dsl | grep IRQ -A 1
>                     IRQ (Level, ActiveLow, Exclusive, )
>                         {1}
>
> This prevents the keyboard from working. To fix this issue, add this laptop
> to the skip_override_table so that the kernel does not override IRQ 1.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217323
> Cc: lore982@yahoo.com
> Cc: Tamim Khan <tamim@fusetak.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index a222bda7e15b..cade3a9e38bb 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -432,6 +432,13 @@ static const struct dmi_system_id asus_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
>                 },
>         },
> +       {
> +               .ident = "Asus ExpertBook B1502CBA",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
> +               },
> +       },
>         {
>                 .ident = "Asus ExpertBook B2402CBA",
>                 .matches = {
> --

Applied as 6.3-rc material, thanks!
