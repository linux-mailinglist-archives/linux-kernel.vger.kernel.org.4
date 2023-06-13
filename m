Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E142B72DB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbjFMHxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbjFMHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:53:07 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5ADE7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:53:05 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-46e0a9aaa01so135894e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686642784; x=1689234784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksmnYzaAZG4SFOtuZwLT0Gj07ow0mCiA7tlTY9FP1/Y=;
        b=d/XOUvzXq7CkULBNjOF5cPQ9T8PQ4GUN2VTUb4tV5GYUOU/bcCMFJER5wRcTiOAxaO
         VEqeTPG5/GSimPhYdVoDC/uqRBqssvbhFmMqZ2UPpATKuDu0zcPmCBugjzLiimaHg+0O
         9wZ1rW7T5SAVt/6r/SykeSUB1kSjjeu1v/QF9yZNVYeWYL/CqPipZS2RqbveG9GDYWQl
         3yZcujcboW/sNqe2RjBd/XPxGCpKyPsA5S0Wt8H20ztGP/P8e2a+LHAM1iWQz7y5UEUU
         byzRaCp7blF315uAiXD/wO22ggP+a/pLSa4fq9EoyeAoPW6lXUTFE4Oe4EeVpTJurQyN
         Z0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642784; x=1689234784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksmnYzaAZG4SFOtuZwLT0Gj07ow0mCiA7tlTY9FP1/Y=;
        b=Zr+DH9bUcRM+bkuspiK5JaXaW3enJUx5eyW3TDBTUVPTr9fnQqL2o2PCuiHJBgbA97
         QzHiuZ54t71hahV9KhFEkOOnEa5eRQzbewrw0SbmjuS6kw/4y08Zm/1/Dv//qNq3WTg6
         Hmw/mwK3mP2mbGonAMUjBbbvdkty0FDyQ7csTVM1vaKg46ZQZan/EHudmGqYwjTZLz9N
         be1Wc9YjqwOjFUUIka91FKUkO3cP0A2tdwfWmoFZnyAdXvZyZa5Lk/9jmIIWTbMjtUkS
         htX9/uc62DeL2LyjIrZtZU3uFrp9q/LG0PU0MhEgHIQ5w8zPI+EW1Ep3RVNzH+GWue/1
         4Xtg==
X-Gm-Message-State: AC+VfDzXCbrEb8Z6kuFyp+o3EMHKoXSPA/mD/6RO12PcIvP1udm5Y+O7
        He80BLFhQREK7r0lGit+YU49t8dBh4Qquqx12IDaag==
X-Google-Smtp-Source: ACHHUZ7i+EBDY2WITwEIRgKogtaSChdc3S4PwWz2Qp9PZP5xCpoeIGDCpD2gClqT3kwLonr4MotjvY3YKsBM2PtVtCk=
X-Received: by 2002:a1f:bd58:0:b0:46d:fd21:76fb with SMTP id
 n85-20020a1fbd58000000b0046dfd2176fbmr580943vkf.10.1686642784529; Tue, 13 Jun
 2023 00:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230612092355.87937-1-brgl@bgdev.pl> <20230612092355.87937-13-brgl@bgdev.pl>
 <20230612203255.72t52ucry7zzq3em@halaney-x13s>
In-Reply-To: <20230612203255.72t52ucry7zzq3em@halaney-x13s>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Jun 2023 09:52:53 +0200
Message-ID: <CAMRc=MfmzWDZuXpb4ySxi0Xu6EWVuEZ4ReaEYbo4KCMme-+G4A@mail.gmail.com>
Subject: Re: [PATCH 12/26] net: stmmac: dwmac-qcom-ethqos: add support for the
 optional serdes phy
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:33=E2=80=AFPM Andrew Halaney <ahalaney@redhat.co=
m> wrote:
>
> On Mon, Jun 12, 2023 at 11:23:41AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > On sa8775p platforms, there's a SGMII SerDes PHY between the MAC and
> > external PHY that we need to enable and configure.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/=
drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > index 8ed05f29fe8b..3438b6229351 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/phy.h>
> > +#include <linux/phy/phy.h>
> >  #include <linux/property.h>
> >
> >  #include "stmmac.h"
> > @@ -93,6 +94,7 @@ struct qcom_ethqos {
> >
> >       unsigned int rgmii_clk_rate;
> >       struct clk *rgmii_clk;
> > +     struct phy *serdes_phy;
> >       unsigned int speed;
> >
> >       const struct ethqos_emac_por *por;
> > @@ -566,6 +568,30 @@ static void ethqos_fix_mac_speed(void *priv, unsig=
ned int speed)
> >       ethqos_configure(ethqos);
> >  }
> >
> > +static int qcom_ethqos_serdes_powerup(struct net_device *ndev, void *p=
riv)
> > +{
> > +     struct qcom_ethqos *ethqos =3D priv;
> > +     int ret;
> > +
> > +     ret =3D phy_set_speed(ethqos->serdes_phy, ethqos->speed);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D phy_init(ethqos->serdes_phy);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return phy_power_on(ethqos->serdes_phy);
>
> The docs say (phy.rst):
>
>     The general order of calls should be::
>
>         [devm_][of_]phy_get()
>         phy_init()
>         phy_power_on()
>         [phy_set_mode[_ext]()]
>         ...
>         phy_power_off()
>         phy_exit()
>         [[of_]phy_put()]
>
>     Some PHY drivers may not implement :c:func:`phy_init` or :c:func:`phy=
_power_on`,
>     but controllers should always call these functions to be compatible w=
ith other
>     PHYs. Some PHYs may require :c:func:`phy_set_mode <phy_set_mode_ext>`=
, while
>     others may use a default mode (typically configured via devicetree or=
 other
>     firmware). For compatibility, you should always call this function if=
 you know
>     what mode you will be using. Generally, this function should be calle=
d after
>     :c:func:`phy_power_on`, although some PHY drivers may allow it at any=
 time.
>
> Not really dictating you need to do that order, but if possible I think
> calling phy_set_speed after init + power_on is more generic. Not sure if
> that plays nice with the phy driver in this series or not.
>
> Otherwise, I think this looks good.
>

I had to rework the PHY driver code a bit for this order to work but
it'll be good now in v2.

Thanks!
Bart

> > +}
> > +
> > +static void qcom_ethqos_serdes_powerdown(struct net_device *ndev, void=
 *priv)
> > +{
> > +     struct qcom_ethqos *ethqos =3D priv;
> > +
> > +     phy_power_off(ethqos->serdes_phy);
> > +     phy_exit(ethqos->serdes_phy);
> > +}
> > +
> >  static int ethqos_clks_config(void *priv, bool enabled)
> >  {
> >       struct qcom_ethqos *ethqos =3D priv;
> > @@ -651,6 +677,12 @@ static int qcom_ethqos_probe(struct platform_devic=
e *pdev)
> >       if (ret)
> >               goto out_config_dt;
> >
> > +     ethqos->serdes_phy =3D devm_phy_optional_get(dev, "serdes");
> > +     if (IS_ERR(ethqos->serdes_phy)) {
> > +             ret =3D PTR_ERR(ethqos->serdes_phy);
> > +             goto out_config_dt;
> > +     }
> > +
> >       ethqos->speed =3D SPEED_1000;
> >       ethqos_update_rgmii_clk(ethqos, SPEED_1000);
> >       ethqos_set_func_clk_en(ethqos);
> > @@ -666,6 +698,11 @@ static int qcom_ethqos_probe(struct platform_devic=
e *pdev)
> >       if (of_device_is_compatible(np, "qcom,qcs404-ethqos"))
> >               plat_dat->rx_clk_runs_in_lpi =3D 1;
> >
> > +     if (ethqos->serdes_phy) {
> > +             plat_dat->serdes_powerup =3D qcom_ethqos_serdes_powerup;
> > +             plat_dat->serdes_powerdown  =3D qcom_ethqos_serdes_powerd=
own;
> > +     }
> > +
> >       ret =3D stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
> >       if (ret)
> >               goto out_config_dt;
> > --
> > 2.39.2
> >
>
