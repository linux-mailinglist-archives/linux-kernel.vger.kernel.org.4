Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4971E6C241E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCTVxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCTVxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:53:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A626A4;
        Mon, 20 Mar 2023 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679349217; x=1710885217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oJMHGVvTU4QVoROZZc4qlj/0k+4uP2SQqZCF5Zkok+I=;
  b=CewUIRVrF1WWRstToR1qYA68D/lue2gGAQ5VIeSuo+9VH1ycUBx6Wagg
   m7fFtthHUBKlPo8N0EoQrnkExFTokIBy5wdQ6FboFnAtgEKiU0n2B7+qw
   gXHC1/NxKb+cuRRbaHSzw5TNcyn38oxDdFWvwoeEj82rp2eemGIMp5qv3
   XXxdsFtrJDZKR27g2ZqDHWvu+kJBt4A5cmMzfrkux4Hl+y8vNAbsLH8PT
   wsB3ims97clOOU3ds4ptx4RTDuMt77syojUGp4E3m4/eNpnNSanPbFh9d
   n2QU1KBJeDiPz2Y3HDeGTEZ69xaprWWDOiYTaCXsaDsrsfUMmI0+X5zS6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="340335296"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="340335296"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:53:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="750274625"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="750274625"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:53:32 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 2912A12160F;
        Mon, 20 Mar 2023 23:53:30 +0200 (EET)
Date:   Mon, 20 Mar 2023 23:53:30 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-media@vger.kernel.org, kernel@pengutronix.de,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <ZBjV2slZlmvB7C8I@kekkonen.localdomain>
References: <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
 <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
 <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
 <ZBggtBU1TjlvVNCS@kekkonen.localdomain>
 <20230320092602.GE20234@pendragon.ideasonboard.com>
 <ZBgpXRtXcxg14OGv@kekkonen.localdomain>
 <20230320095514.GF20234@pendragon.ideasonboard.com>
 <ZBgyOPS23BC2wAfg@kekkonen.localdomain>
 <727949a9c3d9e639b046bcd86635796452b10300.camel@pengutronix.de>
 <20230320140012.GB9535@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320140012.GB9535@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Mon, Mar 20, 2023 at 04:00:12PM +0200, Laurent Pinchart wrote:
> On Mon, Mar 20, 2023 at 02:32:25PM +0100, Philipp Zabel wrote:
> > On Mo, 2023-03-20 at 12:15 +0200, Sakari Ailus wrote:
> > > On Mon, Mar 20, 2023 at 11:55:14AM +0200, Laurent Pinchart wrote:
> > > > On Mon, Mar 20, 2023 at 11:37:33AM +0200, Sakari Ailus wrote:
> > > > > On Mon, Mar 20, 2023 at 11:26:02AM +0200, Laurent Pinchart wrote:
> > > > > > In a (simplified) nutshell,
> > > > > > 
> > > > > > ---------+     +----------+     +---------+     +-----+     +-----+
> > > > > > > Camera | --> | CSI-2 RX | --> | CSI2IPU | --> | Mux | --> | IPU |
> > > > > > > Sensor |     |          |     | Gasket  |     |     |     |     |
> > > > > > ---------+     +----------+     +---------+     +-----+     +-----+
> > > > > 
> > > > > Thank you, this is helpful.
> > > > > 
> > > > > I suppose the mux here at least won't actively do anything to the data. So
> > > > > presumably its endpoint won't contain the active configuration, but its
> > > > > superset.
> > > > > 
> > > > > > 
> > > > > > All those blocks, except for the gasket, have a node in DT.
> > > > > > 
> > > > > > The IPU driver needs to know the number of CSI-2 data lanes, which is
> > > > > > encoded in the data-lanes DT property present in both the sensor output
> > > > > > endpoint and the CSI-2 RX input endpoint, but not the other endpoints in
> > > > > > the pipeline.
> > > > > 
> > > > > This doesn't yet explain why the sensor would need to implement
> > > > > get_mbus_config if its bus configuration remains constant.
> > > > 
> > > > If I recall correctly, the IPU driver calls .g_mbus_config() on the
> > > > camera sensor to get the number of lanes, as it can't get it from its
> > > > own endpoint. That's a hack, and as Jacopo proposed, calling
> > > > .g_mbus_config() on the CSI-2 RX would be better, as the CSI-2 RX driver
> > > > can then get the value from its own endpoint, without requiring all
> > > > sensor drivers to implement .g_mbus_config().
> > > 
> > > The g_mbus_config op could be implemented by the CSI2IPU and mux, by simply
> > > requesting the information from the upstream sub-device. No hacks would be
> > > needed.
> > 
> > I think implementing get_mbus_config on the mux might be enough. The
> > IPU driver already recognizes the CSI-2 RX by its grp_id and could
> > infer that it has to use MIPI CSI-2 mode from that.
> > 
> > The video-mux would have to forward get_mbus_config to its active
> > upstream port and if the upstream sensor does not implement it read bus
> > width from the active upstream endpoint.
> 
> I'm fine with implementing it in the mux as well, but I think we can
> take a shortcut here and call it on the CSI-2 RX from the IPU driver, as
> the IPU driver knows about the architecture of the whole pipeline.

If that's the case then I guess that's fine. But can these drivers be used
elsewhere than with IMX6?

It'd be safest to implement g_mbus_config for the all the way to CSI-2 RX.

But if the answer to the question is "no", then making that shortcut should
be fine (and this can be always reworked if need be).

-- 
Kind regards,

Sakari Ailus
