Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1398640E96
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiLBTgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiLBTgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:36:48 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF951F3FBD;
        Fri,  2 Dec 2022 11:36:47 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id d13so4076009qvj.8;
        Fri, 02 Dec 2022 11:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nxgo4hIVKl7dVdEPq4431GgDimW+AKvY+vGScoQXnqw=;
        b=U9zahFSqZefGJQYQKFVbPOyn5XgDusbYPxZ/1a/DivRaHB3eHaqSLFZgAAySaSVQj2
         8GuduE9DRQVqaoKm1O9fjbD8VLiD06tSAFefP/560sILcVagiKUnJWi1gu6wnuQMfn1E
         t8ltoKa7uvb66yCua0l4u3rmWIk4xuPB8CJ44nIhOsJGI/CFGG5aeqw07yDYD0v6yDdA
         9Tp1gh9KVgGjZC2JkV0WAUvlCF9N2sur71K9VKqnQI3Zq+6awGqd7QIgPvS8BfBk9J2g
         Ou4STjDoBSKlb0xnv7RAi0+cN0q91+p6cYDHOaAFGYlMot7NVOh0EJgjsoBrbi422XK+
         8mgA==
X-Gm-Message-State: ANoB5pkEHSxST3i8KeZeyGArhaD39BUGN0MMJcpaYq/qj+jW73005i0o
        Ns1vKDrIfexe9YtyWaHbsSIcf6CRB4ZgvjJPt10=
X-Google-Smtp-Source: AA0mqf7qwsdx2owpfTQHhvJTnnhle8LG0mQyy+plpXwcfJpzmnFJm3VyR1D7mEkIQIivByu8QNSnxOfljLKSla99wQg=
X-Received: by 2002:a05:6214:451b:b0:4c6:bf45:38ad with SMTP id
 oo27-20020a056214451b00b004c6bf4538admr46865068qvb.73.1670009807011; Fri, 02
 Dec 2022 11:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20221201080514.3015400-1-lizetao1@huawei.com>
In-Reply-To: <20221201080514.3015400-1-lizetao1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 20:36:35 +0100
Message-ID: <CAJZ5v0ia-CN=zsmQr9+vnFDfCe1U8EFUDiRfUnGVMqS9b9AXpQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix use-after-free in acpi_ut_copy_ipackage_to_ipackage()
To:     Li Zetao <lizetao1@huawei.com>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, lv.zheng@intel.com, david.e.box@linux.intel.com,
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

On Thu, Dec 1, 2022 at 8:00 AM Li Zetao <lizetao1@huawei.com> wrote:
>
> There is an use-after-free reported by KASAN:
>
>   BUG: KASAN: use-after-free in acpi_ut_remove_reference+0x3b/0x82
>   Read of size 1 at addr ffff888112afc460 by task modprobe/2111
>   CPU: 0 PID: 2111 Comm: modprobe Not tainted 6.1.0-rc7-dirty
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>   Call Trace:
>    <TASK>
>    kasan_report+0xae/0xe0
>    acpi_ut_remove_reference+0x3b/0x82
>    acpi_ut_copy_iobject_to_iobject+0x3be/0x3d5
>    acpi_ds_store_object_to_local+0x15d/0x3a0
>    acpi_ex_store+0x78d/0x7fd
>    acpi_ex_opcode_1A_1T_1R+0xbe4/0xf9b
>    acpi_ps_parse_aml+0x217/0x8d5
>    ...
>    </TASK>
>
> The root cause of the problem is that the acpi_operand_object
> is freed when acpi_ut_walk_package_tree() fails in
> acpi_ut_copy_ipackage_to_ipackage(), lead to repeated release in
> acpi_ut_copy_iobject_to_iobject(). The problem was introduced
> by "8aa5e56eeb61" commit, this commit is to fix memory leak in
> acpi_ut_copy_iobject_to_iobject(), repeatedly adding remove
> operation, lead to "acpi_operand_object" used after free.
>
> Fix it by removing acpi_ut_remove_reference() in
> acpi_ut_copy_ipackage_to_ipackage(). acpi_ut_copy_ipackage_to_ipackage()
> is called to copy an internal package object into another internal
> package object, when it fails, the memory of acpi_operand_object
> should be freed by the caller.
>
> Fixes: 8aa5e56eeb61 ("ACPICA: Utilities: Fix memory leak in acpi_ut_copy_iobject_to_iobject")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/acpi/acpica/utcopy.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
> index 400b9e15a709..63c17f420fb8 100644
> --- a/drivers/acpi/acpica/utcopy.c
> +++ b/drivers/acpi/acpica/utcopy.c
> @@ -916,13 +916,6 @@ acpi_ut_copy_ipackage_to_ipackage(union acpi_operand_object *source_obj,
>         status = acpi_ut_walk_package_tree(source_obj, dest_obj,
>                                            acpi_ut_copy_ielement_to_ielement,
>                                            walk_state);
> -       if (ACPI_FAILURE(status)) {
> -
> -               /* On failure, delete the destination package object */
> -
> -               acpi_ut_remove_reference(dest_obj);
> -       }
> -
>         return_ACPI_STATUS(status);
>  }
>
> --

Applied as 6.2 material.

Normally, I would ask for a corresponding pull request to be submitted
to the upstream project on GitHub, but this looks serious enough to be
fast-tracked.

Anyway, it would help if you submitted a pull request with this change
to upstream ACPICA on GitHub.  Otherwise, I'll take care of that.
