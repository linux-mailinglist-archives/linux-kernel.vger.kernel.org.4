Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB16D5BDC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiITFwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiITFv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:51:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F13F1DA;
        Mon, 19 Sep 2022 22:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 710A6B82103;
        Tue, 20 Sep 2022 05:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1477DC433C1;
        Tue, 20 Sep 2022 05:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663653112;
        bh=n6gQZoG7jJsxjSK3bqqn1IleP8t2piutWDKO2U7XzJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgUPl1iSk3E0d+tIj09uQQGXfBIEWJCZ+Q9Q4tbsS0FOqo+nYBW/iWkdEZO1mDea/
         PTD1Z0q2vtcJV2NEmHkMinzzHY55c0t7EMq8znTDOVpL4EAcKvXbykg+ZHEm1YlKWD
         pkCodkf4v9KpwpdQf7nlqHpfrNU9eiMNZxZjE2ErIgFpNxV37Mq1plumtTpDU6qrOW
         K0cJ2rNrlyClbREmIxJIQKh7Kx5HPrPlKUHRHuH3VYXfV68GNrw3ZnXRvL04IW9JC+
         AG3FrarevbeHxJPWVjojGJ11ePf/kHzTTpq9lo/nLjZi5pDCfrEdYqHUTSnbwg68c2
         aGUTu5oqeKJNA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaWAg-0007N0-Qa; Tue, 20 Sep 2022 07:51:50 +0200
Date:   Tue, 20 Sep 2022 07:51:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        quic_kriskura@quicinc.com, dianders@chromium.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clk: qcom: gcc-sc7180: Update the .pwrsts for usb
 gdsc
Message-ID: <YylU9hx/9j0QKLsO@hovoldconsulting.com>
References: <20220916102417.24549-1-quic_rjendra@quicinc.com>
 <20220916102417.24549-2-quic_rjendra@quicinc.com>
 <YyiOiudZuMDXOvGr@hovoldconsulting.com>
 <e446d0c0-7084-8b5a-132e-977b25913343@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e446d0c0-7084-8b5a-132e-977b25913343@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:06:22AM +0530, Rajendra Nayak wrote:
> 
> 
> On 9/19/2022 9:15 PM, Johan Hovold wrote:
> > On Fri, Sep 16, 2022 at 03:54:16PM +0530, Rajendra Nayak wrote:
> >> The USB controller on sc7180 does not retain the state when
> >> the system goes into low power state and the GDSC is
> >> turned off. This results in the controller reinitializing and
> >> re-enumerating all the connected devices (resulting in additional
> >> delay while coming out of suspend)
> >> Fix this by updating the .pwrsts for the USB GDSC so it only
> >> transitions to retention state in low power.
> >>
> >> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> >> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> >> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> >> ---
> >> v2:
> >> Updated the changelog
> >>
> >>   drivers/clk/qcom/gcc-sc7180.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
> >> index c2ea09945c47..2d3980251e78 100644
> >> --- a/drivers/clk/qcom/gcc-sc7180.c
> >> +++ b/drivers/clk/qcom/gcc-sc7180.c
> >> @@ -2224,7 +2224,7 @@ static struct gdsc usb30_prim_gdsc = {
> >>   	.pd = {
> >>   		.name = "usb30_prim_gdsc",
> >>   	},
> >> -	.pwrsts = PWRSTS_OFF_ON,
> >> +	.pwrsts = PWRSTS_RET_ON,
> >>   };
> >>   
> >>   static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
> > 
> > It seems like the above will not work unless you also provide the
> > registers offsets that gdsc_force_mem_on() expects.
> 
> That's true, but its needed only on platforms that support complete
> CX domain power collapse. sc7280 (and sc7180) does not support
> that and hence we can achieve GDSC RET without any of the RETAIN_MEM/
> RETAIN_PERIPH bits programmed.
> I explained some of that in detail on another related thread a
> while back [1]
> 
> [1] https://lore.kernel.org/all/5ff21b1e-3af9-36ef-e13e-fa33f526d0e3@quicinc.com/

Thanks for the link, that was was very informative. 

Could you please update the commit message of patch 1/3 so that it also
covers these systems and explains why you don't set the RETAIN_MEM and
RETAIN_PERIPH bits for them?

As that commit message stands now, it seems that those bits must be set
for retention to work.

> > Specifically, unless you set cxc_count for the GDSC, the above call is a
> > no-op and the retention setting (i.e. the RETAIN_MEM and RETAIN_PERIPH
> > bits) will not be updated when registering the GDSC.

Johan
