Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2964D734D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFSIYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjFSIYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:24:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9209CF2;
        Mon, 19 Jun 2023 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=CmK/ulgQpHFWRxaRYT8veXW7TE7RM2/u+ZQEKDXpcoA=;
        t=1687163071; x=1688372671; b=ZuD2wIqIIvsa6N50LNhA077ASOdPcTACkJEiPqSz8pUMYDE
        +vPz/s6RK9FvaRqhMCnBx7AtK1USUI52sqsZfxaNZOP6viyG4+zOz7aRLjr15RfmLZF1QMqqGNpvs
        406fCctojAFi+wSqCeOJFw1qX4GlE8Q+j7divJwbzDKGDavQgTahj7B0GNqv1gTFEE598AS7VmdM3
        DeZlsXK5sQMubV9sLc2hWCGHNd6co1pqEW1IFva7XxSTX91WNmCRFioQe99ZBoohi4Eot2e2EfVmu
        UU0wbkG0N8oDfhMdzAiMyJWOA+MIpVx5ZnSkO7AebgpDso77HYjwNa+tM2hMOQnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qBABX-00BFMO-0Y;
        Mon, 19 Jun 2023 10:24:27 +0200
Message-ID: <5a19bd3074d2763b02a722f31713bbf3bae97e8f.camel@sipsolutions.net>
Subject: Re: [PATCH V3 2/7] wifi: mac80211: Add support for ACPI WBRF
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        kvalo@kernel.org, nbd@nbd.name, lorenzo@kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, Lijo.Lazar@amd.com
Date:   Mon, 19 Jun 2023 10:24:25 +0200
In-Reply-To: <3c3dccd6-6772-d62f-f183-bd84e109a366@amd.com>
References: <20230616065757.1054422-1-evan.quan@amd.com>
         <20230616065757.1054422-3-evan.quan@amd.com>
         <3c3dccd6-6772-d62f-f183-bd84e109a366@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-06-18 at 21:17 -0500, Mario Limonciello wrote:
>=20
> > --- a/include/net/cfg80211.h
> > +++ b/include/net/cfg80211.h
> > @@ -920,6 +920,14 @@ const struct cfg80211_chan_def *
> >   cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
> >   			    const struct cfg80211_chan_def *chandef2);
> >  =20
> > +/**
> > + * nl80211_chan_width_to_mhz - get the channel width in Mhz
> > + * @chan_width: the channel width from &enum nl80211_chan_width
> > + * Return: channel width in Mhz if the chan_width from &enum nl80211_c=
han_width
> > + * is valid. -1 otherwise.
> > + */
> > +int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width);
> > +
>=20
> It's up to mac80211 maintainers, but I would think that the changes to=
=20
> change nl80211_chan_width_to_mhz from static to exported should be=20
> separate from the patch to introduced WBRF support in the series.

Yeah, that'd be nice :)


> > +#define KHZ_TO_HZ(freq)		((freq) * 1000ULL)

Together with MHZ_TO_KHZ() for example :)

johannes
