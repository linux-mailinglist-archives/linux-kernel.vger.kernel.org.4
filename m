Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A790B699592
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjBPNTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBPNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:19:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6955A9;
        Thu, 16 Feb 2023 05:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553578; x=1708089578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nY6IaXfu1GqwT1+FKpC+5+4H6mFpxeozu0yM80UQf08=;
  b=JEBx0vxzoo08/BtRP4fQZyQlvOfzvmo9ofYwMNJPvW8+hKL1pOhMHEPE
   Ww8++/HhFCn7A/r54pjutjFGFFVMY2/GPdmGg9OEetv7OX6m5FdxWdqH3
   6oHyHo56BMpLS/hZKx5MAwSCDSMp5aUtcnW5IO5cd6l9XbapI/WWpW60O
   ccYJjJO8K4KzUy8GvqhR2avprs4A8kdVJbcche6W7dzcuio8yzJSrH11d
   +IkSNE2MdH2ITe5g6DLUFjK7OEkHr0S2uRMeKuAcIlzBJhu924SBGpr0o
   H4Zg0j1Wgh60R3s+AZfhLv4pWQXyrNuYZegvZSfTMhqMLguTV9uv2FDco
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333883843"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333883843"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:19:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647676483"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="647676483"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:19:36 -0800
Date:   Thu, 16 Feb 2023 14:19:34 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Jesper Juhl <jesperjuhl76@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] Don't test for NULL firmware before releasing
Message-ID: <20230216131934.GF2849548@linux.intel.com>
References: <1af763de-dbb8-a6f8-1a8a-2d76610d8776@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af763de-dbb8-a6f8-1a8a-2d76610d8776@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, Feb 16, 2023 at 02:37:15AM +0100, Jesper Juhl wrote:
> From 4fe34831e2e7677b1c9616356f0a2e0a36ec092f Mon Sep 17 00:00:00 2001
> From: Jesper Juhl <jesperjuhl76@gmail.com>
> Date: Thu, 16 Feb 2023 02:33:05 +0100
> Subject: [PATCH] Don't test for NULL firmware before releasing
> 
> release_firmware() tests for a NULL pointer itself, no need to do it up-front.
> 
> Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
> 
> ---
>  drivers/gpu/drm/tegra/falcon.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/falcon.c b/drivers/gpu/drm/tegra/falcon.c
> index c0d85463eb1a..ae599441f031 100644
> --- a/drivers/gpu/drm/tegra/falcon.c
> +++ b/drivers/gpu/drm/tegra/falcon.c
> @@ -153,8 +153,7 @@ int falcon_init(struct falcon *falcon)
> 
>  void falcon_exit(struct falcon *falcon)
>  {
> -	if (falcon->firmware.firmware)
> -		release_firmware(falcon->firmware.firmware);
> +       	release_firmware(falcon->firmware.firmware);

Please check patches with checkpatch.pl before posting.

Regards
Stanislaw

