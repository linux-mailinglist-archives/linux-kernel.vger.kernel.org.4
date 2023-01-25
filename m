Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31E067BF57
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjAYV4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAYV4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:56:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357E2696;
        Wed, 25 Jan 2023 13:56:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93C0061617;
        Wed, 25 Jan 2023 21:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE04DC4339C;
        Wed, 25 Jan 2023 21:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674683772;
        bh=iEJZTt0NjlDw8K50/4qHoq/1GnVqXzmFgaCZh9MA2Z4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YCLqqp0gdW1NhvEbjbKQSRfvnS9AQAXszwzzD0tDtaC+9csDBDkOd8dstb6rvzeh/
         wBRbFlqGq88gfnTuswwY9kOJTLNwO+VWTB4iZHaCaOLR5C/59iGOs5E3oTyxZah9pd
         f8e+P2pzlijf21vG+d32tHLB5hgEpLPWVDrji8ee2ay38QBRjnwicw7ITjzxqAEtaV
         PIHhM1legutzqfMl0tMcGAK8jPbUkhCkV7RhGWviYXTGRhGSF66Z+bHYt1Z5wiRljz
         jO3MPrfJLJj2QQWkGL7A7ko9gBRDsuzjSLClKSbK8rdAMoHGhgHlzwhCBteuRl/hSr
         cKT8PoLGP1zag==
Message-ID: <525ef5cdefe987c3412249760324eb09.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <63f017c7-d320-a996-7bda-33d263a847bc@linaro.org>
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org> <20230118132254.2356209-8-dmitry.baryshkov@linaro.org> <7055af43f4a8894ac34e53c5847fb3de.sboyd@kernel.org> <63f017c7-d320-a996-7bda-33d263a847bc@linaro.org>
Subject: Re: [PATCH v4 7/7] clk: qcom: add the driver for the MSM8996 APCS clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 25 Jan 2023 13:56:09 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-01-25 13:48:54)
>=20
>=20
> On 25.01.2023 22:38, Stephen Boyd wrote:
> > Quoting Dmitry Baryshkov (2023-01-18 05:22:54)
> >> diff --git a/drivers/clk/qcom/apcs-msm8996.c b/drivers/clk/qcom/apcs-m=
sm8996.c
> >> new file mode 100644
> >> index 000000000000..7e46ea8ed444
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/apcs-msm8996.c
> >> @@ -0,0 +1,76 @@
> > [...]
> >> +
> >> +static int qcom_apcs_msm8996_clk_probe(struct platform_device *pdev)
> >> +{
> >> +       struct device *dev =3D &pdev->dev;
> >> +       struct device *parent =3D dev->parent;
> >> +       struct regmap *regmap;
> >> +       struct clk_hw *hw;
> >> +       unsigned int val;
> >> +       int ret =3D -ENODEV;
> >> +
> >> +       regmap =3D dev_get_regmap(parent, NULL);
> >> +       if (!regmap) {
> >> +               dev_err(dev, "failed to get regmap: %d\n", ret);
> >> +               return ret;
> >> +       }
> >> +
> >> +       regmap_read(regmap, APCS_AUX_OFFSET, &val);
> >> +       regmap_update_bits(regmap, APCS_AUX_OFFSET, APCS_AUX_DIV_MASK,
> >> +                          FIELD_PREP(APCS_AUX_DIV_MASK, APCS_AUX_DIV_=
2));
> >> +
> >> +       /* Hardware mandated delay */
> >=20
> > Delay for what? Setting the divider? What if the register value didn't
> > change at all? Can you skip the delay in that case?
> Waiting 5 us unconditionally in exchange for ensured CPU clock
> source stability sounds like a rather fair deal.. Checking if
> the register value changed would not save us much time..

So it is waiting for the CPU clk to be stable? The comment is not clear.
