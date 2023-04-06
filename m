Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633816D94FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjDFLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjDFLVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:21:07 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F5693E0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:20:45 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id b6so30850495vsu.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680780044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ne77xaqbtLGoxF/3ZhDrpD5vvfWoYyoJmdpcIYFNEQ=;
        b=k6I0+4BXskzhRAwmd43QNMVzFMrPVNOkbwwXevTPqhk0D8YtPACw3R0r5oUZIcMPVv
         Y5BUW4ArX1KppvMqptjnxTQn8Eg44+0ZQbizMDjOHAqI9XfPy9ky1Y5/sUTSgx9/3FRG
         GR5QFc6MPGSsDoUOxRB5gBdVgCLmVxbo9cbOTuympKKj/3m64qK3GAZCfrJM9pQXJcku
         pvfwlQ1j6C33FTc8uKtsSlENf9ePLJrXjcA1JInY3DAKtB/WJMRZSF/W23COOL1TWHxe
         TSC2bb+7xWVyX3JOmd+CRHjYYjZg/2CHUVzK5aidd/2lKi4HS6aRnEedqroKaBR6YcFQ
         KZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680780044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ne77xaqbtLGoxF/3ZhDrpD5vvfWoYyoJmdpcIYFNEQ=;
        b=Zogokkf9NoIqsTIbCgKyAQ0FO5/3362eioxT67i/xVejwKkmOYFYu9J3VAvxzRI2Vj
         oDeQSjopv3i6VHK1eNEe4QHlwMzwMcDfdDf1nQtLiu4HgOl7Oqn2+47lCmR/SD0obwez
         3lWKNPcxKrvzf3JdzRx5UqvhsNJQE0khltcPcYevYONg/jQvetHxlS2QUO4p3eva5M1b
         z3+ZOdsrTiR9wReOqx0UGNLJUChF0nM4VJbJNgmPBa+r/NGtqGV4jpOeDrJzjTsJsErc
         LXKqrjkGPj6emAoFtOXLDzxNvRfTbE6miqz2EaaEEfyWP6+m0f4VshlOpkFCrXe+2Ig0
         MVKg==
X-Gm-Message-State: AAQBX9eaNQwKOpPfpC83uz3R+hVeExydQScix9iaBttNYkGe3tRfZDzQ
        OP7CtEm4ljiK0hXMpMd69rGZ3WZwXt/YXHpzEz0jSA==
X-Google-Smtp-Source: AKy350bXUnbyNurB9zPd2ZQDGbD2zJLY7NQCuR5Vz4KL/7JSPzMrGSkVI2JVi1D35K2mHZB5WX3gQMWRx9D513knC9w=
X-Received: by 2002:a67:c19a:0:b0:426:b051:1c4 with SMTP id
 h26-20020a67c19a000000b00426b05101c4mr7770691vsj.0.1680780044683; Thu, 06 Apr
 2023 04:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230328193632.226095-1-brgl@bgdev.pl> <20230328193632.226095-3-brgl@bgdev.pl>
 <72286603300630b890705c99b42f05a4.sboyd@kernel.org>
In-Reply-To: <72286603300630b890705c99b42f05a4.sboyd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 6 Apr 2023 13:20:33 +0200
Message-ID: <CAMRc=McM1DfCoMmuUYcChFFBG=H1PgZFAWcuxnQsdhRdYrT+yA@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: qcom: add the GPUCC driver for sa8775p
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 4:15=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Bartosz Golaszewski (2023-03-28 12:36:27)
> > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > index 449bc8314d21..5e1919738aeb 100644
> > --- a/drivers/clk/qcom/Kconfig
> > +++ b/drivers/clk/qcom/Kconfig
> > @@ -437,6 +437,14 @@ config SA_GCC_8775P
> >           Say Y if you want to use peripheral devices such as UART, SPI=
,
> >           I2C, USB, UFS, SDCC, etc.
> >
> > +config SA_GPUCC_8775P
> > +       tristate "SA8775P Graphics clock controller"
> > +       select SA_GCC_8775P
>
> Should select QCOM_GDSC as well.
>

Why if it's already selected indirectly by SA_GCC_8775P? Other GPUCCs
in here don't select it either.

Bart

> > +       help
> > +         Support for the graphics clock controller on SA8775P devices.
> > +         Say Y if you want to support graphics controller devices and
> > +         functionality such as 3D graphics.
> > +
> >  config SC_GCC_7180
> >         tristate "SC7180 Global Clock Controller"
> >         select QCOM_GDSC
> > diff --git a/drivers/clk/qcom/gpucc-sa8775p.c b/drivers/clk/qcom/gpucc-=
sa8775p.c
> > new file mode 100644
> > index 000000000000..46d73bd0199b
> > --- /dev/null
> > +++ b/drivers/clk/qcom/gpucc-sa8775p.c
> > @@ -0,0 +1,633 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All right=
s reserved.
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +#include <linux/clk.h>
>
> Is this include used? If not, remove it as this is a clk provider and
> not a clk consumer.
