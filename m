Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CF373D293
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFYQ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:56:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B073100;
        Sun, 25 Jun 2023 09:56:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-160-50-14.reb.o2.cz [85.160.50.14])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 34A2B4DB;
        Sun, 25 Jun 2023 18:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687712175;
        bh=A3AnVnOFjJh6d289gsuCnuuSpnAbQwPDVvq/TgXBLpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9W6i3tIHqxN6v1VSP4xm25Qb5Q1kjths2hfrZ8s/qsvH7acskBJlTmWj9hJ9U0lp
         vQDSBTaJgBNJcDSbnJyiqS3H45vn1Cs8D5On6q4V/G387yOtzZU4jH+gDU2DABxKTA
         rMMsD0MIbGKBHfhOrP9WPgxkBYpMJdSlbyjaRSOE=
Date:   Sun, 25 Jun 2023 19:56:51 +0300
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
Message-ID: <20230625165651.GA13886@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <95c2af42a89c65ca603126e56c0423407dfc873f.1687423204.git.geert+renesas@glider.be>
 <20230623165038.GB2112@pendragon.ideasonboard.com>
 <CAMuHMdWsDHMn4P1g_EYKzXyisUOnhJ0Q1Nd5Wq9H_CwPvaSaWw@mail.gmail.com>
 <20230623185052.GR2112@pendragon.ideasonboard.com>
 <CAMuHMdWdeRODcAa26EKuvR3yca0hVqSUR6WBHEtr9+RBKyk_Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWdeRODcAa26EKuvR3yca0hVqSUR6WBHEtr9+RBKyk_Ow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 10:58:17AM +0200, Geert Uytterhoeven wrote:
> On Fri, Jun 23, 2023 at 8:50 PM Laurent Pinchart wrote:
> > On Fri, Jun 23, 2023 at 07:55:22PM +0200, Geert Uytterhoeven wrote:
> > > On Fri, Jun 23, 2023 at 6:50 PM Laurent Pinchart wrote:
> > > > On Thu, Jun 22, 2023 at 11:21:36AM +0200, Geert Uytterhoeven wrote:
> > > > > Unify primary and overlay plane allocation:
> > > > >   - Enhance shmob_drm_plane_create() so it can be used to create the
> > > > >     primary plane, too,
> > > > >   - Move overlay plane creation next to primary plane creation.
> > > > >
> > > > > As overlay plane index zero now means the primary plane, this requires
> > > > > shifting all overlay plane indices by one.
> > > >
> > > > Do you use index zero to identify the primary plane just for
> > > > shmob_drm_plane_create(), or somewhere else too ? If it's just to create
> > > > the plane, you could instead pass the plane type to the function.
> > >
> > > Index zero is just used for the creation.
> > > I guess this sort of goes together with my question below...
> > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > ---
> > > > > Perhaps it would be better to not use dynamic allocation, but store
> > > > > "struct drm_plane primary" and "struct shmob_drm_plane planes[5]" in
> > > > > struct drm_shmob_device instead, like is done for the crtc and encoder?
> > >
> > > ... as embedding separate primary and planes[] would also get rid of
> > > the need to adjust the plane indices when converting from logical to physical
> > > overlay plane indices.
> >
> > Do they need to be embedded for that, or could you simple keep the index
> > as it is ?
> 
> If the plane type would be passed explicitly, they would not need to be
> embedded for that.
> 
> Then the question becomes: does it make sense to unify primary and
> overlay plane handling?

Good point. I don't mind much either way, it depends on how much code
duplication it would remove I suppose.

-- 
Regards,

Laurent Pinchart
