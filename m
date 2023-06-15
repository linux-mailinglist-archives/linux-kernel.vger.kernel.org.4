Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1158730D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbjFODZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbjFODY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:24:56 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC2B26AF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:24:54 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso1266518241.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686799494; x=1689391494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nSVGPPWBRzpCGCRYannX5iA+YMKGtqta1nbYF5t7UA=;
        b=naLregnKKESEIb9Rj4ReayoHQGn78YEhwBRimP5/yR9tSsvy3UnvX3tgU6szoMUip+
         50ISCvWu8EGTn6cEtxA8lCi74gdoa6k4GEUGC4DPGc8khHfUVK6cYsepluZ6DLtvbk9J
         4rBhaNm+eUswtHkMKiCYQ9Mk3w8qGCAPY8ggo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686799494; x=1689391494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nSVGPPWBRzpCGCRYannX5iA+YMKGtqta1nbYF5t7UA=;
        b=Dgl0++hBVpeaQrhcI+oJ0oTqk2kJg+VZt33Lw9o2VggalKXu4LpK3Gs/IlglxhPzsN
         spjJTXPX6klUkzfB1dAX3W3LoaL6Ap0zZrZKz67w0riJFNV6z3D9ajk3X5HXTAqsu04j
         sq9/9stfl0AeFbPDd+gjItIZRKK7P5S2ZesJSKJj0bXwtfLpj7ZFeGJ/qOivThhH/VI6
         UYkbGFEBYEodfhLjqkn/lf4MFMPbKcKCvoj3LZAnMRcdnC4GI7GYnWH/s1CnMC3ITAAA
         4DUuRxAgjwpfim4vCspGl47h3Zf47gPceBfw56Z5olYnisP2/jXwgF/3uBlmhirWn0sT
         kL4w==
X-Gm-Message-State: AC+VfDyG4adzqeou6cV91YS/zbuetKFVZ5fKoLQ5u2EJyPodLTh7X1Jp
        Mg8yf2l5RNTBMV3cC5e3m7AZDYbNCX2pbAYJznEuyF1NWGcy8aZw
X-Google-Smtp-Source: ACHHUZ7yKjRDJ1WlW1Oput8L54g88VDOjieJMDdfRPhL25+Te/RHk2aWjxgB6vrI6XWEfF2SBrmyef0xPxvHJ45yXOg=
X-Received: by 2002:a05:6102:503:b0:43f:5c7e:d5db with SMTP id
 l3-20020a056102050300b0043f5c7ed5dbmr135418vsa.2.1686799493855; Wed, 14 Jun
 2023 20:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230609083009.2822259-1-wenst@chromium.org> <20230609083009.2822259-8-wenst@chromium.org>
 <a5c00706-dc23-4561-8bcf-729fd10e74ef@sirena.org.uk>
In-Reply-To: <a5c00706-dc23-4561-8bcf-729fd10e74ef@sirena.org.uk>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 15 Jun 2023 11:24:42 +0800
Message-ID: <CAGXv+5HWM_mfKp-o8kOyZ7W8yqZwBwPF3QNwo5sBfuv4quc-vQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] regulator: mt6358: Add output voltage fine tuning to
 fixed regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:15=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Fri, Jun 09, 2023 at 04:30:04PM +0800, Chen-Yu Tsai wrote:
> > The "fixed" LDO regulators found on the MT6358 and MT6366 PMICs have
> > either no voltage selection register, or only one valid setting.
> > However these do have a fine voltage calibration setting that can
> > slightly boost the output voltage from 0 mV to 100 mV, in 10 mV
> > increments.
>
> This and the followup patch break the build on both arm64 and x86_64:
>
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =
=E2=80=98MT6358_VFE28_ANA_CON0=E2=80=99 undeclared here (not in a function)=
; did you mean =E2=80=98MT6358_VIO28_ANA_CON0=E2=80=99?
>   127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
>       |                             ^~~~~~~

Argh, I sequenced the patches in my tree incorrectly. I see you already
merged the first six patches. I'll send a new version including a header
change that this patch needs, and other fixups that reviewers suggested.

ChenYu


> /build/stage/linux/drivers/regulator/mt6358-regulator.c:525:9: note: in e=
xpansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
>   525 |         MT6358_REG_FIXED("ldo_vfe28", VFE28, MT6358_LDO_VFE28_CON=
0, 0, 2800000),
>       |         ^~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =
=E2=80=98MT6358_VCN28_ANA_CON0=E2=80=99 undeclared here (not in a function)=
; did you mean =E2=80=98MT6358_VCN18_ANA_CON0=E2=80=99?
>   127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
>       |                             ^~~~~~~
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:526:9: note: in e=
xpansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
>   526 |         MT6358_REG_FIXED("ldo_vcn28", VCN28, MT6358_LDO_VCN28_CON=
0, 0, 2800000),
>       |         ^~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =
=E2=80=98MT6358_VXO22_ANA_CON0=E2=80=99 undeclared here (not in a function)=
; did you mean =E2=80=98MT6358_VIO28_ANA_CON0=E2=80=99?
>   127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
>       |                             ^~~~~~~
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:527:9: note: in e=
xpansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
>   527 |         MT6358_REG_FIXED("ldo_vxo22", VXO22, MT6358_LDO_VXO22_CON=
0, 0, 2200000),
>       |         ^~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =
=E2=80=98MT6358_VAUX18_ANA_CON0=E2=80=99 undeclared here (not in a function=
); did you mean =E2=80=98MT6358_VRF18_ANA_CON0=E2=80=99?
>   127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
>       |                             ^~~~~~~
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:528:9: note: in e=
xpansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
>   528 |         MT6358_REG_FIXED("ldo_vaux18", VAUX18,
>       |         ^~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =
=E2=80=98MT6358_VBIF28_ANA_CON0=E2=80=99 undeclared here (not in a function=
); did you mean =E2=80=98MT6358_VIO28_ANA_CON0=E2=80=99?
>   127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
>       |                             ^~~~~~~
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:530:9: note: in e=
xpansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
>   530 |         MT6358_REG_FIXED("ldo_vbif28", VBIF28,
>       |         ^~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:127:29: error: =
=E2=80=98MT6358_VAUD28_ANA_CON0=E2=80=99 undeclared here (not in a function=
); did you mean =E2=80=98MT6358_VA12_ANA_CON0=E2=80=99?
>   127 |                 .vsel_reg =3D MT6358_##vreg##_ANA_CON0,   \
>       |                             ^~~~~~~
> /build/stage/linux/drivers/regulator/mt6358-regulator.c:535:9: note: in e=
xpansion of macro =E2=80=98MT6358_REG_FIXED=E2=80=99
>   535 |         MT6358_REG_FIXED("ldo_vaud28", VAUD28,
>       |         ^~~~~~~~~~~~~~~~
