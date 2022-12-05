Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4169864280D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiLEMHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiLEMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:07:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB13DF61;
        Mon,  5 Dec 2022 04:07:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EDF9B80F93;
        Mon,  5 Dec 2022 12:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACF3C433D6;
        Mon,  5 Dec 2022 12:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670242032;
        bh=nbVll1UJq4AQLhzCQgmeFzFvQNQuvneOX3xjaOlj+e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qB1J99DF86iViwbgNldFH4Gk2vUeZgtbilZV60VobZ4r2E6G2q0qT0HAMPqlVzGk5
         aPd3KbrscO7WvRR8k7L1zWiPNrTGSUR6YFdTO3iaywrboXXhhG88Qxwjeo64U0HscN
         pR90gest5KlzP1j6JC1y7hFsraVqD3BOEHdiQkXhr5tweicnauFJyka008tOI3XMfX
         67nGSMCYeBcD3yF1ghMVWmR0Abq0hjDOUYDMrgFQwEV6NreJClpAE1w7mFWsuKrFSl
         0lOEc8Xkc99Mf+vi4+4s/WoryU9CCvKAtBbdJqblz96pG4A1TOlzMR8KlE99Ae9O1m
         DQPjmqCM5Du5w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p2AFg-0008W9-OO; Mon, 05 Dec 2022 13:07:17 +0100
Date:   Mon, 5 Dec 2022 13:07:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Message-ID: <Y43e9KRDsTCS5VI4@hovoldconsulting.com>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
 <20221205100837.29212-2-johan+linaro@kernel.org>
 <20221205115906.GA20192@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205115906.GA20192@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 05:29:06PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Dec 05, 2022 at 11:08:36AM +0100, Johan Hovold wrote:
> > UFS controllers may be cache coherent and must be marked as such in the
> > devicetree to avoid data corruption.
> > 
> > This is specifically needed on recent Qualcomm platforms like SC8280XP.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > index f2d6298d926c..1f1d286749c0 100644
> > --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > @@ -44,6 +44,8 @@ properties:
> >      minItems: 8
> >      maxItems: 11
> >  
> > +  dma-coherent: true
> > +
> 
> This property is not applicable to all SoCs. So setting true here will make it
> valid for all.

Yes, it would be a valid, but it will only be added to the DTs of SoCs
that actually require it. No need to re-encode the dtsi in the binding.

Johan
