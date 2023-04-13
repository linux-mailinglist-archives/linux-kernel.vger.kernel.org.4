Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09BB6E0D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDMMn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDMMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E9893D1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9E476146C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629DDC433D2;
        Thu, 13 Apr 2023 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681389834;
        bh=yOCVEPTkqmwzrbgaO4trLtk8j+cugrX7CunNTUSAF4o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eo/swswdEMkWLuTPtC+XSfNe7DxDo2uPvkry0F0awj0Xy5GYN62lRckycHDCOCMu7
         xTfmUHC881NkN6xEPSTxJs6G5rwPTk/OUcFxbKzYP8kJyp0q6BJrFAjtE0YVg52dGa
         l93ocDixpnNZVssYz3IIvocuBFfTq0t72K+VZEeibMLvktwDqj3HLCz/2iA+6z3HW4
         MyiaNaKS4VNCyx0+U8BzxmodHPMZM8Tf0Vnee8zXIaaAPUUcYamTPCurR1YXn2X/Wc
         JUiXEaMgYxyt1j25oDps/VYxBPIEa4XhDa1xKZFX4xJMaXtguQe0XbjNSael1HYD+u
         ONyEslOtsuPag==
Message-ID: <cc3ceecef10fabf6856e29c2dd22b040b3ea757b.camel@kernel.org>
Subject: Re: [PATCH] drm: make drm_dp_add_payload_part2 gracefully handle
 NULL state pointer
From:   Jeff Layton <jlayton@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Date:   Thu, 13 Apr 2023 08:43:52 -0400
In-Reply-To: <87edooarpq.fsf@intel.com>
References: <20230413111254.22458-1-jlayton@kernel.org>
         <87edooarpq.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-13 at 15:31 +0300, Jani Nikula wrote:
> On Thu, 13 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
> > I've been experiencing some intermittent crashes down in the display
> > driver code. The symptoms are ususally a line like this in dmesg:
> >=20
> >     amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port 00=
0000006d3a3885: -5
> >=20
> > ...followed by an Oops due to a NULL pointer dereference.
> >=20
> > The real bug is probably in the caller of this function, which is
> > passing it a NULL state pointer, but this patch at least keeps my
> > machine from oopsing when this occurs.
>=20
> My fear is that papering over this makes the root cause harder to find.
>=20
> Cc: Harry, Alex
>=20
>=20
> BR,
> Jani.
>=20
>=20

I'm happy to help track down the root cause. Display drivers are
somewhat outside my wheelhouse though.

Maybe we can throw a WARNING when this happens? I'd just like it to not
crash my machine.


> >=20
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2184855
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gp=
u/drm/display/drm_dp_mst_topology.c
> > index 38dab76ae69e..87ad406c50f9 100644
> > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > @@ -3404,7 +3404,8 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_to=
pology_mgr *mgr,
> > =20
> >  	/* Skip failed payloads */
> >  	if (payload->vc_start_slot =3D=3D -1) {
> > -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, s=
kipping part 2\n",
> > +		drm_dbg_kms(state ? state->dev : NULL,
> > +			    "Part 1 of payload creation for %s failed, skipping part 2\n",
> >  			    payload->port->connector->name);
> >  		return -EIO;
> >  	}
>=20

--=20
Jeff Layton <jlayton@kernel.org>
