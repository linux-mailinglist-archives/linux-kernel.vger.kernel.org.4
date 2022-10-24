Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF6260BC14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiJXVZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiJXVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:25:07 -0400
X-Greylist: delayed 5379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 12:31:32 PDT
Received: from sternum.kriegisch.at (orion.kriegisch.at [83.215.238.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E342D9E7C;
        Mon, 24 Oct 2022 12:31:28 -0700 (PDT)
Received: from stargate.ley23.wien.funkfeuer.at ([78.41.113.217] helo=kriegisch.at)
        by sternum.kriegisch.at with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <adi@kriegisch.at>)
        id 1omyu0-0002ld-2B; Mon, 24 Oct 2022 16:58:08 +0200
Date:   Mon, 24 Oct 2022 16:58:05 +0200
From:   Adi Kriegisch <adi@kriegisch.at>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Message-ID: <20221024145805.GF23159@kriegisch.at>
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,


On Mon, Oct 24, 2022 at 05:26:44PM +0530, Sreekanth Reddy wrote:
> On Sun, Oct 23, 2022 at 6:57 AM Bart Van Assche <bvanassche@acm.org> wrot=
e:
> >
> > On 10/21/22 02:22, Salvatore Bonaccorso wrote:
> > > We got the following report in Debian after an update from 5.10.140 to
> > > the current 5.10.149. Full quoting below (from
> > > https://bugs.debian.org/1022126). Does this ring some bell about known
> > > regressions?
> >
> > Only three mpt3sas changes are new in v5.10.149 compared to v5.10.140:
> > $ git log --format=3Doneline v5.10.140..v5.10.149
> > 2b9aba0c5d58e141e32bb1bb4c7cd91d19f075b8 scsi: mpt3sas: Fix return valu=
e check of dma_get_required_mask()
> > e7fafef9830c4a01e60f76e3860a9bef0262378d scsi: mpt3sas: Force PCIe scat=
terlist allocations to be within same 4 GB region
> > ea10a652ad2ae2cf3eced6f632a5c98f26727057 scsi: mpt3sas: Fix use-after-f=
ree warning
> >
> > Sreekanth and Suganath, can you help with bisecting this issue? For the
> > full report, see also https://lore.kernel.org/linux-scsi/Y1JkuKTjVYrOWb=
vm@eldamar.lan/.
>=20
> This issue is getting observed after having the below patch changes,
> 2b9aba0c5d58e141e32bb1bb4c7cd91d19f075b8 scsi: mpt3sas: Fix return
> value check of dma_get_required_mask()
reverting this patch fixed the issue for us.
=20
> What is happening is that on Xen hypervisor, this
> dma_get_required_mask() API always returns a 32 bit DMA mask. I.e. It
> says that the minimum DMA mask required to access the host memory is
> 32 bit and hence mpt3sas driver is setting the DMA mask to 32bit. So,
> on a 64 bit machine, if the driver set's the DMA mask to 32 bit then
> SWIOTLB's bounce buffer comes into picture during IOs. Since these
> bounce buffers are limited in size and hence we observe the IO hang if
> the large IOs are issued.
I am not sure about what is going on here but while reverting the above
patch, I added a printk right above the if:
  | printk("dma_get_required_mask =3D%lld\n",dma_get_required_mask(&pdev->d=
ev));
which always (as in booting dom0 with 2GB, 4GB, 16GB and booting bare metal
with 256GB) returns 4294967295 (DMA_BIT_MASK(32)).

> I am not sure whether this API's return value is correct or not in the
> Xen environment. If it is correct then I have to modify the driver to
> not use this API and directly set the DMA mask to 64 bit if the system
> is a 64bit machine.
Obviously, our server always reports a 32bit mask which works just fine in
the bare metal case but does not in the xen dom0 case. Is there anything I
can do to help tracking the issue down?

thanks and all the best,
    Adi
=20
> Thanks,
> Sreekanth
>=20
>=20
>=20
> >
> > Thanks,
> >
> > Bart.



--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEENxTTbbOruRNI5poKdER8DqmFXL8FAmNWp/UACgkQdER8DqmF
XL8X7g/+IOpyoxnAR8DTvE8i6qUMGJWtskT+9h3q1NddPIpQapOKF/zSDg0W5uYf
pi00CcwXueCfZXPhgp+AjLFdPI5FRYlH6Nq8kMCoaDJ2Q8KVmogUgu7q5SQqLhAc
M0GBTLiwhdyAKXDuo0EqSGzycGzvf8QWL3gtTQnOrxSI/ChOoQGV4IMVpGi/r6Nr
yLL/58H6E5bODj+hDBbFx5dLoiXJAOoCJZsVv9p3Y76RDbIok+HU9u6dbhg/eXrS
2uGd7nciFlSOVSwmUoOtUaaqhCh78QmL3ZxAK0fCJ1/4yBsllMOP22ATD+Xnz5zl
B5RSCNpT5n4i4eJfQWQzBz7uaSS+IHquryboncg1Fa4URORPg+SjZuPiJarZbq6+
b9g3e7d7FjKcMTuUrxv0fjPyBV8IlGHZ8DSuykmwZ7p5RQ97tkuhjAH/3GBsb3Lz
DY7vhpUwvTM5D/G3S7tQoBfL+EjlwC5XmH55olbrA2h3Ete+0SUTeqmUjw676Ak4
NHmwzmDXmVR+YQeFNEnWNtzBzUQEYJHi1TslzWmWPDiQ+mX4LlsFy3KhUET1482O
0HHdbtycrMZQJWW9yGuocWCavQOAoOJMfxf8WNRER1H+YJGdbh850wR7/rRUFPWz
rX9Whv1jnnr8R5ztyiVCNUmSvLyVFwRT26K6VRxjaqg04p8Stys=
=AvSb
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
