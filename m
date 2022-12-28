Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28106576C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiL1NJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiL1NJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:09:12 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE95F73
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672232933; bh=XIsYijePFlvpwKLkAOrbvIzaHaw9+yquPSONaYDi1y4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=k0p8P+fHJO/H/fobVSM9fo+LUmcVj4iuTvGn7MW/Mcck1I/Qrta04H+qRxUklHSIC
         wZM3jyhPAXlDgncIwdzkvpqkTAsROMFdzsAXcH00DgXoX4fDEs7X7oAdDR3blS98Ns
         NTV+M4gxxp36+lW3t0Pi/qm896okUQmH/YXnI+Ao=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 28 Dec 2022 14:08:53 +0100 (CET)
X-EA-Auth: 51UmvQ9LL2ezogCcIPWdXZ5LqsEIzoMomGNKNMt1jBrzVDuAnIeVo85BDVyiHpfbe7DnVzrd88G7zCcex3Aj4j9XiPLbLFN6
Date:   Wed, 28 Dec 2022 18:38:48 +0530
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
Message-ID: <Y6w/4IzoMFsVnCmu@qemulion>
References: <Y6sn7XptKyk5cbrA@qemulion>
 <864f2fdd-4289-a178-bbf1-c2a6a579c58c@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864f2fdd-4289-a178-bbf1-c2a6a579c58c@kapsi.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 02:28:54PM +0200, Mikko Perttunen wrote:
> On 12/27/22 19:14, Deepak R Varma wrote:
> > kfree() & vfree() internally perform NULL check on the pointer handed
> > to it and take no action if it indeed is NULL. Hence there is no need
> > for a pre-check of the memory pointer before handing it to
> > kfree()/vfree().
> >
> > Issue reported by ifnullfree.cocci Coccinelle semantic patch script.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >   drivers/gpu/drm/tegra/submit.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
> > index 066f88564169..06f836db99d0 100644
> > --- a/drivers/gpu/drm/tegra/submit.c
> > +++ b/drivers/gpu/drm/tegra/submit.c
> > @@ -680,8 +680,8 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
> >   		kfree(job_data->used_mappings);
> >   	}
> >
> > -	if (job_data)
> > -		kfree(job_data);
> > +	kfree(job_data);
> > +
> >   put_bo:
> >   	gather_bo_put(&bo->base);
> >   unlock:
> > --
> > 2.34.1
> >
> >
> >
>
> It continues to be the case that I think this transform is bad. Same applies
> to the host1x patch.

Hello Mikko,
Thank you for responding to the patch proposal. Could you please explain why is
this bad?

Regards,
./drv

>
> Mikko


