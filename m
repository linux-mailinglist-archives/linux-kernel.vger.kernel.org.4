Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64E56E55AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDRATv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRATs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9506540EF;
        Mon, 17 Apr 2023 17:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27CAE628AE;
        Tue, 18 Apr 2023 00:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E78C4339B;
        Tue, 18 Apr 2023 00:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681777186;
        bh=g3qUdn2hQ1WPJG2BIFK2kXAqmBIPi6cDwAOdAsYPGEs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=L/tBgBfYevEU4sS8/mfX++M/A48vtv4mC8MZbJTMQsuwYTkkiRyta/l7iGLBGIMAD
         WXvmv3rKcIBjklrqVSSm22BE7Lhla9GGLo2F1M3OzgWiBmVcGzmsW0XUNAmsrA9tjO
         FJpaoPyScjeZ1req7eXVuF4mQDM1U+Pgf/uOwtYU2xH94Ur2UTNIugZS3EQOrdC99m
         YUmnulPpCTE29qUEyWVLpOgjzjiJGc8s8YLwm47piGAiQpO8Ul/YTN84nb890sTIrl
         /tCNTBkOUhjNSbOpB1jYuXdanLkVJdjv3iFzPaRvh1A4c2oN34Sw8cJZUJdByBLFM6
         8kCZOAut0DpEw==
Message-ID: <d63d4896afe8a1a901470f88862ce608.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZD2YYrOdQMD3pi7u@gerhold.net>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org> <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org> <ZD2YYrOdQMD3pi7u@gerhold.net>
Subject: Re: [PATCH RFT v2 01/14] dt-bindings: clock: qcom,rpmcc: Add a way to enable unused clock cleanup
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 17 Apr 2023 17:19:44 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephan Gerhold (2023-04-17 12:05:06)
> On Wed, Mar 08, 2023 at 10:35:17PM +0100, Konrad Dybcio wrote:
> > Disabling RPMCC clocks can be a bit touchy. If we can't guarantee all
> > (or at least most) of the oneline peripherals ask the interconnect
> > framework to keep their buses online and guarantee enough bandwidth,
> > we're relying on bootloader defaults to keep the said buses alive throu=
gh
> > RPM requests and rate setting on RPM clocks.
> >=20
> > Without that in place, the RPM clocks are never enabled in the CCF, whi=
ch
> > qualifies them to be cleaned up, since - as far as Linux is concerned -
> > nobody's using them and they're just wasting power. Doing so will end
> > tragically, as within miliseconds we'll get *some* access attempt on an
> > unlocked bus which will cause a platform crash.
> >=20
> > On the other hand, if we want to save power and put well-supported
> > platforms to sleep, we should be shutting off at least some of these
> > clocks (this time with a clear distinction of which ones are *actually*
> > not in use, coming from the interconnect driver).
> >=20
> > To differentiate between these two cases while not breaking older DTs,
> > introduce an opt-in property to correctly mark RPM clocks as enabled
> > after handoff (the initial max freq vote) and hence qualify them for the
> > common unused clock cleanup.
> >=20
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/=
Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> > index 2a95bf8664f9..386153f61971 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> > @@ -58,6 +58,12 @@ properties:
> >      minItems: 1
> >      maxItems: 2
> > =20
> > +  qcom,clk-disable-unused:
> > +    type: boolean
> > +    description:
> > +      Indicates whether unused RPM clocks can be shut down with the co=
mmon
> > +      unused clock cleanup. Requires a functional interconnect driver.
> > +
>=20
> I'm surprised that Stephen Boyd did not bring up his usual "rant" here
> of moving the interconnect clock voting out of rpmcc into the
> interconnect drivers (see [1], [2]). :-)

:) I was hoping to get a fix for disabling unused clks during late init
at the same time. Shucks!

>=20
> I was a bit "cautious" about it back then but at this point I think it
> kind of makes sense. Make sure to read Stephen's detailed explanation in
> https://lore.kernel.org/linux-arm-msm/159796605593.334488.835524465738738=
1953@swboyd.mtv.corp.google.com/
>=20
> We keep looking for workarounds to prevent the CCF from "messing" with
> interconnect-related clocks. But the CCF cannot mess with "clocks" it
> does not manage. The RPM interconnect drivers already talk directly to
> the RPM in drivers/interconnect/qcom/smd-rpm.c. I think it should be
> quite easy to move the QCOM_SMD_RPM_BUS_CLK relates defines over there
> and just bypass the CCF entirely.

Please do it!

>=20
> For backwards compatibility (for platforms without interconnect drivers)
> one could either assume that the bootloader bandwidth votes will be
> sufficient and just leave those clocks completely alone. Or the
> "icc_smd_rpm" platform device could initially make max votes similar to
> the rpmcc device. By coincidence the "icc_smd_rpm" platform device is
> always created, no matter how the device tree looks or if the platform
> actually has an interconnect driver.
>=20

Yeah that's a good plan. Suspend will be broken or burn a lot of power,
but presumably the new DTB will be used fairly quickly. Or you can
implement something like clkdev for interconnects that lets you hack up
an association between interconnects and consumers for existing DTs and
then drop those lookups months later.
