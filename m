Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185FB659699
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiL3JPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiL3JPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:15:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29001A201;
        Fri, 30 Dec 2022 01:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672391705; x=1703927705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b92LBjMTMS+znGkFff7B1W97g2wA+n9hRk1ugdqBn5s=;
  b=MkAmmB916hyyS3Y9RROqFhZeoS6iKydI/IOqjJs2+aE74xmxVgWZyQZd
   M9sxD/gnCvnCoUgVgSYNtIkJDc0FkcnUyCnYvDkoR9WSa5ZNEf4sS5QKB
   FNDrsJZGHVDiZXHxVOG5hCp8XU3ALx7fyCLBXXj0EWHxHLGiRW65yvjvs
   LM49UjH/g5O1fsgEjFN4Rvt/E3+0g9CElqADw23yfQCv/f4FgziFcX9kP
   wvjx93s0qWG9ZnIY7e1eKhNXnTLk58le7o2jTqqxfDTGBEqvuDutYGvuy
   M9ROqDMVxJeAlH3FPwxcOIndFhXhRHMHMtUT+lB3zhpaGw8F9RExNMo47
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="308943792"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="308943792"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 01:15:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="631489114"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="631489114"
Received: from joe-255.igk.intel.com (HELO localhost) ([172.22.229.67])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 01:15:03 -0800
Date:   Fri, 30 Dec 2022 10:15:01 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Deepak R Varma <drv@mailo.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: submit: No need for Null pointer check before
 kfree
Message-ID: <20221230091501.GA1285371@linux.intel.com>
References: <Y6sn7XptKyk5cbrA@qemulion>
 <864f2fdd-4289-a178-bbf1-c2a6a579c58c@kapsi.fi>
 <Y6w/4IzoMFsVnCmu@qemulion>
 <280170a7-de12-f362-cda3-11208ead0a88@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280170a7-de12-f362-cda3-11208ead0a88@kapsi.fi>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:17:59PM +0200, Mikko Perttunen wrote:
> On 12/28/22 15:08, Deepak R Varma wrote:
> > On Wed, Dec 28, 2022 at 02:28:54PM +0200, Mikko Perttunen wrote:
> > > On 12/27/22 19:14, Deepak R Varma wrote:
> > > > kfree() & vfree() internally perform NULL check on the pointer handed
> > > > to it and take no action if it indeed is NULL. Hence there is no need
> > > > for a pre-check of the memory pointer before handing it to
> > > > kfree()/vfree().
> > > > 
> > > > Issue reported by ifnullfree.cocci Coccinelle semantic patch script.
> > > > 
> > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > ---
> > > >    drivers/gpu/drm/tegra/submit.c | 4 ++--
> > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
> > > > index 066f88564169..06f836db99d0 100644
> > > > --- a/drivers/gpu/drm/tegra/submit.c
> > > > +++ b/drivers/gpu/drm/tegra/submit.c
> > > > @@ -680,8 +680,8 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
> > > >    		kfree(job_data->used_mappings);
> > > >    	}
> > > > 
> > > > -	if (job_data)
> > > > -		kfree(job_data);
> > > > +	kfree(job_data);
> > > > +
> > > >    put_bo:
> > > >    	gather_bo_put(&bo->base);
> > > >    unlock:
> > > > --
> > > > 2.34.1
> > > > 
> > > > 
> > > > 
> > > 
> > > It continues to be the case that I think this transform is bad. Same applies
> > > to the host1x patch.
> > 
> > Hello Mikko,
> > Thank you for responding to the patch proposal. Could you please explain why is
> > this bad?
> > 
> > Regards,
> > ./drv
> > 
> > > 
> > > Mikko
> > 
> > 
> 
> Hi,
> 
> it gets rid of visual hints on code paths indicating the possible liveness
> of pointer variables. I.e., after the change, whether the pointer can be
> NULL or not is more difficult to reason about locally, instead requiring
> more global reasoning which is mentally more taxing.
> 
> Since C's type system doesn't help with tracking these kinds of things, I
> believe it is important to have these kinds of local contextual cues to help
> the programmer.

I agree with your point of view. But regarding this particular patch,
at least on code base I can see, after free_job_data label job_done
can not be NULL. So patch seems to be ok, but maybe changelog need to
be different

Regards
Stanislaw
