Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05A05BCCB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiISNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiISNNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:13:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590591E3CF;
        Mon, 19 Sep 2022 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663593223; x=1695129223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kl8u/QncRP4RluJNzmTTBp2YYqFYhohf9QZvMNgIXnM=;
  b=BQ1/mcNigvlEG02MpwM5hh/h3paezewO+F82FEIuK2CUTEu4X+N0Amt4
   NRbfeZgQedy9fZqHSemsv6/pfiY3wcGNPOE6J5ek+Yu1D8voo37FBblHx
   CFw5r30TowZd65p5xKv/HN+NsLo9c69yfZBquNacKIPlcgTPzzNj0wBBM
   r+s6U9CN9TcQX9cmBcxs6Ox7uFUQ90bf9SYwRVAShth4cjPXRwoZjwhvI
   539kBecYfGlWA7vg6hqCIfJHsGadVdxEgLVZHgH9gEZQnyTgqTmf+4hVC
   v+O2jAPEe80Ai/woXG9KG1AN4EjqDSzYD8F7s9dmWgeBlCSpR0PXqN/dw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="282421122"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="282421122"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:13:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="744110405"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:13:41 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id D223B202D2;
        Mon, 19 Sep 2022 16:13:38 +0300 (EEST)
Date:   Mon, 19 Sep 2022 13:13:38 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org, akinobu.mita@gmail.com,
        jacopo+renesas@jmondi.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: mt9m111: fix device power usage
Message-ID: <YyhrAg1GJ+arWdMt@paasikivi.fi.intel.com>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <20220916135713.143890-2-m.felsch@pengutronix.de>
 <YyhkdtFzXn36AytN@paasikivi.fi.intel.com>
 <Yyhm1o44NHWe018B@pendragon.ideasonboard.com>
 <20220919131009.m2vdtsmftqntc2e6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919131009.m2vdtsmftqntc2e6@pengutronix.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 03:10:09PM +0200, Marco Felsch wrote:
> On 22-09-19, Laurent Pinchart wrote:
> > On Mon, Sep 19, 2022 at 12:45:42PM +0000, Sakari Ailus wrote:
> > > Hi Marco,
> > > 
> > > On Fri, Sep 16, 2022 at 03:57:12PM +0200, Marco Felsch wrote:
> > > > @@ -758,10 +751,14 @@ static int mt9m111_g_register(struct v4l2_subdev *sd,
> > > >  	if (reg->reg > 0x2ff)
> > > >  		return -EINVAL;
> > > >  
> > > > +	mt9m111_s_power(sd, 1);
> > > 
> > > It would be nice to have this driver converted to runtime PM. Up to you.
> > 
> > I second that :-)
> 
> I would rather keep it this way and add 2nd patch to change. So it would
> be easier to backport the patch.

Works for me.

-- 
Sakari Ailus
