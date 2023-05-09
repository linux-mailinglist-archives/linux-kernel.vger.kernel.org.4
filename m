Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240CF6FCBE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjEIQ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEIQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:57:06 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95E6FA;
        Tue,  9 May 2023 09:57:04 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1DD7ECCC1C;
        Tue,  9 May 2023 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683651423; bh=I3ePwvXSmImEkgis0VV8gRsOntE/VNU7m0pNxel7O0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ALcJ4cP1cMEftnsVntVXVnAUdYytrvCGqYCs0vH7q0MhfZ3NBiu4QWf/LdODYGPAt
         Z399Lz/f4WKenkoiKEklLujt2pH9gyodZtMYwFtt5abqGtj9xq42kCzw1aQR0b4Dzh
         TAk8WFKWdqx3OoxXhBs28N2m/ilerd2lZEo0ZTJw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: mmcc-msm8974: Add OXILICX_GDSC for msm8226
Date:   Tue, 09 May 2023 18:57:02 +0200
Message-ID: <2528191.PYKUYFuaPT@z3ntu.xyz>
In-Reply-To: <69ec1926-760e-c957-82b5-0c3f48f65dcf@linaro.org>
References: <20230506-msm8226-oxilicx-v1-1-52e34b94ff22@z3ntu.xyz>
 <fdb76743-de20-91c5-2edc-19dd5ead33e3@linaro.org>
 <69ec1926-760e-c957-82b5-0c3f48f65dcf@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 8. Mai 2023 13:35:07 CEST Konrad Dybcio wrote:
> On 8.05.2023 13:32, Dmitry Baryshkov wrote:
> > On 08/05/2023 10:23, Konrad Dybcio wrote:
> >> On 6.05.2023 23:20, Luca Weiss wrote:
> >>> On msm8226 we also have OXILICX_GDSC but we need a slighly different
> >>> config, with a .cxcs defined for clock but with no parent.
> >> 
> >> Hm, on newer (a5xx+) GPUs, CX needs to be turned on first and
> >> to achieve that, we sometimes define it to be the GX's (also
> >> implicitly known as "oxili-non-CX" in before-a6xx-times) parent..
> >> 
> >> Roughly speaking CX powers the "GPU hardware owned by the broader
> >> SoC that may not need the GPU core clock to be up" and GX powers
> >> the "GPU hardware owned strictly by the GPU that needs at least some
> >> GPU clocks to be enabled"
> >> 
> >> Maybe 8974 simply has a bug in the driver that would do the reverse?
> >> Could you (and perhaps Dmitry on his shiny new 13yo board) test that
> >> theory, preferably on both SoCs?
> >> 
> >> --- a/drivers/clk/qcom/mmcc-msm8974.c
> >> +++ b/drivers/clk/qcom/mmcc-msm8974.c
> >> @@ -2431,6 +2431,7 @@ static struct gdsc oxili_gdsc = {
> >>          .pd = {
> >>                  .name = "oxili",
> >>          },
> >> +       .parent = &oxili_gdsc.pd,
> >>          .pwrsts = PWRSTS_OFF_ON,
> >>   };
> > 
> > Are you declaring oxili_gdsc to be a parent of itself?
> 
> lol.. nice catch of course this line should have been
> 
> +       .parent = &oxilicx_gdsc.pd,
> 
> and the definitions would need to be swapped

The 0x4024 oxili_gdsc (downstream name gdsc_oxili_gx) is disabled in 8226 dts.

Only in downstream msm8974.dtsi this gdsc gets "parent-supply = 
<&pm8841_s4_corner>;", on 8226 there's no parent-supply. And the gdsc parent 
doesn't even seem to be described there.

Should I still try?

> 
> Konrad
> 
> >>   @@ -2439,7 +2440,6 @@ static struct gdsc oxilicx_gdsc = {
> >>          .pd = {
> >>                  .name = "oxilicx",
> >>          },
> >> -       .parent = &oxili_gdsc.pd,
> >>          .pwrsts = PWRSTS_OFF_ON,
> >>   };
> >> 
> >> Konrad
> >> 
> >>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> >>> ---
> >>>   drivers/clk/qcom/mmcc-msm8974.c | 11 +++++++++++
> >>>   1 file changed, 11 insertions(+)
> >>> 
> >>> diff --git a/drivers/clk/qcom/mmcc-msm8974.c
> >>> b/drivers/clk/qcom/mmcc-msm8974.c index 4273fce9a4a4..39ee3953567c
> >>> 100644
> >>> --- a/drivers/clk/qcom/mmcc-msm8974.c
> >>> +++ b/drivers/clk/qcom/mmcc-msm8974.c
> >>> @@ -2443,6 +2443,16 @@ static struct gdsc oxilicx_gdsc = {
> >>>       .pwrsts = PWRSTS_OFF_ON,
> >>>   };
> >>>   +static struct gdsc oxilicx_gdsc_msm8226 = {
> >>> +    .gdscr = 0x4034,
> >>> +    .cxcs = (unsigned int []){ 0x4028 },
> >>> +    .cxc_count = 1,
> >>> +    .pd = {
> >>> +        .name = "oxilicx",
> >>> +    },
> >>> +    .pwrsts = PWRSTS_OFF_ON,
> >>> +};
> >>> +
> >>>   static struct clk_regmap *mmcc_msm8226_clocks[] = {
> >>>       [MMSS_AHB_CLK_SRC] = &mmss_ahb_clk_src.clkr,
> >>>       [MMSS_AXI_CLK_SRC] = &mmss_axi_clk_src.clkr,
> >>> @@ -2533,6 +2543,7 @@ static struct gdsc *mmcc_msm8226_gdscs[] = {
> >>>       [MDSS_GDSC] = &mdss_gdsc,
> >>>       [CAMSS_JPEG_GDSC] = &camss_jpeg_gdsc,
> >>>       [CAMSS_VFE_GDSC] = &camss_vfe_gdsc,
> >>> +    [OXILICX_GDSC] = &oxilicx_gdsc_msm8226,
> >>>   };
> >>>     static const struct regmap_config mmcc_msm8226_regmap_config = {
> >>> 
> >>> ---
> >>> base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
> >>> change-id: 20230506-msm8226-oxilicx-7f3f0f8e491d
> >>> 
> >>> Best regards,




