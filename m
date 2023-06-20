Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A25873757C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjFTUA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjFTUAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A374D7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687291176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nDkX/u4zkhYkl8D9Eltwlq6VfSNd8Ak1NeiW21WxpE=;
        b=D3MC0iRmwPZBPkZsjV8WloELn0nLUdG8jbdVSFMZogWHbDGj1Jxsj7n+jygB3Wui3U7hif
        zNsGrxwXTcOQIJcdPnnvnke4Z+f8N3WKPLx0ItQlSJrRQMM/xtzep0PRPd36QlbOqAxYZG
        ot+S2Ne/yhuHPLKwa/W7gJ2s8HKuSKc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-jAQ4UGkGOAqOjW_hZzO4-A-1; Tue, 20 Jun 2023 15:59:35 -0400
X-MC-Unique: jAQ4UGkGOAqOjW_hZzO4-A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-763a2e8a67aso264307485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291166; x=1689883166;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nDkX/u4zkhYkl8D9Eltwlq6VfSNd8Ak1NeiW21WxpE=;
        b=cO/bzCfZI8Vo54pq6IECzioS/6MBjG2ZPZJPLrg/QSqHP8l7dkUsmBU9Z1z7EnKiNT
         pPFKK+dZ4nyyFNaDNWW6uQk7e4L39vTq50j+Mf/dTJgOL9gTvr/XRkC8PYrgw/ChbC7Z
         PbkVenU+PY/U3FHCA8BsvxsuigWTf9GPVxclhxmKCALGTSC1tw/hILKVwkUMCiN0JEq/
         GQsHNvrEgF6vi/0UpPQ8ID3UVYbvLKg67R0ciOT4swnTPgXvNwd3xMdyxThFXC1MAiPX
         gd/4dlBtb5ZmwF9rK82gtFhbJdTsygIYCLTRsD5WarCDnoeRJwlLp/gtobGR54IbyaWJ
         Hwng==
X-Gm-Message-State: AC+VfDyNGym8YidDVUc12rNCY8Ns3KbyEOyF9oP5m85hNOvOj09Lo35U
        eQZUONgkI2Tv/r3hlLHmfADnmmVjXYhZaLXppdQ7FkKTw5isjxcDJ9DJtH3BuvbNgJCOCdxuC81
        ZVAk7cwMoElUb+0MRYm3VcZev
X-Received: by 2002:a05:6214:f01:b0:62f:ef74:a304 with SMTP id gw1-20020a0562140f0100b0062fef74a304mr18705156qvb.8.1687291166195;
        Tue, 20 Jun 2023 12:59:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55Mx2TzRMVHfHKAyGs/tY2KtKOTOfrkOmTeeVyvfrBXj5Ae2gO6QDSWX3vIRrBM2lq/om3Sw==
X-Received: by 2002:a05:6214:f01:b0:62f:ef74:a304 with SMTP id gw1-20020a0562140f0100b0062fef74a304mr18705150qvb.8.1687291165967;
        Tue, 20 Jun 2023 12:59:25 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id j16-20020a0cf310000000b006301bc80875sm1591652qvl.60.2023.06.20.12.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:59:25 -0700 (PDT)
Message-ID: <3d47da79a59817b69d5ed7cdaf4fbec227be00d9.camel@redhat.com>
Subject: Re: [PATCH v2] drm: use mgr->dev in drm_dbg_kms in
 drm_dp_add_payload_part2
From:   Lyude Paul <lyude@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Wayne.Lin@amd.com, alexdeucher@gmail.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Jun 2023 15:59:24 -0400
In-Reply-To: <dd8edd9405049b09cd30ea13e5ae5562a437a2d3.camel@redhat.com>
References: <20230419112447.18471-1-jlayton@kernel.org>
         <d0b9654c756069a6f0edcca6f4d410f7af592784.camel@redhat.com>
         <4400e47d6555ed773d1e9cab5566c03429d43ae9.camel@kernel.org>
         <dd8edd9405049b09cd30ea13e5ae5562a437a2d3.camel@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also since I forgot, so patchwork picks this up:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2023-06-20 at 15:50 -0400, Lyude Paul wrote:
> Eek - this might have been a situation where everyone involved assumed so=
meone
> else would push it, whoops. I'll make sure this is pushed upstream :).
>=20
> FWIW: You could definitely send an MR to the fedora kernel's gitlab to ge=
t
> this included earlier. If you don't get to it before me I'll try to do th=
at
> today
>=20
> On Tue, 2023-06-20 at 07:18 -0400, Jeff Layton wrote:
> > I've noticed that this patch is not included in linux-next currently.
> >=20
> > Can I get some confirmation that this is going to be included in v6.5?
> > Currently, I've been having to rebuild Fedora kernels to avoid this
> > panic, and I'd like to know there is a light at the end of that tunnel.
> >=20
> > Thanks,
> > Jeff
> >=20
> > On Wed, 2023-04-19 at 16:54 -0400, Lyude Paul wrote:
> > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > >=20
> > > Thanks!
> > >=20
> > > On Wed, 2023-04-19 at 07:24 -0400, Jeff Layton wrote:
> > > > I've been experiencing some intermittent crashes down in the displa=
y
> > > > driver code. The symptoms are ususally a line like this in dmesg:
> > > >=20
> > > >     amdgpu 0000:30:00.0: [drm] Failed to create MST payload for por=
t 000000006d3a3885: -5
> > > >=20
> > > > ...followed by an Oops due to a NULL pointer dereference.
> > > >=20
> > > > Switch to using mgr->dev instead of state->dev since "state" can be
> > > > NULL in some cases.
> > > >=20
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2184855
> > > > Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > I've been running this patch for a couple of days, but the problem
> > > > hasn't occurred again as of yet. It seems sane though as long as we=
 can
> > > > assume that mgr->dev will be valid even when "state" is a NULL poin=
ter.
> > > >=20
> > > > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/driver=
s/gpu/drm/display/drm_dp_mst_topology.c
> > > > index 38dab76ae69e..e2e21ce79510 100644
> > > > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > > @@ -3404,7 +3404,7 @@ int drm_dp_add_payload_part2(struct drm_dp_ms=
t_topology_mgr *mgr,
> > > > =20
> > > >  	/* Skip failed payloads */
> > > >  	if (payload->vc_start_slot =3D=3D -1) {
> > > > -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s faile=
d, skipping part 2\n",
> > > > +		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed,=
 skipping part 2\n",
> > > >  			    payload->port->connector->name);
> > > >  		return -EIO;
> > > >  	}
> > >=20
> >=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

