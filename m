Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2166B1534
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCHWiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCHWiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:38:13 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64DF29410
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:38:10 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so4701724pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678315090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJdbC6w3SG4MYVN7j4d6HyU3EGtnN0pTLcXjZIeQBXQ=;
        b=OPBNp/YttWUDsJFSSe6u6gfNGNjamRUW9J/pyRyChRJll/rzlE+0C4Hgds3FzyN+bo
         fYiPQ8Bkl1Wlr9gIs812CcBLCF4z1asWyNml83uBJb3hrAXOl8eYBrrwzbO5S5CMNLBE
         MKmv04+V3bqqPsHSkMTQR7in9mjpUwfTHDHn2GaX79XG4uHgoLomQETWFSQ8nKYo+B0W
         wl3hgZwRAtBIVA0vEDyiILAvWICKCU5uINI8IGyZLuoPazXYilxQNZwQUgqYhMe+uZeJ
         W1T+D4zyrB9lDHlCUQl84KmfbH4HhTnWeCjFGnnY9LkL/ii4NDDkoWcD65F3z834ZfR7
         0Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJdbC6w3SG4MYVN7j4d6HyU3EGtnN0pTLcXjZIeQBXQ=;
        b=W+DZ/fAaPdadoDr1Ca1XNKiH73fu2slMLPVit3kjYWAahbcWabnk75zy+jbYn62ZTJ
         VaS3Ms5brvIpZGSmFBPZW02X27wq5mz+nDtKWsfhRAyALFZfv9QEIqZp5i81AAe93B3+
         WkE0WQdAD7OZkE/1flhMsel2v+Cil+Ln2ZDuz15/x3vouA4eKWzn023TlWX72oAvIWNA
         i7LJQseiSy/juOPBRns5mZgLCFWmf+PFN5XUMvrgVNpPCCFO+Dkjet1odXBZxLP1rB6s
         IiQKtvZpy7tVNlkLxliaMYWn0i4sXq3Namvz6aHU25pSkg+U/GdmgdP6pLo0vjt1sS+V
         mMRA==
X-Gm-Message-State: AO0yUKXy1f8gdYzTEogOz/b/bw8uVMO5JA6aDnmCLqmcCyEf8G1j9XyZ
        II6KGSIhIVRTpfTIvpD8raFjT7jBt40XU3jBDXVfSA==
X-Google-Smtp-Source: AK7set8/aQu37GV6TlGzEl1hGmKYEXe+8jMt96Eq9dvNK8lqb5Fev/lbf/mMmtT61CDOqg9Qxnegn9hFQivBUKI29p0=
X-Received: by 2002:a17:903:449:b0:199:4830:5cc9 with SMTP id
 iw9-20020a170903044900b0019948305cc9mr7546879plb.10.1678315089908; Wed, 08
 Mar 2023 14:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20230308-clk_of_declare-fix-v1-1-317b741e2532@kernel.org>
In-Reply-To: <20230308-clk_of_declare-fix-v1-1-317b741e2532@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Mar 2023 14:37:34 -0800
Message-ID: <CAGETcx_YSKw56HBJmbhYEpHzatb3YQu_msf6Mq=rJUAY_zXp-g@mail.gmail.com>
Subject: Re: [PATCH] clk: Avoid invalid function names in CLK_OF_DECLARE()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Mar 8, 2023 at 12:47=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> After commit c28cd1f3433c ("clk: Mark a fwnode as initialized when using
> CLK_OF_DECLARE() macro"), drivers/clk/mvebu/kirkwood.c fails to build:
>
>  drivers/clk/mvebu/kirkwood.c:358:1: error: expected identifier or '('
>  CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
>  ^
>  include/linux/clk-provider.h:1367:21: note: expanded from macro 'CLK_OF_=
DECLARE'
>          static void __init name##_of_clk_init_declare(struct device_node=
 *np) \
>                             ^
>  <scratch space>:124:1: note: expanded from here
>  98dx1135_clk_of_clk_init_declare
>  ^
>  drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal =
constant
>  include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_=
DECLARE'
>          OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
>                                          ^
>  <scratch space>:125:3: note: expanded from here
>  98dx1135_clk_of_clk_init_declare
>    ^
>  drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal =
constant
>  include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_=
DECLARE'
>          OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
>                                          ^
>  <scratch space>:125:3: note: expanded from here
>  98dx1135_clk_of_clk_init_declare
>    ^
>  drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal =
constant
>  include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_=
DECLARE'
>          OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
>                                          ^
>  <scratch space>:125:3: note: expanded from here
>  98dx1135_clk_of_clk_init_declare
>    ^
>
> C function names must start with either an alphabetic letter or an
> underscore. To avoid generating invalid function names from clock names,
> add two underscores to the beginning of the identifier.
>
> Fixes: c28cd1f3433c ("clk: Mark a fwnode as initialized when using CLK_OF=
_DECLARE() macro")
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  include/linux/clk-provider.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index c9f5276006a0..6f3175f0678a 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -1364,12 +1364,12 @@ struct clk_hw_onecell_data {
>  };
>
>  #define CLK_OF_DECLARE(name, compat, fn) \
> -       static void __init name##_of_clk_init_declare(struct device_node =
*np) \
> +       static void __init __##name##_of_clk_init_declare(struct device_n=
ode *np) \
>         {                                                               \
>                 fn(np);                                                 \
>                 fwnode_dev_initialized(of_fwnode_handle(np), true);     \
>         }                                                               \
> -       OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
> +       OF_DECLARE_1(clk, name, compat, __##name##_of_clk_init_declare)
>
>  /*
>   * Use this macro when you have a driver that requires two initializatio=
n

Thanks Nathan!

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

>
> ---
> base-commit: 89dc65a7cc8a119c395c0931b12d7a514f9d2bcc
> change-id: 20230308-clk_of_declare-fix-4fb89765923e
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
