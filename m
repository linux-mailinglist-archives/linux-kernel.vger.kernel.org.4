Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2002A71491A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjE2MJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjE2MJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:09:39 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC0CC7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:09:38 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 56C1F200BB;
        Mon, 29 May 2023 14:09:35 +0200 (CEST)
Date:   Mon, 29 May 2023 14:09:34 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] drm/panel: Add driver for Visionox r66451 panel
Message-ID: <6enrlcmw6a2vxwzocsdbcx7yaltzh3kv4w3yiydzx7ylrtdozn@xzwdj35uj7na>
References: <20230516-b4-r66451-panel-driver-v1-0-4210bcbb1649@quicinc.com>
 <20230516-b4-r66451-panel-driver-v1-2-4210bcbb1649@quicinc.com>
 <3cca2809-fa26-f0cf-2ccc-6737d150b43d@linaro.org>
 <kc65fjf5xibvszx4afomzbmfrlld4vcnwfxqxefrupkaxw74fa@j2op4bj2recm>
 <2d9d7454-0e7d-b6f2-93ff-9eca69380e47@quicinc.com>
 <9d50bc4e-e747-47fa-03cf-4dbd33f778dd@quicinc.com>
 <5becf303-8a23-6ace-2379-0a002e9b48f7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5becf303-8a23-6ace-2379-0a002e9b48f7@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-26 09:32:45, Neil Armstrong wrote:
<snip>
> >>>>> +static int visionox_r66451_bl_update_status(struct backlight_device *bl)
> >>>>> +{
> >>>>> +    struct mipi_dsi_device *dsi = bl_get_data(bl);
> >>>>> +    u16 brightness = backlight_get_brightness(bl);
> >>>>> +
> >>>>> +    return mipi_dsi_dcs_set_display_brightness(dsi, cpu_to_le16(brightness));
> >>>>
> >>>> mipi_dsi_dcs_set_display_brightness() already converts the brightness,
> >>>> so you don't need cpu_to_le16 here.
> >>>
> >>> Tread carefully here: we've had the same issue and conversation on our
> >>> Sony panels where this extra inversion is required.
> >>> set_display_brightness() sends the bytes as little-endian to the panel
> >>> (and it even assumes little-endian in get_display_brightness()) but the
> >>> spec for 16-bit brightness values states that they have to be sent in
> >>> big-endian.  This is why c9d27c6be518b ("drm/mipi-dsi: Fix byte order of
> >>> 16-bit DCS set/get brightness") added
> >>> mipi_dsi_dcs_set_display_brightness_large().
> >>>
> >>> Jessica, if you need to have the endian swap here (should be very easy
> >>> to test with a real panel, but it should be given the max_brightness
> >>> value being over 8 bits) please switch to the _large() variant.
> >>
> >> Got it, thanks for the heads up!
> > 
> > Hi Marijn,
> > 
> > Just wanted to update this thread -- I've checked the backlight brightness values in the sysfs and it matches the value being given in the panel driver (255), so I think it should be fine to use *_set_display_brightness() without the _large() variant.
> 
> Sure, I was also misleaded by you using cpu_to_le16() but as Dmitry said it's already
> done in mipi_dsi_dcs_set_display_brightness() and a no-op on LE arm64 platforms anyway.

Yuck, right, it's cpu_to_le16 here and not cpu_to_be16.  @Jessica, can
you please remove this misleading conversion?
mipi_dsi_dcs_set_display_brightness() takes a native u16, not a specific
__le16.

- Marijn
