Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E839610DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiJ1Jw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJ1JwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:52:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B61C25E8;
        Fri, 28 Oct 2022 02:50:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so11726037eja.6;
        Fri, 28 Oct 2022 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRV25s9Qm3E2KmaH3Vn0CkgQOv24MvESysG5K9ccwNs=;
        b=k8hrnQsQ6bs8YzJC+yCNSzYUtxFYpdweIf2g15nT7484v1xuinESOvJjSSL5RfFIVh
         +I++z8gfItfNpGsGNQdcoGQK0HVah0IC0CJdfTiLdfG0i7M5pIDbsvQm20WYJ5KKywoA
         +JGSIZoMMnMDXBCiib1DY8uBXPrWPRnHoGjQ2Vv5Vd77dOJO63Q5H6/WRWoBCRyN4c5E
         3HBqxZ8uHPcdSApnJJgSwQyOLlsYK4di8AoQU3PqmedMJLXMT/+WwHxxpcjURzpEl4Md
         2Y/5MQr+luoS0w8rljOJ4bia6Dt3ix99Y/06X/PDKT+vY9CN3+jBfnjozFcRjqCWc+n7
         OF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRV25s9Qm3E2KmaH3Vn0CkgQOv24MvESysG5K9ccwNs=;
        b=MEN4fb56Od5bFnaeZntjQfKPA4eQxNPpS6loIKDcGZtHgTM6zoqy1juMmzWitq8k4S
         6YecWQkXTi4YsTQl8Z07ICU+uMODmXSTU4Wn5Bv7PvS4rP7obMCE56iqYno1Legxa6/F
         bocKuOvjf6dVpnxq5zD0xZvT2nazOyoZOBY1tmZBSA9cAQ8HgsRpzAfkX7KdlNHFhqIj
         RbOkFm0VplUhgDZzQXyhHe4Q58/JXoAu9xOjiLCXz6esD1EH/X79slBgkFGV2TVIPvQD
         PoGah4FURv3ILwa92oYF/m4elAGiv2PZKS7xH+796OUqBUhrG78dhk5xADkq+DSNwWxd
         udFA==
X-Gm-Message-State: ACrzQf1+lrVTa1Ea4ULjjOEIVIWYAZcB1SaTg2ohO+pUPXxwcS1AlrO3
        cP9vRo/qJ6xmjZ1MqFCCh2g=
X-Google-Smtp-Source: AMsMyM5xDH41UpDZ1p8bA2U2ywFhVwF/We7xW1fXCGHuMmJgz51HihdjpoffEsQBoS73pu1yzlfGlA==
X-Received: by 2002:a17:907:2c4a:b0:78d:f5c2:70d1 with SMTP id hf10-20020a1709072c4a00b0078df5c270d1mr46758731ejc.198.1666950649521;
        Fri, 28 Oct 2022 02:50:49 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ry13-20020a1709068d8d00b007ab1b4cab9bsm2129870ejc.224.2022.10.28.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 02:50:48 -0700 (PDT)
Date:   Fri, 28 Oct 2022 11:50:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Jim Lin <jilin@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] xhci: hub: export symbol on xhci_hub_control
Message-ID: <Y1ul9zU2wmbJo3x7@orome>
References: <20221027133127.27592-1-jilin@nvidia.com>
 <20221027133127.27592-2-jilin@nvidia.com>
 <Y1qOhjOXM4sQW+a/@kroah.com>
 <3c3b175d2031b8e440bfdef9b4c23c0272a5f607.camel@nvidia.com>
 <Y1txBtRZAJ5vpItj@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zhN+v8SOOmzSdBq"
Content-Disposition: inline
In-Reply-To: <Y1txBtRZAJ5vpItj@kroah.com>
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


--4zhN+v8SOOmzSdBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 08:04:54AM +0200, gregkh@linuxfoundation.org wrote:
> On Fri, Oct 28, 2022 at 05:36:41AM +0000, Jim Lin wrote:
> > On Thu, 2022-10-27 at 15:58 +0200, Greg KH wrote:
> > > External email: Use caution opening links or attachments
> > >=20
> > >=20
> > > On Thu, Oct 27, 2022 at 09:31:25PM +0800, Jim Lin wrote:
> > > > Add EXPORT_SYMBOL_GPL on xhci_hub_control() for other driver module
> > > > to invoke and avoid linking error.
> > >=20
> > > What other driver module?
> > >=20
> > > There is no user here :(
> > >=20
> > > confused,
> > >=20
> >=20
> > In arch/arm/configs/multi_v7_defconfig
> > It defines
> > CONFIG_USB_XHCI_TEGRA=3Dm
> >=20
> > If I don't add EXPORT_SYMBOL_GPL on xhci_hub_control()
> > , I will get compile/linking error like
> >=20
> > ERROR: modpost: "xhci_hub_control" [drivers/usb/host/xhci-tegra.ko]
> > undefined!
> >=20
> > if patch
> > "[PATCH v5,3/3] xhci: tegra: USB2 pad power controls"
> >=20
> > https://patchwork.kernel.org/project/linux-usb/patch/20221027133127.275=
92-4-jilin@nvidia.com/
> > is added in xhci-tegra.c to invoke xhci_hub_control()
> >=20
> > Should I integrate this patch with [PATCH v5,3/3] as one?
>=20
> Yes, do not add something that is not needed for that specific commit,
> otherwise it causes reviewers to be confused.

Other subsystem maintainers prefer core changes to be split from driver
changes, so this type of split is commonly encountered elsewhere.

Obviously, since this is your turf you get to make the rules. I'm just
trying to say that this kind of advice can be confusing for contributors
because when they then sent driver and code changes mixed for their next
submission, the subsystem maintainer might tell them otherwise.

Thierry

--4zhN+v8SOOmzSdBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNbpfQACgkQ3SOs138+
s6HvtA/9HmyQGlNtvFzSY3rQZmOBzX+P6ldztwBEp2MTeyGhl++83iCBJmKdyGx/
ZpxPXTH9bWb9P1jspNyxV7vYp7rBoqtMTJG4m494V0Nwt4JyvdnD7ORUnawaqQfI
0KMqtiAjobaTXAGGf17SrdqAlL8FtwnC3uIMGresPnqL/1n126e83rJhdJNyfjRc
ytPJ3Fm/HIlnWMuzE+uuJO326K8fOxm/FR9GrYx9O/bD4v7FgDJSNLdYxiflMuiB
SEaLSuObUOtyw8kJTZI/APVii6Ri1Ie7gIS4iG1X/w/zeIsqsj7Dd4AV7ZoupS//
ctMwehSilsLUbeeH/qz7SY4nTRbJAp69+pgf+NdSK10O0Zk+Rl7ufYv4MFoDfhei
kur5inGe/mVxmLdyclrgq5kb0rKdLKsMkxfDTK1EgvQ3MP5Oui+q7M30cJMP32Ek
eWbH0mteCxJ+mP0i6o6Xl852mx1tsDdcriYI3CDsbmaAF9TYbuhYYDoz/27pX0R3
8U3kO5UGLqTQCkPc2txbgicWYoZbVyqkuNwZ1y1iWGxczkyddBcku6t6gWJB1POa
9PplX+LGm2ZEoC8svVuWDtf7HbfyUjiUhIwC/qcog3lWlqvDeFURx9Vg21j9R0v8
B/NTboyCCBgK5q3dbgzDsrLYUkE5/38VafEFD9qFDKgdhfHdfqo=
=wRkt
-----END PGP SIGNATURE-----

--4zhN+v8SOOmzSdBq--
