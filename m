Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6E8627B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbiKNK5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiKNK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:57:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968011D0F0;
        Mon, 14 Nov 2022 02:57:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B580B80DDF;
        Mon, 14 Nov 2022 10:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B5DC433C1;
        Mon, 14 Nov 2022 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668423457;
        bh=fUQ9vpvOPE5lm++N751vUFvd8FWP71h+ikUD+qipnFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9Y9QF3gyLnULxGSOG70vhOS13YMbNd6ulz2UXtYzXr/4muZvQ9G4sjuFJngy0iFW
         zTQ6ruoB44v/QHRlLJTF2bAr9UfToR8CQGZkDIZ6ZULOouDAb3WNdfmTkKvriogcHS
         d1MbFwy/MQAFMawia7USsV4woKNYd0l4tvAXdVnvp+r63SNV35iCwYfx5bO9MNHkKf
         zzHDtLN2s2Ni8rc/ZfazsvXd8+QjvrdWVF5jFrB3EWa4GEySV3ZvqjHzU3EGnkXUTH
         Cs/NcVJ7mVT19kWgYeZoOM6XZLH2kJRYdcq6NfzEZX3FpEIL0RXTufNJLVVX8zabx4
         1lv+/meEFsb7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouX9E-00010k-Jv; Mon, 14 Nov 2022 11:57:04 +0100
Date:   Mon, 14 Nov 2022 11:57:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/22] phy: qcom-qmp-combo: merge USB and DP
 configurations
Message-ID: <Y3IfAEhpPRLnFRhr@hovoldconsulting.com>
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-18-johan+linaro@kernel.org>
 <5fd7a56f-db12-deb3-753a-22867526d90b@linaro.org>
 <Y3ICOwr2ld9cdgrK@hovoldconsulting.com>
 <8802255c-16a9-1fb7-bbc5-d8e0d44a6f1f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8802255c-16a9-1fb7-bbc5-d8e0d44a6f1f@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 01:10:43PM +0300, Dmitry Baryshkov wrote:
> On 14/11/2022 11:54, Johan Hovold wrote:
> > On Sat, Nov 12, 2022 at 10:43:14AM +0300, Dmitry Baryshkov wrote:
> >> On 11/11/2022 11:56, Johan Hovold wrote:
> >>> It does not really make any sense to keep separate configuration
> >>> structures for the USB and DP parts of the same PHY so merge them.
   
> >>> -/* struct qmp_phy_cfg - per-PHY initialization config */
> >>>    struct qmp_phy_cfg {
> >>> -	/* phy-type - PCIE/UFS/USB */
> >>> -	unsigned int type;
> >>>    	int lanes;
> >>
> >> int lanes doesn't really make sense here in my opinion. It should be
> >> usb_lanes and dp_lanes.
> > 
> > It doesn't make much less sense than having it here currently do.
> > 
> > All of these USB-C PHYs are dual lane for bi-directional SS USB and
> > quad lane for uni-directional DP (even if only CC1 orientation and lanes
> > 2 and 3 are currently supported).
> 
> I was under impression that sdm845 has just a single lane for each of 
> USB and DP. After rechecking the phy/next, I see that it was my mistake 
> (quite logical, SS is two lanes, so the compliant PHY must have two 
> lanes too).
> 
> I wander how/if 4-lane DP works. The only thing that we do is 
> programming of the QSERDES_DP_PHY_PD_CTL register, however judging e.g. 
> your 4-lane PCIe changes, one should probably also program the other two 
> lanes. Maybe it is handled automatically inside the hardware.

4-lane PCIe on SC8280XP is a different thing entirely (and remember that
that's actually 8 uni-directional lanes).

I'm sure there are further problems with the current DP alt mode
implementation, but hopefully that can be resolved when adding support
for orientation detection. I'm just fixing the obvious bugs and try to
stay "bug compatible" otherwise. :)

> > I should probably just drop the lanes parameter completely, either as a
> > preparatory clean up or as follow-on one (e.g. also a bit depending on
> > if there are other reasons for respinning a v2).
> 
> I think a follow up is enough, but let's get it. Having a single lanes=2 
> field looks... strange.

I dropped the lane parameter as a preparatory patch to this one in v2
that I'll post in a bit.

Johan
