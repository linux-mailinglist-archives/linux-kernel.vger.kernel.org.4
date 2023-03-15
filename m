Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A406BB937
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjCOQMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjCOQL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:11:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB75E97FE0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678896670; x=1710432670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jFuhWlXO/qjo6QWUILbvKSvhqgBdyjVOn4Kb+6B5HvQ=;
  b=m+gCxtwsu6/bIryVYMQgedkQ4rgpwXm76IJZ0RdKE46WmVDipW53J+7n
   jypobV7AVHMHExXbVy0N82X3kDtxMgUnam7tZ9nMYCRrTffQ7m4bg8Hub
   oG7whAR9mD1q7N5iY2HszSHuQQxbLQGjKgyvk5CY3sfTIC7yJgc4NFhyd
   dyc7DimcIKpcrknLva69/zn2/+34KisoCHpd1/xmY8rPxv2Yh1bIpI4nM
   U9ChxTKs2nH1UMILif/6iw9xCAYA9mPH+yeq65E7xgDeU9GXiG6/2pN34
   ++KaFmlhh0MpENKQC5RemImdeVzBgmnbtcddiQBYOytTMm85Z64dDcBpq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="337769868"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="337769868"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 09:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="711982160"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="711982160"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.59.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 09:09:17 -0700
Date:   Wed, 15 Mar 2023 09:09:16 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBHtrGjgKOiVwjSF@aschofie-mobl2>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <ZBEJ+8DbhADSBTLr@aschofie-mobl2>
 <ZBG699SriXWy1I2K@khadija-virtual-machine>
 <16148020.1MiD057Pog@suse>
 <ZBHUr7bANuhnOnIV@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBHUr7bANuhnOnIV@khadija-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 07:22:39PM +0500, Khadija Kamran wrote:
> On Wed, Mar 15, 2023 at 02:34:31PM +0100, Fabio M. De Francesco wrote:
> > Aside from what I said and asked for with the other message of this same 
> > thread, please take note that you can build a specific module if you prefer 
> > not to re-build the whole kernel and other modules at the same time. 
> > 
> > I'm pretty sure that the instructions to do so are in the OutreachyFirstPatch 
> > tutorial.
> > 
> > If they are not there, please let us know.
> > 
> > Fabio
> 
> Hey Fabio!
> 
> In the Outreachy FirstPatchTutorial under the 'Compiling only part of
> the kernel' section there are ways to compile only some part of the
> kernel.
> 
> I have tried using "make W=1 drivers/staging/axis-fifo/" and it says
> 'nothing to be done for'. 
> 
> Should I start with the steps to reproduce? :'(

Khadija,

I've applied your patch and it fails to compile with the warnings
that LKP reports.

If you are doing: $ make drivers/staging/axis-fifo/

and it is saying 'nothing to be done...'

You either have not changed anything since the last compile, or you
do not have the module configured.

I suspect it has never compiled for you and you need to look at
the direction in the tutorial for 'Recompiling the driver' section
and learn how to use make menuconfig.

This driver has a couple of dependencies described in the Kconfig
file. You will not even see the 'XIL_AXIS_FIFO' option until you
turn on 'OF' and HAS_'IOMEM'.

See the drivers/staging/axis-fifo/Kconfig

Please confirm that you have compiled the driver before chasing
after the build env that lkp reports.

Thanks,
Alison


> 
> Thank you!
> 
> Regards,
> Khadija
> 
> 
> > 
> > 
> > 
