Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7063112F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 23:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiKSWC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 17:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiKSWCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 17:02:53 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9650B13DD7;
        Sat, 19 Nov 2022 14:02:52 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q1so7958399pgl.11;
        Sat, 19 Nov 2022 14:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RhFwdrX3xVq4nHkSY3tPqPXpVMZAR1CFnykerOZ+t8Q=;
        b=pPeETvAPWe4iC/zmeM/kXmtNlKq4PvcYfJGLTrzgpve8/99rJN5eNJDw6JZA3FgVU4
         zUbZZpK9yFT9+I1RbdaqasVmJAngfWBPVJuVt0xtUVyrBY9PJe4Zn2/FVZfN0ppj8wI9
         CK/JhOkwMyOmNDb6n+EAY8q1+COv9I+WB7y2zmMYmW14fIbACD1upE3DZP9Qkl3H1Mo/
         ctx6Bg//T6EnaiWikPyqWWNVu16HLmaycZut5QUHXKPsdg6uEBLg9gBW62FESfVzt72O
         M19jyNZmu/u9kw9QmPGjocag1KipkWlW90YeRVHAfHIkzEdr48ops3nBWBAqV3DSSjCh
         Y/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhFwdrX3xVq4nHkSY3tPqPXpVMZAR1CFnykerOZ+t8Q=;
        b=uAPfBEdArtTEsw6/fGs5xpRxoSRtQgcWnX8WY/99UutA77qL9nJMZi52Lc3cK7IP28
         M5L3Gm5Twyu3A70HH2WkBSB/BT89ugxjoH4rKz7gtQl4iOJaMy9H+WUCqVy99lf4auwQ
         /VVE342x8RjgqVSY1CWLZQUgkXK0zMweoHOJQVKaWfiMoWWkmSTwdyq1fkKWNco6MPVC
         /z+LjwW+jHhlf1VgzvaORIpc98PMxeIjei+gufM0o2yr2tY4HS8OPSp6Q31WznQ9vkpG
         JOFf5fu/awv1lGsBp19x/lgjy4frJoJsvaVuHnTo2VLDvefh+UtXMo2bCvYOZ7WpuzRE
         rHhA==
X-Gm-Message-State: ANoB5plyxL8fTKtUl7qXLbExqdQWXagy7//PCq9ILH0xkZUi7XFlw3M+
        N9t3K3bfAMhe2nRJMKIbwXJgy82D63ftskHymb0XBm5lqoo=
X-Google-Smtp-Source: AA0mqf7mhQCSuu5OTpXcFB4TZkqg70WILZVSNezFrmq+xhuEAIN4lATKzCVpAzjURfXxoEFskZeLhYK1rO+tcHh0sgA=
X-Received: by 2002:a63:2f46:0:b0:477:4a13:f38e with SMTP id
 v67-20020a632f46000000b004774a13f38emr4221768pgv.131.1668895372035; Sat, 19
 Nov 2022 14:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
 <CAOMZO5BPtEU6VCZXRk5FTHXDad6cegF=+oHTTA0wgjBuoh9-rQ@mail.gmail.com> <09611b2d-096e-058b-5349-627684e3a13c@rasmusvillemoes.dk>
In-Reply-To: <09611b2d-096e-058b-5349-627684e3a13c@rasmusvillemoes.dk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 19 Nov 2022 19:02:34 -0300
Message-ID: <CAOMZO5AXSSkHpeuHNRQ6qkFoe2uiFLVxndz1u7_y7s9cLD9ppw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 6:57 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

> Sorry, I don't follow. Before this patch, the driver also implicitly had
> a module_exit() doing exactly this platform_driver_unregister(), it was
> just hidden inside the module_platform_driver() macro. And I think
> that's necessary if one wants to test that the module can be loaded and
> unloaded (I don't think it's ever useful or even possible to have it be
> a module on an actual imx8mp board).

You cannot load/unload it due to .suppress_bind_attrs = true, being passed.

> For a modular build, this patch changes nothing since all foo_initcall
> levels are translated to module_initcall for those. And when the driver
> is built-in, the __exit code, both before and after this patch, is
> discarded in the final image.

All I am suggesting is that you the patch only does:

--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -734,7 +734,19 @@ static struct platform_driver imx8mp_clk_driver = {
                .of_match_table = imx8mp_clk_of_match,
        },
 };
-module_platform_driver(imx8mp_clk_driver);
+
+static int __init imx8mp_clk_init(void)
+{
+       return platform_driver_register(&imx8mp_clk_driver);
+}
+arch_initcall(imx8mp_clk_init);

This is the same as in drivers/pinctrl/freescale/pinctrl-imx8mm.c for example.
