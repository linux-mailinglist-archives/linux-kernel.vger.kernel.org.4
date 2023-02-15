Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F01698200
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjBORal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBORak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:30:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853344A3;
        Wed, 15 Feb 2023 09:30:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FF52B8232C;
        Wed, 15 Feb 2023 17:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3D9C433EF;
        Wed, 15 Feb 2023 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676482236;
        bh=PHjFln2cv3DyyDLZ0VCQo15eyJ/e8PCcLGL6fB244wE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e04R33YsTG7snEaGM6K0/BOIgli4HPjNCnnYShH7K8SvDcRzqA/01XNxIKLoJ1r4L
         4hcg3ZX/IdUPPcjtkrO1QBr21oRdWfMb2cobRMWUVBTk6CCNZIKSrnI0A3vyt4RilL
         hpA2o5jiPuiQ2bnIdMqL3CWzvvOyOuurJw6YpoqZQfq3FRAs9a2rrOE3GfiWyL9GPj
         YvCm8LvOWH0xn1lX18LIDWpWQbx0lXAs2QK7x5uCGudAPbte5icJ8U6WJmPomKHNGM
         9gQfeP6QEpfc/GQwMl3n9ROoLcMIrNVOnF1nilNUp5OGOYjBtRBG9sPMx7NHD/NDom
         WkEBCvpfL0Yng==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pSLcz-0002vN-V0; Wed, 15 Feb 2023 18:31:34 +0100
Date:   Wed, 15 Feb 2023 18:31:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce
 pmic_glink
Message-ID: <Y+0W9U8lIhTH1xik@hovoldconsulting.com>
References: <20230213215619.1362566-1-quic_bjorande@quicinc.com>
 <20230213215619.1362566-3-quic_bjorande@quicinc.com>
 <Y+yqPMdiuJ+ssisR@hovoldconsulting.com>
 <20230215172347.GA2417333@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215172347.GA2417333@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 09:23:47AM -0800, Bjorn Andersson wrote:
> On Wed, Feb 15, 2023 at 10:47:40AM +0100, Johan Hovold wrote:
> > On Mon, Feb 13, 2023 at 01:56:17PM -0800, Bjorn Andersson wrote:
> [..]
> > > +&mdss0_dp0_out {
> > > +	data-lanes = <0 1>;
> > 
> > This does not work as the drm driver expects 'data-lanes' to be defined
> > in the controller node where you had it in the previous versions:
> > 
> > 	[    6.669325] [drm] Invalid property "data-lanes", default max DP lanes = 4
> > 
> > Moving it to the endpoint nodes would require updating both binding and
> > driver it seems.
> > 
> 
> I will go back and double-check, but this should be taken care of in
> d25cfeeec064 ("drm/msm/dp: parse data-lanes as property of dp_out
> endpoint").

That indeed seems to be the case. Sorry about the noise.

I'll just carry the fixes I posted for my sc8280xp 6.2 branches.

Johan
