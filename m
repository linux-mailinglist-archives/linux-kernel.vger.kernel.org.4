Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200DE610F48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJ1LDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJ1LDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:03:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5361CFF19;
        Fri, 28 Oct 2022 04:03:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d25so7271185lfb.7;
        Fri, 28 Oct 2022 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxJv/01u27a+DbP4opVpvt3qoXL+KZu7vR1ijdXo80E=;
        b=GzHOzJM8/0r6gFYp5Qym+/yMpqyLywloWsvL9yTrRLopPuW31VczCwEdILb6oGCBlB
         Uhw1CLnKyr/PvO9EDOriUH02yJ20R1IqOwGs2xJWcgI6uYgYmkdqCi7m6l51Vwn9w4QW
         jdVWp2UeziGu2XKud0HPzDkOhCLrusfQAzT8EZTmmJInc0Nofi7Jsz9HBQQDPLMu9ON+
         bm0FzzdTCOvyBolGEdP3rpBVpVGP18OWynrUyDjGYyPJYXdST1xl4UylH8lZy0GdxVSf
         0siGMkQzbSbtCFOjoD4hb1aL0YcQRoG3rD0VGPt9BZAS6ozyrXThpZnYT7B0AV+a4N1L
         wZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxJv/01u27a+DbP4opVpvt3qoXL+KZu7vR1ijdXo80E=;
        b=3bsL+gJLKQh2AIEy51QwRWDopcYWGRoq3guYIuUFl2+dnLBMhQN4vFIT3j654v10EI
         /SqcbSjglFaApCyJdhZiSHb/SwhwunKBUuqErQ0ifum3q9hpLevtv18jymUzBRnlYQ17
         Jh1bGAhPNYCU8SisFym/7kvPOqK7jSbeh+eAllWAYOGUYmq640WLHADkladOpTTxMhP6
         Mhj3QfiSkuG9ihs7v8l1gsvv3u9zbOmWeaLkOiH1WTayH0fADPPlAH3dq0c2EtZ7mdEC
         +yoJgyXgbPiRvi8LF8V2TsX8YdaJXtbuK8O0ssFecSKmVkPlJFjlTz4RfuHy681ObarW
         8s5w==
X-Gm-Message-State: ACrzQf0hjF/aLyoK1yCj60WfFoBD4DINSHCLr+hHChyfkkm7XZurYkD+
        Gzf1k8koKMvUyzVuDoJq6ss3R7yxdHQ=
X-Google-Smtp-Source: AMsMyM4o/kvBWvl0VYP/6Romuo8Y50lzhHZ+2CoZ8qTrPy/TqYsP+pfSKa9D5FdMksW7PbvMzgzbag==
X-Received: by 2002:a17:906:30c8:b0:73c:81a9:f8e1 with SMTP id b8-20020a17090630c800b0073c81a9f8e1mr46356336ejb.649.1666955000604;
        Fri, 28 Oct 2022 04:03:20 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906b00800b0078dce9984afsm1978939ejy.220.2022.10.28.04.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 04:03:17 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:03:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jim Lin <jilin@nvidia.com>
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        jonathanh@nvidia.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Petlozu Pravareshwar <petlozup@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: Re: [PATCH v5 3/3] xhci: tegra: USB2 pad power controls
Message-ID: <Y1u28wZc8DJDMXfR@orome>
References: <20221027133127.27592-1-jilin@nvidia.com>
 <20221027133127.27592-4-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qcVo4ZDjexOk3l74"
Content-Disposition: inline
In-Reply-To: <20221027133127.27592-4-jilin@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcVo4ZDjexOk3l74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2022 at 09:31:27PM +0800, Jim Lin wrote:
> Program USB2 pad PD controls during port connect/disconnect, port
> suspend/resume, and test mode, to reduce power consumption on
> disconnect or suspend.
>=20
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> Signed-off-by: Jim Lin <jilin@nvidia.com>

As Greg mentioned, these Signed-off-by: lines should be paired up with
Co-developed-by: lines to give additional information about what their
respective role was in the patch submission. A Signed-off-by alone has
no additional information about the actor, so the implication is that
they simply forwarded the patches, which would be what a maintainer
would typically do.

Signed-off-by: lines should also be in chronological order, so So if
Petlozu and JC did not author and simply forward the patches, then you
as the author (taken from the From: field) would need to appear before
both of them. Also in that case, you wouldn't typically be sending the
patch.

Co-developed-by: in this case provides additional information,
indicating that Petlozu and JC co-authored the patch. A Signed-off-by
=66rom them is still required, though.

Your From: line says that you also authored it (i.e. you become the
primary author). Since you then send it upstream the Signed-off-by is
then in the right place. Also, since the authorship is already implied
=66rom the From: header, no need to include a Co-developed-by: line for
yourself.

> ---
> v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
> v3: No change on copyright
> v4: Remove hcd_to_tegra_xusb() function which is used only once.
> v5: Update .hub_control in tegra_xhci_overrides (xhci-tegra.c)
>     Invoke xhci_hub_control() directly (xhci-tegra.c)
>=20
>  drivers/usb/host/xhci-tegra.c | 131 +++++++++++++++++++++++++++++++++-
>  1 file changed, 130 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index c8af2cd2216d..f685bb7459ba 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -189,6 +189,13 @@ struct tegra_xusb_context_soc {
>  	} fpci;
>  };
> =20
> +enum tegra_xhci_phy_type {
> +	USB3_PHY,
> +	USB2_PHY,
> +	HSIC_PHY,
> +	MAX_PHY_TYPES,
> +};

This is a little messy. This is the default order that we define, but
there's no strict requirement for the entries in tegra_xusb_phy_type to
be in this order. To avoid this, we've used string comparisions in other
places, which isn't great either, but it's at least a bit more
consistent.

> +
>  struct tegra_xusb_soc {
>  	const char *firmware;
>  	const char * const *supply_names;
> @@ -274,6 +281,7 @@ struct tegra_xusb {
> =20
>  	bool suspended;
>  	struct tegra_xusb_context context;
> +	u32 enable_utmi_pad_after_lp0_exit;

Perhaps call this lp0_utmi_pad_mask or something to make it clearer that
this represents a mask of bits, one for each UTMI pad.

>  };
> =20
>  static struct hc_driver __read_mostly tegra_xhci_hc_driver;
> @@ -1949,12 +1957,30 @@ static void tegra_xhci_enable_phy_sleepwalk_wake(=
struct tegra_xusb *tegra)
>  static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
>  {
>  	struct tegra_xusb_padctl *padctl =3D tegra->padctl;
> -	unsigned int i;
> +	unsigned int i, j;
> =20
>  	for (i =3D 0; i < tegra->num_phys; i++) {
>  		if (!tegra->phys[i])
>  			continue;
> +		if (tegra_xusb_padctl_remote_wake_detected(padctl, tegra->phys[i])) {
> +			if (i < tegra->soc->phy_types[USB3_PHY].num) {
> +				/* USB3 */
> +				j =3D i;
> +			} else if (i < (tegra->soc->phy_types[USB3_PHY].num +
> +					tegra->soc->phy_types[USB2_PHY].num)) {
> +				/* USB2 */
> +				j =3D i - tegra->soc->phy_types[USB3_PHY].num;
> +				tegra_phy_xusb_utmi_pad_power_on(tegra->phys[i]);
> +			} else {
> +				/* HSIC */
> +				j =3D i - (tegra->soc->phy_types[USB3_PHY].num +
> +					 tegra->soc->phy_types[USB2_PHY].num);
> +			}
> +			dev_dbg(tegra->dev,
> +				"%s port %u (0 based) remote wake detected\n",
> +				dev_name(&tegra->phys[i]->dev), j);

It looks like the only reason we do all this is to print out a debug
message. Can we not just stick with dev_name(&tegra->phys[i]->dev)? That
should already be unique. I guess the only downside is that the index
included in that string is not 0 based (PHY core uses a global index for
some reason), but I'm not sure all this extra effort is warranted just
for that.

If it is, perhaps we need to find some other way to get at the actual
index. Maybe the PHY driver can be modified to make the device name
reflect a more meaningful name.

Or perhaps yet another solution would be to print the PHY's OF node
name:

	"%pOFn", phy->dev.of_node

> =20

This blank line was originally after the "continue;" above, to make
things a bit more readable, so put it back there.

> +		}
>  		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);

Again, could use a blank line after the closing } for readability.

>  	}
>  }
> @@ -1972,6 +1998,23 @@ static void tegra_xhci_disable_phy_sleepwalk(struc=
t tegra_xusb *tegra)
>  	}
>  }
> =20
> +static void tegra_xhci_program_utmi_power_lp0_exit(struct tegra_xusb *te=
gra)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < tegra->soc->phy_types[USB2_PHY].num; i++) {
> +		if (!is_host_mode_phy(tegra, USB2_PHY, i))
> +			continue;
> +		/* USB2 */
> +		if (tegra->enable_utmi_pad_after_lp0_exit & BIT(i))
> +			tegra_phy_xusb_utmi_pad_power_on(
> +				tegra->phys[tegra->soc->phy_types[USB3_PHY].num + i]);
> +		else
> +			tegra_phy_xusb_utmi_pad_power_down(
> +				tegra->phys[tegra->soc->phy_types[USB3_PHY].num + i]);

This is all very confusing. The following should get you the right PHY
in a more straightforward way:

	struct phy *phy =3D tegra_xusb_get_phy(tegra, "usb2", i);

> +	}
> +}
> +
>  static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
>  {
>  	struct xhci_hcd *xhci =3D hcd_to_xhci(tegra->hcd);
> @@ -1980,6 +2023,7 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb =
*tegra, bool runtime)
>  	unsigned int i;
>  	int err;
>  	u32 usbcmd;
> +	u32 portsc;
> =20
>  	dev_dbg(dev, "entering ELPG\n");
> =20
> @@ -1993,6 +2037,15 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb=
 *tegra, bool runtime)
>  		goto out;
>  	}
> =20
> +	for (i =3D 0; i < tegra->soc->phy_types[USB2_PHY].num; i++) {
> +		if (!xhci->usb2_rhub.ports[i])
> +			continue;
> +		portsc =3D readl(xhci->usb2_rhub.ports[i]->addr);
> +		tegra->enable_utmi_pad_after_lp0_exit &=3D ~BIT(i);
> +		if (((portsc & PORT_PLS_MASK) =3D=3D XDEV_U3) || ((portsc & DEV_SPEED_=
MASK) =3D=3D XDEV_FS))
> +			tegra->enable_utmi_pad_after_lp0_exit |=3D BIT(i);
> +	}
> +
>  	err =3D xhci_suspend(xhci, wakeup);
>  	if (err < 0) {
>  		dev_err(tegra->dev, "failed to suspend XHCI: %d\n", err);
> @@ -2066,6 +2119,8 @@ static int tegra_xusb_exit_elpg(struct tegra_xusb *=
tegra, bool runtime)
> =20
>  		phy_power_on(tegra->phys[i]);
>  	}
> +	if (tegra->suspended)
> +		tegra_xhci_program_utmi_power_lp0_exit(tegra);
> =20
>  	tegra_xusb_config(tegra);
>  	tegra_xusb_restore_context(tegra);
> @@ -2437,8 +2492,82 @@ static int tegra_xhci_setup(struct usb_hcd *hcd)
>  	return xhci_gen_setup(hcd, tegra_xhci_quirks);
>  }
> =20
> +static int tegra_xhci_hub_control(struct usb_hcd *hcd, u16 type_req, u16=
 value, u16 index,
> +				  char *buf, u16 length)
> +{
> +	struct tegra_xusb *tegra =3D dev_get_drvdata(hcd->self.controller);
> +	struct xhci_hcd *xhci =3D hcd_to_xhci(hcd);
> +	struct xhci_hub *rhub;
> +	struct xhci_bus_state *bus_state;
> +	int port =3D (index & 0xff) - 1;
> +	int i;

"unsigned int i" to match rhub->num_ports;

The variable name choice is a little confusing to me here. I wonder if
perhaps this would be clearer if you didn't reuse "i" for the PHY index
and instead used the tegra_xusb_get_phy() as before. See below...

> +	struct xhci_port **ports;
> +	u32 portsc;
> +	int ret;
> +
> +	rhub =3D &xhci->usb2_rhub;
> +	bus_state =3D &rhub->bus_state;
> +	if (bus_state->resuming_ports && hcd->speed =3D=3D HCD_USB2) {
> +		ports =3D rhub->ports;
> +		i =3D rhub->num_ports;
> +		while (i--) {
> +			if (!test_bit(i, &bus_state->resuming_ports))
> +				continue;
> +			portsc =3D readl(ports[i]->addr);
> +			if ((portsc & PORT_PLS_MASK) =3D=3D XDEV_RESUME)
> +				tegra_phy_xusb_utmi_pad_power_on(
> +					tegra->phys[tegra->soc->phy_types[USB3_PHY].num + i]);

This could then be:

				phy =3D tegra_xusb_get_phy(tegra, "usb2", i);
				tegra_phy_xusb_utmi_pad_power_on(phy);

> +		}
> +	}
> +
> +	if (hcd->speed =3D=3D HCD_USB2) {
> +		i =3D tegra->soc->phy_types[USB3_PHY].num + port;

Similarly:

		phy =3D tegra_xusb_get_phy(tegra, "usb2", i);

> +		if ((type_req =3D=3D ClearPortFeature) && (value =3D=3D USB_PORT_FEAT_=
SUSPEND)) {
> +			if (!index || index > rhub->num_ports)
> +				return -EPIPE;
> +			tegra_phy_xusb_utmi_pad_power_on(tegra->phys[i]);

And:

			tegra_phy_xusb_utmi_pad_power_on(phy);

> +		}
> +		if ((type_req =3D=3D SetPortFeature) && (value =3D=3D USB_PORT_FEAT_RE=
SET)) {
> +			if (!index || index > rhub->num_ports)
> +				return -EPIPE;
> +			ports =3D rhub->ports;
> +			portsc =3D readl(ports[port]->addr);
> +			if (portsc & PORT_CONNECT)
> +				tegra_phy_xusb_utmi_pad_power_on(tegra->phys[i]);

And, finally:

			tegra_phy_xusb_utmi_pad_power_on(phy);

> +		}
> +	}
> +
> +	ret =3D xhci_hub_control(hcd, type_req, value, index, buf, length);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (hcd->speed =3D=3D HCD_USB2) {

It might be a good idea to add a comment here about where "i" (or "phy"
in the alternative I proposed) has been set. I kept thinking that this
was accidentally using an old value, whereas it's really doing so on
purpose.

Maybe that could be made a bit clearer by making this second check:

	if (phy) {
		...
	}

If you then declare phy =3D NULL at the top level of this function, it
becomes clearer that it's reusing something that was previously
obtained. That's less clear (to me) from looking at the current check.

> +		if ((type_req =3D=3D SetPortFeature) && (value =3D=3D USB_PORT_FEAT_SU=
SPEND))
> +			/* We don't suspend the PAD while HNP role swap happens on the OTG po=
rt */
> +			if (!((hcd->self.otg_port =3D=3D (port + 1)) && hcd->self.b_hnp_enabl=
e))
> +				tegra_phy_xusb_utmi_pad_power_down(tegra->phys[i]);
> +
> +		if ((type_req =3D=3D ClearPortFeature) && (value =3D=3D USB_PORT_FEAT_=
C_CONNECTION)) {
> +			ports =3D rhub->ports;
> +			portsc =3D readl(ports[port]->addr);
> +			if (!(portsc & PORT_CONNECT)) {
> +				/* We don't suspend the PAD while HNP role swap happens on the OTG
> +				 * port
> +				 */
> +				if (!((hcd->self.otg_port =3D=3D (port + 1)) && hcd->self.b_hnp_enab=
le))
> +					tegra_phy_xusb_utmi_pad_power_down(tegra->phys[i]);
> +			}
> +		}
> +		if ((type_req =3D=3D SetPortFeature) && (value =3D=3D USB_PORT_FEAT_TE=
ST))
> +			tegra_phy_xusb_utmi_pad_power_on(tegra->phys[i]);
> +	}
> +
> +	return ret;
> +}

Honestly, after going through all this I'm beginning to wonder if
perhaps we should encapsulate all of this better. On one hand we've got
a bunch of low-level stuff being done here in the XHCI driver that would
fit better into the XUSB pad control driver (where the PHY
implementation lives). We may be missing a bit of infrastructure here,
but perhaps we can add something to improve this overall?

Secondly, this whole .hub_control patching seems overly complicated to
me. But maybe I'm being a bit naive and there's really no better way to
do this currently.

Thierry

> +
>  static const struct xhci_driver_overrides tegra_xhci_overrides __initcon=
st =3D {
>  	.reset =3D tegra_xhci_setup,
> +	.hub_control =3D tegra_xhci_hub_control,
>  };
> =20
>  static int __init tegra_xusb_init(void)
> --=20
> 2.17.1
>=20

--qcVo4ZDjexOk3l74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNbtvEACgkQ3SOs138+
s6FNwg//U/NNOpH1sRyNw8ogoBopK3OF9/Ky6VugMh5LCat0DK0vdILfmr2Q7Igs
OojqpMCRv4Lqbgf/FczIcWSygTPZnqI2wxndJjpZG4QY587AlbaLJdnMbnsoBcWl
nAfPiB+GsfS2j7r/fVhle2H0pliQVeuIn10CrvD6bo5VggDvHM2il+ySiZiZN3ga
RWL7FosJrK1VGbmOzcOHWhkhF29uYzpRFxdQxNG1ygvb2BxJ1cirgwQn7ettdnCG
PU8fXZSaBdgxhHJCMgVuA2YZ8sf+LPTn2ocA6IJjD3WW/R/z/ncCxyUwZ5uAJV6e
qrjDHxHVxw6Zrxal6dh0xBy4uoIBMmpYWkVNKYs00v8EMGAf/miEmusS058q6NZi
KRYYWwXhXfAIXl0Ha5VZVtTDNMY1rEREwptsnoBtPCoGTh+E4932FioWl1OS+Cix
c7mMqusPyCAtRQye/UzfReHBultUBRfsJpBy5HCJok2Rz2bGvJm+9M1ApCZBE5mB
NALZXLw4LTBs6sF/7GDBqhhabE4dP7Lw/nTRo8CGThOBSHcA130W4IYvRpy7fJ9n
PAYpb4LNo7WAAyb/KSwLRiy4woZqnbM9JzDQcVXfn84UtnCKsmjxx1svYODr7epo
mNWPLGzoduvAeOfb1XUAOmMiAWoIr1O2GWEXCkZnYFC5AV0xRDE=
=RR3M
-----END PGP SIGNATURE-----

--qcVo4ZDjexOk3l74--
