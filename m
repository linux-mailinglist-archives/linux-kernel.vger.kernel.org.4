Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A568660C71
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 05:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbjAGEj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 23:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAGEjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 23:39:20 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101A384628
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 20:39:19 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id x65so3478323vsb.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 20:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=soxPkCXSgF66wtzGQPY+AblCoXmgckFkRYZ+m8JoLcs=;
        b=XaMCznScnyS2mvU02NMSHL9Fjvnrbj9pBDlhXknXEhwbo8/JaE4/8Qc0Yvu3vvHy9z
         qRRicRpMMcd5nu2GFyxkQV4EvNvpS1VBwwsqMrPEn3nqUgSlZZN065iNpkLDuKGGlW01
         h3NWlJa2tu2QwiBEqXRm1Iip/53l4Dcw19H5ww2LDLQha8TaVpRidpjym+URsj8aEO5h
         dpXynh4s7xX6F1eXSjRbMR8IN9aMB5irVf9QDwYPJPvL19wcBdsTCTXm8d6T4TDhcTih
         7UraAehyw5d4IaYtvgNCpvm5U9qDL7Ho2DGystANQaKMIP9BmWq7Tf29TFi2mYD8k8Io
         Sk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soxPkCXSgF66wtzGQPY+AblCoXmgckFkRYZ+m8JoLcs=;
        b=ATZxOXj7QCBGOZSjygcdENFj+GkKxiZCmseJlpkzjRnwuzRBX46SzD/VCSwk53jsiU
         Nq4I1OAuAfwkkceXhri10zrsdxJDbOCjlHdmvray2ffN8q/KCTzVYdQACtsDZVlOLLMi
         NbuIkj2uIrdrLAwpyOWxJOL8jUJqE7yxDz7xJYll3TSGYBMenpmxvWFPAwkGxxOoxweR
         Q7xy27jUBpXwVq1O6LMsFX1ZP9gUqT/6G/+V3AxB65S0PiL4NChbQ5p3Ff/3x1a3pt+l
         eA0/kQUS/DYPI4t+M7RvZGCBmVmptWzAr8E9PGScRW2ZxOxIXMV1Lpko8sN7Hh1snoHF
         R4gA==
X-Gm-Message-State: AFqh2kpRWHcrNE2lE9B2P7LQCUIg/NLbSn5Fy3wWQWZj/GVFsMUrpYl3
        RyfMXadyblqcOF3aAYB6+Pidm+Uf8ZBCPUG22VOvGQ==
X-Google-Smtp-Source: AMrXdXtEwkNBrCD3dpAe8T6gjukdKQRc59k38VHtyEyhN7uFj+ljim3SvU0JbYzWgOg/PECYH8yl/ajKIvGbuKtYN8k=
X-Received: by 2002:a05:6102:f8c:b0:3c9:8cc2:dd04 with SMTP id
 e12-20020a0561020f8c00b003c98cc2dd04mr5292950vsv.73.1673066358124; Fri, 06
 Jan 2023 20:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20230107031406.gonna.761-kees@kernel.org>
In-Reply-To: <20230107031406.gonna.761-kees@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 6 Jan 2023 20:39:06 -0800
Message-ID: <CABXOdTfENiCZF-G4TW7=hy7eVJSQJ5t63GzW4_mtezZzTs+18g@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: coreboot: Check size of table entry and
 split memcpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 7:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> The memcpy() of the data following a coreboot_table_entry couldn't
> be evaluated by the compiler under CONFIG_FORTIFY_SOURCE. To make it
> easier to reason about, add an explicit flexible array member to struct
> coreboot_device so the entire entry can be copied at once. Additionally,
> validate the sizes before copying. Avoids this run-time false positive
> warning:
>
>   memcpy: detected field-spanning write (size 168) of single field "&device->entry" at drivers/firmware/google/coreboot_table.c:103 (size 8)
>
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/all/03ae2704-8c30-f9f0-215b-7cdf4ad35a9a@molgen.mpg.de/
> Cc: Jack Rosenthal <jrosenth@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> v2: move flex array to struct coreboot_device (julius)
> v1: https://lore.kernel.org/lkml/20230106045327.never.413-kees@kernel.org
> ---
>  drivers/firmware/google/coreboot_table.c | 9 +++++++--
>  drivers/firmware/google/coreboot_table.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> index 2652c396c423..564a3c908838 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -93,14 +93,19 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
>         for (i = 0; i < header->table_entries; i++) {
>                 entry = ptr_entry;
>
> -               device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
> +               if (entry->size < sizeof(*entry)) {
> +                       dev_warn(dev, "coreboot table entry too small!\n");
> +                       return -EINVAL;
> +               }
> +
> +               device = kzalloc(sizeof(device->dev) + entry->size, GFP_KERNEL);
>                 if (!device)
>                         return -ENOMEM;
>
>                 device->dev.parent = dev;
>                 device->dev.bus = &coreboot_bus_type;
>                 device->dev.release = coreboot_device_release;
> -               memcpy(&device->entry, ptr_entry, entry->size);
> +               memcpy(device->raw, entry, entry->size);
>
>                 switch (device->entry.tag) {
>                 case LB_TAG_CBMEM_ENTRY:
> diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
> index 37f4d335a606..d814dca33a08 100644
> --- a/drivers/firmware/google/coreboot_table.h
> +++ b/drivers/firmware/google/coreboot_table.h
> @@ -79,6 +79,7 @@ struct coreboot_device {
>                 struct lb_cbmem_ref cbmem_ref;
>                 struct lb_cbmem_entry cbmem_entry;
>                 struct lb_framebuffer framebuffer;
> +               DECLARE_FLEX_ARRAY(u8, raw);
>         };
>  };
>
> --
> 2.34.1
>
