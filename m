Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B0E5EF596
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiI2Mjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiI2Mjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469FE293;
        Thu, 29 Sep 2022 05:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2303C61123;
        Thu, 29 Sep 2022 12:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE56C433D6;
        Thu, 29 Sep 2022 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664455170;
        bh=Xbo6C8uJ+Wh+za/BkKJp6mMR9ogN2jY7z+sJnjU0PgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzx80oPfJql87o6EHAA9npUDDwJhJ863ZQr8E36bBqmPPmm39mhbI+1S5XxkuhCR6
         LkaxEMbNsnn94pbfExnwTkmdkRRj4VCWpV8C/9DoAhmB0CIlfkhCCe9BFmnQfnrD3V
         q7OTpGY3PUTbwG64RyfzUpTZ0CQqo4cXLd+7LpHZx7zV/8iQ1bTCCVItNBSsR+eFQ9
         EZoHBt+Erp2mBMRkStGoVnEsVDPB2TDvbCHKy+OykxDVypur0w0pm0oKS6avphzcql
         X+mVgFpkSONdGGW29ACzHv9bXkDSuMSuygCzoPomsqX+rOROXcccYU2ECNGEu1+Lra
         yij/GxUcz+/Fg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odspE-0003J2-FX; Thu, 29 Sep 2022 14:39:37 +0200
Date:   Thu, 29 Sep 2022 14:39:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] phy: qcom-qmp-pcie: drop bogus register update
Message-ID: <YzWSCI7uGnWVxKPp@hovoldconsulting.com>
References: <20220929092916.23068-1-johan+linaro@kernel.org>
 <20220929092916.23068-12-johan+linaro@kernel.org>
 <CAA8EJpp+j1fx46V3zNgiYxsMbQ5UmB4+7o5dojS2FLjwUL=hRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpp+j1fx46V3zNgiYxsMbQ5UmB4+7o5dojS2FLjwUL=hRg@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 01:18:05PM +0300, Dmitry Baryshkov wrote:
> On Thu, 29 Sept 2022 at 12:29, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
> > PHY is powered on before configuring the registers and only the MSM8996
> > PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
> > initialisation table, may possibly require a second update afterwards.
> >
> > To make things worse, the POWER_DOWN_CONTROL register lies at a
> > different offset on more recent SoCs so that the second update, which
> > still used a hard-coded offset, would write to an unrelated register
> > (e.g. a revision-id register on SC8280XP).
> >
> > As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
> > the bogus register update.
> >
> > Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB") added support
> 
> Unless somebody confirms that this write is not needed on 8998 and
> sdm845, I'd prefer a two stage fix here:
> - changing this to write to proper register (and maybe moving to the
> top of patch series, as we'd want to backport this to the last few
> kernels)

It already is the "proper" register for the v2 platforms that may
conceivably need it it. For the rest it is clearly just broken.

And I don't think this needs to block the rest of the series. That's
why I moved it last. If we decide to backport this we have other context
changes in -next to handle anyway.

> - dropping the write completely.

But sure, doing it in two steps is a possibility.

> Meanwhile I'll try testing this patchset on rb3 and checking whether
> it makes any difference or not.

Thanks for doing that.

Johan
