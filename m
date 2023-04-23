Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A569D6EBC2E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 02:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDWAfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 20:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWAe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 20:34:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48702211E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 17:34:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D397261461
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 00:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611E7C433D2;
        Sun, 23 Apr 2023 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682210097;
        bh=JNSlUkMUb/vTZyPvFPK9GDKgh29Sk76KROilX21N1bY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N8LfNmHhurMgegU++0cdfW0n9sl4pIgFJCEbK5J8QG5KYJDfHRup03GgvqtCqsVYt
         uM4+5Nd67bNhprWPpCHs6RBLEFIJ9murSI53svGg+je+LzOHvwj7yJmn8smFOgcIvv
         NY+bQad5oRgKwomjbeEr7dMqtdx9qaiTg+DJY1lTRhvifNoiu42unWvTEDMMMLqSfV
         v1ZL1Z0Q3b5yRfaNXLg793YVQWZjCrRDbezSsxtDpm7gYe8LNua91bhyHudu0XtXds
         MCKS5GwNA+iP+fIXZ0uqoHTqcQ5krbahT5k2jrM4bfGfqlIiZENnva9Hlqhep4KDx+
         UdB/dtpcTvMUA==
Message-ID: <04cc52e7458cbd22c0ef9d092aabca3ea5403074.camel@kernel.org>
Subject: Re: [PATCH v2] drm: use mgr->dev in drm_dbg_kms in
 drm_dp_add_payload_part2
From:   Jeff Layton <jlayton@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Wayne.Lin@amd.com, lyude@redhat.com, alexdeucher@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Sat, 22 Apr 2023 20:34:55 -0400
In-Reply-To: <87o7nkypmo.fsf@intel.com>
References: <20230419112447.18471-1-jlayton@kernel.org>
         <87o7nkypmo.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-19 at 16:21 +0300, Jani Nikula wrote:
> On Wed, 19 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
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
>=20
> Thanks,
>=20
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>=20
>
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

Thanks for the reviews!

I finally had this happen again today, and I can confirm that this does
prevent the oops. GNOME rearranged my screen layout after the error, but
the box stayed up and running.=20
--=20
Jeff Layton <jlayton@kernel.org>
