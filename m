Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B84627986
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiKNJvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiKNJuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:50:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD61EC43;
        Mon, 14 Nov 2022 01:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668419450; x=1699955450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bvCV3Uy48/vF8dFJSL00AfaeR+dqTwb/LElJZziN7Qw=;
  b=jnyKcvY39ySyIFN35t9jpWILHXCuTCA810Yxlp0Cq5+oFNNTrmA7e9sL
   B6bjKCfQlLlDqmy7tMdwgXtoH7Py6CHl0JsYobt4d5N88sdN3PbWJFT3C
   dxUP7zs0CMDQKc6NOucn6uVaTg/b8t4+40DkvyBGWmnorOaZ/wXtvjGlz
   h/sv1Tj/8R9OAj1mMphbwaRuN0jE1nVZjDZmPMQC/Clgkj8FtPq7k5ESg
   FKwfFBlxZCI6ETpvK6HFxSzEfCvj9vQrlfh83AM9HkvYK+jdnEvMow8wT
   xuNt6SrRUFeI7MZPE8iRQbPiBaJV34AksaXKxFIZxWwREexN1pbMsadVH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="291644775"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="291644775"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 01:50:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="813193793"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="813193793"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 01:50:47 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id BAB4F201D2;
        Mon, 14 Nov 2022 11:50:44 +0200 (EET)
Date:   Mon, 14 Nov 2022 09:50:44 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] staging: media: tegra-video: Replace custom
 implementation of device_match_fwnode()
Message-ID: <Y3IPdAg8wnjzbQPU@paasikivi.fi.intel.com>
References: <20220927173011.72571-1-andriy.shevchenko@linux.intel.com>
 <Y3IO4zVqex78+rTn@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3IO4zVqex78+rTn@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Nov 14, 2022 at 11:48:19AM +0200, Andy Shevchenko wrote:
> On Tue, Sep 27, 2022 at 08:30:11PM +0300, Andy Shevchenko wrote:
> > Replace custom implementation of the device_match_fwnode().
> 
> Sakari, here you are in Cc list and I never have any response on this patch.
> 
> Maybe something wrong with emails somewhere?

You should have received a notification from Patchwork the patch is "under
review".

It's in my PR to Mauro now:

<URL:https://patchwork.linuxtv.org/project/linux-media/patch/Y3IJwomIow2+vdMh@valkosipuli.retiisi.eu/>

-- 
Kind regards,

Sakari Ailus
