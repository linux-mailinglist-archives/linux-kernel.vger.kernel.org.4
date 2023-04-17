Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE4E6E42DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDQIo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDQIoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:44:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA21E49
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681721093; x=1713257093;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=KV/N/E6kXh6FygL9ZMy5fr2iCnJHqBytPmQ8FHRLomc=;
  b=c7qXXfZZwiPUe27P7DIHmoXDkzqKCJw7g2MTHq6sYpbx9DqJPPoOu/CT
   8n373oOnj9Cz6BL8TUU1/fJqXrqIvaDuHEbQbx1nY1WwSMEGYJhCxRY+P
   eqDX8ZTgwe1Tlay3Xr2LC4JnFPrSsLjx+kTRhIIgLPc4gD1kxAF9VpKfk
   lnsSvPoUU29dd8uvYWivtBKhLMuunn3pY5ZaXgviy5wwvWj0xG00pe1IS
   7LWfmt+w9aK8toGuP434rxr4JeecdSxanRpRh1IB1EKCV213PvWPsPcQf
   DnFQj8iPnl/72m2RrSa67a4ZTeyHKxdvsvA979ABFN3hyYfe2Zhzcts4+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="343595720"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="343595720"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640887252"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="640887252"
Received: from habramov-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.47.83])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:44:49 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        "Lin, Wayne" <Wayne.Lin@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: make drm_dp_add_payload_part2 gracefully handle
 NULL state pointer
In-Reply-To: <7a1b00f02b125bd65824b18ea09509efe3cf777d.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230413111254.22458-1-jlayton@kernel.org>
 <87edooarpq.fsf@intel.com>
 <CADnq5_PVnYMSiKO77+cfg_V-tDKYkVJYN3qGNb1vhQO3QtXskA@mail.gmail.com>
 <CO6PR12MB5489044012B2A96639470F38FC999@CO6PR12MB5489.namprd12.prod.outlook.com>
 <4d8479f20ef30866fcf73f3602f1237376110764.camel@kernel.org>
 <878reug394.fsf@intel.com>
 <7a1b00f02b125bd65824b18ea09509efe3cf777d.camel@redhat.com>
Date:   Mon, 17 Apr 2023 11:44:47 +0300
Message-ID: <874jpegao0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023, Lyude Paul <lyude@redhat.com> wrote:
> On Fri, 2023-04-14 at 13:35 +0300, Jani Nikula wrote:
>> On Fri, 14 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
>> > On Fri, 2023-04-14 at 04:40 +0000, Lin, Wayne wrote:
>> > > [Public]
>> > >=20
>> > > Hi Jeff,
>> > >=20
>> > > Thanks. I might need more information to understand why we can't ret=
rieve
>> > > the drm atomic state. Also , "Failed to create MST payload for port"=
 indicates
>> > > error while configuring DPCD payload ID table. Could you help to pro=
vide log
>> > > with KMS + ATOMIC + DP debug on please? Thanks in advance!
>> > >=20
>> > > Regards,
>> > > Wayne
>> > >=20
>> >=20
>> > Possibly. I'm not that familiar with display driver debugging. Can you
>> > send me some directions on how to crank up that sort of debug logging?
>> >=20
>> > Note that this problem is _very_ intermittent too: I went about 2 weeks
>> > between crashes, and then I got 3 in one day. I'd rather not run with a
>> > lot of debug logging for a long time if that's what this is going to
>> > require, as this is my main workstation.
>> >=20
>> > The last time I got this log message, my proposed patch did prevent the
>> > box from oopsing, so I'd really like to see it go in unless it's just
>> > categorically wrong for the caller to pass down a NULL state pointer to
>> > drm_dp_add_payload_part2.
>>=20
>> Cc: Lyude.
>>=20
>> Looks like the state parameter was added in commit 4d07b0bc4034
>> ("drm/display/dp_mst: Move all payload info into the atomic state") and
>> its only use is to get at state->dev for debug logging.
>>=20
>> What's the plan for the parameter? Surely something more than that! :)
>
> I don't think there was any plan for that, or at least I certainly don't =
even
> remember adding that D:. It must totally have been by mistake and snuck by
> review, if that's the only thing that we're using it for I'd say it's
> definitely fine to just drop it entirely

I guess we could use two patches then, first replace state->dev with
mgr->dev as something that can be backported as needed, and second drop
the state parameter altogether.

Jeff, up for it? At least the first one?


BR,
Jani.


>
>>=20
>> Instead of "state ? state->dev : NULL" I guess we could use mgr->dev
>> like the other logging calls do. It's papering over the NULL parameter
>> too, but perhaps in a slightly cleaner way...
>>=20
>>=20
>> BR,
>> Jani.
>>=20
>>=20
>> >=20
>> > > > -----Original Message-----
>> > > > From: Alex Deucher <alexdeucher@gmail.com>
>> > > > Sent: Thursday, April 13, 2023 8:59 PM
>> > > > To: Jani Nikula <jani.nikula@linux.intel.com>; Lin, Wayne
>> > > > <Wayne.Lin@amd.com>
>> > > > Cc: Jeff Layton <jlayton@kernel.org>; David Airlie <airlied@gmail.=
com>;
>> > > > Daniel Vetter <daniel@ffwll.ch>; Deucher, Alexander
>> > > > <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; dri-
>> > > > devel@lists.freedesktop.org
>> > > > Subject: Re: [PATCH] drm: make drm_dp_add_payload_part2 gracefully
>> > > > handle NULL state pointer
>> > > >=20
>> > > > + Wayne
>> > > >=20
>> > > > On Thu, Apr 13, 2023 at 8:31=E2=80=AFAM Jani Nikula <jani.nikula@l=
inux.intel.com>
>> > > > wrote:
>> > > > >=20
>> > > > > On Thu, 13 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
>> > > > > > I've been experiencing some intermittent crashes down in the d=
isplay
>> > > > > > driver code. The symptoms are ususally a line like this in dme=
sg:
>> > > > > >=20
>> > > > > >     amdgpu 0000:30:00.0: [drm] Failed to create MST payload fo=
r port
>> > > > > > 000000006d3a3885: -5
>> > > > > >=20
>> > > > > > ...followed by an Oops due to a NULL pointer dereference.
>> > > > > >=20
>> > > > > > The real bug is probably in the caller of this function, which=
 is
>> > > > > > passing it a NULL state pointer, but this patch at least keeps=
 my
>> > > > > > machine from oopsing when this occurs.
>> > > > >=20
>> > > > > My fear is that papering over this makes the root cause harder t=
o find.
>> > > > >=20
>> > > > > Cc: Harry, Alex
>> > > > >=20
>> > > > >=20
>> > > > > BR,
>> > > > > Jani.
>> > > > >=20
>> > > > >=20
>> > > > > >=20
>> > > > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2184855
>> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > > > > > ---
>> > > > > >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 3 ++-
>> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > > > > >=20
>> > > > > > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> > > > > > b/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> > > > > > index 38dab76ae69e..87ad406c50f9 100644
>> > > > > > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> > > > > > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> > > > > > @@ -3404,7 +3404,8 @@ int drm_dp_add_payload_part2(struct
>> > > > > > drm_dp_mst_topology_mgr *mgr,
>> > > > > >=20
>> > > > > >       /* Skip failed payloads */
>> > > > > >       if (payload->vc_start_slot =3D=3D -1) {
>> > > > > > -             drm_dbg_kms(state->dev, "Part 1 of payload creat=
ion for %s
>> > > > failed, skipping part 2\n",
>> > > > > > +             drm_dbg_kms(state ? state->dev : NULL,
>> > > > > > +                         "Part 1 of payload creation for %s f=
ailed,
>> > > > > > + skipping part 2\n",
>> > > > > >                           payload->port->connector->name);
>> > > > > >               return -EIO;
>> > > > > >       }
>> > > > >=20
>> > > > > --
>> > > > > Jani Nikula, Intel Open Source Graphics Center
>>=20

--=20
Jani Nikula, Intel Open Source Graphics Center
