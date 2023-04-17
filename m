Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69216E44B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjDQKDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjDQKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:03:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5493FF;
        Mon, 17 Apr 2023 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681725742; x=1713261742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zvjET+jzN2hNNHCvxTti35dlNkZroCmFXuHR9aPW1gI=;
  b=d9+LbDgnJhUHfWqjZF5yVFetvIHM/Ihq1xGZHA+pnjUnbvonETVA77bj
   E4PItE065HZBiAZ622sbqvG7T2gH+89SoJaGf7PHZM7otcQN/D/Ef/0Y4
   NHnvhKimoeB3kyetqpl93edeXJq78wsqzv8HPcjLKKQdFAHBClRh13xGt
   wuALpAOk45shKkY38w1c6xRWPPtxN0vJ+xonoPEqa9iPz04CTasaDx0Ad
   V1OZkGQ7k5qeEO21GgG70Sb3J0SXHm1NsrX+pPfFgGa6Izd3nOmZd1Z0i
   /p63mOx+Pxf1M67oVRixF84DmAksSxiqhRrL7DZeP3Ib9mu3/94wQXExj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="329019079"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="329019079"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 03:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="759894444"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="759894444"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 03:00:17 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 8BBE012227A;
        Mon, 17 Apr 2023 13:00:14 +0300 (EEST)
Date:   Mon, 17 Apr 2023 13:00:14 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: imx296: Fix error handling while reading
 temperature
Message-ID: <ZD0YrkVOoxPL7TrB@kekkonen.localdomain>
References: <827f94730c85b742f9ae66209b383a50ca79ec43.1681683246.git.christophe.jaillet@wanadoo.fr>
 <20230417053059.GC28551@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417053059.GC28551@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Mon, Apr 17, 2023 at 08:30:59AM +0300, Laurent Pinchart wrote:
> Hi Christophe,
> 
> Thank you for the patch.
> 
> On Mon, Apr 17, 2023 at 12:14:42AM +0200, Christophe JAILLET wrote:
> > If imx296_read() returns an error, its returned value is a negative value.
> > But because of the "& IMX296_TMDOUT_MASK" (i.e. 0x3ff), 'tmdout' can't be
> > negative.
> > 
> > So the error handling does not work as expected and a wrong value is used
> > to compute the temperature.
> > 
> > Apply the IMX296_TMDOUT_MASK mask after checking for errors to fix it.
> > 
> > Fixes: cb33db2b6ccf ("media: i2c: IMX296 camera sensor driver")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Dan Carpenter has submitted the same fix in
> https://lore.kernel.org/linux-media/Y%2FYf19AE78jn5YW7@kili/. Sakari,
> could you please pick it up ?

Oops, thanks for notifying me. This slipped from my hands somehow. It's in
my tree now.

-- 
Sakari Ailus
