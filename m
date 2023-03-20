Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89F76C0D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCTJiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCTJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:37:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEA823D8C;
        Mon, 20 Mar 2023 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679305061; x=1710841061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tgSBiNMlvox8p9HFIVHyf8lm+Mh/0Js79g7+/dJk32s=;
  b=ISdDfwmNhP/JzbCvk5ah5iycy57uSdrH86AXlia4PYtzkfuyNz8aGErC
   bPdk9BmqN++0bs7f4s4OlXVaafQBeIipbbzCxUdd95LR8QOK6La95F9zO
   pOqGiPc4+XB3ll1yVEUyAlF2xu8sWzcPml3noOt4LdCNyn0i9Lv5T15GU
   LHf03qIM4JdCQBTKSePXJZb5l7MamdsK36oFffJHOit88L0meWCe4+sy9
   rIlGAAE00/J43tdcItCMJPEVPuom0xIMBxcxiFMqJJZhhMaVrwTOx65m1
   3/97XWXD7GmJj0PxT7dPXLdl5QymE07jy2Px5vodliBTJr9JwtNajQwOu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="366333512"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="366333512"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 02:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="631064558"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="631064558"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 02:37:36 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 6B5C5122400;
        Mon, 20 Mar 2023 11:37:33 +0200 (EET)
Date:   Mon, 20 Mar 2023 11:37:33 +0200
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
Message-ID: <ZBgpXRtXcxg14OGv@kekkonen.localdomain>
References: <20230306063649.7387-1-marcel@ziswiler.com>
 <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
 <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
 <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
 <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
 <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
 <ZBggtBU1TjlvVNCS@kekkonen.localdomain>
 <20230320092602.GE20234@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320092602.GE20234@pendragon.ideasonboard.com>
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

On Mon, Mar 20, 2023 at 11:26:02AM +0200, Laurent Pinchart wrote:
> In a (simplified) nutshell,
> 
> ---------+     +----------+     +---------+     +-----+     +-----+
> | Camera | --> | CSI-2 RX | --> | CSI2IPU | --> | Mux | --> | IPU |
> | Sensor |     |          |     | Gasket  |     |     |     |     |
> ---------+     +----------+     +---------+     +-----+     +-----+

Thank you, this is helpful.

I suppose the mux here at least won't actively do anything to the data. So
presumably its endpoint won't contain the active configuration, but its
superset.

> 
> All those blocks, except for the gasket, have a node in DT.
> 
> The IPU driver needs to know the number of CSI-2 data lanes, which is
> encoded in the data-lanes DT property present in both the sensor output
> endpoint and the CSI-2 RX input endpoint, but not the other endpoints in
> the pipeline.

This doesn't yet explain why the sensor would need to implement
get_mbus_config if its bus configuration remains constant.

I suppose those blocks in between would probably need something to convey
their active configuration from upstream sub-devices.

-- 
Kind regards,

Sakari Ailus
