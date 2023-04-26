Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC556EF222
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbjDZKev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbjDZKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:34:22 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5725C3AA5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:33:54 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-42ca0c08aa9so1707852137.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20221208.gappssmtp.com; s=20221208; t=1682505231; x=1685097231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1fGPJlHu6l7X7WsfJvCNS6QR0SA3h2Zw922iWfKNZI=;
        b=Usx265iOT6v3GkItV6XMI1RJds2zK7WSYjz50PJ3sA8RJnt6tLsQLuYW2LrHDbMRaD
         RXCR8AaaCRnukMDfzvKidWKkfPdBJ8AUw37ccahtk2drjUPT83q+hlgqYc4wI1toM3E1
         8ZFsSVrcHHBqf1vkDBipQ4F/pxpm0vz/cLtrdF7ReExpjEgTSIRD3iaI8AAe2X9MYCiP
         8vlVMESiGnxx1G/yJhgb0P5igOIlSAY9ekmaAocYIWZfZkCptiKT5UOGYOb69yPYL0jN
         eBjaBBrIuvmSdyDfyKQ3Bf+p6LiO3ELzfgMt6E8lRqjHOXUKQubgjd5oDd/MSDiFOJa7
         cX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682505231; x=1685097231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1fGPJlHu6l7X7WsfJvCNS6QR0SA3h2Zw922iWfKNZI=;
        b=gCgalbLx+K0oxSZIiwMszDmxbN2Re4tL3T/8cLKyUKLqq3v+ufty0UYiC8hbpqiOoC
         fMm/fOV9LOVZ5Om5IJ/YTvcqZ209YfvbBOFJN28uNu2xCxs1nuvhaVi+aN7GQFFnSXIx
         1br4pvKfr+00OiVx/vFYBofj2rgF5dZoSKZ6jVfld826dvAJlhsmt/12tbsSoX3ok3Kk
         mt/qq40wh9hobd+DV/7pTxZN+jkCsoONO7gaU2wC9qwJLdUxsZASgrATTH7oXtQM3l1H
         +F+oSZB6sD1od/0Psnk536g7gGP+epeGpwZInPALkOYCQTiJ/8H4T5JdJhR+gRIiwvKY
         P5WA==
X-Gm-Message-State: AAQBX9cZ7CVB2NnzGYGAygVRZpNlgDXP0DddsYcW49TK5a2hwoekajcN
        EoZqELFlJoVaM2vx1jowmQ4iAcP2Pv4+qoFiHZJtmA==
X-Google-Smtp-Source: AKy350bLbcQ1HvoG8xLjW8UzSGSFRdqFANyqcXcuOcFFdYFn0JripAqDqG1+77edDeeYwIMoHU4hKkN7U0F6NAPVC4s=
X-Received: by 2002:a05:6102:34e2:b0:42f:cfdc:4803 with SMTP id
 bi2-20020a05610234e200b0042fcfdc4803mr9106697vsb.33.1682505231629; Wed, 26
 Apr 2023 03:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com> <20230425034010.3789376-6-quic_bjorande@quicinc.com>
In-Reply-To: <20230425034010.3789376-6-quic_bjorande@quicinc.com>
From:   "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Date:   Wed, 26 Apr 2023 11:33:40 +0100
Message-ID: <CAJB8c04ah3YfK2VGxDhHMHK4KVJ7kZQv0b5JfPBu7jOk3mFQRA@mail.gmail.com>
Subject: Re: [PATCH 5/7] phy: qcom-qmp-combo: Introduce drm_bridge
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Apr 25, 2023 at 4:40=E2=80=AFAM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> The QMP combo PHY sits in an of_graph connected between the DisplayPort
> controller and a USB Type-C connector (or possibly a redriver).
>
> The TCPM needs to be able to convey the HPD signal to the DisplayPort
> controller, but no directly link is provided by DeviceTree so the signal
> needs to "pass through" the QMP combo phy.
>
> Handle this by introducing a drm_bridge which upon initialization finds
> the next bridge (i.e. the usb-c-connector) and chain this together. This
> way HPD changes in the connector will propagate to the DisplayPort
> driver.
>
> The connector bridge is resolved lazily, as the TCPM is expected to be
> able to resolve the typec mux and switch at probe time, so the QMP combo
> phy will probe before the TCPM.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 36 +++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qual=
comm/phy-qcom-qmp-combo.c
> index 5d6d6ef3944b..84bc08002537 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -22,6 +22,8 @@
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_mux.h>
>
> +#include <drm/drm_bridge.h>
> +
>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>
>  #include "phy-qcom-qmp.h"
> @@ -1332,6 +1334,8 @@ struct qmp_combo {
>         struct clk_hw dp_link_hw;
>         struct clk_hw dp_pixel_hw;
>
> +       struct drm_bridge bridge;
> +
>         struct typec_switch_dev *sw;
>         enum typec_orientation orientation;
>  };
> @@ -3196,6 +3200,34 @@ static int qmp_combo_register_clocks(struct qmp_co=
mbo *qmp, struct device_node *
>         return devm_add_action_or_reset(qmp->dev, phy_clk_release_provide=
r, dp_np);
>  }
>
> +static int qmp_combo_bridge_attach(struct drm_bridge *bridge,
> +                                  enum drm_bridge_attach_flags flags)
> +{
> +       struct qmp_combo *qmp =3D container_of(bridge, struct qmp_combo, =
bridge);
> +       struct drm_bridge *next_bridge;
> +
> +       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> +               return -EINVAL;
> +
> +       next_bridge =3D devm_drm_of_get_bridge(qmp->dev, qmp->dev->of_nod=
e, 0, 0);
> +       if (IS_ERR(next_bridge))
> +               return dev_err_probe(qmp->dev, PTR_ERR(next_bridge), "fai=
led to acquire drm_bridge\n");
> +
> +       return drm_bridge_attach(bridge->encoder, next_bridge, bridge, DR=
M_BRIDGE_ATTACH_NO_CONNECTOR);
> +}
> +
> +static const struct drm_bridge_funcs qmp_combo_bridge_funcs =3D {
> +       .attach =3D qmp_combo_bridge_attach,
> +};
> +
> +static int qmp_combo_dp_register_bridge(struct qmp_combo *qmp)
> +{
> +       qmp->bridge.funcs =3D &qmp_combo_bridge_funcs;
> +       qmp->bridge.of_node =3D qmp->dev->of_node;
> +
> +       return devm_drm_bridge_add(qmp->dev, &qmp->bridge);
> +}
> +
>  static int qmp_combo_parse_dt_lecacy_dp(struct qmp_combo *qmp, struct de=
vice_node *np)
>  {
>         struct device *dev =3D qmp->dev;
> @@ -3459,6 +3491,10 @@ static int qmp_combo_probe(struct platform_device =
*pdev)
>         if (ret)
>                 return ret;
>
> +       ret =3D qmp_combo_dp_register_bridge(qmp);
> +       if (ret)
> +               return ret;
> +
>         /* Check for legacy binding with child nodes. */
>         usb_np =3D of_get_child_by_name(dev->of_node, "usb3-phy");
>         if (usb_np) {
> --
> 2.39.2
>

You need to add some or all of these
       select DRM_DISPLAY_DP_HELPER
       select DRM_DISPLAY_HELPER
       select DRM_DP_AUX_BUS
       select DRM_KMS_HELPER
       select DRM_MIPI_DSI
       select DRM_PANEL


/opt/linaro/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-l=
inux-gnu-ld:
Unexpected GOT/PLT entries detected!
/opt/linaro/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-l=
inux-gnu-ld:
Unexpected run-time procedure linkages detected!
drivers/phy/qualcomm/phy-qcom-qmp-combo.o: In function
`qmp_combo_bridge_attach':
phy-qcom-qmp-combo.c:(.text+0xb50): undefined reference to
`devm_drm_of_get_bridge'
phy-qcom-qmp-combo.c:(.text+0xb6c): undefined reference to `drm_bridge_atta=
ch'
drivers/phy/qualcomm/phy-qcom-qmp-combo.o: In function `qmp_combo_probe':
phy-qcom-qmp-combo.c:(.text+0x13fc): undefined reference to
`devm_drm_bridge_add'

---
bod
