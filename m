Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42C26D280B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjCaSqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjCaSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:46:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6201D90A;
        Fri, 31 Mar 2023 11:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDCF8B831B1;
        Fri, 31 Mar 2023 18:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1BDC433D2;
        Fri, 31 Mar 2023 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680288394;
        bh=tCzI3Tz/p1oGs31cXIxkiwzfqh3vb27okPmXKlpiXUY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lousBBo5HxCugDSX/ME76JZExUqA6oOiacYVRNIwZ4zp78DNt6r60dFSB9oodFp0Z
         4VGPwZDoQfRfFcNobpydkYSN+TTSsMsOA3q0nBJW6D6LlJVkDk80e8Y/60etXAdyPE
         6Rwv9rpAjMrVbR11quy2ZLebPyp6Bfk5IXfLoW2nYxh8CEarsAuntkFYKWaPm6AIDx
         UBcKbc98SzG1nUayg3wz63fI0bznU88hsh03AZB8YxAM5CanDqDe4x19ob/7ryr2T2
         SUAxdDU5letGimI7vmDg/RaoEQQfpYDelathg/oNAUaubvKStnEcQnSUdk/lJsc1I0
         84+/haDA0RPlQ==
Message-ID: <32e439d2fb2db190cd1486b2bd15aab3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230331152805.3199968-3-quic_mohs@quicinc.com>
References: <20230331152805.3199968-1-quic_mohs@quicinc.com> <20230331152805.3199968-3-quic_mohs@quicinc.com>
Subject: Re: [PATCH v10 2/3] clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        quic_visr@quicinc.com, robh+dt@kernel.org, swboyd@chromium.org
Date:   Fri, 31 Mar 2023 11:46:32 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mohammad Rafi Shaik (2023-03-31 08:28:04)
> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc=
-sc7280.c
> index 5c1e17bd0d76..24aeed6bcf0e 100644
> --- a/drivers/clk/qcom/lpasscc-sc7280.c
> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
> @@ -17,6 +17,8 @@
>  #include "clk-branch.h"
>  #include "common.h"
> =20
> +#define QDSP6SS_MAX_REGISTER           0x3f

You can drop the define and just put the raw number in the one place
this is used.

> +
>  static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk =3D {
>         .halt_reg =3D 0x0,
>         .halt_check =3D BRANCH_HALT,
> @@ -118,12 +120,15 @@ static int lpass_cc_sc7280_probe(struct platform_de=
vice *pdev)
>                 goto destroy_pm_clk;
>         }
> =20
> -       lpass_regmap_config.name =3D "qdsp6ss";
> -       desc =3D &lpass_qdsp6ss_sc7280_desc;
> +       if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode=
")) {
> +               lpass_regmap_config.name =3D "qdsp6ss";
> +               lpass_regmap_config.max_register =3D QDSP6SS_MAX_REGISTER;
> +               desc =3D &lpass_qdsp6ss_sc7280_desc;
>
