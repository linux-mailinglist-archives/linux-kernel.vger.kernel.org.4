Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582D26664A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjAKUOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjAKUO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:14:27 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193B26D6;
        Wed, 11 Jan 2023 12:14:23 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id jo4so39709125ejb.7;
        Wed, 11 Jan 2023 12:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azhtcREvUE7KG7kPLSNOtB+brYZtna3TNYPfxBJ8KYs=;
        b=JLtfjb9ZlEOBfWujPIFAACt5f/PIKNPGW6cxGn32LlFHwu4zRtkMyMvn6b2tkFe4vB
         RDbT3cHBzJbC8N+JNkkwAeQCzUtfzL1mm71yazfUi3unwF5edmafHIKjEdqR8J0czbBF
         X6iyqsLh7JalxuE6a+c5QTOvbD9OEYdgIH+IZUxI658V/857EL+rL1h3ydY5Wn2J8Zq2
         0zarL8r9WGQqd3pX/uuMtb5MBAqmjT0EhKrOKR5kGbrhU27yID0sNN1eRS85vEl+qpo3
         QOd7WvHwHgxE75Io6pjJFJQPjLuI9jzsa0kKZMx78Bgi1Tn67VCCZ4lXCZDvxrgzPJ1f
         3Hjg==
X-Gm-Message-State: AFqh2kqhpmpAfh8NRhhEJb7TE9k2lktpX0L0yyQVE/xzoBertl50pYra
        Z+MJziS/MTXEAUQOi5iIoyvZfKgXEi3IuTt9BNo=
X-Google-Smtp-Source: AMrXdXtqunNT1d7ZCF/ShS8QGcnfLpwrN/qjJhiR70gKaVR0KjHcM0TDrouu+VHu+GlD3gV2B22zSJ3+4mvaYJzQKPY=
X-Received: by 2002:a17:907:29c3:b0:84d:4b8e:efc with SMTP id
 ev3-20020a17090729c300b0084d4b8e0efcmr879112ejc.390.1673468062061; Wed, 11
 Jan 2023 12:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20221230055839.80885-1-tamim@fusetak.com>
In-Reply-To: <20221230055839.80885-1-tamim@fusetak.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 21:14:10 +0100
Message-ID: <CAJZ5v0ikQN=C966p3Fm=HTRGfeWimjgCps9aqAp0UBHRQ5Xt9g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Expertbook B2402CBA
To:     Tamim Khan <tamim@fusetak.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        linux-kernel@vger.kernel.org, zelenat <zelenat@gmail.com>
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

On Fri, Dec 30, 2022 at 6:59 AM Tamim Khan <tamim@fusetak.com> wrote:
>
> Like the Asus Expertbook B2502CBA and various Asus Vivobook laptops,
> the Asus Expertbook B2402CBA has an ACPI DSDT table that describes IRQ 1
> as ActiveLow while the kernel overrides it to Edge_High. This prevents the
> keyboard from working. To fix this issue, add this laptop to the
> skip_override_table so that the kernel does not override IRQ 1.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216864
> Tested-by: zelenat <zelenat@gmail.com>
> Signed-off-by: Tamim Khan <tamim@fusetak.com>
> ---
> This patch is very similar to 7203481fd12b1257938519efb2460ea02b9236ee
> (ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks) and just adds
> another ExpertBook that has the same IRQ override problem to the quirks list.
>
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 16dcd31d124f..153e3f8b446f 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -432,6 +432,13 @@ static const struct dmi_system_id asus_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
>                 },
>         },
> +       {
> +               .ident = "Asus ExpertBook B2402CBA",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
> +               },
> +       },
>         {
>                 .ident = "Asus ExpertBook B2502",
>                 .matches = {
> --

Applied as 6.2-rc material, thanks!
