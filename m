Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2642865779E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiL1OS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiL1OSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:18:53 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03BB1114F;
        Wed, 28 Dec 2022 06:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672237121; bh=yANQEkK1IO/bYghgRYS3kQ3PM89nXCz+xH6GDv5bpnk=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=TVX79ohedRv394INpOimrtaFaCSzjWLUYEKH+JoyWWXAxJ3kSiaAjuW1NqHVqWSca
         +WUZJ+4ULokcaiM3ksJLcIca/34mpZXftrCulvQi4/iWahyyZ3kLEosMykZvF/evxs
         VqRxd60VWOX5w/JIbc8zuPZRClyUfiSFevzsEwk4=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 28 Dec 2022 15:18:41 +0100 (CET)
X-EA-Auth: WOFZZK0BvzIyYCS/gLWIjuUMTenxQtvi5fn8DqO7riw4RfvcJhr+nYdWb5QT5rtXzf4tEZ+gdO6yrD4WH0zEhJBsxytgHyse
Date:   Wed, 28 Dec 2022 19:48:35 +0530
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
Message-ID: <Y6xQO+w/P+m8w6ke@qemulion>
References: <Y6sn7XptKyk5cbrA@qemulion>
 <864f2fdd-4289-a178-bbf1-c2a6a579c58c@kapsi.fi>
 <Y6w/4IzoMFsVnCmu@qemulion>
 <280170a7-de12-f362-cda3-11208ead0a88@kapsi.fi>
 <Y6xF6q6qj+ggEdgN@qemulion>
 <1453f93b-f6ad-04d8-c493-6c8d2a3678bd@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453f93b-f6ad-04d8-c493-6c8d2a3678bd@kapsi.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:48:05PM +0200, Mikko Perttunen wrote:
> On 12/28/22 15:34, Deepak R Varma wrote:
> > On Wed, Dec 28, 2022 at 03:17:59PM +0200, Mikko Perttunen wrote:
> > > On 12/28/22 15:08, Deepak R Varma wrote:
> > >
> > > Hi,
> > >
> > > it gets rid of visual hints on code paths indicating the possible liveness
> > > of pointer variables. I.e., after the change, whether the pointer can be
> > > NULL or not is more difficult to reason about locally, instead requiring
> > > more global reasoning which is mentally more taxing.
> > >
> > > Since C's type system doesn't help with tracking these kinds of things, I
> > > believe it is important to have these kinds of local contextual cues to help
> > > the programmer.
> >
> > Hello Mikko,
> > That really helps. Thank you for the detailed explanation. I do have an extended
> > question though. In this context, when we are ready to release the memory, how
> > is it useful to know if it is NULL or not this late in the flow when the scope
> > is about to end?
>
> In the current code it doesn't matter, but if someone went to change this
> code (for example to add another release step), and we just had
> 'kfree(job_data)', they would have to remember that kfree works with NULL
> pointers, and would have to go looking elsewhere in the code to see if it is
> in fact possible to assume that job_data cannot be NULL here, or not. If
> they forget about kfree working with NULL pointers, which wouldn't be that
> surprising since it is almost always only called with non-NULL pointers,
> they might instead introduce a bug.
>
> In this particular instance it's probably not that bad since immediately
> above we have another 'if' block that checks if job_data is NULL, which
> serves as a hint to the programmer; however, as a general principle it
> stands that having the NULL check here makes it obvious to any reading
> programmer that they any changes they make have to consider if the pointer
> is NULL or not.

Sounds good. Thanks again. Would like to see if other experts have any further
guidance on this patch.

Regards,
./drv

>
> >
> > > Mikko
> >
> >
>


