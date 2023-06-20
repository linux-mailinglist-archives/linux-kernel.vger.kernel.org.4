Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46ED737562
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjFTTv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFTTvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3A310F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687290636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6ucTdIAb48KkpphrkEbKr8Pmm/qOe0nUhjp8QpDWVY=;
        b=UZQcvjvkfP5ybNYSApgxMicmEqSMBYxChYXWV/tXVDylIOd5LyjPDS0NgoSCwXKSxjbY2i
        KKLZ70KGYX1B81nmPihuXSITAq13WlqAqNTwep8wmbTJM9FnWyTmnSx5gCniE/LOHsU5rq
        8i4emlTl2lMJw4hFk4g5GkaRAlTXyyc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-pywGIEoDOwyDiNtNmwALBQ-1; Tue, 20 Jun 2023 15:50:34 -0400
X-MC-Unique: pywGIEoDOwyDiNtNmwALBQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62fed7d0f05so51373206d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290626; x=1689882626;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6ucTdIAb48KkpphrkEbKr8Pmm/qOe0nUhjp8QpDWVY=;
        b=KGBVOliAeJy3Aud1wsi4Uxw9ztsdhH6TjhBVk7JJ2R0g+aiGAksq7dj9hFgGHGQqgD
         JlAX9zYo9bxUv9PDT/ClOfWhwk8gP38YEvctyUV3/JoD3ekWZh9ERSPW8fLHHnCxidfL
         XyoBw30IjeKmouN5DVZubfVvPH3v23Ii1vdLcOSVKVxxVcPDW5XewPTGamEaH4+iDeSK
         oB7MN6WeZRfS08TDCCwx1N5YoBcjxGSrqOAO4X8sOPlcIVBHK136cBwCHFXAY0IAxx5V
         E4lxu05c3hrESaBTBibdhsDLkxnDzdoGknVbK92ijlHI9uliTF+DxhQW9O6VBUuVjFAt
         bGjg==
X-Gm-Message-State: AC+VfDz1SVo5Qu7LwTw2Xu3zmMMpyl8txHfgbe04Sj5Nnh/TXT+RBig+
        22kbiasqecbZh+odP1eUKZAfh0pe1mtPkrzMvDUJNgqHbM/rGrg6jXPOPwJzeO633sbzedPP1FM
        d93t60XIFGSkJZpa3/9Kg/j2h
X-Received: by 2002:a05:6214:21a9:b0:630:1bc8:9c8 with SMTP id t9-20020a05621421a900b006301bc809c8mr7356315qvc.13.1687290625898;
        Tue, 20 Jun 2023 12:50:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GILEoSu57RIihBnk3ZDC3l1XHJzoGQ53+iPFuodcdHgryd/P+NBe9CAKco3ZkyvbVHMUymw==
X-Received: by 2002:a05:6214:21a9:b0:630:1bc8:9c8 with SMTP id t9-20020a05621421a900b006301bc809c8mr7356295qvc.13.1687290625548;
        Tue, 20 Jun 2023 12:50:25 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id d14-20020a0cb2ce000000b00630173b9a7asm1598177qvf.71.2023.06.20.12.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:50:24 -0700 (PDT)
Message-ID: <dd8edd9405049b09cd30ea13e5ae5562a437a2d3.camel@redhat.com>
Subject: Re: [PATCH v2] drm: use mgr->dev in drm_dbg_kms in
 drm_dp_add_payload_part2
From:   Lyude Paul <lyude@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Wayne.Lin@amd.com, alexdeucher@gmail.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Jun 2023 15:50:24 -0400
In-Reply-To: <4400e47d6555ed773d1e9cab5566c03429d43ae9.camel@kernel.org>
References: <20230419112447.18471-1-jlayton@kernel.org>
         <d0b9654c756069a6f0edcca6f4d410f7af592784.camel@redhat.com>
         <4400e47d6555ed773d1e9cab5566c03429d43ae9.camel@kernel.org>
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

Eek - this might have been a situation where everyone involved assumed some=
one
else would push it, whoops. I'll make sure this is pushed upstream :).

FWIW: You could definitely send an MR to the fedora kernel's gitlab to get
this included earlier. If you don't get to it before me I'll try to do that
today

On Tue, 2023-06-20 at 07:18 -0400, Jeff Layton wrote:
> I've noticed that this patch is not included in linux-next currently.
>=20
> Can I get some confirmation that this is going to be included in v6.5?
> Currently, I've been having to rebuild Fedora kernels to avoid this
> panic, and I'd like to know there is a light at the end of that tunnel.
>=20
> Thanks,
> Jeff
>=20
> On Wed, 2023-04-19 at 16:54 -0400, Lyude Paul wrote:
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> >=20
> > Thanks!
> >=20
> > On Wed, 2023-04-19 at 07:24 -0400, Jeff Layton wrote:
> > > I've been experiencing some intermittent crashes down in the display
> > > driver code. The symptoms are ususally a line like this in dmesg:
> > >=20
> > >     amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port =
000000006d3a3885: -5
> > >=20
> > > ...followed by an Oops due to a NULL pointer dereference.
> > >=20
> > > Switch to using mgr->dev instead of state->dev since "state" can be
> > > NULL in some cases.
> > >=20
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2184855
> > > Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > I've been running this patch for a couple of days, but the problem
> > > hasn't occurred again as of yet. It seems sane though as long as we c=
an
> > > assume that mgr->dev will be valid even when "state" is a NULL pointe=
r.
> > >=20
> > > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/=
gpu/drm/display/drm_dp_mst_topology.c
> > > index 38dab76ae69e..e2e21ce79510 100644
> > > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > @@ -3404,7 +3404,7 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_=
topology_mgr *mgr,
> > > =20
> > >  	/* Skip failed payloads */
> > >  	if (payload->vc_start_slot =3D=3D -1) {
> > > -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed,=
 skipping part 2\n",
> > > +		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, s=
kipping part 2\n",
> > >  			    payload->port->connector->name);
> > >  		return -EIO;
> > >  	}
> >=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

