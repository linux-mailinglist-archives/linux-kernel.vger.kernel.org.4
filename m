Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6530365B688
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjABSVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjABSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:21:08 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8044192;
        Mon,  2 Jan 2023 10:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672683643; bh=l5eFdlgx+VAP0BeHLUtw9bf3seXl0g8MDnD92C6hEZg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=EkJJlYSDym9aBoHWX0MTXz78y/KcdI/3h045DudkCBTy6QMvvqUeAiYCkfWEtuD4L
         12y7r2L2U5FGHCGDGt4Es4XnbMvPTCH015b3/BCHNT7+ucyfRNZJr4e3/D97jAL8/8
         vY/Bw3bGB5Uk0eqi5OOzHT765Ep4Ng5ZHJQ3Zm14=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon,  2 Jan 2023 19:20:42 +0100 (CET)
X-EA-Auth: 1TipYpPawqPMVWURTIUa3Q9huT/sskdTH3CKY3E5NqMDlZcXzmSa7O60tFZSxlW4XUJP6QN1+lF3/JSXJcYtR/S2WkmYVfuP
Date:   Mon, 2 Jan 2023 23:50:36 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, drv@mailo.com
Subject: Re: [PATCH] drm/tegra: submit: No need for Null pointer check before
 kfree
Message-ID: <Y7MgdKD14kLwOo0S@qemulion>
References: <Y6sn7XptKyk5cbrA@qemulion>
 <864f2fdd-4289-a178-bbf1-c2a6a579c58c@kapsi.fi>
 <Y6w/4IzoMFsVnCmu@qemulion>
 <280170a7-de12-f362-cda3-11208ead0a88@kapsi.fi>
 <20221230091501.GA1285371@linux.intel.com>
 <65468c84-fc40-e4e1-0adb-ddfc23ec4fb9@kapsi.fi>
 <a815b74d-c158-73b6-cfc8-583826277b5c@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a815b74d-c158-73b6-cfc8-583826277b5c@kapsi.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 12:03:25PM +0200, Mikko Perttunen wrote:
> On 12/30/22 12:01, Mikko Perttunen wrote:
> > On 12/30/22 11:15, Stanislaw Gruszka wrote:
> > > On Wed, Dec 28, 2022 at 03:17:59PM +0200, Mikko Perttunen wrote:
> > > > On 12/28/22 15:08, Deepak R Varma wrote:
> > > > > On Wed, Dec 28, 2022 at 02:28:54PM +0200, Mikko Perttunen wrote:
> > > > > > On 12/27/22 19:14, Deepak R Varma wrote:
> > > > > > > kfree() & vfree() internally perform NULL check on the pointer handed
> > > > > > > to it and take no action if it indeed is NULL. Hence there is no need
> > > > > > > for a pre-check of the memory pointer before handing it to
> > > > > > > kfree()/vfree().
> > > > > > >
> > > > > > > Issue reported by ifnullfree.cocci Coccinelle semantic patch script.
> > > > > > >
> > > > > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > > > > ---
> > > > > > >     drivers/gpu/drm/tegra/submit.c | 4 ++--
> > > > > > >     1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/tegra/submit.c
> > > > > > > b/drivers/gpu/drm/tegra/submit.c
> > > > > > > index 066f88564169..06f836db99d0 100644
> > > > > > > --- a/drivers/gpu/drm/tegra/submit.c
> > > > > > > +++ b/drivers/gpu/drm/tegra/submit.c
> > > > > > > @@ -680,8 +680,8 @@ int
> > > > > > > tegra_drm_ioctl_channel_submit(struct drm_device
> > > > > > > *drm, void *data,
> > > > > > >             kfree(job_data->used_mappings);
> > > > > > >         }
> > > > > > >
> > > > > > > -    if (job_data)
> > > > > > > -        kfree(job_data);
> > > > > > > +    kfree(job_data);
> > > > > > > +
> > > > > > >     put_bo:
> > > > > > >         gather_bo_put(&bo->base);
> > > > > > >     unlock:
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > It continues to be the case that I think this transform
> > > > > > is bad. Same applies
> > > > > > to the host1x patch.
> > > > >
> > > > > Hello Mikko,
> > > > > Thank you for responding to the patch proposal. Could you
> > > > > please explain why is
> > > > > this bad?
> > > > >
> > > > > Regards,
> > > > > ./drv
> > > > >
> > > > > >
> > > > > > Mikko
> > > > >
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > it gets rid of visual hints on code paths indicating the
> > > > possible liveness
> > > > of pointer variables. I.e., after the change, whether the pointer can be
> > > > NULL or not is more difficult to reason about locally, instead requiring
> > > > more global reasoning which is mentally more taxing.
> > > >
> > > > Since C's type system doesn't help with tracking these kinds of
> > > > things, I
> > > > believe it is important to have these kinds of local contextual
> > > > cues to help
> > > > the programmer.
> > >
> > > I agree with your point of view. But regarding this particular patch,
> > > at least on code base I can see, after free_job_data label job_done
> > > can not be NULL. So patch seems to be ok, but maybe changelog need to
> > > be different
> > >
> > > Regards
> > > Stanislaw
> >
> > It can be NULL; see:
> >
> >          job->user_data = job_data;
> >          job->release = release_job;
> >          job->timeout = 10000;
> >
> >          /*
> >           * job_data is now part of job reference counting, so don't
> > release
> >           * it from here.
> >           */
> >          job_data = NULL;
> >
> > If we go into free_job_data after this code (which happens if there is
> > no error, or if host1x_job_submit fails), job_data will be NULL.
> >
> > The memory is instead released in the 'put_job' label; host1x_job_put
> > ends up calling release_job, which does the kfree.
>
> Well, the refcount is dropped -- it's not necessarily freed immediately, if
> the job is in execution.

Thanks Mikko. I Agree. Hence I think there is no change for the program at
runtime. The proposed change looks safe to me.

./drv

>
> Mikko
>
> >
> > (Yes, it is rather complicated..)
> >
> > Thanks,
> > Mikko
>


