Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A16CD081
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjC2DL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjC2DL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1A0EB;
        Tue, 28 Mar 2023 20:11:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D89261A3F;
        Wed, 29 Mar 2023 03:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEC9C433D2;
        Wed, 29 Mar 2023 03:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680059484;
        bh=NGXGuRBdOlfV6sliKx3bHpwelJaLp9Dl+kaN86ruvRo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=on6XzOQnDWy0rhBKPfsMZoUnduZsd+4J4pd/ZUIiduLFyyBuW0QOj0EpcK+nQu8+L
         m9GiSWPZ0JDwEdBVpwE52WiUfsZUxf+qx+dXO+3GfPrOCX0ICbgnnqj1ysDNRqYD4V
         WWdrLzfUygts9QqXbaJQHlWmpsQqs6XkFK5M+XqEuoSEF3ojUKRd5zFEoq7nbpz13E
         aQuM9qhJv3sPQyTZ40UKPaoRn7S/lqp8h7Rayc3bJ9fsO7VNUv92VH+lUaxbf/TPgc
         FKKSE9OIpEdB/+pwLKVeII89dKEe7K0PpchzcHQU/YjxktbmUhb4zNhYcPGvCKN4yg
         EhD/ZJ4oMfeUg==
Message-ID: <f2fa0b0813b26c0eb1893ef4c4c4c672.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230327163249.1081824-5-quic_mohs@quicinc.com>
References: <20230327163249.1081824-1-quic_mohs@quicinc.com> <20230327163249.1081824-5-quic_mohs@quicinc.com>
Subject: Re: [PATCH v1 4/4] clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        quic_visr@quicinc.com, robh+dt@kernel.org, swboyd@chromium.org
Date:   Tue, 28 Mar 2023 20:11:22 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mohammad Rafi Shaik (2023-03-27 09:32:49)
> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc=
-sc7280.c
> index 48432010ce24..4719e3fa8b05 100644
> --- a/drivers/clk/qcom/lpasscc-sc7280.c
> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
> @@ -121,17 +67,10 @@ static int lpass_cc_sc7280_probe(struct platform_dev=
ice *pdev)
>                 goto destroy_pm_clk;
>         }
> =20
> -       lpass_regmap_config.name =3D "qdsp6ss";
> -       desc =3D &lpass_qdsp6ss_sc7280_desc;
> -
> -       ret =3D qcom_cc_probe_by_index(pdev, 0, desc);
> -       if (ret)
> -               goto destroy_pm_clk;
> -
>         lpass_regmap_config.name =3D "top_cc";
>         desc =3D &lpass_cc_top_sc7280_desc;
> =20
> -       ret =3D qcom_cc_probe_by_index(pdev, 1, desc);
> +       ret =3D qcom_cc_probe_by_index(pdev, 0, desc);

Instead of changing the binding, it may be better to leave it as is and
ignore the first reg property in the driver. Then you don't need any DTS
patch or binding patch. You can just have this one patch. After that you
can introduce a new compatible string for the proper design and make it
have only a single reg property and deprecate the old binding. The
driver can then pick index 0 if the new compatible is present.
