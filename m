Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E25B4774
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 18:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIJQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 12:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIJQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 12:17:30 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3348EA4;
        Sat, 10 Sep 2022 09:17:29 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-324ec5a9e97so52275347b3.7;
        Sat, 10 Sep 2022 09:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=03ngtYqYEXolKu6SgaLeTLYIPRaT5PUq8tMj9qg+G+I=;
        b=VahRpgtK1G6BOqLEK+b+GueRalhAh9l5kapJYSE3U/V26pWHsZSt8cVEWRUUiUJc9l
         SAD2tNpCe5rqfPXAw1hQRGexVRhSRiEIvrNykfcNEx+FPlC90zhIZ3Ir+WLJ5qu9PvQW
         Ck9CfXDB6+fAibaLRIsa9/7VmUZioRQKnVGovIg6SI9Abxi2JCJSTR34LJlYD9OT5Ooa
         uw9pRqeJYqNAbVeaffJzxpV1FeX5nFY4tjUAbLT/kPVKWCRlMlvESp0ymu93VytIGq2M
         Spd55bP1Gg2K8AFlULwCRZNecTcwpmBIS3vEIFSASoR+ldWU8zkoujv4ERQCG6k9iy/0
         Mxrw==
X-Gm-Message-State: ACgBeo2WBKdurp+ejJywIYXXjW9mADLzmcXaE2jufV0i+0Q01DB58vPI
        N0I8Db9QhQ0t2xZQjGwdMIiV/LCEJCPnPciSnKUFj03BAVE=
X-Google-Smtp-Source: AA6agR6v62pnEPxkAGr4xlxx7njz6TcGp5QQC3n1gAUT4PKCiUpCdOOVfffdXLpLRmac2uOMJ64ECiF6X/j2Pt6Y33c=
X-Received: by 2002:a0d:cdc2:0:b0:335:debd:2b3d with SMTP id
 p185-20020a0dcdc2000000b00335debd2b3dmr15704201ywd.19.1662826648749; Sat, 10
 Sep 2022 09:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220902074144.2209674-1-floridsleeves@gmail.com>
In-Reply-To: <20220902074144.2209674-1-floridsleeves@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 10 Sep 2022 18:17:17 +0200
Message-ID: <CAJZ5v0jXjmgV8vAVgJzVfmPKFXOPbeXYojxOnqKQu4wukFSt-A@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/acpi/acpi_video: check return value of acpi_get_parent()
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 9:42 AM Li Zhong <floridsleeves@gmail.com> wrote:
>
> Check return status of acpi_get_parent() to confirm whether it fails.
>
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/acpi/acpi_video.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 5cbe2196176d..5fca9a39b1a4 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> +       // SPDX-License-Identifier: GPL-2.0-or-later

This change surely is not intended?

>  /*
>   *  video.c - ACPI Video Driver
>   *
> @@ -1753,6 +1753,7 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
>         int result;
>         static int count;
>         char *name;
> +       acpi_status status;
>
>         result = acpi_video_init_brightness(device);
>         if (result)
> @@ -1766,8 +1767,9 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
>                 return;
>         count++;
>
> -       acpi_get_parent(device->dev->handle, &acpi_parent);
> -
> +       status = acpi_get_parent(device->dev->handle, &acpi_parent);
> +       if (ACPI_FAILURE(status))
> +               return;

But device->dev->handle is known to be valid, so the only case in
which acpi_get_parent() above can fail is when the given namespace
object has no parent, in which case acpi_parent will be NULL, so that
should be caught my the check below, shouldn't it?

>         pdev = acpi_get_pci_dev(acpi_parent);
>         if (pdev) {
>                 parent = &pdev->dev;
> --
