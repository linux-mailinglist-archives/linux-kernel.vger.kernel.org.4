Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3E266DC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjAQLcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbjAQLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:32:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CF335266;
        Tue, 17 Jan 2023 03:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673955128; x=1705491128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vsIVOIrS7q6A7BCafUqQD6RvbA9hdg3f41c0wIqZ+Rw=;
  b=BSQaBQ+zzD1QnXswzanB1GHn6k+/fWLqikmm4gTM2IH+ksQA3RjIrmDM
   5qVUAIjKjHuttcKie6Cv1+cvPYwUG6fpGiUVvYncjxguwBArleZhExcok
   3vsBrTwfAHkZw+41BoIoBv0k8UsoP+mFJt5Z+Wtx1+SSkT2GnMw2xqCht
   nu3+5kaYeZ5Z2+rYHJpUd/a+TmagAOekq+ApmMeHtD3BWnA3qyedeRbhg
   dF/wBHexqfWs7kB754pSoUmja2mWh8Aho+N2DGoIYd7TuLf9yYrsH4j1v
   o4vsP6jVQzHaY4HRmVrOQPA1C/z0rRowrgAvdF4GvtNuLHsMn8GTjvHJJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="325947529"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="325947529"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:32:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="727755216"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="727755216"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:32:06 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C98A720165;
        Tue, 17 Jan 2023 13:32:03 +0200 (EET)
Date:   Tue, 17 Jan 2023 11:32:03 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, mchehab@kernel.org,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] media: mt9m111: fix device power usage
Message-ID: <Y8aHM2B4Ix88Yx96@paasikivi.fi.intel.com>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-3-m.felsch@pengutronix.de>
 <YwMix1+Bm1jEbWqv@paasikivi.fi.intel.com>
 <20220822075426.qjgxue7sjehazga4@pengutronix.de>
 <YwNJ8RpSR+oVxnS/@paasikivi.fi.intel.com>
 <20220823144450.ctjmby53prjw5qis@pengutronix.de>
 <Y8XMP7+HrABQCaMR@valkosipuli.retiisi.eu>
 <20230117112959.omsjmx4gmhnoaxj3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117112959.omsjmx4gmhnoaxj3@pengutronix.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 12:29:59PM +0100, Marco Felsch wrote:
> Hi Sakari,
> 
> On 23-01-17, Sakari Ailus wrote:
> > Hi Marco,
> > 
> > On Tue, Aug 23, 2022 at 04:44:50PM +0200, Marco Felsch wrote:
> > > Hi Sakari,
> > > 
> > > On 22-08-22, Sakari Ailus wrote:
> > > > On Mon, Aug 22, 2022 at 09:54:26AM +0200, Marco Felsch wrote:
> > > > > Hi Sakari,
> > > > > 
> > > > > On 22-08-22, Sakari Ailus wrote:
> > > > > > Hi Marco,
> > > > > > 
> > > > > > On Thu, Aug 18, 2022 at 04:47:11PM +0200, Marco Felsch wrote:
> > > > > > > Currently the driver turn off the power after probe and toggle it during
> > > > > > > .stream by using the .s_power callback. This is problematic since other
> > > > > > > callbacks like .set_fmt accessing the hardware as well which will fail.
> > > > > > > So in the end the default format is the only supported format.
> > > > > > 
> > > > > > It'd be much better to add runtime PM support to the driver instead.
> > > > > 
> > > > > I got your point, but didn't have the time for it right now, I will drop
> > > > > the patch from my v2.
> > > > 
> > > > The API is different but generally involves doing more or less the same
> > > > what this and the 4th patch do together.
> > > 
> > > I know :) as soon as I got feedback on my TC35 series [1] I give it a
> > > try and change it to dev-pm.
> > 
> > What's the status of this set?
> > 
> > These are nice improvements but I was expecting v2.
> 
> Unfortunately this was just a testing vehicle I had for the TC35 bridge
> chip. As soon as I have access to it again I will send a new version.

Ack, thanks!

-- 
Sakari Ailus
