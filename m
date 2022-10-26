Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB50B60E672
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiJZR1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiJZR1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:27:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C11FE91C;
        Wed, 26 Oct 2022 10:27:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a67so42685309edf.12;
        Wed, 26 Oct 2022 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YT9dZTW1IcvIzEw+/TA0JI+18vP7bQFANMlj5OcRlS0=;
        b=JqiaRixrE6P83gh5A98tk32sYSCxaspmzZxsQ88zMlY3nS+AKcyK5zmhwfRfPf/cRb
         /sgLqcFiec6hDHwog9PItF12obB7ZatkR5sdEV9UNKSyYWpELvwICcHjogvwQIrS0XqS
         nOT+MqkERNa4x5pYbYEXDos/imjy5P9HYKPZXlOHO3hAF3z8yv/LOh9jnT2pFd21AY6V
         W8CncXWNY3GjB7IS5uWFw47leUf+r3LEBqgspybj3ZZVQ2LKG+oepXxo4kn6ZUWrL2vb
         z06GL/HDOtwlsQGZ4PCqUbSYDInjH6W/eNuIVjESTNeNk2UQN4r30Vpvxw2WBrvm4riV
         CcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YT9dZTW1IcvIzEw+/TA0JI+18vP7bQFANMlj5OcRlS0=;
        b=h6uqM1AJX07gOtfkKmwck8LqnnR8UOvCHNE2N5ibT8j2IUCD9plPJHgbb5zpHaxDN+
         OYJPXU1xwyOXjBDgmF4jEKIURjmdXOoznm7961S1XZFpXU9nQql4Ed0dggDNCmi8fyU6
         30NOl5ZBsAbLlgRZDufS6rl35WLmoTdinKOERwsi4mz7l5ujua7q6y+Lu5c99/SQtHD3
         MQwIiobHc/q58uvziW9lutkThp39ZSocvPlMr+gzYZmf9EDf2jc2RKVjZjWsD9th9T9Q
         x1hJlEVp629+JoHFgpjOsWcu4zgeENaF+nEkyAG/TOKOA+Xo1EKEBPbB3t+JmpNrWbD/
         GRKg==
X-Gm-Message-State: ACrzQf0E8SpJxMud/zzzdgkBBZULxDqnQIrgyNuyb5NNSObPHjYDFk6q
        OIYKZbp/RCM5j0YAo5zCUAIe6hu8/9pMMCq9ZWM=
X-Google-Smtp-Source: AMsMyM7y6mfcVec+7Eztyvd1D+cxLSvKU9h/OLJ85C8F8wtKEbcxFNJBZCTeR7cf49lmMcrZZkoeI8n3Gpioa7WSrNY=
X-Received: by 2002:a05:6402:26cf:b0:45d:48d7:928e with SMTP id
 x15-20020a05640226cf00b0045d48d7928emr40535848edd.275.1666805236670; Wed, 26
 Oct 2022 10:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026130658.45601-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221026171721.4nfvhamguwnrw6zf@pengutronix.de>
In-Reply-To: <20221026171721.4nfvhamguwnrw6zf@pengutronix.de>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Oct 2022 18:26:49 +0100
Message-ID: <CA+V-a8urKEjEKP0n9mki8xx1B9JLOMTYM4F1aXC3h_5Ne0+tCw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] media: i2c: ov5645: Don't return early on failures
 for s_stream(0)
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>, devicetree@vger.kernel.org,
        Jacopo Mondi <jacopo@jmondi.org>, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

Hi Marco,

Thank you for the review.

On Wed, Oct 26, 2022 at 6:17 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Prabhakar,
>
> thanks for the patch, please see below my comments.
>
> On 22-10-26, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Make sure we dont stop the code flow in case of errors while stopping
> > the stream and return the error code of the first error case if any.
> >
> > v4l2-core takes care of warning the user so no need to add a warning
> > message in the driver.
> >
> > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3
> > * Now propagating the first error code in case of failure.
> >
> > v1->v2
> > * New patch
> > ---
> >  drivers/media/i2c/ov5645.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> > index eea3067ddc8b..5702a55607fc 100644
> > --- a/drivers/media/i2c/ov5645.c
> > +++ b/drivers/media/i2c/ov5645.c
> > @@ -996,17 +996,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> >               if (ret < 0)
> >                       goto err_rpm_put;
> >       } else {
> > +             int stream_off_ret = 0;
> > +
> >               ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
>
> If this write failed..
>
> >               if (ret < 0)
> > -                     return ret;
> > +                     stream_off_ret = ret;
> >
> >               ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
> >                                      OV5645_SYSTEM_CTRL0_STOP);
>
> why should this write be successful?
>
Indeed that will fail unless I have a lucky day ;-)

But it seemed to be an overkill for adding an additional check to see
if the previous write succeeded. Do you think this will create an
issue?

Cheers,
Prabhakar
