Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AFE6B78B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCMNUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCMNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:20:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6130E88;
        Mon, 13 Mar 2023 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678713648; x=1710249648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gu9CMdY5O+gypuZ5ak5S3TZBJoRYuiw5EfoYKV7FCV4=;
  b=ONp4wxYOJEw5V4alA8P4/mSJz84u/boFU3YCfHP0hxROMOHs21xE7fIP
   GXgvElAD0XaKJEb5OiGn4wP7qB0g7iuMRJhG0j9uDk8oNjUMLM7C/Jz1N
   lIg7wFhyDoUBrJ+E2qG6/JKv8LOwlV1gkTjBGgPGgOetQ2KAG0dYniyRr
   01KO58a6BNrUw7ncmVn9aYm4y0LLxsT4rM+9CaZvWXRQOndn87yr+Vf0m
   Lg8ffscp36giTi7l8rrC0RK1uBJDycpHp+2BPmWjW/OM9m+1BNGH8U0QG
   fD0IwdQzTbABynI1Df/h+QnzQLO29IF6zBHzYt4ldVyl8CqvBnp+iOqNM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="423408073"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="423408073"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 06:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="628630094"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="628630094"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 06:20:45 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 4EB42120C21;
        Mon, 13 Mar 2023 15:20:42 +0200 (EET)
Date:   Mon, 13 Mar 2023 15:20:42 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/1] media: i2c: imx290: Make use of
 get_unaligned_le24(), put_unaligned_le24()
Message-ID: <ZA8jKpSR+p8e6Uel@kekkonen.localdomain>
References: <20230209221205.46573-1-andriy.shevchenko@linux.intel.com>
 <Y+V1Hds/yCjABDnL@pendragon.ideasonboard.com>
 <Y+Z5mAhQk6zEFHOz@smile.fi.intel.com>
 <ZAtnKLKEZXCw/Ezy@smile.fi.intel.com>
 <ZA8J5/vElpjrRD4N@valkosipuli.retiisi.eu>
 <ZA8Qk8CmBNvsDUMv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA8Qk8CmBNvsDUMv@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:01:23PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 13, 2023 at 01:32:55PM +0200, Sakari Ailus wrote:
> > On Fri, Mar 10, 2023 at 07:21:44PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 10, 2023 at 07:06:32PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Feb 10, 2023 at 12:35:09AM +0200, Laurent Pinchart wrote:
> > > > > On Fri, Feb 10, 2023 at 12:12:05AM +0200, Andy Shevchenko wrote:
> > > > > > Since we have a proper endianness converters for LE 24-bit data use them.
> > > > > > 
> > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > 
> > > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > 
> > > > Thank you for the reviews!
> > > > 
> > > > > I assume Sakari will pick both patches.
> > > > 
> > > > I also assume the same.
> > > 
> > > Sakari, do you have any comments?
> > 
> > Yes. These are in my tree now.
> 
> Which is...?
> 
> I don't see anything on https://git.linuxtv.org/sailus/media_tree.git/.

This is a bit opportunistic since we don't have rc1 in the media tree yet.

I'll push it once we do.

-- 
Sakari Ailus
