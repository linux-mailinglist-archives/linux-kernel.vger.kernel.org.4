Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29C86EC16D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 19:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDWRml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 13:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 13:42:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937CD10C9;
        Sun, 23 Apr 2023 10:42:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-95369921f8eso531641466b.0;
        Sun, 23 Apr 2023 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682271757; x=1684863757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA+bFNXU5lnOq/dCAFC+X0Kqr+6jDOeqz+/GHp8kMoU=;
        b=K+runzIHR2GUuCZS0hxnRvuqLe8cxdW9DAJtsL8nSZ+fz5eVKaACjVavRLa9BMC3n2
         ExcQjW0oMjxhnol1oqfaaWQ+Z4hipBQVfTFFz0tVWsIASlVM3iWS96KXyF+uje6KBadb
         9606h/DVUIAj57AWet15IzumE0EP6CFKSYLFaA2ltMifY6yioqjJC3kpO4M14UxLGuEt
         Tyqq/0PQZlFNkXFHlQv64iYiVxyLH76HmQ/YZXbkNTWjOalELGWczEPZu45z6xyLcDYu
         u3j+kB7ziImEVj7GUkNAH/CZmaV7+otGMhXLV48+0wj0x5WYwvIPJyYKBzOYs2B/32U7
         dsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682271757; x=1684863757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA+bFNXU5lnOq/dCAFC+X0Kqr+6jDOeqz+/GHp8kMoU=;
        b=jyudMacdrpgfXd/G8bPNpgoe1HlnctopXsz60SLX2rHCWTvDIWl+O3XjgqOEoLUE25
         1Ilt244DF22TIRa+Q4LdY6jfmYzGPdXiFjBPDf5lxPcQPWJtp6avN0fAfa8W8C7Arfxn
         NVVmgqlXbZChIv6t5hJbyDLUToGmoo9UhGHlTaA0JvLeP7mpDf7/4kKPn/a18QusELyC
         Xq5M4OqpnM1Ez89Tj44i0s9UiykIU7HNZsVki/R1R2gvCOyaW7ipQ8ZqaWXLu0u1nLng
         RyD471WkrYF4syEfvmrOvQOYbLp0ux0aORvuBXSzNsTgKHYUQ9nTVcM/BxoxWvEc472l
         rMEg==
X-Gm-Message-State: AAQBX9dRbrfihWohhyLXI0j+/gX9jfsqg3OwslReqJ6j0YNlbcWKwBYR
        j+nbvgxdR78okuuf1EylERO5LZ4d11QxOHcQSSg=
X-Google-Smtp-Source: AKy350bOdYkKefr9OG/iFTwW9Y8zJi7WP0q8ncdz0K81CjLsSSyV47R6xfpW3r2gOJHzwOS5zcVVfmeI2K2pEIvtR4k=
X-Received: by 2002:a17:906:a10a:b0:94f:695e:b0c9 with SMTP id
 t10-20020a170906a10a00b0094f695eb0c9mr8386847ejy.5.1682271756815; Sun, 23 Apr
 2023 10:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru> <20230418111612.19479-2-ddrokosov@sberdevices.ru>
In-Reply-To: <20230418111612.19479-2-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 19:42:25 +0200
Message-ID: <CAFBinCDyhBQ5Nob38EmXor1PtcO09dRdReDTW+tc5CN4i20HhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] phy: amlogic: enable/disable clkin during Amlogic
 USB PHY init/exit
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        mturquette@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        hminas@synopsys.com, Thinh.Nguyen@synopsys.com,
        yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Apr 18, 2023 at 1:16=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
>
> Previously, all Amlogic boards used the XTAL clock as the default board
> clock for the USB PHY input, so there was no need to enable it.
> However, with the introduction of new Amlogic SoCs like the A1 family,
> the USB PHY now uses a gated clock. Hence, it is necessary to enable
> this gated clock during the PHY initialization sequence, or disable it
> during the PHY exit, as appropriate.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/phy/amlogic/phy-meson-g12a-usb2.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlo=
gic/phy-meson-g12a-usb2.c
> index 9d1efa0d9394..80938751da4f 100644
> --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> @@ -172,10 +172,16 @@ static int phy_meson_g12a_usb2_init(struct phy *phy=
)
>         int ret;
>         unsigned int value;
>
> -       ret =3D reset_control_reset(priv->reset);
> +       ret =3D clk_prepare_enable(priv->clk);
>         if (ret)
>                 return ret;
>
> +       ret =3D reset_control_reset(priv->reset);
> +       if (ret) {
> +               clk_disable_unprepare(priv->clk);
> +               return ret;
> +       }
> +
This part looks good. You asked why I suggested this approach instead
of enabling the clock at probe time and only now I have time to reply
to it.
Consider the following scenario:
- modprobe phy-meson-g12a-usb2
- modprobe dwc3-meson-g12a (this will call phy_init)
- rmmod dwc3-meson-g12a (this will call phy_exit)

If the clock was enabled at probe time then it would only be disabled
when using rmmod phy-meson-g12a-usb2.
By manually calling clk_prepare_enable/clk_disable_unprepare we ensure
that the clock gets disabled when we don't need the PHY anymore.
Whether this makes any difference in terms of power draw: I can't say.

>         udelay(RESET_COMPLETE_TIME);
>
>         /* usb2_otg_aca_en =3D=3D 0 */
> @@ -277,8 +283,11 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>  static int phy_meson_g12a_usb2_exit(struct phy *phy)
>  {
>         struct phy_meson_g12a_usb2_priv *priv =3D phy_get_drvdata(phy);
> +       int ret =3D reset_control_reset(priv->reset);
> +
> +       clk_disable_unprepare(priv->clk);
>
> -       return reset_control_reset(priv->reset);
> +       return ret;
I think this can cause issues in case when reset_control_reset returns
an error: If I understand the code in phy-core.c correctly it will
only decrease the init ref-count if exit returns 0.
Whenever phy_exit is called for the second time
clk_disable_unprepare() will be called with a clock ref-count of 0, so
it'll likely print some warning.

My suggestion is to return early if reset_control_reset() fails and
not call clk_disable_unprepare() in that case.
What do you think?


Best regards,
Martin
