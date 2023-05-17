Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20E2705BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjEQAbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjEQAb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:31:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F34F40FB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:31:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f22908a082so219836e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684283485; x=1686875485;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85tj7cERzQUFMgIoMyKczc8IKyrN6wIgIWOqQfpMlDo=;
        b=jtMJJDwYaYhTc6C6QspYc4twjQZDUkykOJa3NicXAKw6p7cDvj58tf8UG8XU7Eplof
         lSBZRY36X547z3GHfO1qt40ZYTPWrriLlT9uTRQ5+6+yPlQPnlijQHbaAmaXgH+yAXWn
         yUdjw1313iag7m0XWkZvBB3tP5p83xAsrIRSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684283485; x=1686875485;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85tj7cERzQUFMgIoMyKczc8IKyrN6wIgIWOqQfpMlDo=;
        b=BDyCL/n+A2IsmPP+BharwZNYsv/YSrA9wq6Nrlz3qyPO0jd+U0vjCm4gCxNRR6q6Dq
         a2/3uysJcwuoFubeef7JTx4Y63iRr73ygZXZXv01XAtZ9NBKIHJgx3diPSY4ydEPSbxy
         sOH3DXfRd8UQSy4Xu4Xt45fTl2029IEV4b/DOzEC55DPpCTqvNSt+MRfnEv6xD5HQitL
         uBw7SAMlnjXDkhXBNuws1OwsZGpDAt5IIePA81z+iGgGrp4TDSrQxw/zGf/GDGWjCLrM
         zjt1WS1L3Le3jW6cDQfhv88FPkbESaenn9A9ui33LvnW+R+tXLxy7vQcZ+ORGAfOsIHc
         nqzg==
X-Gm-Message-State: AC+VfDyv7Iz7ItcQkBkE90gUx4HWcoR37KoGJInbVW5UnZUjSRlvSoBh
        YWZpWiVzBzYr1Wd97hdcKGOHAXoOMtw3/WJEgbfJ2g==
X-Google-Smtp-Source: ACHHUZ508i9q4cn2mVNF2UODCHXuv6hgo4JJfdk/dNcca6S43+rSFSKLjwd8ZnfrBdE9PrUrOAVqlrFERQqt36gzEP8=
X-Received: by 2002:a19:5216:0:b0:4f3:77f6:14b1 with SMTP id
 m22-20020a195216000000b004f377f614b1mr3919564lfb.34.1684283485283; Tue, 16
 May 2023 17:31:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 May 2023 17:31:24 -0700
MIME-Version: 1.0
In-Reply-To: <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
References: <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 16 May 2023 17:31:24 -0700
Message-ID: <CAE-0n52-uUiMyVEsuiaBfbtgAr8x+cAHURMGa56r50TRe9dgHw@mail.gmail.com>
Subject: Re: [PATCH] SoC: rt5682: Disable jack detection interrupt during suspend
To:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        stable@kernel.org
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

Quoting Matthias Kaehlcke (2023-05-16 09:46:30)
> The rt5682 driver switches its regmap to cache-only when the
> device suspends and back to regular mode on resume. When the
> jack detect interrupt fires rt5682_irq() schedules the jack
> detect work. This can result in invalid reads from the regmap
> in cache-only mode if the work runs before the device has
> resumed:

I was wondering why we can't resume the device before device irqs are
enabled (and similarly suspend it after irqs are disabled). It looks
like snd_soc_component_driver is not an actual 'struct driver' instance
so it reimplements PM hooks like suspend and resume for the components
and the suspend hooks run from snd_soc_suspend() at the struct
dev_pm_ops::suspend() path. Adding a noirq variant looks like it isn't
worth it.

>
> [   56.245502] rt5682 9-001a: ASoC: error at soc_component_read_no_lock on rt5682.9-001a for register: [0x000000f0] -16
>
> Disable the jack detection interrupt during suspend and
> re-enable it on resume. The driver already schedules the
> jack detection work on resume, so any state change during
> suspend is still handled.
>
> This is essentially the same as commit f7d00a9be147 ("SoC:
> rt5682s: Disable jack detection interrupt during suspend")
> for the rt5682s.
>
> Cc: stable@kernel.org
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
> index 2935c1bb81f3..5bc46b041786 100644
> --- a/sound/soc/codecs/rt5682-i2c.c
> +++ b/sound/soc/codecs/rt5682-i2c.c
> @@ -267,7 +267,9 @@ static int rt5682_i2c_probe(struct i2c_client *i2c)
>                 ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
>                         rt5682_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
>                         | IRQF_ONESHOT, "rt5682", rt5682);
> -               if (ret)
> +               if (!ret)
> +                       rt5682->irq = i2c->irq;
> +               else
>                         dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);

Not in this patch, but

s/reguest/request/
