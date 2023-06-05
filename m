Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9808722D64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbjFERL2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 13:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjFERLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:11:25 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CB9F3;
        Mon,  5 Jun 2023 10:11:24 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so1279544a12.0;
        Mon, 05 Jun 2023 10:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985082; x=1688577082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAZK0CFWBZg3n0JhDQbbwcnvbot02N2sjUNcr3SyWic=;
        b=Q1ZCscsg18hC/J00jydq7FlY23U0Fb3/4wUmHxygoNLJiiKTGHSFnV0nXzYDEsgiaG
         cCS3Egzxif/TmXpJDBHXb6F/hOl2nqOU+UMWRjHxbKS7dzD5I5XIW+nKbdZHlWgLF3us
         2VDd2GjLQXsQq2WdRQmkr4Ncq0MLro/RohRwU9a9/dq8qlH2XSUmqASRGoivZ/UBB/Kf
         fZ0i2t2l+4oGPTz0ELp38SOvIWmVlRCFrV4cdMgPj7ciLajI0nzGg8Uaj4DBjY5F+m6k
         YbqrHY5AIx70S/tBEL75TwtYJsBp15z5Z+3RdGM8m9HCcUJJb5SgpfahbrCk0s0HhyBY
         OPvQ==
X-Gm-Message-State: AC+VfDw5To1OAXRslJX/6zOO5bqFHkZLaFH+6zDFg5/fE3ROMAI/toRp
        X6vhcc5WVNRRUr80r/XcgQiY65tMjQQdBsrmo7I=
X-Google-Smtp-Source: ACHHUZ5h86xRMdCReVoqdtgTo9c0HC1pLXPtCnQP6/MLDzPEeu78XbCD1rTyegXFjQLEHKfvzK/UKjGqQ8ScFgm6H6o=
X-Received: by 2002:a17:906:7794:b0:974:5de8:b5ce with SMTP id
 s20-20020a170906779400b009745de8b5cemr8307438ejm.2.1685985082344; Mon, 05 Jun
 2023 10:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230519201249.31147-1-leoyang.li@nxp.com>
In-Reply-To: <20230519201249.31147-1-leoyang.li@nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jun 2023 19:11:11 +0200
Message-ID: <CAJZ5v0i1nspPuHuUoLsWOz7MLnnB8bv=cXYbFcv0a=okBxBg3w@mail.gmail.com>
Subject: Re: [PATCH v2] apei/ghes: correctly return NULL for ghes_get_devices()
To:     Li Yang <leoyang.li@nxp.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Jia He <justin.he@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 10:13 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> Since 315bada690e0 ("EDAC: Check for GHES preference in the
> chipset-specific EDAC drivers"), vendor specific EDAC driver will not
> probe correctly when CONFIG_ACPI_APEI_GHES is enabled but no GHES device
> is present.  Make ghes_get_devices() return NULL when the GHES device
> list is empty to fix the problem.
>
> Fixes: 9057a3f7ac36 ("EDAC/ghes: Prepare to make ghes_edac a proper module")
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Cc: Jia He <justin.he@arm.com>

Boris, Tony, any comments?

> ---
>
> V2: fix the fallthrough case in x86 path
>
>  drivers/acpi/apei/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 34ad071a64e9..4382fe13ee3e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1544,6 +1544,8 @@ struct list_head *ghes_get_devices(void)
>
>                         pr_warn_once("Force-loading ghes_edac on an unsupported platform. You're on your own!\n");
>                 }
> +       } else if (list_empty(&ghes_devs)) {
> +               return NULL;
>         }
>
>         return &ghes_devs;
> --
> 2.38.0
>
