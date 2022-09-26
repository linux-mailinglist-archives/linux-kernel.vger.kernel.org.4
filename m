Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C275EABA8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiIZPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbiIZPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:52:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E7640552
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:39:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m3so9289018eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=U4P4B3TbQzarjVNZDv4gqApQTlrs8KmOMrryfEJMlqQ=;
        b=Fp99UflAw+Dk6Ml2cfIJ16FGICkQxIkBHbnCh9bLj+OhheO2m3OhnF+uD7cHOMH3p5
         gltrAa3kSng8qilmB53Pt+2SS+lChIa9pRgx8dXM46vyh4O6wlXOxNzd/SDdy3AvQwyS
         iHJ7IKKrsqP4Xnm8aMFM0F0Vw5DGOgVoO3wUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=U4P4B3TbQzarjVNZDv4gqApQTlrs8KmOMrryfEJMlqQ=;
        b=vc2GnMie2DQBVwgWxJLYX2/I8oaT8Ag9OI2GW04vhOlMwHtdRQL4sJSB/WPbmYZSHJ
         er4/fFLWYojak2LVRy4iiWi/jR09GDyl1rx3o4HHciF9ovJH0olq9aVjX5klH0R/UJ9v
         d/o5S/I+G3FAqbPyyO3DqoEMokZ4/w8HHVm0YfUebwql38NBzJniiNOwQmjijxEivOxZ
         YnMp//1f0Y/4iqV9L8Yatz3xoN8VaA5Rg1+cGsD+/vIngeiMd+cnVvwchYkfiNyMv885
         1F7FWmEOzMp8rywbJPlri+wmfW5oRYb7n79zRLBlYdIy1Li/5ZEyY2PuZbM2Kcso5hHR
         X90g==
X-Gm-Message-State: ACrzQf2yMvnypyobyF6k30ko0ardKLuGyigs/Z2F7i6Skj/A93TybTDo
        sD/PpncN6Ec73iGgwobHg9GPm/dIKFdQXs61
X-Google-Smtp-Source: AMsMyM7uSaEma7Omo3i2Ow2NXzODP5hYRq4pZ+fNZE4ND0xG41g3FCagVfaKU6pBGwhOeOl0rbbqCg==
X-Received: by 2002:a05:6402:1d54:b0:44e:a683:d041 with SMTP id dz20-20020a0564021d5400b0044ea683d041mr22846312edb.411.1664203188906;
        Mon, 26 Sep 2022 07:39:48 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090653ce00b007828150a2f1sm5841480ejo.36.2022.09.26.07.39.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:39:47 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id n10so10509207wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:39:47 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr13578674wrr.583.1664203187390; Mon, 26
 Sep 2022 07:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220926100839.482804-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220926100839.482804-1-sean.hong@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 26 Sep 2022 07:39:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U1iUHBbA52Jr2mV5JSvTeipTZ3DuAS9mJ6gitBDwp8UQ@mail.gmail.com>
Message-ID: <CAD=FV=U1iUHBbA52Jr2mV5JSvTeipTZ3DuAS9mJ6gitBDwp8UQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add INX N116BCA-EA2
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 26, 2022 at 3:08 AM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> Add support for the INX - N116BCA-EA2 (HW: C1) panel
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 060f4f98bc04..ba75fae7d376 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1889,6 +1889,7 @@ static const struct edp_panel_entry edp_panels[] = {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
>
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
> +       EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_p2e80, "N116BCA-EA2"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),

This patch doesn't apply cleanly. You should be posting it against the
top of drm-misc-next to make it easy to apply.

In this case the merge conflict was trivial so I've fixed it and pushed it but:
* Other folks applying patches won't do this.
* If a patch is more complicated, I won't do this either.

In any case, this is now in drm-misc-next as:

c7bcc1056cff drm/panel-edp: Add INX N116BCA-EA2


-Doug
