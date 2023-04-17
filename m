Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A26E44D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDQKHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDQKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18836580
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FFC61172
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A09CC433D2;
        Mon, 17 Apr 2023 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681726000;
        bh=0UxBgWduU60jsaUm8r63BWFQT7ncWMhFp8WEWJOslAo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dw7Vd3/QhWCca/5kuM9Ki5142rSavzqkKujRpBRQtEseB393LlT6Y9io5nWcfOcyc
         LMoCls9zCErdC8Qd8X8ALLphh8xsiWDqNp6O943c7jn9FtOB6NDpqnK40fTE3HQng9
         /Yz30wm599cwMyPo7uUgOzvUsxzzKenCk+uPF/MKS8rkcf8sSm99pSfWJzdUOxXlxQ
         Juyk9cpfcrmhaydVL7jxQ6DQKaR3TtMdX6oPOYkbADoNO1d5yP0tbV6Nc+9DY4Ngu/
         lZIezj80tv9nAkvUD2HQowSOpGJ+XWXjRo2Oul1pzoRKLcwl+FdBCYBy273oCz6V/D
         1TdvU6/9871jA==
Message-ID: <b99732f7c0dd968c0702ae7629695e8fb9cb573f.camel@kernel.org>
Subject: Re: [PATCH] drm: make drm_dp_add_payload_part2 gracefully handle
 NULL state pointer
From:   Jeff Layton <jlayton@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        "Lin, Wayne" <Wayne.Lin@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Date:   Mon, 17 Apr 2023 06:06:37 -0400
In-Reply-To: <874jpegao0.fsf@intel.com>
References: <20230413111254.22458-1-jlayton@kernel.org>
         <87edooarpq.fsf@intel.com>
         <CADnq5_PVnYMSiKO77+cfg_V-tDKYkVJYN3qGNb1vhQO3QtXskA@mail.gmail.com>
         <CO6PR12MB5489044012B2A96639470F38FC999@CO6PR12MB5489.namprd12.prod.outlook.com>
         <4d8479f20ef30866fcf73f3602f1237376110764.camel@kernel.org>
         <878reug394.fsf@intel.com>
         <7a1b00f02b125bd65824b18ea09509efe3cf777d.camel@redhat.com>
         <874jpegao0.fsf@intel.com>
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

On Mon, 2023-04-17 at 11:44 +0300, Jani Nikula wrote:
> On Fri, 14 Apr 2023, Lyude Paul <lyude@redhat.com> wrote:
> > On Fri, 2023-04-14 at 13:35 +0300, Jani Nikula wrote:
> > > On Fri, 14 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
> > > > On Fri, 2023-04-14 at 04:40 +0000, Lin, Wayne wrote:
> > > > > [Public]
> > > > >=20
> > > > > Hi Jeff,
> > > > >=20
> > > > > Thanks. I might need more information to understand why we can't =
retrieve
> > > > > the drm atomic state. Also , "Failed to create MST payload for po=
rt" indicates
> > > > > error while configuring DPCD payload ID table. Could you help to =
provide log
> > > > > with KMS + ATOMIC + DP debug on please? Thanks in advance!
> > > > >=20
> > > > > Regards,
> > > > > Wayne
> > > > >=20
> > > >=20
> > > > Possibly. I'm not that familiar with display driver debugging. Can =
you
> > > > send me some directions on how to crank up that sort of debug loggi=
ng?
> > > >=20
> > > > Note that this problem is _very_ intermittent too: I went about 2 w=
eeks
> > > > between crashes, and then I got 3 in one day. I'd rather not run wi=
th a
> > > > lot of debug logging for a long time if that's what this is going t=
o
> > > > require, as this is my main workstation.
> > > >=20
> > > > The last time I got this log message, my proposed patch did prevent=
 the
> > > > box from oopsing, so I'd really like to see it go in unless it's ju=
st
> > > > categorically wrong for the caller to pass down a NULL state pointe=
r to
> > > > drm_dp_add_payload_part2.
> > >=20
> > > Cc: Lyude.
> > >=20
> > > Looks like the state parameter was added in commit 4d07b0bc4034
> > > ("drm/display/dp_mst: Move all payload info into the atomic state") a=
nd
> > > its only use is to get at state->dev for debug logging.
> > >=20
> > > What's the plan for the parameter? Surely something more than that! :=
)
> >=20
> > I don't think there was any plan for that, or at least I certainly don'=
t even
> > remember adding that D:. It must totally have been by mistake and snuck=
 by
> > review, if that's the only thing that we're using it for I'd say it's
> > definitely fine to just drop it entirely
>=20
> I guess we could use two patches then, first replace state->dev with
> mgr->dev as something that can be backported as needed, and second drop
> the state parameter altogether.
>=20
> Jeff, up for it? At least the first one?
>=20
>=20
> BR,
> Jani.
>=20

Sure. I'm happy to test patches if you send them along.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
