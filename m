Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ECD6A7935
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCBByN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCBByM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:54:12 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775A4608E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:53:45 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id z11so9187857pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 17:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677722024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqeOn4Q4cJcBqeA1Wx7fcXJepvZr6btV1VhI9yXuxDY=;
        b=NN6Q/adlJrn+ion/Hu8qHS/qTlNK2RTEl6JRl7dVlig6o2u8yZDizsPOQwQALmQH8c
         Ba+WHIY5C5nkHkq0tEJPuKH0ek0IWgsnDjaynaBC4g2q0mfKSBUVGobjyefVUkai2uJT
         wxV3rrjQTwuz9rRuszRmtdgPr4eVzajX6kUog4wwPEmRnAiL2F8zBF1Zv6GLJ7ma1XDq
         RMMEBcpE7TKbGfWxrVsRwA03mkdKH3LBFpsC/XIv64BlKylAJieLVU0nhvpes4146mgj
         rmp6EtwO8lkICIVF++m3+Zkj48Sb3Sf7mBwOLdBck3OgWGVZti9VWR6LJCKiKjWvI+tL
         NIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677722024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqeOn4Q4cJcBqeA1Wx7fcXJepvZr6btV1VhI9yXuxDY=;
        b=D/720hkHeIx4DXYj4FZjhJ4MI07AaFnW/wSq/5CWRzXsNo8Zq5Mfmb8liCHXiUxlXz
         R06y5TgfeIRWK9ky/Idb25IwNyWOl9RcG9kaps5tqL9Dpplc7XIk4uiLwWY8fBvedOvv
         1AiAzaa9X3iA4vo4ErOnikFAmFLuMybAzZNkkfEdKNK5yR8O5LPzouNQKR6W1uvA3OOY
         3FTseeJPXp8QQ5MzxGXee366np5oUfzsLOk4XGgV6PSBeyJErToXKZ0wQGcwp3SkwGaB
         qiEDKF4qlQLsm2Qa00z0MCdM2uLOf02rcIhah2VCCBCw8CPig2bae+tPslonuUNm/FJK
         TEjA==
X-Gm-Message-State: AO0yUKU0tkmwjR9/j9PyEXoT0jjlbgLBbfzQRTaAMX1DFf9U5ICpWC22
        F8ZzTu8WFl48R9y1EZNRtZpdTugVMuS6TN+xxAIEWQ==
X-Google-Smtp-Source: AK7set8ky6bHKGk0gbRu3jVk94mzKWlZMU93SWmLEMTSzH4UyXYwJ4HqXOVx6cjz9cSa86cMTjbhsuV+TI3KMRPH69E=
X-Received: by 2002:a65:51c3:0:b0:4fb:3896:a7d4 with SMTP id
 i3-20020a6551c3000000b004fb3896a7d4mr2693551pgq.7.1677722024107; Wed, 01 Mar
 2023 17:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20230302014639.297514-1-saravanak@google.com>
In-Reply-To: <20230302014639.297514-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Mar 2023 17:53:07 -0800
Message-ID: <CAGETcx8BAud7fj7EYJNYXF+XjgSSk=GT7eOGAHhnxXQCp4R_rw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE() macro
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 5:46=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> We already mark fwnodes as initialized when they are registered as clock
> providers. We do this so that fw_devlink can tell when a clock driver
> doesn't use the driver core framework to probe/initialize its device.
> This ensures fw_devlink doesn't block the consumers of such a clock
> provider indefinitely.
>
> However, some users of CLK_OF_DECLARE() macros don't use the same node
> that matches the macro as the node for the clock provider, but they
> initialize the entire node. To cover these cases, also mark the nodes
> that match the macros as initialized when the init callback function is
> called.
>
> An example of this is "stericsson,u8500-clks" that's handled using
> CLK_OF_DECLARE() and looks something like this:
>
> clocks {
>         compatible =3D "stericsson,u8500-clks";
>
>         prcmu_clk: prcmu-clock {
>                 #clock-cells =3D <1>;
>         };
>
>         prcc_pclk: prcc-periph-clock {
>                 #clock-cells =3D <2>;
>         };
>
>         prcc_kclk: prcc-kernel-clock {
>                 #clock-cells =3D <2>;
>         };
>
>         prcc_reset: prcc-reset-controller {
>                 #reset-cells =3D <2>;
>         };
>         ...
>         ...
> };
>
> This patch makes sure that "clocks" is marked as initialized so that
> fw_devlink knows that all nodes under it have been initialized.
>
> If the driver creates struct devices for some of the subnodes,
> fw_devlink is smart enough to know to wait for those devices to probe.
> So, no special handling is required for those cases.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/lkml/CACRpkdamxDX6EBVjKX5=3DD3rkHp17f5pwGdB=
VhzFU90-0MHY6dQ@mail.gmail.com/
> Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Linus, I changed the code a bit and I think this should work too. Can
you give it a shot please?

-Saravana

> ---
>  include/linux/clk-provider.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 842e72a5348f..c9f5276006a0 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -1363,7 +1363,13 @@ struct clk_hw_onecell_data {
>         struct clk_hw *hws[];
>  };
>
> -#define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat,=
 fn)
> +#define CLK_OF_DECLARE(name, compat, fn) \
> +       static void __init name##_of_clk_init_declare(struct device_node =
*np) \
> +       {                                                               \
> +               fn(np);                                                 \
> +               fwnode_dev_initialized(of_fwnode_handle(np), true);     \
> +       }                                                               \
> +       OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
>
>  /*
>   * Use this macro when you have a driver that requires two initializatio=
n
> --
> 2.39.2.722.g9855ee24e9-goog
>
