Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C46D120C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjC3WUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3WUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:20:31 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F01B74B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:20:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54606036bb3so216352147b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680214829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XHbYcIgrFHrYvAFgKxf4i1nvwZgCPxOVsUNf1NNENs=;
        b=XUlxAl8du6o4u/LV1RNVFNvw7n3F7NCnc5aU2soy13kDVY6OC2+6IadcPrBEv7pf3A
         ftrDS1KsftjQmiYSNS/rmQb5R3qIabtbFTOumMp0SkG3mhthWgvPEJ6Uh5e5bp8xVGIn
         vsLEhwwB3R8HrOvqHzm9upBbJGRYI0qZQ02XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680214829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XHbYcIgrFHrYvAFgKxf4i1nvwZgCPxOVsUNf1NNENs=;
        b=xK+SDAA6fBaQVHFB9ohUd9D6aEwnwpSe+GTBaI2nI+5LazyrC796FqekWe7dkLo5hM
         wS3/jQB9PZNimF5FcU5LJ9xflamLhYjd5rL/vWpURjxy6JQtaoNoOhBUcBGcoKMuuepR
         dM1cf7hD4YFTB/6u6+l54CoOhHGT5NA3IEV0+EF8Ou7CIAF3Ecs0mzYmtV9zwH8JaqRp
         VqVtWzdM28xGLhR8Q8OnL3+kh+VhZq1YuRtxKuYi8jTjtdTqV7ny1At5pU4bu/lyQWer
         2kT8VjqjZjj7Wbgsb6rY73XuFYRHfR9vqjLad9YcTrxxVJPptGOUSrjTCI42XvEtwZdo
         Y3KQ==
X-Gm-Message-State: AAQBX9e9/DhWsoqWf1EyQqRxpjV8/8kkYT929KwuAuwuQAp1MqPFlKe2
        kZxs8TV41kJThh23O8coBIcUOZnx9NYi1HN24Kc=
X-Google-Smtp-Source: AKy350Zwcy/+1NIU4GraQHQjbbQGRklfjeHhhDslDG8jKZuFKs83uyRRTw3ObP6BFVMekzkaChrGtQ==
X-Received: by 2002:a0d:cb45:0:b0:538:4f61:494e with SMTP id n66-20020a0dcb45000000b005384f61494emr22415124ywd.47.1680214829562;
        Thu, 30 Mar 2023 15:20:29 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id z4-20020a81e244000000b005463239c018sm124139ywl.74.2023.03.30.15.20.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 15:20:28 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id n125so25392013ybg.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:20:28 -0700 (PDT)
X-Received: by 2002:a05:6902:1501:b0:b6d:80ab:8bb6 with SMTP id
 q1-20020a056902150100b00b6d80ab8bb6mr16743748ybu.1.1680214828159; Thu, 30 Mar
 2023 15:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230330220251.2388494-1-javierm@redhat.com>
In-Reply-To: <20230330220251.2388494-1-javierm@redhat.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 30 Mar 2023 15:20:16 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOtyBgr0o+bhjOScjs2h3oUKdouoAi4m+Z=R=Bho=iRFA@mail.gmail.com>
Message-ID: <CA+ASDXOtyBgr0o+bhjOScjs2h3oUKdouoAi4m+Z=R=Bho=iRFA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Remove non-existing pwm-delay-us DT property
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <eballetbo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lin Huang <hl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, zain wang <wzz@rock-chips.com>
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

On Thu, Mar 30, 2023 at 3:03=E2=80=AFPM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> There is no neither a driver that parses this nor a DT binding schema tha=
t
> documents it so let's remove it from the DTS files that make use of this.
>
> The properties that exist are post-pwm-on-delay-ms and pwm-off-delay-ms,
> defined in the pwm-backlight DT binding. So probably what these DTS want
> is something like following:
>
>         backlight: backlight {
>                 compatible =3D "pwm-backlight";
>                 enable-gpios =3D <&gpio4 21 GPIO_ACTIVE_HIGH>;
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&bl_en>;
>                 pwms =3D <&pwm1 0 1000000 0>;
>                 post-pwm-on-delay-ms =3D <10>;
>                 pwm-off-delay-ms =3D <10>;
>         };
>
> But that should be follow-up change if that is the case. Because otherwis=
e
> it would be change in behaviour, since currently pwm-delay-us is a no-op.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

pwm-delay-us seems to have been a downstream-only ("CHROMIUM", if
you're familiar with ChromiumOS kernel parlance) change that seems
like a combination of the two now-upstream properties you point at. I
looked through the first use of pwm-delay-us on RK3399 Gru systems,
and I can't find a spec reference that said it was needed; perhaps it
was needless copy/paste imitation?

So, simple deletion is probably fine:

Reviewed-by: Brian Norris <briannorris@chromium.org>
