Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE84C60DFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiJZLpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiJZLok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:44:40 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC58B2B613;
        Wed, 26 Oct 2022 04:43:03 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id z30so10225695qkz.13;
        Wed, 26 Oct 2022 04:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tl9nR4GMW6r2dLuSUcarGjhqkbCJxYfVIXMRlGPM/34=;
        b=2bw5ngfSfHo80lWXEv4dd8u7Ok9wywPAGhwkbFcxmVYwGGIjFzltvJr9ct0L9lB446
         CGxJN0uLcQ2L+2tmfdUwflspMQqsSFsszqQohZW0P7jySPzzBG92e1fyfvzpDTOjGUyl
         dhDiTJEoQZez1eV8vJSCHeBToTNrusLh61dGzSkv58ewtZhGT1osZ7z6zDFPwpjApgb8
         VLoMOiSDiznh0tRUiU3IUcHW/QiP7n+MQCutWuGRwrhYI6toRMI6Wdfe+APZQzjz0gvS
         PlmkQ358VOGECu02Rhs3eSDG+2GJx4N4WynHDvX4zIfGt4KzSvivEouv5o+/6a7GO8II
         xUiw==
X-Gm-Message-State: ACrzQf20/x4uDq8VRVTbQkVacNTiv7y22QxBIoR/18v1aTqBmHQCOUTb
        zti5Stg1gjDYaFF8LD3s1vWw0lGopKirbrOoq/Y=
X-Google-Smtp-Source: AMsMyM7gtxf2B9qfZMOPfJBOlRo3C74Hbcq1gakwCkrfMDXZOqh7WuwP9LPWRocNnWlUaUllGLEBH2I5stmqQgNqinc=
X-Received: by 2002:a05:620a:4547:b0:6ee:dc16:d67a with SMTP id
 u7-20020a05620a454700b006eedc16d67amr30609504qkp.23.1666784583126; Wed, 26
 Oct 2022 04:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221014051931.155483-1-tamim@fusetak.com>
In-Reply-To: <20221014051931.155483-1-tamim@fusetak.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Oct 2022 13:42:50 +0200
Message-ID: <CAJZ5v0hgm2REg6cxy3cdnETpt0G-cnH5JH0X8FqS8XtTzttZyg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook S5602ZA
To:     Tamim Khan <tamim@fusetak.com>
Cc:     linux-acpi@vger.kernel.org, lenb@kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Dzmitry <wrkedm@gmail.com>
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

On Fri, Oct 14, 2022 at 7:22 AM Tamim Khan <tamim@fusetak.com> wrote:
>
> Like the Asus Vivobook K3402ZA/K3502ZA/S5402ZA Asus Vivobook S5602ZA
> has an ACPI DSDT table the describes IRQ 1 as ActiveLow while the kernel
> overrides it to Edge_High. This prevents the keyboard on this laptop
> from working. To fix this add this laptop to the skip_override_table so
> that the kernel does not override IRQ 1.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216579
> Tested-by: Dzmitry <wrkedm@gmail.com>
> Signed-off-by: Tamim Khan <tamim@fusetak.com>
> ---
> This patch is similar to e12dee3736731e24b1e7367f87d66ac0fcd73ce7
> (ACPI: resource: Skip IRQ override on Asus Vivobook K3402ZA/K3502Z) and
> 6e5cbe7c4b41824e500acbb42411da692d1435f1 (ACPI: resource: Add ASUS model
> S5402ZA to quirks) and just adds another Asus Vivobook that has the
> same IRQ override problem
>
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 6f9489edfb4e..0270421d12db 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -425,6 +425,13 @@ static const struct dmi_system_id asus_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "S5402ZA"),
>                 },
>         },
> +       {
> +               .ident = "Asus Vivobook S5602ZA",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
> +               },
> +       },
>         { }
>  };
>
> --

Applied as 6.1-rc material, thanks!
