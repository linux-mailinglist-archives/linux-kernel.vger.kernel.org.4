Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8057A6E462A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDQLQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDQLQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD8A171A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37F9461A98
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA362C433EF;
        Mon, 17 Apr 2023 11:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681730026;
        bh=hL3HemzQu0W+VoN6r7QGvyo5bFw22rSL5CO9yDPgTQI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FEU5PakWUXFe+jipb6I7mWm+415nA23wFN31d2OVyokyCIewMuA76TMpnHs4xEvEJ
         pxOR9E2OIZAK0cTcHOZ/QzhEOkrXBvjRHS6o6tBRuIiE1xdK1NFZR7kRvA9n+LPkzP
         ATumsY5Cadgh8XKFRLRpivlMvhO2kO7ElciBOO1C8UX3l/GcJc94MSh/WovAq/WKY3
         8bxH17OfJ/Y2ZqNu22CnYv1dss9wolyfR0OQvWoNuJe3ETijKY3yQgwfnM3+39guaW
         qfRCd7dw5sp0tKPwIdzELsvkN5WDKZb6jlWr/AarvA5pmcBMrTVyf2rLOkxco252NG
         StPR0dvOujjLw==
Message-ID: <308cc38532a8cc3f3ce45d26ee71570df26b3288.camel@kernel.org>
Subject: Re: [PATCH] drm: make drm_dp_add_payload_part2 gracefully handle
 NULL state pointer
From:   Jeff Layton <jlayton@kernel.org>
To:     "Lin, Wayne" <Wayne.Lin@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Date:   Mon, 17 Apr 2023 07:13:44 -0400
In-Reply-To: <CO6PR12MB548998DE5E97B8EA9EB92AA6FC9C9@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20230413111254.22458-1-jlayton@kernel.org>
         <87edooarpq.fsf@intel.com>
         <CADnq5_PVnYMSiKO77+cfg_V-tDKYkVJYN3qGNb1vhQO3QtXskA@mail.gmail.com>
         <CO6PR12MB5489044012B2A96639470F38FC999@CO6PR12MB5489.namprd12.prod.outlook.com>
         <4d8479f20ef30866fcf73f3602f1237376110764.camel@kernel.org>
         <878reug394.fsf@intel.com>
         <7a1b00f02b125bd65824b18ea09509efe3cf777d.camel@redhat.com>
         <874jpegao0.fsf@intel.com>
         <b99732f7c0dd968c0702ae7629695e8fb9cb573f.camel@kernel.org>
         <87leiqer8g.fsf@intel.com>
         <CO6PR12MB548998DE5E97B8EA9EB92AA6FC9C9@CO6PR12MB5489.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-17 at 10:58 +0000, Lin, Wayne wrote:
> [AMD Official Use Only - General]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Jani Nikula <jani.nikula@linux.intel.com>
> > Sent: Monday, April 17, 2023 6:30 PM
> > To: Jeff Layton <jlayton@kernel.org>; Lyude Paul <lyude@redhat.com>; Li=
n,
> > Wayne <Wayne.Lin@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> > Cc: David Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; linux-
> > kernel@vger.kernel.org; dri-devel@lists.freedesktop.org
> > Subject: Re: [PATCH] drm: make drm_dp_add_payload_part2 gracefully
> > handle NULL state pointer
> >=20
> > On Mon, 17 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
> > > On Mon, 2023-04-17 at 11:44 +0300, Jani Nikula wrote:
> > > > On Fri, 14 Apr 2023, Lyude Paul <lyude@redhat.com> wrote:
> > > > > On Fri, 2023-04-14 at 13:35 +0300, Jani Nikula wrote:
> > > > > > On Fri, 14 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > > On Fri, 2023-04-14 at 04:40 +0000, Lin, Wayne wrote:
> > > > > > > > [Public]
> > > > > > > >=20
> > > > > > > > Hi Jeff,
> > > > > > > >=20
> > > > > > > > Thanks. I might need more information to understand why we
> > > > > > > > can't retrieve the drm atomic state. Also , "Failed to crea=
te
> > > > > > > > MST payload for port" indicates error while configuring DPC=
D
> > > > > > > > payload ID table. Could you help to provide log with KMS +
> > ATOMIC + DP debug on please? Thanks in advance!
> > > > > > > >=20
> > > > > > > > Regards,
> > > > > > > > Wayne
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Possibly. I'm not that familiar with display driver debugging=
.
> > > > > > > Can you send me some directions on how to crank up that sort =
of
> > debug logging?
> > > > > > >=20
> > > > > > > Note that this problem is _very_ intermittent too: I went abo=
ut
> > > > > > > 2 weeks between crashes, and then I got 3 in one day. I'd
> > > > > > > rather not run with a lot of debug logging for a long time if
> > > > > > > that's what this is going to require, as this is my main work=
station.
> > > > > > >=20
> > > > > > > The last time I got this log message, my proposed patch did
> > > > > > > prevent the box from oopsing, so I'd really like to see it go
> > > > > > > in unless it's just categorically wrong for the caller to pas=
s
> > > > > > > down a NULL state pointer to drm_dp_add_payload_part2.
> > > > > >=20
> > > > > > Cc: Lyude.
> > > > > >=20
> > > > > > Looks like the state parameter was added in commit 4d07b0bc4034
> > > > > > ("drm/display/dp_mst: Move all payload info into the atomic
> > > > > > state") and its only use is to get at state->dev for debug logg=
ing.
> > > > > >=20
> > > > > > What's the plan for the parameter? Surely something more than
> > > > > > that! :)
> > > > >=20
> > > > > I don't think there was any plan for that, or at least I certainl=
y
> > > > > don't even remember adding that D:. It must totally have been by
> > > > > mistake and snuck by review, if that's the only thing that we're
> > > > > using it for I'd say it's definitely fine to just drop it entirel=
y
> > > >=20
> > > > I guess we could use two patches then, first replace state->dev wit=
h
> > > > mgr->dev as something that can be backported as needed, and second
> > > > mgr->drop
> > > > the state parameter altogether.
> > > >=20
> > > > Jeff, up for it? At least the first one?
> > > >=20
> > > >=20
> > > > BR,
> > > > Jani.
> > > >=20
> > >=20
> > > Sure. I'm happy to test patches if you send them along.
> >=20
> > I was hoping to lure you into sending patches. ;)
> >=20
> > Anyway, I'm not working on this.
> >=20
> >=20
> Hi Jeff,
>=20
> I probably know the root cause.=20
> But it doesn't need to use the state in the end, I will just rely on the =
patch=20
> that Jani suggested to fix it. I can help to provide the patch later : )
>=20
>=20

Sounds good. If you want to send me a patch to solve the root cause,
I'll put it in the kernel with the other one I'm testing.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
