Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393AE73810B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjFUKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjFUKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:23:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8ED197;
        Wed, 21 Jun 2023 03:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=E5J3XlE1FsUIlBpFkRpwctJVhjB2FlOiEwVbSdNHhcE=;
        t=1687342994; x=1688552594; b=RWtUxkjg4xYJmfKtMvXoXY9u+ktdikFpu3EU1sEVWoOMMT8
        yRPhfqWwcpIRVq2h6WbdY9kJCvIzY9xs8/Qr6cZfqCHenSBeZLYwBgO77nmZ6gf4WvSYn0FyE8mHP
        51bLL5TzE65XoYEAS6u4PLvWulm7ONYEtwqRvaVuaQTo20BMVnj6onpPUlYOSLqS3GbMnWne6qqMK
        +0mehziktlLvAymbu56uiTIU0buVLRi2HfzI15d6sNYtAahLoQkxL1Z1lEMJgeFO1vEWAK8YWPq7C
        CLnZFUcHwp7PjPGPHrrcyA3K52ALg/sg+96X9HEfYrQuZd8rVewPngW3ff6+fHqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qBuym-00DagI-0V;
        Wed, 21 Jun 2023 12:22:24 +0200
Message-ID: <3eb2c16cb0692c8d6b03bd57cb049b1fb3457e92.camel@sipsolutions.net>
Subject: Re: [PATCH V4 3/8] wifi: mac80211: Add support for ACPI WBRF
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mario.limonciello@amd.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date:   Wed, 21 Jun 2023 12:22:21 +0200
In-Reply-To: <20230621054603.1262299-4-evan.quan@amd.com>
References: <20230621054603.1262299-1-evan.quan@amd.com>
         <20230621054603.1262299-4-evan.quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 13:45 +0800, Evan Quan wrote:
> To support AMD's WBRF interference mitigation mechanism, Wifi adapters
> utilized in the system must register the frequencies in use(or unregister
> those frequencies no longer used) via the dedicated APCI calls. So that,
> other drivers responding to the frequencies can take proper actions to
> mitigate possible interference.
>=20
> To make WBRF feature functional, the kernel needs to be configured with
> CONFIG_ACPI_WBRF and the platform is equipped with WBRF support(from
> BIOS and drivers).
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Co-developed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

I was going to say this looks good ... but still have a few nits, sorry.

But then the next question anyway is how we merge this? The wifi parts
sort of depend on the first patch, although technically I guess I could
merge them since it's all hidden behind the CONFIG_ symbol, assuming you
get that in via some other tree it can combine upstream.

I'd also say you can merge those parts elsewhere but I'm planning to
also land some locking rework that I've been working on, so it will
probably conflict somewhere.

> +++ b/net/mac80211/chan.c
> @@ -506,11 +506,16 @@ static void _ieee80211_change_chanctx(struct ieee80=
211_local *local,
> =20
>  	WARN_ON(!cfg80211_chandef_compatible(&ctx->conf.def, chandef));
> =20
> +	ieee80211_remove_wbrf(local, &ctx->conf.def);
> +
>  	ctx->conf.def =3D *chandef;
> =20
>  	/* check if min chanctx also changed */
>  	changed =3D IEEE80211_CHANCTX_CHANGE_WIDTH |
>  		  _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
> +
> +	ieee80211_add_wbrf(local, &ctx->conf.def);

You ignore the return value here.


> @@ -668,6 +673,10 @@ static int ieee80211_add_chanctx(struct ieee80211_lo=
cal *local,
>  	lockdep_assert_held(&local->mtx);
>  	lockdep_assert_held(&local->chanctx_mtx);
> =20
> +	err =3D ieee80211_add_wbrf(local, &ctx->conf.def);
> +	if (err)
> +		return err;

But not here.

In the code, there are basically two error paths:

> +int ieee80211_add_wbrf(struct ieee80211_local *local,
> +		       struct cfg80211_chan_def *chandef)
> +{
> +	struct device *dev =3D local->hw.wiphy->dev.parent;
> +	struct wbrf_ranges_in ranges_in =3D {0};
> +	int ret;
> +
> +	if (!local->wbrf_supported)
> +		return 0;
> +
> +	ret =3D wbrf_get_ranges_from_chandef(chandef, &ranges_in);
> +	if (ret)
> +		return ret;

This really won't fail, just if the bandwidth calculation was bad, but
that's an internal error that WARNs anyway and we can ignore it.

> +	return wbrf_add_exclusion(ACPI_COMPANION(dev), &ranges_in);

This I find a bit confusing, why do we even propagate the error? If the
platform has some issue with it, should we really fail the connection?


I think it seems better to me to just make this void, and have it be
only a notification interface?

johannes
