Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FAE6D3790
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 13:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDBLUq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Apr 2023 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDBLUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 07:20:44 -0400
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Apr 2023 04:20:43 PDT
Received: from lynxeye.de (ns.lynxeye.de [87.118.118.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A031D2DC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 04:20:43 -0700 (PDT)
Received: by lynxeye.de (Postfix, from userid 501)
        id D153DE74004; Sun,  2 Apr 2023 13:13:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from [192.168.178.22] (a89-183-231-124.net-htp.de [89.183.231.124])
        by lynxeye.de (Postfix) with ESMTPSA id 510DFE74004;
        Sun,  2 Apr 2023 13:13:42 +0200 (CEST)
Message-ID: <3c1d4d055df1b75c757956b47b77a23a9edcf842.camel@lynxeye.de>
Subject: Re: [PATCH 0/3] drm/lima: expose usage statistics via fdinfo
From:   Lucas Stach <dev@lynxeye.de>
To:     Qiang Yu <yuq825@gmail.com>, Erico Nunes <nunes.erico@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org
Date:   Sun, 02 Apr 2023 13:13:41 +0200
In-Reply-To: <CAKGbVbtb-cKv2Fb1x91vZssZxayxciSp3RLJeVsn0z1JhvT6QQ@mail.gmail.com>
References: <20230312233052.21095-1-nunes.erico@gmail.com>
         <CAKGbVbs2ZRGyYOy9yYUMJ+apQm=NaXXb58C-97CaoTe5KPNqgw@mail.gmail.com>
         <CAKGbVbtb-cKv2Fb1x91vZssZxayxciSp3RLJeVsn0z1JhvT6QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 02.04.2023 um 18:22 +0800 schrieb Qiang Yu:
> Applied to drm-misc-next.
> 
"df622729ddbf drm/scheduler: track GPU active time per entity" had to
be reverted due to it introducing a use after free. I guess this
patchset now conflicts with the revert.

Regards,
Lucas

> On Mon, Mar 13, 2023 at 11:09 AM Qiang Yu <yuq825@gmail.com> wrote:
> > 
> > Patch set is:
> > Reviewed-by: Qiang Yu <yuq825@gmail.com>
> > 
> > Looks like drm-misc-next does not contain "df622729ddbf drm/scheduler:
> > track GPU active time per entity" yet.
> > Will apply later.
> > 
> > Regards,
> > Qiang
> > 
> > On Mon, Mar 13, 2023 at 7:31 AM Erico Nunes <nunes.erico@gmail.com> wrote:
> > > 
> > > Expose lima gp and pp usage stats through fdinfo, following
> > > Documentation/gpu/drm-usage-stats.rst.
> > > Borrowed from these previous implementations:
> > > 
> > > "df622729ddbf drm/scheduler: track GPU active time per entity" added
> > > usage time accounting to drm scheduler, which is where the data used
> > > here comes from.
> > > 
> > > Then the main implementation is based on these etnaviv commits:
> > > "d306788b6e1b drm/etnaviv: allocate unique ID per drm_file" and
> > > "97804a133c68 drm/etnaviv: export client GPU usage statistics via
> > > fdinfo"
> > > 
> > > Also "874442541133 drm/amdgpu: Add show_fdinfo() interface" since lima
> > > has a context manager very similar to amdgpu and all contexts created
> > > (and released) at the ctx_mgr level need to be accounted for.
> > > 
> > > Tested with the generic "gputop" tool currently available as patches to
> > > igt, a sample run with this patchset looks like this:
> > > 
> > > DRM minor 128
> > >     PID               NAME             gp                        pp
> > >     4322   glmark2-es2-way |█████▊                  ||██████████████████      |
> > >     3561            weston |▎                       ||███▌                    |
> > >     4159          Xwayland |▏                       ||▉                       |
> > >     4154          glxgears |▏                       ||▎                       |
> > >     3661           firefox |▏                       ||▏                       |
> > > 
> > > 
> > > Erico Nunes (3):
> > >   drm/lima: add usage counting method to ctx_mgr
> > >   drm/lima: allocate unique id per drm_file
> > >   drm/lima: add show_fdinfo for drm usage stats
> > > 
> > >  drivers/gpu/drm/lima/lima_ctx.c    | 30 ++++++++++++++++++++-
> > >  drivers/gpu/drm/lima/lima_ctx.h    |  3 +++
> > >  drivers/gpu/drm/lima/lima_device.h |  3 +++
> > >  drivers/gpu/drm/lima/lima_drv.c    | 43 +++++++++++++++++++++++++++++-
> > >  drivers/gpu/drm/lima/lima_drv.h    |  1 +
> > >  5 files changed, 78 insertions(+), 2 deletions(-)
> > > 
> > > --
> > > 2.39.2
> > > 

