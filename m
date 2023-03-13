Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED5C6B7718
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCMMBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCMMBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:01:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA621BF3;
        Mon, 13 Mar 2023 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678708901; x=1710244901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5tpThYG3MB7AnoeGfsr379RC5BDviVBlifTFX+VBMiw=;
  b=TLxT2kcg7QA10BmcHEKfD+rNpvUEugt0AvwXUBpVu6BZx08seeAPEQqT
   NsywMFDCRLuOgEz8VjANVhjubP/o+65S3Nwm91+46dV812TbzMdY6jSb9
   KrnHbsdlmlbZtvKg3UDz+21TOJEzfpzwyKP/0uhX/mENp4dSSaQLKcV0J
   G40HA3y2Zm4lyYfiyh6k6qp21oj1WZ6HJtiuyOZHBN7JKOl+u0S43Y8pQ
   fYwCsI9WFAU8pHB3lQysLs0ZA6G0A+qR8D8nKupPJ2kzKzi6uF17MyWFg
   0bgqoLgLiOv9khKiWsr3N7fbqi/t3DeRsJTikeVqt4VjjlA26u+bF691D
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="399720017"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="399720017"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 05:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="747584782"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="747584782"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2023 05:01:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbgrk-002bve-0F;
        Mon, 13 Mar 2023 14:01:24 +0200
Date:   Mon, 13 Mar 2023 14:01:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/1] media: i2c: imx290: Make use of
 get_unaligned_le24(), put_unaligned_le24()
Message-ID: <ZA8Qk8CmBNvsDUMv@smile.fi.intel.com>
References: <20230209221205.46573-1-andriy.shevchenko@linux.intel.com>
 <Y+V1Hds/yCjABDnL@pendragon.ideasonboard.com>
 <Y+Z5mAhQk6zEFHOz@smile.fi.intel.com>
 <ZAtnKLKEZXCw/Ezy@smile.fi.intel.com>
 <ZA8J5/vElpjrRD4N@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA8J5/vElpjrRD4N@valkosipuli.retiisi.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 01:32:55PM +0200, Sakari Ailus wrote:
> On Fri, Mar 10, 2023 at 07:21:44PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 10, 2023 at 07:06:32PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 10, 2023 at 12:35:09AM +0200, Laurent Pinchart wrote:
> > > > On Fri, Feb 10, 2023 at 12:12:05AM +0200, Andy Shevchenko wrote:
> > > > > Since we have a proper endianness converters for LE 24-bit data use them.
> > > > > 
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > Thank you for the reviews!
> > > 
> > > > I assume Sakari will pick both patches.
> > > 
> > > I also assume the same.
> > 
> > Sakari, do you have any comments?
> 
> Yes. These are in my tree now.

Which is...?

I don't see anything on https://git.linuxtv.org/sailus/media_tree.git/.

-- 
With Best Regards,
Andy Shevchenko


