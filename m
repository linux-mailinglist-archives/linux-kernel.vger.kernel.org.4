Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52273BE97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjFWSu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWSu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:50:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292D19A1;
        Fri, 23 Jun 2023 11:50:56 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2153BD5F;
        Fri, 23 Jun 2023 20:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687546217;
        bh=P76feT+FVoK0nYQ6ZMQuUeAea/agovi+t1v5uPp/zVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXXgRGrgSc+LQPQk0jme5BeMb3EHAWejy8/mQObA+3A5QBG+JgoAqKQXyBNkgTk4f
         fA0KK4k4KcHQ4ATmhV1NB0+nUd+GWCuuGwr9vy/ILt/px/Zem6HIn3aG7PcxrZQhx/
         mKD5f2XIe0V6xrArhMA/t1/nc1LiQziU3WB0Udlk=
Date:   Fri, 23 Jun 2023 21:50:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/39] drm: renesas: shmobile: Unify plane allocation
Message-ID: <20230623185052.GR2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <95c2af42a89c65ca603126e56c0423407dfc873f.1687423204.git.geert+renesas@glider.be>
 <20230623165038.GB2112@pendragon.ideasonboard.com>
 <CAMuHMdWsDHMn4P1g_EYKzXyisUOnhJ0Q1Nd5Wq9H_CwPvaSaWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWsDHMn4P1g_EYKzXyisUOnhJ0Q1Nd5Wq9H_CwPvaSaWw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 07:55:22PM +0200, Geert Uytterhoeven wrote:
> On Fri, Jun 23, 2023 at 6:50 PM Laurent Pinchart wrote:
> > On Thu, Jun 22, 2023 at 11:21:36AM +0200, Geert Uytterhoeven wrote:
> > > Unify primary and overlay plane allocation:
> > >   - Enhance shmob_drm_plane_create() so it can be used to create the
> > >     primary plane, too,
> > >   - Move overlay plane creation next to primary plane creation.
> > >
> > > As overlay plane index zero now means the primary plane, this requires
> > > shifting all overlay plane indices by one.
> >
> > Do you use index zero to identify the primary plane just for
> > shmob_drm_plane_create(), or somewhere else too ? If it's just to create
> > the plane, you could instead pass the plane type to the function.
> 
> Index zero is just used for the creation.
> I guess this sort of goes together with my question below...
> 
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > Perhaps it would be better to not use dynamic allocation, but store
> > > "struct drm_plane primary" and "struct shmob_drm_plane planes[5]" in
> > > struct drm_shmob_device instead, like is done for the crtc and encoder?
> 
> ... as embedding separate primary and planes[] would also get rid of
> the need to adjust the plane indices when converting from logical to physical
> overlay plane indices.

Do they need to be embedded for that, or could you simple keep the index
as it is ?

-- 
Regards,

Laurent Pinchart
