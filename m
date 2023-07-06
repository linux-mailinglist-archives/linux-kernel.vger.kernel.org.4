Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA767496B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjGFHn0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 03:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjGFHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:43:23 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589121BE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:43:16 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-579de633419so5351957b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688629395; x=1691221395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU7wIuB8pzU5mgZRjLNHZb0xDTBNcfDXYxTP1tuxTqw=;
        b=WdrBz+PZBZIf02MvjOo+OpJOa9pT97eQc5IQ9y1j4ruDxfrBeUo6tTdM6NUn+yJ88s
         z12WfgLUQwgrW70DhX41gTERqmCwkkKzTPy9Osjd0pPJQmIQLK8thTkhEdAgHaGkHD9Y
         5b7vBrGw3e3xdFVwUJS1kCmO1/impmGlJJ7FHPdQ3AGj4p0byA0NvQZlJ7LF9yzUosZp
         WpFWdO3TDpI7EQcrsZDqigyvVvbGrAYg0BdJjx5HtOHnmnX0g2njyqbeNeVH57pfZ8Ov
         EqhbdqTphv3fM4BG3c4syMLcgpD4kLPZQHTgrnn9tuA2Fjkwg5OFvLZKvDBpWAY2FytB
         Wkng==
X-Gm-Message-State: ABy/qLblfQ+BgPQhRNGQaFYfd9Pg6WQTYBOe/7lTOUtOsFJUMXbvb8uK
        NMTVtzP+mryaV0nHz+1Br5aMzVL+0R5Zbw==
X-Google-Smtp-Source: APBJJlE7h6x1Gk7i9MpWhPoX9IRCPJWfA64Ah5PiPPmzceF9ltE1eK2wtCr+9IiAefwce9AqNNw1TA==
X-Received: by 2002:a0d:d345:0:b0:579:5bbe:b022 with SMTP id v66-20020a0dd345000000b005795bbeb022mr1145588ywd.30.1688629395309;
        Thu, 06 Jul 2023 00:43:15 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id v76-20020a81484f000000b0054fba955474sm193506ywa.17.2023.07.06.00.43.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 00:43:14 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-57a4a476bbfso4525437b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:43:14 -0700 (PDT)
X-Received: by 2002:a25:d0b:0:b0:c62:9810:db27 with SMTP id
 11-20020a250d0b000000b00c629810db27mr1001959ybn.60.1688629394538; Thu, 06 Jul
 2023 00:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230706071310.38388-1-luhongfei@vivo.com>
In-Reply-To: <20230706071310.38388-1-luhongfei@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Jul 2023 09:43:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1TTKYMQfnZ_6H1Vee9NcYtN1TK0wNesqsjiKwBHZz=A@mail.gmail.com>
Message-ID: <CAMuHMdV1TTKYMQfnZ_6H1Vee9NcYtN1TK0wNesqsjiKwBHZz=A@mail.gmail.com>
Subject: Re: [PATCH] drivers: bus: Fix resource leaks in for_each_available_child_of_node
 loop
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

Thanks for your patch!

On Thu, Jul 6, 2023 at 9:13 AM Lu Hongfei <luhongfei@vivo.com> wrote:
> Ensure child node references are decremented properly in
> the error path.

Which error path?

>
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>  drivers/bus/imx-weim.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 52a5d0447390..d05472f7c20f 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -251,6 +251,7 @@ static int weim_parse_dt(struct platform_device *pdev)
>                 else
>                         have_child = 1;
>         }
> +       of_node_put(child);

This is not an error path.

for_each_available_child_of_node() walks a list, getting a reference
to each child, and releasing the reference afterwards.

Have you tested this patch?
I expect the of_node_put() to trigger a refcount underflow error
message on the console.

>
>         if (have_child)
>                 ret = of_platform_default_populate(pdev->dev.of_node,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
