Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA2727B75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjFHJcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjFHJbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:31:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F692D66
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686216692; x=1717752692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JMt8rb6ddYRdXl6MLi1i9h8w7FO4bvZFiK6fEY2DLE4=;
  b=AlRZ0Ehvt1dk8rJ2Cz5tad1zazl2WSMYoSGAodTW00fgpBW1PiOW9Bnt
   tp+rjkYCI3HbnrubBCpQShYS2aEIwNBIS5Suo8I3i5U8MHtDY+pUh7EZC
   QFYNfC9G8x6fZgAjofK7p2cGATrEF3tT8EwU4kbn8mJgvj5eq7sMdw/p3
   24UTx0zSqAo5ff/5lOR5JAT0QrIYBNgCMQmlZ+NK4PPrP3RPQ6jv0uGPZ
   BS5IQoqYf4/vOLtPX0yr98zMWBamNnnoxDVWwcKWfQMzy0/tPlmcjYG31
   N5L0ltxobnbAXKEer6yPtQz0oLDHWey0oKROBRmS+gGormRft/DmKAXBY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337617607"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="337617607"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 02:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="739638211"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="739638211"
Received: from operepel-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.58.149])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 02:31:30 -0700
Date:   Thu, 8 Jun 2023 11:31:22 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO
Message-ID: <ZIGf6mKwX9RIm5a5@ashyti-mobl2.lan>
References: <20230608024207.581401-1-suijingfeng@loongson.cn>
 <ZIGAEZTJvq1GqFVD@aptenodytes>
 <aff664c7-b692-4fcf-ad61-8030cc648501@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aff664c7-b692-4fcf-ad61-8030cc648501@loongson.cn>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingfeng,

On Thu, Jun 08, 2023 at 03:24:54PM +0800, Sui Jingfeng wrote:
> Hi,
> 
> thanks a lot
> 
> On 2023/6/8 15:15, Paul Kocialkowski wrote:
> > Hi,
> > 
> > On Thu 08 Jun 23, 10:42, Sui Jingfeng wrote:
> > > drm/logicvc driver is depend on REGMAP and REGMAP_MMIO, should select this
> > > two kconfig option, otherwise the driver failed to compile on platform
> > > without REGMAP_MMIO selected:
> > > 
> > > ERROR: modpost: "__devm_regmap_init_mmio_clk" [drivers/gpu/drm/logicvc/logicvc-drm.ko] undefined!
> > > make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> > > make: *** [Makefile:1978: modpost] Error 2
> > > 
> > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > Thanks for the fix, looks good to me!
> > 
> > Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> After received this Acked-by, do a need append this tag to the patch, and
> resend this again?
> 
> I don't know about this.
> 
> I don't need to do anythings ales, you will push it to your repository,
> right?

no need... someone will pick it up and add the needed tags.

Andi
