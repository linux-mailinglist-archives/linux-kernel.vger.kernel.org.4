Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A1865772C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiL1Ne5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiL1Ney (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:34:54 -0500
X-Greylist: delayed 1543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Dec 2022 05:34:52 PST
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCFCFCCB;
        Wed, 28 Dec 2022 05:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672234480; bh=zj1G9XtSbgP2IMjlZt8bU1AeKLxPZy+7UvqegAcaz94=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=cCR/t/RaTbniXligKvrHSzXjL9kIhvPyMQI7lc2L35IQ5NmAYdPE7t17V1vh/VM4K
         DBRr9i1Uc9gZXfqgxhVPSuMqwXa3fYrXAtJKTsZSDRfGf+sixCg8dByXtowJTeVCgX
         dny2OiWKv/IdPV0WZ5P0G1KFDKrxoFEruTS3fH4g=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 28 Dec 2022 14:34:40 +0100 (CET)
X-EA-Auth: XxjeHADDpEMuIfv03pgE4TNnom85AUt6vgbt4CNewrTUbuAhZVPibKbWspQG/nuu/rN5mc2wVp5AhBOIX5OW9F5QQjSqiaIU
Date:   Wed, 28 Dec 2022 19:04:34 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] drm/tegra: submit: No need for Null pointer check before
 kfree
Message-ID: <Y6xF6q6qj+ggEdgN@qemulion>
References: <Y6sn7XptKyk5cbrA@qemulion>
 <864f2fdd-4289-a178-bbf1-c2a6a579c58c@kapsi.fi>
 <Y6w/4IzoMFsVnCmu@qemulion>
 <280170a7-de12-f362-cda3-11208ead0a88@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280170a7-de12-f362-cda3-11208ead0a88@kapsi.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
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

Hello Mikko,
That really helps. Thank you for the detailed explanation. I do have an extended
question though. In this context, when we are ready to release the memory, how
is it useful to know if it is NULL or not this late in the flow when the scope
is about to end?

Thanks again!
./drv




>
> Mikko


