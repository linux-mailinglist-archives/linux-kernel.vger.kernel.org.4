Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026C16B4E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCJRXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCJRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:23:17 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1DA117FF8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:22:34 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so10558898pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678468954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/DE4BbFE+cxAZN5gN/efxtiXFGQR5+c7FHCyJNvBW0=;
        b=lBKfb9q0r7vkZYNRlLOjcEmf6VPf5rwijNxOF//+Xy4M3xBeF9HOtVh0eG819F2Sev
         NnnbLf8PDG+ZdoYiUrAC2qeUDnwFEp8CQAfkuRHSPd2ovw5P26p7+2+CDJ70+tXr1/Eh
         iLtwr5dZauN0iESvOyUcL+zgmCETUoyN6hTzAVjmTmKUtCBEEXURVcGEBAZEOA8QJXqg
         XeZ+Z86HTwPiBDusp+t3f10kzftM+lNeJbQD88zibtEf47xAeWKTTGFe7PpZVYflLe3U
         WJCL2BRMaurSlT14jx1hTDrzzQH7o+86mTNxfRkrCmSywPD9DkL1RUJ2GN0t/hd01bW5
         PVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678468954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/DE4BbFE+cxAZN5gN/efxtiXFGQR5+c7FHCyJNvBW0=;
        b=EuY4cWE22cVu8TFuTZii4bMZmu/gd+Fi8CNwppbydXDW1cBdSS0GQqjx9nATScI1Zz
         E1gr6bbDvlokeW4m/YmvXo/kRdHTam85oVNwA8jzl7oSSDrCHkOVNJKcgDTDgvQ4z2Qn
         bVey2H8a5RRbrU8agBayt+bKosfjBBsMxAxTzsMAI/dNLCcWF86QTEto+AqmAQLyb5DB
         AwECaN+vGgoUV/Csq6LLmn14wm9nQqvDkMcVPPzkxr7Fi8/Glwiy/s0DoZ6SIVsOvDe2
         jmQAMOrOyAHzhaFYOrDlxN1zkEzqLtP/dMBDxHl5o2weDrDAJS9ltK5Dhc6PdhWamlW2
         8neA==
X-Gm-Message-State: AO0yUKWqTmFTB9nJAgqlCk/VCKjrI8nnMlJt4V9GB9GxYzk2InlOnaZ5
        +El+jqvtwKy9PuPUtCFdAFCuREbAfS/YukX1eKc0Jg==
X-Google-Smtp-Source: AK7set9Hv6Hx+AVNj9NYlD3DaqMoPARFDlR4f7ayZ9t8PEJeytSyInKXiN8NL1CElZFLbGIGgLslyKMEbbMELLNtbOg=
X-Received: by 2002:a17:90a:dc0d:b0:235:1fb7:393c with SMTP id
 i13-20020a17090adc0d00b002351fb7393cmr1198503pjv.1.1678468953481; Fri, 10 Mar
 2023 09:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20230310140218.326626-1-arnd@kernel.org>
In-Reply-To: <20230310140218.326626-1-arnd@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Mar 2023 09:21:57 -0800
Message-ID: <CAGETcx-9PDaWc7eFQ5ajk0BFY7HRhvf30R6uR0Mo1qb+6Af0jQ@mail.gmail.com>
Subject: Re: [PATCH] clk: avoid build failure on CLK_OF_DECLARE() with invalid name
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 10, 2023 at 6:02=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Generating an init function function from CLK_OF_DECLARE() broke for the
> 98dx1135_clk declaration because that string starts with a digit and
> is not a valid C identifier:

Nathan already sent out a fix for this and it's been picked up.

https://lore.kernel.org/lkml/20230308-clk_of_declare-fix-v1-1-317b741e2532@=
kernel.org/

-Saravana

>
> In file included from drivers/clk/mvebu/kirkwood.c:15:
> drivers/clk/mvebu/kirkwood.c:358:16: error: invalid suffix "dx1135_clk_of=
_clk_init_declare" on integer constant
>   358 | CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
>       |                ^~~~~~~~~~~~
> include/linux/clk-provider.h:1367:28: note: in definition of macro 'CLK_O=
F_DECLARE'
>  1367 |         static void __init name##_of_clk_init_declare(struct devi=
ce_node *np) \
>       |                            ^~~~
> drivers/clk/mvebu/kirkwood.c:358:16: error: expected identifier or '(' be=
fore numeric constant
>   358 | CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
>       |                ^~~~~~~~~~~~
> include/linux/clk-provider.h:1367:28: note: in definition of macro 'CLK_O=
F_DECLARE'
>  1367 |         static void __init name##_of_clk_init_declare(struct devi=
ce_node *np) \
>       |                            ^~~~
>
> This could be fixed in the driver by renaming 98dx1135_clk to a valid
> C identifier, but it's easy enough to make the macro more robust by
> reversing the two parts of the name, which makes it work for other files
> that may have the same issue. Since CLK_OF_DECLARE_DRIVER() has a very
> similar definition, do the same change in both.
>
> Fixes: c7296c51ce5d ("clk: core: New macro CLK_OF_DECLARE_DRIVER")
> Fixes: c28cd1f3433c ("clk: Mark a fwnode as initialized when using CLK_OF=
_DECLARE() macro")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/clk-provider.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index c9f5276006a0..3586a029db05 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -1364,24 +1364,24 @@ struct clk_hw_onecell_data {
>  };
>
>  #define CLK_OF_DECLARE(name, compat, fn) \
> -       static void __init name##_of_clk_init_declare(struct device_node =
*np) \
> +       static void __init of_clk_init_declare##name(struct device_node *=
np) \
>         {                                                               \
>                 fn(np);                                                 \
>                 fwnode_dev_initialized(of_fwnode_handle(np), true);     \
>         }                                                               \
> -       OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
> +       OF_DECLARE_1(clk, name, compat, of_clk_init_declare##name)
>
>  /*
>   * Use this macro when you have a driver that requires two initializatio=
n
>   * routines, one at of_clk_init(), and one at platform device probe
>   */
>  #define CLK_OF_DECLARE_DRIVER(name, compat, fn) \
> -       static void __init name##_of_clk_init_driver(struct device_node *=
np) \
> +       static void __init of_clk_init_driver##name(struct device_node *n=
p) \
>         {                                                               \
>                 of_node_clear_flag(np, OF_POPULATED);                   \
>                 fn(np);                                                 \
>         }                                                               \
> -       OF_DECLARE_1(clk, name, compat, name##_of_clk_init_driver)
> +       OF_DECLARE_1(clk, name, compat, of_clk_init_driver##name)
>
>  #define CLK_HW_INIT(_name, _parent, _ops, _flags)              \
>         (&(struct clk_init_data) {                              \
> --
> 2.39.2
>
