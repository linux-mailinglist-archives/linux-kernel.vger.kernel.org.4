Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0ED69C739
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjBTJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjBTJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:03:29 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F38FB47B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:03:02 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y140so447483iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vK8cWtmG3hyaLbDRLFgpGqrS4p5hCk6+ikOOD3341A=;
        b=BT2ud7sxoolXPSVz5YqHI7AD9RUl8N77zxnGMFNIRbnYZ5NkGNX9t15jb4JPaWA0gx
         RjgNyOP62hyyw3LtDM51WRaeDbSW+gmOyX365JR1nV/4MS/DGuN+CxjtV2S82wMFZDkJ
         APJfi8WJHRCCVh7BpaS6YJFgaYSTVJLIbJWYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vK8cWtmG3hyaLbDRLFgpGqrS4p5hCk6+ikOOD3341A=;
        b=AFOS4p1E/GcvVruU4twSNxfMxzccY7mmMQoNfDNGBtlA/gAEiGGJ4+8DsB7Ob7zzCX
         WRiFwyq4l/5SuPMRZycPkUfCHFc8JnRhwj0gb8STzAKOdwIHF7k66V2qB6q5zJYZJRQg
         s1TXq+xOB3xpbpopTdUswRBrpbiihA3DWGJrKvt7qa+DY8W7c9OpF87VwEIMNSg1SZwq
         iMKxGIymiodrdZMP36egR2AvRYh8lbxZmiJZZZQlbMz6GFeTX+LYoRoGd2RXig+Nq82U
         5Qfc7Nmxeh5JZxJC+LYNOLZ1Llq8nxX18SR62yt1BUTWlSqS/6sYXzyCSVcEDjm+1Hj0
         RuFg==
X-Gm-Message-State: AO0yUKXcxLr9V77dViJIsvCAAcYEOiwQTlBnsvl9EudL/RSheqx0OBSm
        WI95UNevVoEci1Gsw1D9gGoxz/jGazPupY9sB6qrsg==
X-Google-Smtp-Source: AK7set/kfz8hhDABr4DJ+44LUPCJEAg1cYsDPb4PwPecz9RynTAejbvde/9b9DWWLC1U8dNQIeThAlbfMv3O8bnKttg=
X-Received: by 2002:a05:6638:1342:b0:3c2:c1c9:8bca with SMTP id
 u2-20020a056638134200b003c2c1c98bcamr1153386jad.2.1676883781590; Mon, 20 Feb
 2023 01:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20230204133040.1236799-1-treapking@chromium.org>
 <20230204133040.1236799-4-treapking@chromium.org> <Y+LBzkP+/j6RQ5Jy@ashyti-mobl2.lan>
 <CAEXTbpfxJVyL_TT7j1J0tbEjWnzj6JYOrEJZLa14OdHZQhYopg@mail.gmail.com>
In-Reply-To: <CAEXTbpfxJVyL_TT7j1J0tbEjWnzj6JYOrEJZLa14OdHZQhYopg@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Mon, 20 Feb 2023 17:02:50 +0800
Message-ID: <CAEXTbpe_DGzF+M6Cm041Qkec-FZTXn5G8oCa_P-1cU355MA0JA@mail.gmail.com>
Subject: Re: [PATCH v11 3/9] drm/display: Add Type-C switch helpers
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
        devicetree@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        chrome-platform@lists.linux.dev,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        Robert Foss <rfoss@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I accidentally used HTML mode for the previous email. Sorry about t=
hat.

On Mon, Feb 20, 2023 at 4:41 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> Hi Andi,
>
> Thanks for the review.
>
> On Wed, Feb 8, 2023 at 5:25 AM Andi Shyti <andi.shyti@linux.intel.com> wr=
ote:
>>
>> Hi Pin-yen,
>>
>> [...]
>>
>> > +static int drm_dp_register_mode_switch(struct device *dev,
>> > +                                    struct fwnode_handle *fwnode,
>> > +                                    struct drm_dp_typec_switch_desc *=
switch_desc,
>> > +                                    void *data, typec_mux_set_fn_t mu=
x_set)
>> > +{
>> > +     struct drm_dp_typec_port_data *port_data;
>> > +     struct typec_mux_desc mux_desc =3D {};
>> > +     char name[32];
>> > +     u32 port_num;
>> > +     int ret;
>> > +
>> > +     ret =3D fwnode_property_read_u32(fwnode, "reg", &port_num);
>> > +     if (ret) {
>> > +             dev_err(dev, "Failed to read reg property: %d\n", ret);
>> > +             return ret;
>> > +     }
>> > +
>> > +     port_data =3D &switch_desc->typec_ports[port_num];
>> > +     port_data->data =3D data;
>> > +     port_data->port_num =3D port_num;
>> > +     port_data->fwnode =3D fwnode;
>> > +     mux_desc.fwnode =3D fwnode;
>> > +     mux_desc.drvdata =3D port_data;
>> > +     snprintf(name, sizeof(name), "%pfwP-%u", fwnode, port_num);
>> > +     mux_desc.name =3D name;
>> > +     mux_desc.set =3D mux_set;
>> > +
>> > +     port_data->typec_mux =3D typec_mux_register(dev, &mux_desc);
>> > +     if (IS_ERR(port_data->typec_mux)) {
>> > +             ret =3D PTR_ERR(port_data->typec_mux);
>> > +             dev_err(dev, "Mode switch register for port %d failed: %=
d\n",
>> > +                     port_num, ret);
>> > +
>> > +             return ret;
>>
>> you don't need this return here...
>>
>> > +     }
>> > +
>> > +     return 0;
>>
>> Just "return ret;" here.

This was actually suggested by Angelo in [1]. I personally don't have
a strong opinion on either approach.

[1]https://lore.kernel.org/all/023519eb-0adb-3b08-71b9-afb92a6cceaf@collabo=
ra.com/

Pin-yen
>>
>>
>> > +}
>> > +
>> > +/**
>> > + * drm_dp_register_typec_switches() - register Type-C switches
>> > + * @dev: Device that registers Type-C switches
>> > + * @port: Device node for the switch
>> > + * @switch_desc: A Type-C switch descriptor
>> > + * @data: Private data for the switches
>> > + * @mux_set: Callback function for typec_mux_set
>> > + *
>> > + * This function registers USB Type-C switches for DP bridges that ca=
n switch
>> > + * the output signal between their output pins.
>> > + *
>> > + * Currently only mode switches are implemented, and the function ass=
umes the
>> > + * given @port device node has endpoints with "mode-switch" property.
>> > + * The port number is determined by the "reg" property of the endpoin=
t.
>> > + */
>> > +int drm_dp_register_typec_switches(struct device *dev, struct fwnode_=
handle *port,
>> > +                                struct drm_dp_typec_switch_desc *swit=
ch_desc,
>> > +                                void *data, typec_mux_set_fn_t mux_se=
t)
>> > +{
>> > +     struct fwnode_handle *sw;
>> > +     int ret;
>> > +
>> > +     fwnode_for_each_child_node(port, sw) {
>> > +             if (fwnode_property_present(sw, "mode-switch"))
>> > +                     switch_desc->num_typec_switches++;
>> > +     }
>>
>> no need for brackets here
>>
>> > +
>> > +     if (!switch_desc->num_typec_switches) {
>> > +             dev_dbg(dev, "No Type-C switches node found\n");
>>
>> dev_warn()?
>
>
> I used dev_dbg here because the users might call this without checking if=
 there are mode switch endpoints present, and this is the case for the curr=
ent users (it6505 and anx7625). If we use dev_warn here, there will be warn=
ings every time even on use cases without Type-C switches.
>
> Thanks and regards,
> Pin-yen
>>
>>
>> > +             return 0;
>> > +     }
>> > +
>> > +     switch_desc->typec_ports =3D devm_kcalloc(
>> > +             dev, switch_desc->num_typec_switches,
>> > +             sizeof(struct drm_dp_typec_port_data), GFP_KERNEL);
>> > +
>> > +     if (!switch_desc->typec_ports)
>> > +             return -ENOMEM;
>> > +
>> > +     /* Register switches for each connector. */
>> > +     fwnode_for_each_child_node(port, sw) {
>> > +             if (!fwnode_property_present(sw, "mode-switch"))
>> > +                     continue;
>> > +             ret =3D drm_dp_register_mode_switch(dev, sw, switch_desc=
, data, mux_set);
>> > +             if (ret)
>> > +                     goto err_unregister_typec_switches;
>> > +     }
>> > +
>> > +     return 0;
>> > +
>> > +err_unregister_typec_switches:
>> > +     fwnode_handle_put(sw);
>> > +     drm_dp_unregister_typec_switches(switch_desc);
>> > +     dev_err(dev, "Failed to register mode switch: %d\n", ret);
>>
>> there is a bit of dmesg spamming. Please choose where you want to
>> print the error, either in this function or in
>> drm_dp_register_mode_switch().
>>
>> Andi
>>
>> > +     return ret;
>> > +}
>> > +EXPORT_SYMBOL(drm_dp_register_typec_switches);
>>
>> [...]
