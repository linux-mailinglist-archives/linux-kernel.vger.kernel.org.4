Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B669B610F65
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJ1LIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJ1LIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:08:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB7F1D1005;
        Fri, 28 Oct 2022 04:08:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z18so2348483edb.9;
        Fri, 28 Oct 2022 04:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IozlHscLjpLwJyHsLSyhcI+XmPovR0MZOhHVQZCtsA8=;
        b=fr2wi2JZTDYzvWpHZjjA+Zc1b7umYk39fA5/USu4s3QzAO7N8Wi+cP6lCvNPZbJbed
         EySHCFsyH/YKzt+OYTTzbf5WZmyjt7EnD7KJwswQoQ4d2h+HliXjnSho0ituCNg3D+Uz
         8z+P/EqnM3O3Ba4ASElyazReO8uKrSyUyaU/jWMjFRxgrLee45tMfs6zG/FqRlOR8EEF
         UPVW+KQabT2FfX++hGkGT14KRXTiVmXD+CZCxXN5bQgtdhgW0IPrvAQ2ri2LJRgneypk
         hUzcffpnKDdcbmbUGxVfxXNVpWlH5SNT294pt9RFLtEbkP8h+IJchmV9HjRoL1pCFsWl
         +aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IozlHscLjpLwJyHsLSyhcI+XmPovR0MZOhHVQZCtsA8=;
        b=XAWGn2iZXbkFxb6ZLOWFa4qgD1h9JU7byYr9FNQILmsa/pTKPA3+jmS5wMdR1A0NcL
         UvZeAJtK/ic7QV2pri6y/uaVZBMNxd6jhnSxsVcuMC+bDXejsWb6DCJtOgNYC8Ol164J
         8euCOqBpFEWzaMpcc4Siudc3uJFlnH5JpLESWULIxlZ2DVBchatp84Z26wTrwK8WR+9r
         li8QLY0mPLJHdx5XBNOEVnEm9aLLzQYOt5pGqBEtDzR+u2lBEDFyl/7YA7k4hTE0gerM
         NYA+LT2HTGkjYiqrSd335Lfd4M+lEjjPPcWLHrjPrfHI0BzOLxYdcjq650JvMZho0ejU
         qNvQ==
X-Gm-Message-State: ACrzQf0UKqUETUV0ftfCi4mbdOPkex1zQio3KFRDGmll6SIeNPqisH9b
        uvgVBT2jQjAO29dLPUhuB1Q=
X-Google-Smtp-Source: AMsMyM4eU4Fxar8xkWV4vt4ckwoxWojY2QN6KHRHYLclIUt72hYropJGj0cFVOGyVEcQuKegJevkPA==
X-Received: by 2002:a05:6402:440c:b0:43a:1124:e56a with SMTP id y12-20020a056402440c00b0043a1124e56amr51393928eda.134.1666955285152;
        Fri, 28 Oct 2022 04:08:05 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bd9-20020a056402206900b004610899742asm2433877edb.13.2022.10.28.04.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 04:08:04 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:08:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jim Lin <jilin@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] xhci: hub: export symbol on xhci_hub_control
Message-ID: <Y1u4Ei1SUq39CGPW@orome>
References: <20221027133127.27592-1-jilin@nvidia.com>
 <20221027133127.27592-2-jilin@nvidia.com>
 <Y1qOhjOXM4sQW+a/@kroah.com>
 <3c3b175d2031b8e440bfdef9b4c23c0272a5f607.camel@nvidia.com>
 <Y1txBtRZAJ5vpItj@kroah.com>
 <Y1ul9zU2wmbJo3x7@orome>
 <Y1uw2zp/XnUdgEwJ@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5cRpSgsOPvmvY0+n"
Content-Disposition: inline
In-Reply-To: <Y1uw2zp/XnUdgEwJ@kroah.com>
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


--5cRpSgsOPvmvY0+n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 12:37:15PM +0200, gregkh@linuxfoundation.org wrote:
> On Fri, Oct 28, 2022 at 11:50:47AM +0200, Thierry Reding wrote:
> > On Fri, Oct 28, 2022 at 08:04:54AM +0200, gregkh@linuxfoundation.org wr=
ote:
> > > On Fri, Oct 28, 2022 at 05:36:41AM +0000, Jim Lin wrote:
> > > > On Thu, 2022-10-27 at 15:58 +0200, Greg KH wrote:
> > > > > External email: Use caution opening links or attachments
> > > > >=20
> > > > >=20
> > > > > On Thu, Oct 27, 2022 at 09:31:25PM +0800, Jim Lin wrote:
> > > > > > Add EXPORT_SYMBOL_GPL on xhci_hub_control() for other driver mo=
dule
> > > > > > to invoke and avoid linking error.
> > > > >=20
> > > > > What other driver module?
> > > > >=20
> > > > > There is no user here :(
> > > > >=20
> > > > > confused,
> > > > >=20
> > > >=20
> > > > In arch/arm/configs/multi_v7_defconfig
> > > > It defines
> > > > CONFIG_USB_XHCI_TEGRA=3Dm
> > > >=20
> > > > If I don't add EXPORT_SYMBOL_GPL on xhci_hub_control()
> > > > , I will get compile/linking error like
> > > >=20
> > > > ERROR: modpost: "xhci_hub_control" [drivers/usb/host/xhci-tegra.ko]
> > > > undefined!
> > > >=20
> > > > if patch
> > > > "[PATCH v5,3/3] xhci: tegra: USB2 pad power controls"
> > > >=20
> > > > https://patchwork.kernel.org/project/linux-usb/patch/20221027133127=
=2E27592-4-jilin@nvidia.com/
> > > > is added in xhci-tegra.c to invoke xhci_hub_control()
> > > >=20
> > > > Should I integrate this patch with [PATCH v5,3/3] as one?
> > >=20
> > > Yes, do not add something that is not needed for that specific commit,
> > > otherwise it causes reviewers to be confused.
> >=20
> > Other subsystem maintainers prefer core changes to be split from driver
> > changes, so this type of split is commonly encountered elsewhere.
> >=20
> > Obviously, since this is your turf you get to make the rules. I'm just
> > trying to say that this kind of advice can be confusing for contributors
> > because when they then sent driver and code changes mixed for their next
> > submission, the subsystem maintainer might tell them otherwise.
>=20
> Sure, but if you do split it up like this, DOCUMENT WHY THE EXPORT IS
> NEEDED.  That didn't happen here so I had no idea why this was even an
> issue.
>=20
> And yes, I am very sensitive to this, we have had LOTS of people trying
> to export xhci symbols in the past few years for no in-kernel users,
> despite us constantly telling them that this is not allowed.  It
> happened again, just yesterday:
> 	https://lore.kernel.org/r/20221027004050.4192111-1-albertccwang@google.c=
om
>=20
> And at first glance, I assumed this was much the same as there was no
> description of why this was needed at all.

Agreed. I suppose this could've been spelled out more explicitly in the
cover letter or in patch 1.

Jim, please make sure to describe this dependency explicitly in v6.

Thierry

--5cRpSgsOPvmvY0+n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNbuBIACgkQ3SOs138+
s6FhUxAAhHI43sw1W9y8qsWj9Z2WvDNhDrLUHDhLJTx85BLK8Elgl9cKhWCPSqqP
FMZz0Q5+DzNyuOXBwN/JnFOf2k0Wr/VrWoKPjyVMyptn0Rp07ihg1WL8FlyduzXV
uVijpfX7oQHH/a57uR1/Z0SSI1+Gw3LNY5hPKCIt8WfYbbEk+lp52d7gn7ubetZI
HhTfJ3JOGVdNE1gP99o7vl9yZLU0vAeYuFGNeRnwX0qdzWZU8w3xrXobfZ70rWml
o9mx0HoRVU3Ct3ED1Wgcv2lfcT2b2FGfiFzyDMVDlkobB8onxWZJwcAmPR8POz+q
nvqhMvboFOtbVm4wb8BRs8Mu99mP7Ts+VPZNeDQunlYsF3lC5t8cx9edATohDEmn
Ikl5xCHVwYBk/9Z2yWKAaTgSiCPIU83o0EcOKZAvmj2Xfg5ayGVESnnOoUfzJOym
haubbuAsMnpJVDBe7dM4Pjeq4pCSh+uhwMPAt2pTauwibzPCJirhgQhDK/BZvJQ7
mPVklzsq0Y61lHoHcKgOBmAJLiYS8qyL+s0rzjcHFLfSOd1vS+j+fWKir7pv33TN
QWE7x5EYxis//rVYd/l00xc7URIOg2uNpLTnCbl9TXKdsk8OkREmENVuI0r3k/G0
CykkgySCrgr+u09oJa00BonyvA9l6Q1r2f7xY2KKo3JGara6a9k=
=Pl2R
-----END PGP SIGNATURE-----

--5cRpSgsOPvmvY0+n--
