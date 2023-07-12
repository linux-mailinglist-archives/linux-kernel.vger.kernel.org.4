Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6089D750846
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGLM2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjGLM2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE15A0;
        Wed, 12 Jul 2023 05:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40CCA61517;
        Wed, 12 Jul 2023 12:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D9DC433C7;
        Wed, 12 Jul 2023 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689164920;
        bh=H25d+53xWwXJx3v6K8YthS8mMiWOu37NY0dqL+/3Dv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dR9vauswIDIs4B7H/R1Ja4iHP5QHU78WDXEzKfmgoGcYVOuoVsLeNwX5+Ep2HX7ng
         Xa0Q7Sxr+tui6m4iZOw7vfKBOM2kql6vq1N4YszAhZ3/S1fcYdsn+vBXyxyGXM3Rc9
         TxXPGpM5NWOU/mAZQlgQvjhe4dLpGDGwafuaT1Qek3FDWsd6trr1XEgKY/Ww/UnWRL
         RGl++xjCGKHaeeOWgFs/5fnQzjLJeb4EDIFlF1+Xi5vX9wboBT0MOxvKO4JbdYVf1J
         C/dIIbyNnFM749CtPEuseyvxbyYppfxUrvQT0n+UD9Q93FLZMe2kTzsgBgoD4MqBA+
         eC1p3fOY5cfVA==
Date:   Wed, 12 Jul 2023 15:28:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 for-next] RDMA/core: Get IB width and speed from netdev
Message-ID: <20230712122836.GZ41919@unreal>
References: <20230707105634.1921046-1-huangjunxian6@hisilicon.com>
 <20230712121534.GY41919@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712121534.GY41919@unreal>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:15:34PM +0300, Leon Romanovsky wrote:
> On Fri, Jul 07, 2023 at 06:56:34PM +0800, Junxian Huang wrote:
> > From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> > 
> > Previously, there was no way to query the number of lanes for a network
> > card, so the same netdev_speed would result in a fixed pair of width and
> > speed. As network card specifications become more diverse, such fixed
> > mode is no longer suitable, so a method is needed to obtain the correct
> > width and speed based on the number of lanes.
> > 
> > This patch retrieves netdev lanes and speed from net_device and
> > translates them to IB width and speed. Also, add a generic function
> > to translating netdev speed to IB speed.
> > 
> > Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> > Signed-off-by: Luoyouming <luoyouming@huawei.com>
> > Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> > ---
> >  drivers/infiniband/core/verbs.c | 17 +++++++++++++++--
> >  include/rdma/ib_verbs.h         | 26 ++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+), 2 deletions(-)

<...>

> >  
> >  	if (!rc && lksettings.base.speed != (u32)SPEED_UNKNOWN) {
> >  		netdev_speed = lksettings.base.speed;
> > +		if (lksettings.lanes) {
> > +			ib_get_width_and_speed(netdev_speed, lksettings.lanes,
> > +					       speed, width);
> > +			return 0;
> > +		}
> >  	} else {
> >  		netdev_speed = SPEED_1000;
> > -		pr_warn("%s speed is unknown, defaulting to %u\n", netdev->name,
> > -			netdev_speed);
> > +		if (rc)
> 
> This if (rc) is not needed as we will take this else leaf for two
> reasons: rc != 0 or base_speed is SPEED_UNKNOWN.
> 
> Fixed it locally and applied.

Actually not, this patch still needs some changes before it can be applied.

Thanks

> 
> > +			pr_warn("%s speed is unknown, defaulting to %u\n",
> > +				netdev->name, netdev_speed);
> >  	}
> >  
> >  	if (netdev_speed <= SPEED_1000) {
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index 1e7774ac808f..7dc926ec7fee 100644
> > --- a/include/rdma/ib_verbs.h
> > +++ b/include/rdma/ib_verbs.h
> > @@ -552,6 +552,18 @@ static inline int ib_width_enum_to_int(enum ib_port_width width)
> >  	}
> >  }
> >  
> > +static inline int ib_int_to_ib_width(u32 lanes)
> > +{
> > +	switch (lanes) {
> > +	case 1: return IB_WIDTH_1X;
> > +	case 2: return IB_WIDTH_2X;
> > +	case 4: return IB_WIDTH_4X;
> > +	case 8: return IB_WIDTH_8X;
> > +	case 12: return IB_WIDTH_12X;
> > +	default: return IB_WIDTH_1X;
> > +	}
> > +}
> > +
> >  enum ib_port_speed {
> >  	IB_SPEED_SDR	= 1,
> >  	IB_SPEED_DDR	= 2,
> > @@ -563,6 +575,20 @@ enum ib_port_speed {
> >  	IB_SPEED_NDR	= 128,
> >  };
> >  
> > +static inline int ib_eth_to_ib_speed(u32 speed)
> > +{
> > +	switch (speed) {
> > +	case SPEED_2500: return IB_SPEED_SDR;
> > +	case SPEED_5000: return IB_SPEED_DDR;
> > +	case SPEED_10000: return IB_SPEED_FDR10;
> > +	case SPEED_14000: return IB_SPEED_FDR;
> > +	case SPEED_25000: return IB_SPEED_EDR;
> > +	case SPEED_50000: return IB_SPEED_HDR;
> > +	case SPEED_100000: return IB_SPEED_NDR;
> > +	default: return IB_SPEED_SDR;
> > +	}
> > +}
> > +
> >  enum ib_stat_flag {
> >  	IB_STAT_FLAG_OPTIONAL = 1 << 0,
> >  };
> > -- 
> > 2.30.0
> > 
