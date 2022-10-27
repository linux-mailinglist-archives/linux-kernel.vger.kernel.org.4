Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E88460F402
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiJ0JtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiJ0JtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:49:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A65A96396;
        Thu, 27 Oct 2022 02:49:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a67so1706336edf.12;
        Thu, 27 Oct 2022 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IWPyJZW5AVoC+nrDVVz16Q/2YNSTwOB7weYuST5UkDM=;
        b=jDWhFlSODS1EWcJZZeGu65cVUR9mHawB/5m7LVZcG1/shMrHhfwkLWzJ9qiJlehoR/
         WoD2GU6tA1YkVAB5uX6meQVb2pkppteLdaU+N4F/LHK2ujAUkKLHtgNpqewbR8HdfeOR
         NPDqf6vccVGlvfM77hnmobflfGQ1TFycN1HdfyWbBTczYXJ29RLojyk9JmfqSFUGaeay
         KmzBRb1KzC2YS7pYl+JQRBwOKBqC3IteefHZy8KY0LdBh4E9cuBuUfIFikzbB/GqN1RZ
         B3IE2uVwYM4EhHKDqUtHio8mqPTlc34G0or/HSsw2FHYSBrazekliDIwZk/AXpMgUWrc
         ukZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWPyJZW5AVoC+nrDVVz16Q/2YNSTwOB7weYuST5UkDM=;
        b=CorCta9FF3TdyiAzUIIEkg4G7RGqxTnImPRWaI89C1Zd0D824zfB/MD/mpb6edGMM0
         hc8BIuAXmCv19Al9KiCwIWR27JMNKkkdHWCXdy6fmrBueWVa9Va8tq3weW25/rJVx9DF
         24ZqyOaitmiOHGUIR55elXLgzTaqpFUwzx06t5VSNkejejzbQrzKmUXhjEO4X/u6zEo+
         +3sfRNGpVArR9rff3exj4gJbwATkvffd6ZlJZafuvzIMUGhkJf58pQd9H2KwO9d708te
         pGnfcMebx6wGyL0TIYy0oyAQmH5I9IhQO4pGssrZTA99i5Gyz6+AuOKk+iYsCeexE9TE
         9L+Q==
X-Gm-Message-State: ACrzQf3IZC4oe+QT/1n25m5qLh3S0oljWCQlNmQZRm9b6f5pMcqz/eoJ
        w0N+JAofIF5mON3V3JODsmakE9EqtcxWC3HqCZY=
X-Google-Smtp-Source: AMsMyM50d4ocHboYT2FXOEMzrCVMW05GrxeaNf3kP4FkUT2jOdfQ2qVD18OBeNLY7N3Ce30ysegqhAHqb2ijaiwzG3w=
X-Received: by 2002:a05:6402:26cf:b0:45d:48d7:928e with SMTP id
 x15-20020a05640226cf00b0045d48d7928emr43252923edd.275.1666864158072; Thu, 27
 Oct 2022 02:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026130658.45601-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y1pN0oksKeauTpBA@paasikivi.fi.intel.com>
In-Reply-To: <Y1pN0oksKeauTpBA@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 27 Oct 2022 10:48:51 +0100
Message-ID: <CA+V-a8uqPenMqbhixzefspsffLH=P7i7DJ53C7hfv0hMcgGutQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] media: i2c: ov5645: Use runtime PM
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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

Hi Sakari,

On Thu, Oct 27, 2022 at 10:22 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> Thanks for the update.
>
> On Wed, Oct 26, 2022 at 02:06:55PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Switch to using runtime PM for power management.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > v2->v3
> > * Jumped to err_pm_runtime label in case of sd register failure
> > * Now calling pm_runtime_mark_last_busy() before pm_runtime_put_autosuspend()
> >   call
> > * Now calling pm_runtime_put_sync() in case s_stream(1) fails
> > * In s_stream(0) no calling pm_runtime_mark_last_busy() and
> >   pm_runtime_put_autosuspend()
> > * Included RB tag from Laurent.
> >
> > v1->v2
> > * Moved pm_runtime_*_autosuspend() calls after registering the subdev.
> > ---
> >  drivers/media/i2c/Kconfig  |   2 +-
> >  drivers/media/i2c/ov5645.c | 141 +++++++++++++++++++------------------
> >  2 files changed, 73 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > index 7806d4b81716..c0edd1017fe8 100644
> > --- a/drivers/media/i2c/Kconfig
> > +++ b/drivers/media/i2c/Kconfig
> > @@ -459,7 +459,7 @@ config VIDEO_OV5640
> >  config VIDEO_OV5645
> >       tristate "OmniVision OV5645 sensor support"
> >       depends on OF
> > -     depends on I2C && VIDEO_DEV
> > +     depends on I2C && PM && VIDEO_DEV
>
> I think you can drop the PM dependency --- the driver will work fine
> without CONFIG_PM.
>
Agreed, I'll send a new version dropping this and fixing the comments
on patch #5 and patch #8.

> Although one could question why do we have CONFIG_PM. Some systems won't
> boot without it and who would want to consume more power than necessary?
>
> Could this be removed altogether? Or perhaps we could add CONFIG_PM
> dependency to V4L2 and DVB? :-)
>
Or rather this option should be selected by the platform itself rather
than subsystem?

Cheers,
Prabhakar
