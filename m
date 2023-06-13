Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47872D754
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbjFMCUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjFMCUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:20:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B0C1730
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 19:20:09 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f63ea7bfb6so5692546e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 19:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686622808; x=1689214808;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1shOEn6nPaVCEbd4LM/XYWlmeirPeNDnDCpFLJAn8M=;
        b=RAtFtf51gawv3C7hUz5ysqbwI7ecg+XXrOydFkRhKemur5yZN3RD5q9GAF5/Sljofw
         17WN4Cj3ugfoMZJkMFYnB+Hk0AduWXEiNApie/YI1gmnWVvRbYLenB1FDQo0vpq/pz35
         O+DasHqbUyrEBTgqNENAOrq2J3LT+GYiG3h00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686622808; x=1689214808;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1shOEn6nPaVCEbd4LM/XYWlmeirPeNDnDCpFLJAn8M=;
        b=Ox3szqe7KNrJQXTqsQJ2SPowKVPoY33BZQW+R0GvQNZhjj5rY37HD6hlK6YzprR/af
         3BnY6dioeZpT3qpOwQiChXEfE8vjPW8saVlr2LN2UQLJIFJPxySupON0CGcGk31m4aau
         ARMGiN/F02shx0YmKQPtGZcf1p9Pphn2lmWVbqMEoNQTcUwGiYZoDkqQ3436lMRFyqoR
         TSgOnreAMmfk5AINAv/18yCgXZR1HHHyJ8yGtqj76Qff7fP7a3sFz1ZcUYGsq2qlMJ6H
         3kig9du5MosErLBtbf6+TPyBAJRhthQAvNymmLJxwCtIdE5t3jPaB/Vhz+mHjFDS8p9u
         R86w==
X-Gm-Message-State: AC+VfDwC4IHyKZ/5LWfi7ORACm7Jz+ii7bj5DCvbKtOX0Y5mEgF6KIk5
        jqGznI0kh5bGYfBp0xqmLmSOOE6QO/Lnu2RwRJBT8g==
X-Google-Smtp-Source: ACHHUZ5nU/RT+l0B8eGNQK7cVvbMPzWQeVYVWx36X8mWJm2OkkWZ8BTKX3tUWqYeB7PdXuhD39Z6AeV/fsdbkM+IuZ0=
X-Received: by 2002:a2e:868b:0:b0:2b1:c783:b905 with SMTP id
 l11-20020a2e868b000000b002b1c783b905mr3549460lji.15.1686622807918; Mon, 12
 Jun 2023 19:20:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jun 2023 19:20:07 -0700
MIME-Version: 1.0
In-Reply-To: <20230612165302.1.I24b838a5b4151fb32bccd6f36397998ea2df9fbb@changeid>
References: <20230612165302.1.I24b838a5b4151fb32bccd6f36397998ea2df9fbb@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 12 Jun 2023 19:20:07 -0700
Message-ID: <CAE-0n50E+ERC2tvTmb2_FMas8QETgdogm8A1d_bkmhhwafsn6w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-06-12 16:53:03)
> Memory for the "struct device" for any given device isn't supposed to
> be released until the device's release() is called. This is important
> because someone might be holding a kobject reference to the "struct
> device" and might try to access one of its members even after any
> other cleanup/uninitialization has happened.
>
> Code analysis of ti-sn65dsi86 shows that this isn't quite right. When
> the code was written, it was believed that we could rely on the fact
> that the child devices would all be freed before the parent devices
> and thus we didn't need to worry about a release() function. While I
> still believe that the parent's "struct device" is guaranteed to
> outlive the child's "struct device" (because the child holds a kobject
> reference to the parent), the parent's "devm" allocated memory is a
> different story. That appears to be freed much earlier.
>
> Let's make this better for ti-sn65dsi86 by allocating each auxiliary
> with kzalloc and then free that memory in the release().
>
> Fixes: bf73537f411b ("drm/bridge: ti-sn65dsi86: Break GPIO and MIPI-to-eDP bridge into sub-drivers")
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Thanks!

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 597ceb7024e0..db1461cc3170 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -464,27 +464,32 @@ static void ti_sn65dsi86_delete_aux(void *data)
>         auxiliary_device_delete(data);
>  }
>
> -/*
> - * AUX bus docs say that a non-NULL release is mandatory, but it makes no
> - * sense for the model used here where all of the aux devices are allocated
> - * in the single shared structure. We'll use this noop as a workaround.
> - */
> -static void ti_sn65dsi86_noop(struct device *dev) {}
> +static void ti_sn65dsi86_aux_device_release(struct device *dev)
> +{
> +       struct auxiliary_device *aux = container_of(dev, struct auxiliary_device, dev);
> +
> +       kfree(aux);
> +}
>
>  static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
> -                                      struct auxiliary_device *aux,
> +                                      struct auxiliary_device **aux_out,
>                                        const char *name)
>  {
>         struct device *dev = pdata->dev;
> +       struct auxiliary_device *aux;
>         int ret;
>
> +       aux = kzalloc(sizeof(*aux), GFP_KERNEL);

Check for allocation failure?

> +
>         aux->name = name;
>         aux->dev.parent = dev;
> -       aux->dev.release = ti_sn65dsi86_noop;
> +       aux->dev.release = ti_sn65dsi86_aux_device_release;
>         device_set_of_node_from_dev(&aux->dev, dev);
>         ret = auxiliary_device_init(aux);
> -       if (ret)
> +       if (ret) {
> +               kfree(aux);
>                 return ret;
> +       }
>         ret = devm_add_action_or_reset(dev, ti_sn65dsi86_uninit_aux, aux);
>         if (ret)
>                 return ret;
> @@ -494,6 +499,9 @@ static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
>                 return ret;
>         ret = devm_add_action_or_reset(dev, ti_sn65dsi86_delete_aux, aux);
>

Nitpick: Stick this if line to the line above

> +       if (!ret)
> +               *aux_out = aux;
> +
>         return ret;
