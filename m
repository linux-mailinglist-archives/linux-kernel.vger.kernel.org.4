Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519DD6AB4D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCFDBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCFDBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:01:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3FD10AA6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 19:01:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D2C8B80B13
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2D8C4339E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678071687;
        bh=qS9KqK3sQ/cWLrmiBP+ByBRqWpgp6Bt97op4y5jbV8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hgzUqDNMdPvAuWZdSa2aK4Rz2NnTYONE01oqgpYlpo9FwEf0QoQLbJMEy8Tou6s2d
         WXIJANabfH1c0xe2zJl7UaT3e1GZOzKrupvxWGP672PLj4FwMkbtWVCud17doQRQkl
         Qa8E8W+auT9qyL5KU9A3m+EAfT6sBgo9SP9m0Mgtc17/un2HU7q1PpgIc/l3KBu1h1
         lnQ7hvEKDfvVOSTHHQVoeDvcxYS0FUcphsMlF3qwJa720qwZg3C5dD6z+alb+rrIII
         y9anMeCggK6UZdV3TTpAisyu7KN6FhRQRCLsUWJ5g6J1kLYPoouSYGHhr/jBx9Fijm
         RER51U45etKgA==
Received: by mail-ed1-f50.google.com with SMTP id x3so32738309edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 19:01:27 -0800 (PST)
X-Gm-Message-State: AO0yUKV7mKiILR//b5cXtWcdQQUU7pE8ndJMHTNHQQXuB3uUWbTn7JEJ
        uJaa39wW3fWQoYY3wPAtob18/PX/ndra/Qdu53E=
X-Google-Smtp-Source: AK7set9rPITqsdTecIWxvyoghDbDqzdFkN/3ZX0xna7NAthjEF96lZLNo/v6UiTh6rI3bvJHkPAZSTbIoVd2EaxMX+k=
X-Received: by 2002:a50:9357:0:b0:4aa:a4f1:3edc with SMTP id
 n23-20020a509357000000b004aaa4f13edcmr5012559eda.7.1678071685389; Sun, 05 Mar
 2023 19:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20230306025308.248987-1-dzm91@hust.edu.cn>
In-Reply-To: <20230306025308.248987-1-dzm91@hust.edu.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 6 Mar 2023 11:01:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4jW3cJbtoL1gMZ=i7zy1fc4A4q0DqMYPQ-fGc7aHMmog@mail.gmail.com>
Message-ID: <CAAhV-H4jW3cJbtoL1gMZ=i7zy1fc4A4q0DqMYPQ-fGc7aHMmog@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: loongson: fix memory leak in loongson2_guts_probe
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Mon, Mar 6, 2023 at 10:55=E2=80=AFAM Dongliang Mu <dzm91@hust.edu.cn> wr=
ote:
>
> drivers/soc/loongson/loongson2_guts.c:150 loongson2_guts_probe()
> warn: 'guts->regs' from ioremap() not released on lines: 131,135,139,143.
>
> Fix this by modifying ioremap to devm_ioremap.
>
> Note that, this patch is not tested due to the loongson architecture.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1->v2: instead of modifying error handling code, directly change
> ioremap to devm_ioremap.
>  drivers/soc/loongson/loongson2_guts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson=
/loongson2_guts.c
> index bace4bc8e03b..a053e3fdae09 100644
> --- a/drivers/soc/loongson/loongson2_guts.c
> +++ b/drivers/soc/loongson/loongson2_guts.c
> @@ -107,7 +107,7 @@ static int loongson2_guts_probe(struct platform_devic=
e *pdev)
>         guts->little_endian =3D of_property_read_bool(np, "little-endian"=
);
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       guts->regs =3D ioremap(res->start, res->end - res->start + 1);
> +       guts->regs =3D devm_ioremap(dev, res->start, res->end - res->star=
t + 1);
>         if (IS_ERR(guts->regs))
>                 return PTR_ERR(guts->regs);
>
> --
> 2.39.2
>
>
