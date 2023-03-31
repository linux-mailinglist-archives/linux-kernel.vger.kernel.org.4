Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD916D17AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCaGoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCaGn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:43:58 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25ABD502
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:43:43 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k17so9352769iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680245023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJMiIBnIOha8INMf/aKt6n4a45jL1+cW2jXTn14ItTU=;
        b=NpfpugV6wKsgTbPpOaWm54+nfos2fguzyrvBG1BEwsGGsQPnuppnKYbIC4GWGdcZoW
         jZYwkukueXAmwAc/sXqgRgVX603AGnSpVaV/lkwM8NxqsweY8JQpf+/+LwoUFHBTr8BA
         VOCkuekSuf67GI8TQDNSd1Ei5xaOvqVOWwRmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680245023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJMiIBnIOha8INMf/aKt6n4a45jL1+cW2jXTn14ItTU=;
        b=21YIxQCvV2+2WkokRK4gWbwgVGIr5BQXkrAFCun1ysqP4cmkILOAcXMYtDFM0Jz3fZ
         XCKQ2B8kUAuavkPsKQnqgHiygDtSNkeyQkL3OxDG96tYVIbeCQmYMxvqcOSLMciV1T5J
         TfWXVnfk5wC5LV1hXM0t0Qu7z6nDcGeu2eC5gD30yOC1/VkVgretjOeTlPxINbZ/2LbW
         exL+QOUibgMSSwu+sy5/eNyjH1QOdQYRaeTi8s8MD5+OtMPW+50QS6c5v4IO+Y4KkAHS
         dlrUSOh8kvIVOt3FosDje9zaf1H3eIkke0x//SylgO0Q98IFwKFiW2y3QtH5nPEwZN1U
         lDdA==
X-Gm-Message-State: AO0yUKU8yA9Cwyt7JZsnud11VI/aaiTXRNs4w0LSMDVf1T7hwVAj4cSe
        X4Y9RPc6VBWPGA8uoB+4QkxCeBbQ+F2afmotpXkEdw==
X-Google-Smtp-Source: AK7set+SXmn8wNLCLzHsExgu0fibwth1DHdBynRwGrcMxlN2IJdRta9xWzqdv5f7mEqipgjZ8W0DCENK8hCl2a3ZWj8=
X-Received: by 2002:a02:95a1:0:b0:3ec:dc1f:12dd with SMTP id
 b30-20020a0295a1000000b003ecdc1f12ddmr10175738jai.6.1680245023333; Thu, 30
 Mar 2023 23:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230322104639.221402-1-treapking@chromium.org>
 <20230322104639.221402-4-treapking@chromium.org> <ZBrgD61p/p17IOJL@smile.fi.intel.com>
 <CAEXTbpcLU6jr2MoDEhZCz3wWzXmJATwHU+Tird-3Q9bXrGeTnA@mail.gmail.com>
In-Reply-To: <CAEXTbpcLU6jr2MoDEhZCz3wWzXmJATwHU+Tird-3Q9bXrGeTnA@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 31 Mar 2023 15:43:32 +0900
Message-ID: <CAEXTbpf8JXRYv-5nA_sNEM_D2jP6Hv_kp9o1vkrsEXjyKuOS6g@mail.gmail.com>
Subject: Re: [PATCH v14 03/10] drm/display: Add Type-C switch helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-acpi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, dri-devel@lists.freedesktop.org,
        Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:36=E2=80=AFAM Pin-yen Lin <treapking@chromium.or=
g> wrote:
>
> Hi Andy,
>
> Thanks for the review.
>
> On Wed, Mar 22, 2023 at 8:01=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Mar 22, 2023 at 06:46:32PM +0800, Pin-yen Lin wrote:
> > > Add helpers to register and unregister Type-C "switches" for bridges
> > > capable of switching their output between two downstream devices.
> > >
> > > The helper registers USB Type-C mode switches when the "mode-switch"
> > > and the "reg" properties are available in Device Tree.
> >
> > ...
> >
> > > +config DRM_DISPLAY_DP_TYPEC_HELPER
> >
> > > +     bool
> > > +     default y
> >
> >         def_bool y
> >
> > > +     depends on DRM_DISPLAY_HELPER
> > > +     depends on DRM_DISPLAY_HELPER=3DTYPEC || TYPEC=3Dy
> > > +     help
> > > +       DRM display helpers for USB Type-C Displayport Alternate mode=
.
> >
> > Hmm... Dunno if this help is enough.
>
> Okay I'll add more detail in the next version.
> >
> > ...
> >
> > > +     snprintf(name, sizeof(name), "%pfwP-%u", fwnode, port_num);
> >
> > Would it be possible to have a dup in name and would it be a problem if=
 so?
> >
> The port_num is included in the name, so the names should be unique.
> Also, the fwnode name actually contains the reg property, so this name
> looks like "endpoint@0-1" now... I'll change the name from fwnode name

This should be "endpoint@0-0", or "endpoint@1-1@. The `port_num` value
has the same number as the `reg` property

> to dev_name() per Dmitry's comment.
> > ...
> >
> > > +/**
> > > + * drm_dp_register_typec_switches() - register Type-C switches
> > > + * @dev: Device that registers Type-C switches
> > > + * @port: Device node for the switch
> > > + * @switch_desc: A Type-C switch descriptor
> > > + * @data: Private data for the switches
> > > + * @mux_set: Callback function for typec_mux_set
> > > + *
> > > + * This function registers USB Type-C switches for DP bridges that c=
an switch
> > > + * the output signal between their output pins. This function uses d=
evm_kcalloc
> > > + * to allocate memory, so it is expected to only call this in the dr=
iver probe
> > > + * functions.
> > > + *
> > > + * Currently only mode switches are implemented, and the function as=
sumes the
> > > + * given @port device node has endpoints with "mode-switch" property=
.
> > > + * The port number is determined by the "reg" property of the endpoi=
nt.
> >
> > `kernel-doc -v ...` should complain on absence of "Return" section.
> >
> > > + */
> >
> > ...
> >
> > > +     switch_desc->typec_ports =3D devm_kcalloc(dev, switch_desc->num=
_typec_switches,
> > > +                                             sizeof(struct drm_dp_ty=
pec_port_data),
> >
> >                                                 sizeof(*switch_desc_typ=
ec_ports),
> >
> > ?
> >
> > > +                                             GFP_KERNEL);
> > > +     if (!switch_desc->typec_ports)
> > > +             return -ENOMEM;
> >
> > ...
> >
> > > +#ifdef CONFIG_DRM_DISPLAY_DP_TYPEC_HELPER
> >
> > Ah, maybe this should use IS_REACHABLE() ?
>
> CONFIG_DRM_DISPLAY_DP_TYPEC_HELPER is a boolean. Is there any
> difference between IS_REACHABLE and ifdef when the given config is a
> boolean?
> >
> > > +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_des=
c *switch_desc);
> > > +int drm_dp_register_typec_switches(struct device *dev, struct fwnode=
_handle *port,
> > > +                                struct drm_dp_typec_switch_desc *swi=
tch_desc,
> > > +                                void *data, typec_mux_set_fn_t mux_s=
et);
> > > +#else
> > > +static inline void drm_dp_unregister_typec_switches(struct drm_dp_ty=
pec_switch_desc *switch_desc)
> > > +{
> > > +}
> > > +static inline int drm_dp_register_typec_switches(
> > > +             struct device *dev, struct fwnode_handle *port,
> > > +             struct drm_dp_typec_switch_desc *switch_desc, void *dat=
a,
> > > +             typec_mux_set_fn_t mux_set)
> > > +{
> > > +     return -EOPNOTSUPP;
> > > +}
> > > +#endif
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
>
> Best regards,
> Pin-yen
> >
