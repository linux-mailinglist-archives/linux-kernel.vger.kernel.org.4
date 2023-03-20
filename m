Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1AF6C1D73
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjCTRNA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjCTRMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:12:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC861AD32;
        Mon, 20 Mar 2023 10:08:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t5so12695811edd.7;
        Mon, 20 Mar 2023 10:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFVHNlRMO76HDr09YoyKDoaw0W+v/H++bh6zzUPwciw=;
        b=1TpIvmuf5RRr/+Ef1XQg3wfORoZaksFe7eTknMWF28h6AqZuOyeUt81tOZ022eoCcF
         2+sYH8WxxjztUTeUBonsCa2mxhqLlxk8iKly9Z0I00TAHVnj+hyv0JL8JXwjC85K8g7C
         lsi0H6A3q8UjdMoYIIjQrU5d0CHmgT/4KeMmOXEgU3y43oioiHup9YbEg20YIIGJnZqV
         TNHr63nF/Nmb63JIKd9OxTPL8eOWxKjvQfPcb+IIq6tMiggz84bBaFr3MevVRmg2mHpx
         iDUe8ZpjAvvKCwyoPnSEyvYeQVw4DedWwJiQVUfQK3e3u3KSkGib4D4sUIN/9iuTbrbm
         inxg==
X-Gm-Message-State: AO0yUKWLB5hcWuvyl2xiHm2sBejQHMZn3X9qb1ZY8C2Fm5xDOqE2ainJ
        dpyK9eKvjbb6Jq3FzTked3rYQG5W3LkppqmgvxQ=
X-Google-Smtp-Source: AK7set8IWNc6rCvCSTt6Cym0dRfcEV5QnQDpcJYfUxxoh/DMQBcvBVdd0baimYZFBpozt4CsK/yJCoQLzw7v4RbpoRE=
X-Received: by 2002:a50:d70e:0:b0:501:d60a:da6d with SMTP id
 t14-20020a50d70e000000b00501d60ada6dmr122065edi.3.1679331978195; Mon, 20 Mar
 2023 10:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230226055427.2512453-1-void0red@gmail.com>
In-Reply-To: <20230226055427.2512453-1-void0red@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:06:07 +0100
Message-ID: <CAJZ5v0jwQwepjFhWQXnQndGp060WGD4LjBqot5VrV-gpL46vHg@mail.gmail.com>
Subject: Re: [PATCH] acpi: check for null return of devm_kzalloc in fch_misc_setup
To:     Kang Chen <void0red@gmail.com>
Cc:     lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 6:54 AM Kang Chen <void0red@gmail.com> wrote:
>
> devm_kzalloc may fail, clk_data->name might be null and will
> cause illegal address access later.
>
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>  drivers/acpi/acpi_apd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 3bbe2276c..80f945cbe 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -83,6 +83,8 @@ static int fch_misc_setup(struct apd_private_data *pdata)
>         if (!acpi_dev_get_property(adev, "clk-name", ACPI_TYPE_STRING, &obj)) {
>                 clk_data->name = devm_kzalloc(&adev->dev, obj->string.length,
>                                               GFP_KERNEL);
> +               if (!clk_data->name)
> +                       return -ENOMEM;
>
>                 strcpy(clk_data->name, obj->string.pointer);
>         } else {
> --

Applied as 6.4 material with some edits in the subject and changelog, thanks!
