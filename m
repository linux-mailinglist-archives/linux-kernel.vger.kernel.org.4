Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6441E5B8738
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiINLYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiINLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:23:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B596D6525A;
        Wed, 14 Sep 2022 04:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D3B1B81A5B;
        Wed, 14 Sep 2022 11:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBDBC433D6;
        Wed, 14 Sep 2022 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663154625;
        bh=rospQRd01AkN2gJUmUr22fajGKIcwYulhJwV6VJLFOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSzSk/akGXmI6A/Szevs3K7j5JrGCFq1vhUkoXLB16FgUZi7uGKdThmVonAXyG329
         W9kiXbpbTiB02IbvLvBp21sDOQsZ4AfkRrIBpzTcxZY9klwRsXGZJErnpBPdb7YFGp
         5fgHGmpNPVJccWQfF2xt6pBuR/cze6U4Uudt6wXV1mHTDwZzGshxlA6LHfqSkqMz20
         b5iHPBhpHp3G0DV1uR+gEXES4mtiuMCdKOFDSBEiN/9YHgNAxHVASCnPzdyaw7nCWa
         ercs03qaNVfiyjnseeSaT0VoBMk2hI6TTH5+57NEZHNP435XPd3waHXWgpaMskqJdn
         xmKZgP6MQtZEA==
Date:   Wed, 14 Sep 2022 16:53:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     David Collins <quic_collinsd@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <YyG5vRgsejk7Y0DH@matsya>
References: <20220201134108.2677578-1-vkoul@kernel.org>
 <YhUVAwtfjuIdKrRQ@matsya>
 <1c66890b-6736-61ef-7d16-619f90ced4a0@linaro.org>
 <4f1ae43c-0f22-19fe-0794-3cc268104396@linaro.org>
 <20220829222601.47241C433C1@smtp.kernel.org>
 <Yw2TsARPfuCLvDg0@matsya>
 <20220830211129.6D60EC433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830211129.6D60EC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-22, 14:11, Stephen Boyd wrote:
> Quoting Vinod Koul (2022-08-29 21:36:00)
> > On 29-08-22, 15:25, Stephen Boyd wrote:
> > > Quoting Dmitry Baryshkov (2022-06-18 08:29:58)
> > > > On 01/05/2022 22:41, Dmitry Baryshkov wrote:
> > > > > On 22/02/2022 19:53, Vinod Koul wrote:
> > > > >> On 01-02-22, 19:11, Vinod Koul wrote:
> > > > >>> Hello,
> > > > >>>
> > > > >>> The is version 3 of support for PMIC v7. I have added a new property
> > > > >>> qcom,bus-id for supporting v7 and then add driver changes for v7
> > > > >>>
> > > > >>> This depends on yaml conversion patch:
> > > > >>> https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/ 
> > > > >>>
> > > > >>
> > > > >> Any feedback on this...
> > > > > 
> > > > > Another gracious reminder about these patches. At this moment this is 
> > > > > one of the important pieces lacking for the full SM8450 support in the 
> > > > > upstream kernel.
> > > > 
> > > > Stephen, yet another ping. This is the blocking point for the further 
> > > > SM8450 progress.
> > > > 
> > > 
> > > Sorry I completely missed this one as it fell off the end of my inbox
> > > into the abyss.
> > 
> > Thanks for the reply. Is this applied now or you have some feedback for
> > me to address..
> > 
> 
> Does it apply along with the series from qcom[1]? I have to check and
> make sure they both work together.

There were conflicts, I have resolved, tested on top of spmi/next again
and posted the v4 now.. Hope this would get in.

-- 
~Vinod
