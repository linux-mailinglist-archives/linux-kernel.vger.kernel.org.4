Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD47C6DCB56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjDJTJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJTJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B316170B;
        Mon, 10 Apr 2023 12:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05405617AC;
        Mon, 10 Apr 2023 19:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3B1C433EF;
        Mon, 10 Apr 2023 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681153773;
        bh=6AM3IaSISpi2UJXkc2lWWcX+1778WF33N4cnk40E1co=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=APr9zLvB/hh3+87BtMdUNx3eVQRO9c+qp/4UX7vboA4/APxZW/a9tR9DAeAzPl8jL
         TmckCAQ8j71bQxFTOFAClgd3J9mKG3EXOQGtEPMUrVSLs5+ilsbTPo51Mh/P+CEzNo
         v0Fc7dW7BcQQi814hq9MI7DlDpaeBrNrRKyphlMlE2+yqXB+oR4Kmp0GYtxUD+M3LU
         ciMdrJwSVwHmvgunvcJh8hovFPDkLtCwl7CLx+b5Pu4tq+OaRbzPkouw/3OJozzmT2
         QdULEzivBcPN+tcbcD3lW12chUvGOFjzqo7BNsRyZfzc/gIAKt2lPafAXYFa/IRSJz
         7Kgv0RbOfApvA==
Message-ID: <c8847456a3a30b31bb3b3aa3c32a5a8b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMRc=McM1DfCoMmuUYcChFFBG=H1PgZFAWcuxnQsdhRdYrT+yA@mail.gmail.com>
References: <20230328193632.226095-1-brgl@bgdev.pl> <20230328193632.226095-3-brgl@bgdev.pl> <72286603300630b890705c99b42f05a4.sboyd@kernel.org> <CAMRc=McM1DfCoMmuUYcChFFBG=H1PgZFAWcuxnQsdhRdYrT+yA@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: qcom: add the GPUCC driver for sa8775p
From:   Stephen Boyd <sboyd@kernel.org>
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
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Apr 2023 12:09:31 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bartosz Golaszewski (2023-04-06 04:20:33)
> On Wed, Mar 29, 2023 at 4:15=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > Quoting Bartosz Golaszewski (2023-03-28 12:36:27)
> > > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > > index 449bc8314d21..5e1919738aeb 100644
> > > --- a/drivers/clk/qcom/Kconfig
> > > +++ b/drivers/clk/qcom/Kconfig
> > > @@ -437,6 +437,14 @@ config SA_GCC_8775P
> > >           Say Y if you want to use peripheral devices such as UART, S=
PI,
> > >           I2C, USB, UFS, SDCC, etc.
> > >
> > > +config SA_GPUCC_8775P
> > > +       tristate "SA8775P Graphics clock controller"
> > > +       select SA_GCC_8775P
> >
> > Should select QCOM_GDSC as well.
> >
>=20
> Why if it's already selected indirectly by SA_GCC_8775P? Other GPUCCs
> in here don't select it either.

For completeness.
