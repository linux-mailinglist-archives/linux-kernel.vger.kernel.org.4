Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EB26779A8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjAWK4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjAWK4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:56:46 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ADBCA10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:56:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q5so5729418wrv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+6uYP+MbTYF0NBYNdaigx/58WjLEGFdjk2/rVFjcyc=;
        b=Q7XJBZsR/2LjtipimHF2PWIbSJhSPtlaX/WDZ3z6jD3XW8wwtFX7nivgiFl34QGwbq
         BNoPZ9MmzwLIM3jLL+LG7F+1weXOofb5dYp9DxthnNj6UojG+IJ424ScDqmXVN02bU/Q
         lBGWdYyN98tfymSWPVr5QWJPexlQHipp/8J2x7nWl2AH81Ry+cbsyTmrJN0o0XM2p7ui
         vvILB60sabY9N0yJmMZwUleRwhPLlECoLpHW36yMIhkF7AbSbLZiLmbmGfEdwvFVzOks
         lgpOjCFaFCvR58YjB8aXYYwPVIEeeXo1ycQxP1aBZ7tai4J1zJR4KxpIVhobCx6VpQuR
         w9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+6uYP+MbTYF0NBYNdaigx/58WjLEGFdjk2/rVFjcyc=;
        b=jzqeEyJEyl58NemfDjtgCqS9pIgRN9r0ewvZDJSoY7SzxK2BE9vHL2HAR0einBgv1o
         agcIje2CseEPrqWfUE6/SMgH8hdjyFBZHD3cnsBEBy6d/TI7bv6eL+JOKJubQElFTFN+
         W+oqnKpEnEgjg2iS0rOjW/fQLSvl27ncm9pBkdZhK19++X/DfUjdphZ09FbxZYI2kN4C
         zikti6EvG7QBSFZcOyWcgLiqHCphJU6qHaIRbsBSutiahyi/xAjHV7Fjcb/vjCfzgHsX
         fyr18y/T85MZXq3+XocMMau7yPOUUDct8KadEEVQvI8XmLTjEJ5UX/D7epFKR6FClUVu
         HUEA==
X-Gm-Message-State: AFqh2kp8qL+bG8A4opeiUjTkySABdJZO90hmDukQ6pDMA1jlz+c4cvu0
        aqOYMIRioUgP09njnQmLPz1BeQ==
X-Google-Smtp-Source: AMrXdXs0x2uUX0FmQbIv3R5wGA6FQnaTyB5mpfT8FEVNcT8YVvcMWJ5NWN/lCK+THPxUopDAMwuW8A==
X-Received: by 2002:a05:6000:1006:b0:24f:5890:616b with SMTP id a6-20020a056000100600b0024f5890616bmr28966879wrx.56.1674471403238;
        Mon, 23 Jan 2023 02:56:43 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4cc8000000b002bdeb0cf706sm22803416wrt.65.2023.01.23.02.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:56:42 -0800 (PST)
Date:   Mon, 23 Jan 2023 12:56:41 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 4/6] phy: qcom-qmp: qserdes-txrx-ufs: Add v6 register
 offsets
Message-ID: <Y85n6Z3lPhj6gAKb@linaro.org>
References: <20230117142015.509675-1-abel.vesa@linaro.org>
 <20230117142015.509675-5-abel.vesa@linaro.org>
 <61be8f36-7171-dbc1-94ec-7e77438b37f5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61be8f36-7171-dbc1-94ec-7e77438b37f5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-17 16:42:07, Dmitry Baryshkov wrote:
> On 17/01/2023 16:20, Abel Vesa wrote:
> > The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
> > UFS and PCIE g3x2. Add the new qserdes TX RX but UFS specific offsets
> > in a dedicated header file.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   .../phy-qcom-qmp-qserdes-txrx-ufs-v6.h        | 30 +++++++++++++++++++
> >   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |  2 ++
> >   2 files changed, 32 insertions(+)
> >   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> > new file mode 100644
> > index 000000000000..6238dd2b8421
> > --- /dev/null
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +#ifndef QCOM_PHY_QMP_QSERDES_TXRX_UFS_V6_H_
> > +#define QCOM_PHY_QMP_QSERDES_TXRX_UFS_V6_H_
> > +
> > +#define QSERDES_UFS_V6_TX_RES_CODE_LANE_TX			0x28
> > +#define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX			0x2c
> > +#define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX		0x30
> > +#define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX		0x34
> 
> Emty line please
> 

Sure. Will drop in the next version.

> > +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2			0x08
> > +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4			0x10
> 
> Any chance to doublecheck these two values? I think that UCDR_FO_GAIN_RATE2
> is 0xd4 (according to phy-qcom-ufs-qmp-v4-cape.h from msm-5.10)

Double checked. The values are correct. Please note that your are
looking in a header file for qmp v4. This is v6.

> 
> > +
> > +#define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
> > +#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
> > +#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
> > +#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3			0x214
> > +#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6			0x220
> > +#define QSERDES_UFS_V6_RX_MODE_RATE2_B3				0x238
> > +#define QSERDES_UFS_V6_RX_MODE_RATE2_B6				0x244
> > +#define QSERDES_UFS_V6_RX_MODE_RATE3_B3				0x25c
> > +#define QSERDES_UFS_V6_RX_MODE_RATE3_B4				0x260
> > +#define QSERDES_UFS_V6_RX_MODE_RATE3_B5				0x264
> > +#define QSERDES_UFS_V6_RX_MODE_RATE3_B8				0x270
> > +#define QSERDES_UFS_V6_RX_MODE_RATE4_B3				0x280
> > +#define QSERDES_UFS_V6_RX_MODE_RATE4_B6				0x28c
> > +
> > +#endif
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > index 110d8fb9309f..a5cdd58c5b4d 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > @@ -27,6 +27,8 @@
> >   #include "phy-qcom-qmp-pcs-ufs-v4.h"
> >   #include "phy-qcom-qmp-pcs-ufs-v5.h"
> > +#include "phy-qcom-qmp-qserdes-txrx-ufs-v6.h"
> > +
> >   /* QPHY_SW_RESET bit */
> >   #define SW_RESET				BIT(0)
> >   /* QPHY_POWER_DOWN_CONTROL */
> 
> -- 
> With best wishes
> Dmitry
> 
