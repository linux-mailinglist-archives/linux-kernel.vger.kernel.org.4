Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8AB6C0E76
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCTKPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCTKPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:15:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DF41114B;
        Mon, 20 Mar 2023 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679307330; x=1710843330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iWDXrnJ/tO43TsGugCkvz7bOfr4hjER5QYM6kAETLk8=;
  b=aJ8+XLDnRuLVoox8IZ5rlQQ9yq84ovopCm8FgG2Yr3FLjp26zBFsK0D9
   JW6MhHMhGvgOb119uA41cqST0Z0YHvJ9MT5V2nzf9AVKqGVSOf+CWemdi
   G9ffB+r2LW2H8apXX8Pzw4Kf3nN01YKsA232cmsxZaZA9TVvozrR0E0xS
   1smalh1xlsv/DujLi56A6XaXRPFMAgc8x5jNKSWzoVKfR0mfQujLq3wQz
   Bs9JQ/dNOfLRmmS7wBBOJFMh7QfNZdGIkMHykAaiZC1HJcEUkB8km3m3j
   76u39DgGx0tqN6kYR3U4D3RuzuKtDam3bhTL6nAvFT0JcWnCRYANsi0e1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="340167700"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="340167700"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:15:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="750039079"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="750039079"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:15:24 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id AF157122400;
        Mon, 20 Mar 2023 12:15:20 +0200 (EET)
Date:   Mon, 20 Mar 2023 12:15:20 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-media@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <ZBgyOPS23BC2wAfg@kekkonen.localdomain>
References: <20230306063649.7387-1-marcel@ziswiler.com>
 <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
 <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
 <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
 <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
 <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
 <ZBggtBU1TjlvVNCS@kekkonen.localdomain>
 <20230320092602.GE20234@pendragon.ideasonboard.com>
 <ZBgpXRtXcxg14OGv@kekkonen.localdomain>
 <20230320095514.GF20234@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320095514.GF20234@pendragon.ideasonboard.com>
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

On Mon, Mar 20, 2023 at 11:55:14AM +0200, Laurent Pinchart wrote:
> On Mon, Mar 20, 2023 at 11:37:33AM +0200, Sakari Ailus wrote:
> > Hi Laurent,
> > 
> > On Mon, Mar 20, 2023 at 11:26:02AM +0200, Laurent Pinchart wrote:
> > > In a (simplified) nutshell,
> > > 
> > > ---------+     +----------+     +---------+     +-----+     +-----+
> > > | Camera | --> | CSI-2 RX | --> | CSI2IPU | --> | Mux | --> | IPU |
> > > | Sensor |     |          |     | Gasket  |     |     |     |     |
> > > ---------+     +----------+     +---------+     +-----+     +-----+
> > 
> > Thank you, this is helpful.
> > 
> > I suppose the mux here at least won't actively do anything to the data. So
> > presumably its endpoint won't contain the active configuration, but its
> > superset.
> > 
> > > 
> > > All those blocks, except for the gasket, have a node in DT.
> > > 
> > > The IPU driver needs to know the number of CSI-2 data lanes, which is
> > > encoded in the data-lanes DT property present in both the sensor output
> > > endpoint and the CSI-2 RX input endpoint, but not the other endpoints in
> > > the pipeline.
> > 
> > This doesn't yet explain why the sensor would need to implement
> > get_mbus_config if its bus configuration remains constant.
> 
> If I recall correctly, the IPU driver calls .g_mbus_config() on the
> camera sensor to get the number of lanes, as it can't get it from its
> own endpoint. That's a hack, and as Jacopo proposed, calling
> .g_mbus_config() on the CSI-2 RX would be better, as the CSI-2 RX driver
> can then get the value from its own endpoint, without requiring all
> sensor drivers to implement .g_mbus_config().

The g_mbus_config op could be implemented by the CSI2IPU and mux, by simply
requesting the information from the upstream sub-device. No hacks would be
needed.

-- 
Kind regrads,

Sakari Ailus
