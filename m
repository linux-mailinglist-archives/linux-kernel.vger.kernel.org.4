Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5F06CF3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjC2Tul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjC2Tug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4451711;
        Wed, 29 Mar 2023 12:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D268861E08;
        Wed, 29 Mar 2023 19:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380C0C433EF;
        Wed, 29 Mar 2023 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680119362;
        bh=hYn4WbhBF9Rj4s8CX4YfCGFQYwTZemqDMnlxN7alqCc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WJ3prnXqzFYvW40J07pruGFfkj8X9rYOqEUiY8/61uNsL6rMvq4o2LdMWm4L4xqeW
         GReYTckx/hBtRUrvRXfJUlBgYqMA1K6xlKcTWCY8rf2LQyGbO+vSLXJkSDuocjOPgC
         //YxNGMhicHErPa//m4uaeOWa9PXglK/L9V9jfbGliu0AvsYDjugzfhf/lSII7JLJV
         2M4aPmID2JVtO7+21lGlXoh8NtvAoLA1bsmmxi3uKF3OG69E4qglHkrOOjo/kx6E4f
         9Tetmg8wxpA91ZfDVmLof+rYIj9o54jBxWJFEloLF7cGljWfPqyDzg+lqmwPwYXMw0
         c8QVI1cHIlSZQ==
Message-ID: <4d8d412a33a7d63f2ffe6a13194375ed.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221026151812.1042052-1-u.kleine-koenig@pengutronix.de>
References: <20221026151812.1042052-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] clk: expand clk_ignore_unused mechanism to keep only a few clks on
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Corbet <corbet@lwn.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Wed, 29 Mar 2023 12:49:19 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2022-10-26 08:18:12)
> Allow to pass an integer n that results in only keeping n unused clocks
> enabled.
>=20
> This helps to debug the problem if you only know that clk_ignore_unused
> helps but you have no clue yet which clock is the culprit.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> compared to v2 sent in August 2021 this is a trivial rebase on top of
> v6.1-rc1. I pinged that one repeatedly, I'm now trying with resending
> and calling the rebased patch v3 to maybe get some feedback. :-\
>=20
> Best regards
> Uwe
>=20
>  Documentation/driver-api/clk.rst |  4 +++-

No update to Documentation/admin-guide/kernel-parameters.txt?

>  drivers/clk/clk.c                | 33 ++++++++++++++++++++++++--------
>  2 files changed, 28 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c3c3f8c07258..356119a7e5fe 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1322,6 +1322,8 @@ static void __init clk_unprepare_unused_subtree(str=
uct clk_core *core)
>         clk_pm_runtime_put(core);
>  }
> =20
> +static unsigned clk_unused_keep_on __initdata;
> +
>  static void __init clk_disable_unused_subtree(struct clk_core *core)
>  {
>         struct clk_core *child;
> @@ -1352,12 +1354,17 @@ static void __init clk_disable_unused_subtree(str=
uct clk_core *core)
>          * back to .disable
>          */
>         if (clk_core_is_enabled(core)) {
> -               trace_clk_disable(core);
> -               if (core->ops->disable_unused)
> -                       core->ops->disable_unused(core->hw);
> -               else if (core->ops->disable)
> -                       core->ops->disable(core->hw);
> -               trace_clk_disable_complete(core);
> +               if (clk_unused_keep_on) {
> +                       pr_warn("Keep unused clk \"%s\" on\n", core->name=
);
> +                       clk_unused_keep_on -=3D 1;
> +               } else {
> +                       trace_clk_disable(core);

We have trace_clk_disable() here. Can you have this tracepoint print to
the kernel log and watch over serial console? That would be faster than
bisecting.

> +                       if (core->ops->disable_unused)
> +                               core->ops->disable_unused(core->hw);
> +                       else if (core->ops->disable)
> +                               core->ops->disable(core->hw);
> +                       trace_clk_disable_complete(core);
> +               }
>         }
> =20
>  unlock_out:
> @@ -1369,9 +1376,17 @@ static void __init clk_disable_unused_subtree(stru=
ct clk_core *core)
>  }
> =20
>  static bool clk_ignore_unused __initdata;
> -static int __init clk_ignore_unused_setup(char *__unused)
> +static int __init clk_ignore_unused_setup(char *keep)
>  {
> -       clk_ignore_unused =3D true;
> +       if (*keep =3D=3D '=3D') {
> +               int ret;
> +
> +               ret =3D kstrtouint(keep + 1, 0, &clk_unused_keep_on);
> +               if (ret < 0)

Could omit 'ret' and just have if (kstrtouint(..))

> +                       pr_err("Warning: failed to parse clk_ignore_unuse=
d parameter, ignoring");

Missing newline on printk.

> +       } else {
> +               clk_ignore_unused =3D true;
> +       }
>         return 1;
>  }
>  __setup("clk_ignore_unused", clk_ignore_unused_setup);
