Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3929063B63A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 01:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiK2ADY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 19:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiK2ADW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 19:03:22 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1FF186D1;
        Mon, 28 Nov 2022 16:03:20 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ml11so5030777ejb.6;
        Mon, 28 Nov 2022 16:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TdT+BmdIneu3TI8BLD07hqcjbUZk43YKZ9BLkChxuPo=;
        b=ITLzLdBFltzXasiY87QzobnsGAjZcX0eJgUsWviLRRgFDR1MRrM4wsOblh9/4+aPB4
         0JfrE9SZtsCFujA8tq23N3E0AU5kGd/U9kNLDNPzO9Za1iRKHD9TomJ+/ntSxcAv0Y01
         wSMzvLcdHUXNh8lqpaHHYYoxOcyrv3yD1kVbu3x+HlgbjGHJ+F1+yj3mtX3BsWqnO+63
         KTIWo3kYnm8ybgI6QnNyMqUkOFHRs82X2UHVwwg/ihCrBmi5bsW6KRSxLc+CigJKDLRR
         Jsp60TaeQ6fZLG+iPAmuAkRt30YUaa+EjLRWAOZ7g97549Ly0HjnWS7J7uSH5/yZMJ67
         W8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdT+BmdIneu3TI8BLD07hqcjbUZk43YKZ9BLkChxuPo=;
        b=QWy7xPeVhog24jn7VED9vydNy5CdhIZG/J6Azq8vZ44ljo5QJEYd+DyoOgvDtLn75s
         BVnumjbCorBs6FeJmZy0ekUhqLNWD+t04hyg2NC6JDSxkcs8hU0flRH0ECG8Gi5+gWBR
         A0OrywqLaIpzZxm69+tiqHUO/PY08sF/Z7BBLEomjHzH6aWhvCGOZAPmZpRft9ecKfoz
         qoEicKMlhoF4UyGUIOr5SPOIdlJ6gHuriFvuYdEzp7qox1DM2hiGko/WSgZWZWQbXze8
         EacPPvPBH39fyLqWI707tkxoju8xLMmExlzZtpx7d8yOKX6cy2nAJJ1U5oAX/eyi7A7j
         o3Rg==
X-Gm-Message-State: ANoB5pngbqfWxhNEH4XMeiQbqQ9VixjI4Hrmn9TMiDD160q/AuxIk9+H
        gDjDqJymO/cvZpryiIJbed4nCkGew/7bJps1VPg=
X-Google-Smtp-Source: AA0mqf6fZM8tA810LE12Y15mX6MIkaG2UqDn3lS7Cb+AUhc5yb+m4XendEUXBVGYmQ36nUCanxQnZ2pOmiYUlk7SLu8=
X-Received: by 2002:a17:906:79c4:b0:778:e3e2:8311 with SMTP id
 m4-20020a17090679c400b00778e3e28311mr31820692ejo.342.1669680198945; Mon, 28
 Nov 2022 16:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221031232202.131945-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <738a2461-7a6a-286b-89e8-d46a26ec6506@xs4all.nl>
In-Reply-To: <738a2461-7a6a-286b-89e8-d46a26ec6506@xs4all.nl>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 29 Nov 2022 00:02:52 +0000
Message-ID: <CA+V-a8tr9486HV4zvVG3bh4fWNQ-edUDPMZAUM-kKDN-PvRU+w@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] media: i2c: ov5645: Use runtime PM
To:     Hans Verkuil <hverkuil@xs4all.nl>
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
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Hans,

On Mon, Nov 28, 2022 at 1:49 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Prabhakar,
>
> On 11/1/22 00:21, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
<snip>
> > -static void ov5645_set_power_off(struct ov5645 *ov5645)
> > -{
> > -     gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
> > -     gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
> > -     clk_disable_unprepare(ov5645->xclk);
> > -     regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> > -}
> > -
> > -static int ov5645_s_power(struct v4l2_subdev *sd, int on)
> > -{
> > -     struct ov5645 *ov5645 = to_ov5645(sd);
> > -     int ret = 0;
> > -
> > -     mutex_lock(&ov5645->power_lock);
> > -
> > -     /* If the power count is modified from 0 to != 0 or from != 0 to 0,
> > -      * update the power state.
> > -      */
> > -     if (ov5645->power_count == !on) {
> > -             if (on) {
> > -                     ret = ov5645_set_power_on(ov5645);
> > -                     if (ret < 0)
> > -                             goto exit;
> > -
> > -                     ret = ov5645_set_register_array(ov5645,
> > -                                     ov5645_global_init_setting,
> > +     ret = ov5645_set_register_array(ov5645, ov5645_global_init_setting,
> >                                       ARRAY_SIZE(ov5645_global_init_setting));
> > -                     if (ret < 0) {
> > -                             dev_err(ov5645->dev,
> > -                                     "could not set init registers\n");
> > -                             ov5645_set_power_off(ov5645);
> > -                             goto exit;
> > -                     }
> > -
> > -                     usleep_range(500, 1000);
> > -             } else {
> > -                     ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
> > -                     ov5645_set_power_off(ov5645);
> > -             }
> > +     if (ret < 0) {
> > +             dev_err(ov5645->dev, "could not set init registers\n");
> > +             goto exit;
> >       }
> >
> > -     /* Update the power count. */
> > -     ov5645->power_count += on ? 1 : -1;
> > -     WARN_ON(ov5645->power_count < 0);
> > +     usleep_range(500, 1000);
> >
> > -exit:
> > -     mutex_unlock(&ov5645->power_lock);
> > +     return 0;
> >
> > +exit:
> > +     ov5645_set_power_off(dev);
> >       return ret;
>
> smatch gives this warning:
>
> drivers/media/i2c/ov5645.c:687 ov5645_set_power_on() warn: 'ov5645->xclk' from clk_prepare_enable() not released on lines: 687.
>
it's a false positive, as in case of error we jump to the exit label
which calls ov5645_set_power_off() which internally calls
clk_disable_unprepare() for xclk and on success we need to have xclk
ON during s_stream(ON) and eventually the
xclk will be unprepared in s_stream(OFF).

Cheers,
Prabhakar
