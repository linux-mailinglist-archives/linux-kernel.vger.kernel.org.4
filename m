Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3807292F1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbjFIIYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbjFIIYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:24:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1126549E2;
        Fri,  9 Jun 2023 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ioJP5/nPwkDScpLmhYFsFtpoICiOH9A6AqZVomfCoCQ=;
        t=1686298978; x=1687508578; b=Fj2Omoqt3ZL/OswKsngO9jty2eDHEr6OYDwKzdWyP++5bdz
        U1kYjyWW53KyYKLVbsg8eYBuLLMva5CIxuMx+Sl3/XgMVbA+ayed/21ugPgYQCeYzGM4uo84Yt81R
        eHTpu0fpTL+0lUQJn1fFHnYynZ+xE1y/cuYOKjPMrm8UtJjhM48dKYfKw6mpQAw7IeYdhp/5GOSaO
        SyExcKrqR6i2VZ+b/jvQAvvG9ezu14wSjUwK4h5j2CwCa80IR1F/Hh/H0K2szp0/MdtfjVu1/v6G0
        gaSzqJhZgENjEuOR9IUIsGY9lAjFw67VBq3E7vHp17fluQTwrUoECdVBJaSseaAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q7XMw-000rrZ-1g;
        Fri, 09 Jun 2023 10:21:14 +0200
Message-ID: <ccbaf80adb305ea59eb1a457460b99dc920bb65d.camel@sipsolutions.net>
Subject: Re: [PATCH V2 2/7] wifi: mac80211: Add support for ACPI WBRF
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        kvalo@kernel.org, nbd@nbd.name, lorenzo@kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, Mario.Limonciello@amd.com,
        Lijo.Lazar@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org
Date:   Fri, 09 Jun 2023 10:21:12 +0200
In-Reply-To: <20230609072846.1552238-3-evan.quan@amd.com>
References: <20230609072846.1552238-1-evan.quan@amd.com>
         <20230609072846.1552238-3-evan.quan@amd.com>
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

On Fri, 2023-06-09 at 15:28 +0800, Evan Quan wrote:

> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -5551,6 +5551,10 @@ struct wiphy {
> =20
>  	u16 hw_timestamp_max_peers;
> =20
> +#ifdef CONFIG_ACPI_WBRF
> +	bool wbrf_supported;
> +#endif

This should be in some private struct in mac80211, ieee80211_local I
think.

>  	char priv[] __aligned(NETDEV_ALIGN);
>  };
> =20
> @@ -9067,4 +9071,18 @@ static inline int cfg80211_color_change_notify(str=
uct net_device *dev)
>  bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
>  					      const struct cfg80211_chan_def *chandef);
> =20
> +#ifdef CONFIG_ACPI_WBRF
> +void ieee80211_check_wbrf_support(struct wiphy *wiphy);
> +int ieee80211_add_wbrf(struct wiphy *wiphy,
> +		       struct cfg80211_chan_def *chandef);
> +void ieee80211_remove_wbrf(struct wiphy *wiphy,
> +			   struct cfg80211_chan_def *chandef);
> +#else
> +static inline void ieee80211_check_wbrf_support(struct wiphy *wiphy) { }
> +static inline int ieee80211_add_wbrf(struct wiphy *wiphy,
> +				     struct cfg80211_chan_def *chandef) { return 0; }
> +static inline void ieee80211_remove_wbrf(struct wiphy *wiphy,
> +					 struct cfg80211_chan_def *chandef) { }
> +#endif /* CONFIG_ACPI_WBRF */

Same here, not the right place. This should even be in an internal
mac80211 header (such as net/mac80211/ieee80211_i.h or create a new
net/mac80211/wrbf.h or so if you prefer.)


> --- a/net/mac80211/chan.c
> +++ b/net/mac80211/chan.c
> @@ -668,6 +668,10 @@ static int ieee80211_add_chanctx(struct ieee80211_lo=
cal *local,
>  	lockdep_assert_held(&local->mtx);
>  	lockdep_assert_held(&local->chanctx_mtx);
> =20
> +	err =3D ieee80211_add_wbrf(local->hw.wiphy, &ctx->conf.def);
> +	if (err)
> +		return err;
> +
>  	if (!local->use_chanctx)
>  		local->hw.conf.radar_enabled =3D ctx->conf.radar_enabled;
> =20
> @@ -748,6 +752,8 @@ static void ieee80211_del_chanctx(struct ieee80211_lo=
cal *local,
>  	}
> =20
>  	ieee80211_recalc_idle(local);
> +
> +	ieee80211_remove_wbrf(local->hw.wiphy, &ctx->conf.def);
>  }
> =20
>  static void ieee80211_free_chanctx(struct ieee80211_local *local,
>=20

This is tricky, and quite likely incorrect.

First of all, chandefs can actually _change_, see
_ieee80211_change_chanctx(). You'd probably have to call this add/remove
(or have modify) whenever we call drv_change_chanctx() to change the
width (not if radar/rx chains change).

Secondly, you don't know if the driver will actually use ctx->conf.def,
or ctx->conf.mindef. For client mode that doesn't matter, but for AP
mode if the AP is configured to say 160 MHz, it might actually configure
down to 20 MHz when no stations are connected (or only 20 MHz stations
are). I don't know if you really care about taking that into account, I
also don't know how dynamic this really should be. Stations can connect
and disconnect quickly, so perhaps the WBRF should actually take the
full potential bandwidth into account all the time, in which case taking
ctx->conf.def would be correct.

I'll note that your previous in-driver approach had all the same
problems the way you had implemented it, though I don't know if that
driver ever can use mindef or not.


> +void ieee80211_check_wbrf_support(struct wiphy *wiphy)
> +{
> +	struct device *dev =3D wiphy->dev.parent;
> +	struct acpi_device *acpi_dev;
> +
> +	acpi_dev =3D ACPI_COMPANION(dev);

Can this cope with 'dev' being NULL? Just not sure nothing like hwsim or
so always even has a parent. I guess it should, but ...

> +static int chan_width_to_mhz(enum nl80211_chan_width chan_width)
> +{
> +	int mhz;
> +
> +	switch (chan_width) {
> +	case NL80211_CHAN_WIDTH_1:
> +		mhz =3D 1;
> +		break;
> +	case NL80211_CHAN_WIDTH_2:
> +		mhz =3D 2;
> +		break;
> +	case NL80211_CHAN_WIDTH_4:
> +		mhz =3D 4;
> +		break;
> +	case NL80211_CHAN_WIDTH_8:
> +		mhz =3D 8;
> +		break;
> +	case NL80211_CHAN_WIDTH_16:
> +		mhz =3D 16;
> +		break;
> +	case NL80211_CHAN_WIDTH_5:
> +		mhz =3D 5;
> +		break;
> +	case NL80211_CHAN_WIDTH_10:
> +		mhz =3D 10;
> +		break;
> +	case NL80211_CHAN_WIDTH_20:
> +	case NL80211_CHAN_WIDTH_20_NOHT:
> +		mhz =3D 20;
> +		break;
> +	case NL80211_CHAN_WIDTH_40:
> +		mhz =3D 40;
> +		break;
> +	case NL80211_CHAN_WIDTH_80P80:
> +	case NL80211_CHAN_WIDTH_80:
> +		mhz =3D 80;
> +		break;
> +	case NL80211_CHAN_WIDTH_160:
> +		mhz =3D 160;
> +		break;
> +	case NL80211_CHAN_WIDTH_320:
> +		mhz =3D 320;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return -1;
> +	}
> +	return mhz;

This might be more generally useful as a function in cfg80211 that's
exported - hwsim has exactly the same function today, for example.

> +static void get_chan_freq_boundary(u32 center_freq,
> +				   u32 bandwidth,
> +				   u64 *start,
> +				   u64 *end)
> +{
> +	bandwidth =3D MHZ_TO_KHZ(bandwidth);
> +	center_freq =3D MHZ_TO_KHZ(center_freq);
> +
> +	*start =3D center_freq - bandwidth / 2;
> +	*end =3D center_freq + bandwidth / 2;
> +
> +	/* Frequency in HZ is expected */
> +	*start =3D KHZ_TO_HZ(*start);
> +	*end =3D KHZ_TO_HZ(*end);
> +}

Similar patterns are probably elsewhere too for this, but I guess we can
always refactor later too.

johannes
