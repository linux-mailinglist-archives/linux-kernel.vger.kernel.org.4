Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120D6EAA22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjDUMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjDUMRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:17:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7770F1984;
        Fri, 21 Apr 2023 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682079442; x=1713615442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M3qKVGr6/aHBUEi+j2c5BIefZwYt/P1syotMIPOX0eA=;
  b=hcSM1cAPl6bg886xohj0jw6EHnRfsVG9drkmiyDDpCl2vZnuIImYGKLK
   QucMyayziEdxqX/K9Fl+9ctTf45gqva5YuUk8PlZjWw5B89a4KkAFKiSW
   C6YWmyETU+VeJwngHndURCcDhLNgoK6Am5yGmCbEMxHLS6/r5cn2QQp5T
   sJySA8wc5sUKmUMpm1gzwqt7R6ltpU5RJCs/DaKPTEnXP/iDCvkxoaFy8
   Q9apsU5soae0jA1i+1e+eVtdlPr7SQQs3WGfFJLEDKOxeCmdH/PpE41Re
   D13aO+K7IL1505ylkJ4COmO11XU5u7io+BNDPDCBdRRlK79m31GKL1t0N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="432256389"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="432256389"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 05:17:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="642496515"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="642496515"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 05:17:20 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 8CEEE11FAD0;
        Fri, 21 Apr 2023 15:17:17 +0300 (EEST)
Date:   Fri, 21 Apr 2023 15:17:17 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vaishnav Achath <vaishnav.a@ti.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, u-kumar1@ti.com
Subject: Re: [PATCH] media: v4l2-mc: Drop subdev check in
 v4l2_create_fwnode_links_to_pad()
Message-ID: <ZEJ+zURHpGUo+Wvm@kekkonen.localdomain>
References: <20230421100430.28962-1-vaishnav.a@ti.com>
 <20230421121048.GK21943@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421121048.GK21943@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:10:48PM +0300, Laurent Pinchart wrote:
> Hi Vaishnav,
> 
> Thank you for the patch.
> 
> On Fri, Apr 21, 2023 at 03:34:30PM +0530, Vaishnav Achath wrote:
> > While updating v4l2_create_fwnode_links_to_pad() to accept non-subdev
> > sinks, the check is_media_entity_v4l2_subdev() was not removed which
> > prevented the function from being used with non-subdev sinks, Drop the
> > unnecessary check.
> > 
> > Fixes: bd5a03bc5be8 ("media: Accept non-subdev sinks in v4l2_create_fwnode_links_to_pad()")
> > 
> > Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Sakari, the commit this patch fixes will land in v6.4, should this be
> merged as a v6.4 fix ?

I'd think so. I'll take this soonish.

-- 
Sakari Ailus
