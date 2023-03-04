Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599006AACC4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 22:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCDVpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 16:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 16:45:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC2125B4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 13:45:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o15so23714291edr.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 13:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKDIxvFH4F3D/Bp8+BmLpjtlutHoc8KA5An4csidBcU=;
        b=jzS3yeCClEU5ic+r6pgQ/vQwrY4Lj324IPOIkZYoWfvdmucb1ln4sYfsza2nWDWTNL
         4mtcMhMyNlIRWv24QYhcwEtOU12QAYKj9EURBj5bcbmpQoF5570sCwvVOR+IWU30DjI/
         7AB3YMigQcTKQX2rwSYrtfKZwOPcSK7sXlBMzB89QkV5CPJhzpYwTu0LTWwr1CPk5bfT
         5fkm41zDUcAzcqfeaR4Sq3b9aKdO1oRkZ3f6dXusQwZ70heMW1IzC3n+O7Kpew8BPliH
         4AQkZ6ptMn5c7dafr/RgoabPd0AAMGkJUl0j6IH8PTgxEdPCpRvcIzAKTKg/4oLKEwWd
         WXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKDIxvFH4F3D/Bp8+BmLpjtlutHoc8KA5An4csidBcU=;
        b=jFbmOm178PoFBnQoaAgaH5jagQrU3H0uHnDP2OLaARgDXEG4iY4R7n4Lx7HASeY9lr
         luMmhjdQBeQRo5pcNOwVrW1XZOvkbigNGA1YJJ66vn2aDe2WWbtH45hQvqa0Nd9NGJBe
         O/9eMuQW64eaWN7mulTiTZ7ms2tcaXWAFyX2sapCw8hv8Kh+4m6GMLSqvtEpeJVAPCfS
         V54r4nUclSpUnZwTUuA/H7d7DGmL8sSdummP3t3IJqcTMZZ8G0I1HXFlLZ/dg/gGd1ZF
         9G0sWz57InsVksF8SgpM95TmdWGybdUJboKBo1kK73KJ8wyiAnqrkO81VETccIbKEY8O
         mQ0A==
X-Gm-Message-State: AO0yUKX+F8vs50XgqtAvyEKW6yPM9DGG+WsGvRs+3vtZal9qMQc2fBOu
        CP5q6vIJbvjvpgWdQrDPhNHWxAktgPQWZywKiJQ=
X-Google-Smtp-Source: AK7set9wY0tIW78yGxDw99q432fpv27SQCH8++tgi5/mw5cQNNLf7m3KivFDf11whC1GeXIRw82onTzmkovP2vSJ4lI=
X-Received: by 2002:a17:906:f18f:b0:8af:2ad8:3453 with SMTP id
 gs15-20020a170906f18f00b008af2ad83453mr5871550ejb.6.1677966304797; Sat, 04
 Mar 2023 13:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20230303123312.155164-1-christianshewitt@gmail.com>
In-Reply-To: <20230303123312.155164-1-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 4 Mar 2023 22:44:53 +0100
Message-ID: <CAFBinCDwGW-NaMx63t2v=Rt298MY1W13A1b1BDwHN72q7ifbZQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/meson: fix 1px pink line on GXM when scaling video overlay
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 1:33=E2=80=AFPM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Playing media with a resolution smaller than the crtc size requires the
> video overlay to be scaled for output and GXM boards display a 1px pink
> line on the bottom of the scaled overlay. Comparing with the downstream
> vendor driver revealed VPP_DUMMY_DATA not being set [0].
>
> Setting VPP_DUMMY_DATA prevents the 1px pink line from being seen.
>
> [0] https://github.com/endlessm/linux-s905x/blob/master/drivers/amlogic/a=
mports/video.c#L7869
>
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controll=
er")
> Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
> Change since v1:
> This time I sent the right patch from the correct branch; the wording in
> v1 is incorrect and the change to meson_registers.h is not required.
Thanks Christian - I was about to ask whether you could isolate which
part of the original patch fixes the issue, but you've been quicker
:-)
