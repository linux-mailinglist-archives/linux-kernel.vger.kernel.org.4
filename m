Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46287021BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjEOCej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEOCeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:34:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B011B;
        Sun, 14 May 2023 19:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C1660F23;
        Mon, 15 May 2023 02:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21926C433EF;
        Mon, 15 May 2023 02:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684118075;
        bh=VCcecaqn4IPehbbTLLoz99REnFzzsmHGGoAyEPzYTdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvJA8fkUQyE0nQECJ054AoPoLdadm2n3LjqtKqTjW0ITm9UNE3e9v8vNu3G0RwOu/
         Sz4JwFa2szH8Svq2/7q7A83F9HJA6j5CeLSOxj1+aFJnJpdKwCURJarh9E7XWCuQq2
         ITIQP3gef4ESbC4o7Q9r3GJD6jlK8W5QUcN0KjFX8BCo52gN86Gqv42srk2pBCHbeX
         lMnr3rfCCKj13uan7ykzmyVrUOZWxYaZBUrFv00rMgPFuxpsXzEuWhn7sQQnPG+/bF
         wqM7lHcbdft25e9/aQrOgWBU/7+tGF2tKMMGHWfVezt4GXbRmJI/rCZWT7ynKuOR94
         VFuM89EUIZTbA==
Date:   Sun, 14 May 2023 19:38:28 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
Message-ID: <20230515023828.jqrrqkit5ygovimp@ripper>
References: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
 <f6ecd66b-e207-0ed9-0ff3-1febfdf5bce9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ecd66b-e207-0ed9-0ff3-1febfdf5bce9@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 11:09:07AM +0200, Konrad Dybcio wrote:
> 
> 
> On 12.05.2023 17:04, Bjorn Andersson wrote:
> > The rpmh driver will cache sleep and wake votes until the cluster
> > power-domain is about to enter idle, to avoid unnecessary writes. So
> > associate the apps_rsc with the cluster pd, so that it can be notified
> > about this event.
> > 
> > Without this, only AMC votes are being commited.
> Ouch.
> 
> Should we make this required: in bindings and add it to all
> platforms?
> 

I though this was an optimization and in the absence of this callback
the driver would just write out wake and sleep sets as well. But per the
current implementation (and perhaps some underlying cause?) it is indeed
required, if you care about power consumption.

> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> 

The Fixes sounds reasonable.

Thanks,
Bjorn

> Konrad
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 8fa9fbfe5d00..5c68f2182c2f 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -3982,6 +3982,7 @@ apps_rsc: rsc@18200000 {
> >  			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
> >  					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
> >  			label = "apps_rsc";
> > +			power-domains = <&CLUSTER_PD>;
> >  
> >  			apps_bcm_voter: bcm-voter {
> >  				compatible = "qcom,bcm-voter";
