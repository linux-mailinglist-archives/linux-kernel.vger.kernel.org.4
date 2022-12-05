Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53375643808
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiLEWZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiLEWZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:25:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D2A2BD0;
        Mon,  5 Dec 2022 14:25:38 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9ADAA660038D;
        Mon,  5 Dec 2022 22:25:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670279136;
        bh=cJiVKPV8Tkg8KuLgBhpoM+Yb8ATFwvoIly8E2xqO+xE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dn4Ci+O6LOMoer7PtdJNfsRx6wlfPHnhDVSBZVJhOS/ReBGRW9X5dzWi8CnF2oGIN
         u/tZ3CesmAo+Tsxy38sxQhojTImMOerPLMx5uL+0qxT3KKZ0I9kj9uLHgBF0ClEuc1
         3GyfjhphpQI9Mh9GBk7pPZHXNQ3+FkV65TAEHlTZU/d2vLvmWcty0HwWFpCLc6xolf
         En0jad+1AMPH30zdK33iT/jDshx/iUqYYcZE9dIpPpFKiyQuyR9YNxe1Dk0yxfzGRH
         l4IFXymyMdDG6440EaoeQbaS421jQnXorG1TLu60paPvKcafd3hgun188xLPibpzjY
         x/zJGDVbERNpA==
Received: by mercury (Postfix, from userid 1000)
        id 310971060F2F; Mon,  5 Dec 2022 23:25:34 +0100 (CET)
Date:   Mon, 5 Dec 2022 23:25:34 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     ruanjinjie <ruanjinjie@huawei.com>, linus.walleij@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: fix null pointer dereferencing in
 power_supply_get_battery_info
Message-ID: <20221205222534.7wfew7ny2iyxhirm@mercury.elektranox.org>
References: <20221205075153.2830393-1-ruanjinjie@huawei.com>
 <ea327ec7-e9f3-b589-43f5-70b5f1a0025a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="25zwgmpvujsqnt6j"
Content-Disposition: inline
In-Reply-To: <ea327ec7-e9f3-b589-43f5-70b5f1a0025a@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--25zwgmpvujsqnt6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 05, 2022 at 07:05:04PM +0800, Baolin Wang wrote:
> On 12/5/2022 3:51 PM, ruanjinjie wrote:
> > when kmalloc() fail to allocate memory in kasprintf(), propname
> > will be NULL, strcmp() called by of_get_property() will cause
> > null pointer dereference.
> >=20
> > So return ENOMEM if kasprintf() return NULL pointer.
> >=20
> > Fixes: 3afb50d7125b ("power: supply: core: Add some helpers to use the =
battery OCV capacity table")
> > Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>=20
> LGTM.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks, queued.

-- Sebastian

>=20
> > ---
> > v2:
> > - release resource instead of just returning error number
> > ---
> >   drivers/power/supply/power_supply_core.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index 4b5fb172fa99..afbe9eecfc30 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -750,6 +750,11 @@ int power_supply_get_battery_info(struct power_sup=
ply *psy,
> >   		int i, tab_len, size;
> >   		propname =3D kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
> > +		if (!propname) {
> > +			power_supply_put_battery_info(psy, info);
> > +			err =3D -ENOMEM;
> > +			goto out_put_node;
> > +		}
> >   		list =3D of_get_property(battery_np, propname, &size);
> >   		if (!list || !size) {
> >   			dev_err(&psy->dev, "failed to get %s\n", propname);

--25zwgmpvujsqnt6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOOb90ACgkQ2O7X88g7
+pq4AQ/+M1YP55rvH0vMM8k9nNGfckQQLYibVLHB9s3Al5e/sfEaGP4AL6CdI77m
prFCgacVe8IqfMidUpE+mEEuLVPWlr0cVL5w18fdL6uYSwRKwLNgF370mSW6Myx2
+C59Ts1Wv5RlSqUQkXrYkUFa0/ioV68cvBtgtP+3jq7CWuvLxrDOEUcOr8d1LizB
ArsrbHcqdJZBLzoqz4hmagXQ9WOjMJKU5O1B9yXBG1/Na9tc7A7kPDZ1JQwdgU6l
lN+udgeMw6XKXBZTqcpVs+6Lwn/o6p9m6GJIEvuptvv1Yry1u6/bW+P8xzLAdh5B
G/cHVEOnRy36gZuIerz9CDZEoyg8E57iorvW4lscfalzZ0Ifto46jmXkWeX2olqa
v9lTc2coaTsDSiiCeZadQNdGBj9A31fjcSbGHIPBgs6hP/FdBDk62L6ViBBwUp7T
GajZ7sIKVvufMT/IqiYAbyGwnH2llllK2RSvlWOgCDjiSKvPDFgG6RqV8+/X3ZUT
0mC6Rse7RFncPtcFxpoR6QVfb2yWlA+5AhFEgJLCWWRWrMxuKXEGKeT4vNy81I8E
OKoIwf4jC7Li5xNYZQwPt8diRrsuAck23AxDT8KpqcAESwWID0zj/u34fYZtoNII
sIytudFzgFa9n+thdN6gJMaHMEMxxenfdgITm0m4dY/bN8XnOkY=
=IIna
-----END PGP SIGNATURE-----

--25zwgmpvujsqnt6j--
