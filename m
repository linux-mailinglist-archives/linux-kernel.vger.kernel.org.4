Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1216E660526
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjAFQ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjAFQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:57:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174DB7A393;
        Fri,  6 Jan 2023 08:57:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE595B81E0E;
        Fri,  6 Jan 2023 16:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88044C433EF;
        Fri,  6 Jan 2023 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673024219;
        bh=r1TugKFhTopftyqZXhFj4NZAEhxezwqJpeyrAMjzPxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJTrnxSh2OInsOKJ9LVjqBdAjVht1rikq72Gij3sNIBDjQwbYItW5K3d8spq4FgVM
         jMHZNvGPNqeqa+HfRZZHh5swxxpv/ThZz9zzDJCOBuxfa21Nveqz+5og7i8HeyvZR9
         E3fGOhWO5/dy6lO2gcgDoLkKVOb6h9lm92TXipsIzhzl5xnOA+rdxcqTPCkK2QQg3U
         7w1aCzKdizipVXbQ9IqeXYV/WdfOqu7tmjXCWwjMAVGVjrW9jiIbBhbmgmSeuDZRIo
         KVNG0uBd/J0paJt+bbUEYGMVv3vIi5M6nP7nsCMeR+tqpfPOUjznOCVDK6GfokNDEG
         Vq3/El3gO9REA==
Date:   Fri, 6 Jan 2023 10:56:56 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 3/4] clk: qcom: rpmh: Add support for SM8550 rpmh
 clocks
Message-ID: <20230106165656.zseftsxay4c74v6e@builder.lan>
References: <20230104093450.3150578-1-abel.vesa@linaro.org>
 <20230104093450.3150578-4-abel.vesa@linaro.org>
 <07a849a9-03dc-f3af-1d3f-2369cb71451e@linaro.org>
 <Y7V00JiPAYfqF4wH@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7V00JiPAYfqF4wH@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:45:04PM +0200, Abel Vesa wrote:
> On 23-01-04 12:46:55, Dmitry Baryshkov wrote:
> > On 04/01/2023 11:34, Abel Vesa wrote:
> > > Adds the RPMH clocks present in SM8550 SoC.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > ---
> > >   drivers/clk/qcom/clk-rpmh.c | 36 ++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 36 insertions(+)
> > 
> > I think the plan was to have the _PAD clock as a child node of the rpmcc. Is
> > it still the planned implementation?
> 
> Yes. Here is how the dts rpmhcc node will look like:
> 
>          rpmhcc: clock-controller {
>                  compatible = "qcom,sm8550-rpmh-clk";
>                  #clock-cells = <1>;
>                  clock-names = "xo";
>                  clocks = <&xo_board>;
> 
>                  bi_tcxo_div2: bi-tcxo-div2-clk {

Considering that the remainder of the clock exposed (except ipa clock)
by the rpmhcc provider represent clock signals coming out of the pmic;
and that this divider is not located in the aoss (rsc), I don't think
these nodes should live here.

/clocks seems perfectly fine to me.

Regards,
Bjorn

>                          #clock-cells = <0>;
>                          compatible = "fixed-factor-clock";
>                          clocks = <&rpmhcc RPMH_CXO_CLK>;
>                          clock-mult = <1>;
>                          clock-div = <2>;
>                  };
> 
>                  bi_tcxo_ao_div2: bi-tcxo-div2-ao-clk {
>                          #clock-cells = <0>;
>                          compatible = "fixed-factor-clock";
>                          clocks = <&rpmhcc RPMH_CXO_CLK_A>;
>                          clock-mult = <1>;
>                          clock-div = <2>;
>                  };
>          };
> 
> The clock nodes will be probed on of_clk_init.
> 
> > 
> > -- 
> > With best wishes
> > Dmitry
> > 
