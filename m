Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D576EF5FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbjDZOFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbjDZOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:05:21 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAEA6591
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:05:20 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3294eacb2f6so17779835ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682517919; x=1685109919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj7WRPReo3X43Tifzj8RaGCINknzpjb7t0vp2Cx5wEA=;
        b=m5VsICDMGjVd2yiJYEn6dyO90Z+fWmKOxoXEeusA85XRK8jHAJAJ+N18ipdwpRf+FR
         ReJMVhi3lGbG3TcDhik/fl7Tb0wWsQ1JFDYdkKv8NIYO3SSoaQNBGFSuRDHLGDGn+rhq
         Nyc/29v8HpsCR8+KdXAMX1Ux4qoRz/bCwFbFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682517919; x=1685109919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj7WRPReo3X43Tifzj8RaGCINknzpjb7t0vp2Cx5wEA=;
        b=gssnk+WGtaxzgmGKv82lNSXnOxgXsfm6xfd1reFIN9/YNkHlYI5rcedzEj/KS+cwO8
         scx5vI6r9u783cF9LG2jCOMHeLaDPTWtxhp3SfX3VeZ480yRYQ9CISkB0a4LbrYXlbLS
         hTxFxwhIXwOdl2khJSESKv1oG1/3ly4F1pwScXVeHp5A6BXtGhThPhB2ELTT9TciUTlV
         R08j515wBQirN8sHMTUnBRzxVAV++2mu0TIFciIWgDFQgYhXK18Kw/Oc0mXvVF4xpOI8
         27nxC7RGuTMr9pnX259+L6Q6htt/+5/QhG51bCQKpSQDq2I2v4FjiDZVoBCjOz1hsPDT
         rGNg==
X-Gm-Message-State: AAQBX9eGhJbrOzIXCcHTU7dvLG6cZ6WXSPPoRdgMeCeYYm0RMzyu7G8i
        Fqayz4tt2JOiHB94QWlHVXRzLagviN3XmVt9114=
X-Google-Smtp-Source: AKy350aJ6eeRKdjRi+9zpAS1iJTbk73T30+RBAPWmPreDJ/TFW4cqdouxWOH7GGF/lQtVa4ODKF6QA==
X-Received: by 2002:a92:d951:0:b0:32c:9c5e:900c with SMTP id l17-20020a92d951000000b0032c9c5e900cmr10621918ilq.8.1682517918941;
        Wed, 26 Apr 2023 07:05:18 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id e2-20020a022102000000b0040f7b91108esm4294700jaa.144.2023.04.26.07.05.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:05:17 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-329577952c5so260325ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:05:17 -0700 (PDT)
X-Received: by 2002:a05:6e02:2199:b0:326:55d0:efad with SMTP id
 j25-20020a056e02219900b0032655d0efadmr306665ila.12.1682517916542; Wed, 26 Apr
 2023 07:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230426093231.1466984-1-fshao@chromium.org> <20230426093231.1466984-3-fshao@chromium.org>
In-Reply-To: <20230426093231.1466984-3-fshao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Apr 2023 07:05:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VY+01V7hBfUeZKR3OnnTcNuuYb-vhLWGgdS5jb4QTLBQ@mail.gmail.com>
Message-ID: <CAD=FV=VY+01V7hBfUeZKR3OnnTcNuuYb-vhLWGgdS5jb4QTLBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: i2c-hid: goodix: Add support for
 "goodix,no-reset-during-suspend" property
To:     Fei Shao <fshao@chromium.org>
Cc:     Jeff LaBundy <jeff@labundy.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 26, 2023 at 2:33=E2=80=AFAM Fei Shao <fshao@chromium.org> wrote=
:
>
> In the beginning, commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the
> reset line to true state of the regulator") introduced a change to tie
> the reset line of the Goodix touchscreen to the state of the regulator
> to fix a power leakage issue in suspend.
>
> After some time, the change was deemed unnecessary and was reverted in
> commit 557e05fa9fdd ("HID: i2c-hid: goodix: Stop tying the reset line to
> the regulator") due to difficulties in managing regulator notifiers for
> designs like Evoker, which provides a second power rail to touchscreen.
>
> However, the revert caused a power regression on another Chromebook
> device Steelix in the field, which has a dedicated always-on regulator
> for touchscreen and was covered by the workaround in the first commit.
>
> To address both cases, this patch adds the support for the new
> "goodix,no-reset-during-suspend" property in the driver:
> - When set to true, the driver does not assert the reset GPIO during
>   power-down.
>   Instead, the GPIO will be asserted during power-up to ensure the
>   touchscreen always has a clean start and consistent behavior after
>   resuming.
>   This is for designs with a dedicated always-on regulator.
> - When set to false or unset, the driver uses the original control flow
>   and asserts GPIO and disable regulators normally.
>   This is for the two-regulator and shared-regulator designs.
>
> Signed-off-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v2:
> - Do not change the regulator_enable logic during power-up.
>
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 26 +++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hi=
d/i2c-hid-of-goodix.c
> index 0060e3dcd775..fc4532fcadcc 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> @@ -28,6 +28,7 @@ struct i2c_hid_of_goodix {
>         struct regulator *vdd;
>         struct regulator *vddio;
>         struct gpio_desc *reset_gpio;
> +       bool no_reset_during_suspend;
>         const struct goodix_i2c_hid_timing_data *timings;
>  };
>
> @@ -37,6 +38,20 @@ static int goodix_i2c_hid_power_up(struct i2chid_ops *=
ops)
>                 container_of(ops, struct i2c_hid_of_goodix, ops);
>         int ret;
>
> +       if (ihid_goodix->no_reset_during_suspend) {
> +               /*
> +                * This is not mandatory, but we assert reset here (inste=
ad of
> +                * during power-down) to ensure the device will have a cl=
ean
> +                * state after powering up, just like the normal scenario=
s will
> +                * have.
> +                *
> +                * Note that in this case we assume the regulators should=
 be
> +                * (marked as) always-on, so the regulator core knows wha=
t to
> +                * do with them in the following regulator_enable() calls
> +                * despite regulator_disable() was not called previously.
> +                */
> +               gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
> +       }
>         ret =3D regulator_enable(ihid_goodix->vdd);
>         if (ret)
>                 return ret;
> @@ -60,6 +75,14 @@ static void goodix_i2c_hid_power_down(struct i2chid_op=
s *ops)
>         struct i2c_hid_of_goodix *ihid_goodix =3D
>                 container_of(ops, struct i2c_hid_of_goodix, ops);
>
> +       /*
> +        * Don't assert reset GPIO if it's set.
> +        * Also, it's okay to skip the following regulator_disable() call=
s
> +        * because the regulators should be always-on in this case.
> +        */
> +       if (ihid_goodix->no_reset_during_suspend)
> +               return;
> +
>         gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
>         regulator_disable(ihid_goodix->vddio);
>         regulator_disable(ihid_goodix->vdd);

I think the above is wrong. You should just skip the GPIO call when
"no_reset_during_suspend", not the regulator calls. As your code is
written, you'll enable the regulators over and over again in
"power_up" and never in "power_down".

-Doug
