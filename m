Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD806F08F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbjD0QBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244066AbjD0QBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586EB2D72
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EADAA63E1E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925A4C433EF;
        Thu, 27 Apr 2023 16:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682611306;
        bh=1Bgza/4uPsYCy5eT6JwQzCQ4JiSUqYPkXew3bWD3hwc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QLow74rlEHQtFQtzBAoUiYLM9bpEvQ+9jIVaCJT0rKtS0i49bYsaml9v4f+w9iieY
         8xRetbBbvsizjRQ2BAHXTPrSAK6+IwabJeXzUyJ/r458ND8QWQG0sZhFOraPO2xfG6
         CHf3uceonGw/ej0OqQwaYl3yRYgliIyPM6Huj2LOvMnfyWiUS5Glwt/Vj1h1oCnMcp
         4fU3wmeyjb+vd6FsTFgP0diBamf0VSdzbOY0dmbg4nSqrM2V4AGevxci2QNcT0MJk+
         co3KhKYJcEJyjFgvdSY2pGmQbEbg4QAYltNMkh/u9RFKvn6RPYYELPyBWVvFzAgGzQ
         3t8NIuVwl3BhQ==
Message-ID: <9656b75354112dbb1ba671297358b41a28ce91f1.camel@kernel.org>
Subject: Re: [PATCH v2] drm: use mgr->dev in drm_dbg_kms in
 drm_dp_add_payload_part2
From:   Jeff Layton <jlayton@kernel.org>
To:     Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Wayne.Lin@amd.com, alexdeucher@gmail.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Apr 2023 12:01:44 -0400
In-Reply-To: <d0b9654c756069a6f0edcca6f4d410f7af592784.camel@redhat.com>
References: <20230419112447.18471-1-jlayton@kernel.org>
         <d0b9654c756069a6f0edcca6f4d410f7af592784.camel@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-19 at 16:54 -0400, Lyude Paul wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>=20
> Thanks!
>=20
> On Wed, 2023-04-19 at 07:24 -0400, Jeff Layton wrote:
> > I've been experiencing some intermittent crashes down in the display
> > driver code. The symptoms are ususally a line like this in dmesg:
> >=20
> >     amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port 00=
0000006d3a3885: -5
> >=20
> > ...followed by an Oops due to a NULL pointer dereference.
> >=20
> > Switch to using mgr->dev instead of state->dev since "state" can be
> > NULL in some cases.
> >=20
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2184855
> > Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > I've been running this patch for a couple of days, but the problem
> > hasn't occurred again as of yet. It seems sane though as long as we can
> > assume that mgr->dev will be valid even when "state" is a NULL pointer.
> >=20
> > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gp=
u/drm/display/drm_dp_mst_topology.c
> > index 38dab76ae69e..e2e21ce79510 100644
> > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > @@ -3404,7 +3404,7 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_to=
pology_mgr *mgr,
> > =20
> >  	/* Skip failed payloads */
> >  	if (payload->vc_start_slot =3D=3D -1) {
> > -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, s=
kipping part 2\n",
> > +		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, ski=
pping part 2\n",
> >  			    payload->port->connector->name);
> >  		return -EIO;
> >  	}
>=20

Thanks! BTW, I've had a couple more of these events in the last few
days:

[20199.446159] amdgpu 0000:30:00.0: [drm] Failed to create MST payload for =
port 00000000556eb455: -5
[20199.508379] [drm] DM_MST: stopping TM on aconnector: 000000001c0c0284 [i=
d: 86]
[20200.064417] [drm] DM_MST: starting TM on aconnector: 000000001c0c0284 [i=
d: 86]

The patch prevents an Oops, but GNOME seems to decide that a different
monitor is primary and moves all of the windows on the desktop around (I
have 2 monitors). Mostly this seems to happen when I walk away from the
machine for a bit, so I suspect it's associated with the display going
to sleep.

At one point, Wayne said he might know the root cause of this. If there
are patches that you need help testing, I can do that. I'm having to
build my own kernels anyway until this patch makes it into the distros.
--=20
Jeff Layton <jlayton@kernel.org>
