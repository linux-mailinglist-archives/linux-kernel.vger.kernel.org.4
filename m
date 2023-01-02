Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5FC65B40E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbjABPTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbjABPTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:19:15 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462285F88
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:19:15 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id n4so29820034plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KdnkDFcMHnvIULuNtPU9Uhl5EliqgNNQb4JVnTW8DfA=;
        b=cmpkjnTaa1do+euhjhhjR+2oOZGEpdGOqarV8/PlOKfwiP699dezLW7QBErMGTQrwL
         91YVVPoqUP2bbkpsRBOC8XaCNojS4BgUrt7HDnNGxM2n3EOLBdxZVOZDT34A213aM86i
         wgP9cbYdTaHQ5nesW97sWqVgGU31J6B27fjMxjjlL/VJal73iGnfyUwqL3itFEupSiXM
         k+0oKpRfbtTsgX0VtFSUCrv0mYpzPk8rRK+dqhGB7MDYKG/X+ABBOnfb4AGY0JtWIjF4
         FM0UkriQ84Lt97chOQ7f+XQInIgzJdNKczi3KcvDdO5V1RVt2ugKOnwGA4yIsUM1O+5i
         /dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdnkDFcMHnvIULuNtPU9Uhl5EliqgNNQb4JVnTW8DfA=;
        b=Ga/cCFp4J6AkljcF6jiyqiMxqJMxDieJd0c5XTDaECLjeaydYkBFUGbk2BKB8l+WCI
         EpshCIltGTpCGbzgycoOeI6ANeJ+ShA9mSliYoHnnOpxpVQJb5Wuh1dH4wbNYcd3VGvQ
         7PJLBI5BQTwNrwM3t/JGEAm66n9SylsXioYm0aFkwTAu1Wf/4Tj2HkVrZJN3TZDhTfHb
         y8cbdzlhe69EtO4+ObFoSk5DE7IE75WF+56nckBIYkv5iuhOj3T4NT3u9TTDKbGb2U8H
         lfBm510DPrnDwJR82LCvSXmI1S7qMemcyE0hSIXP+ZqQTCJg/V8g2GJbwPA7YdcMwTDQ
         YZAg==
X-Gm-Message-State: AFqh2kqYlq4I6XwppxUpD/K0a7VwTvwUL4j0fmCGqqZadufwMWvCzrx3
        U1v0YdLzxPjB6OGtCE1s+eG35L6vVbK7mpY/nq5mgg==
X-Google-Smtp-Source: AMrXdXv70uv2w/Ors7JAl+0UNyHAfyD3wViaW4JA4Os2LgzBif5ypGc4gj38EXF4UwJ9yJXGOzVfK4tbVbj3obqG14g=
X-Received: by 2002:a17:90a:be18:b0:226:60cc:d0 with SMTP id
 a24-20020a17090abe1800b0022660cc00d0mr527791pjs.164.1672672754737; Mon, 02
 Jan 2023 07:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20230102094733.3966825-1-linmq006@gmail.com>
In-Reply-To: <20230102094733.3966825-1-linmq006@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:18:38 +0100
Message-ID: <CAPDyKFoTkKakjxsTSzuMTJ2=mpOXAVtvf9uPmFNGo7tBswpkWQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: ux500: Fix refcount leak in ux500_pm_domains_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2023 at 10:47, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_irq_find_parent() returns a node pointer with refcount incremented,

Probably a cut and paste, as you probably mean of_find_matching_node().

> We should use of_node_put() on it when not needed anymore.
> Add missing of_node_put() in the error path to avoid refcount leak.
>
> Fixes: cd931dcfda5e ("ARM: ux500: Initial support for PM domains")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Other than the above, which maybe Linus can fixup when applying:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/arm/mach-ux500/pm_domains.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
> index 427b9ac4af6c..01cae91854ca 100644
> --- a/arch/arm/mach-ux500/pm_domains.c
> +++ b/arch/arm/mach-ux500/pm_domains.c
> @@ -65,8 +65,10 @@ int __init ux500_pm_domains_init(void)
>                 return -ENODEV;
>
>         genpd_data = kzalloc(sizeof(*genpd_data), GFP_KERNEL);
> -       if (!genpd_data)
> +       if (!genpd_data) {
> +               of_node_put(np);
>                 return -ENOMEM;
> +       }
>
>         genpd_data->domains = ux500_pm_domains;
>         genpd_data->num_domains = ARRAY_SIZE(ux500_pm_domains);
> --
> 2.25.1
>
