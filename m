Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7014B64503F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiLGATR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiLGATM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:19:12 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A4C4C262;
        Tue,  6 Dec 2022 16:19:07 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20221207001903usoutp018d536c3b911c3854d23022f50090e739~uWsvOhDCF1670816708usoutp01q;
        Wed,  7 Dec 2022 00:19:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20221207001903usoutp018d536c3b911c3854d23022f50090e739~uWsvOhDCF1670816708usoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670372343;
        bh=43dryQYIAhUovZbhz0QETdAuVywU91Sj5otrDy4MdIk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=IvFOiRI2SCdr4josQonieaueZaHN4sgmW8cGU7wIdNf+7942aC7J8rdgOrZmzqiyX
         2eDP+2N+/3UwJBKxD4wWG3eURTFqtQfnxiSG2m65dVp/hXYg6cbh1WRfFwU7OGXCpT
         C+Rzl094U9PpUfGsuxXNym1NWXZDtpUgv9sYv66A=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221207001902uscas1p169c29e6dacb6092d517fb554ace45c7c~uWsu7Z8wH0777807778uscas1p1r;
        Wed,  7 Dec 2022 00:19:02 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id DE.E6.09669.6FBDF836; Tue, 
        6 Dec 2022 19:19:02 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221207001902uscas1p2140599eb4550c13eac9823daf9d8b032~uWsunXC5-1068810688uscas1p2v;
        Wed,  7 Dec 2022 00:19:02 +0000 (GMT)
X-AuditID: cbfec36d-827ff700000025c5-88-638fdbf6e9db
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id FA.97.09588.6FBDF836; Tue, 
        6 Dec 2022 19:19:02 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 6 Dec 2022 16:19:01 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        6 Dec 2022 16:19:01 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix memdev reuse check
Thread-Topic: [PATCH] cxl/region: Fix memdev reuse check
Thread-Index: AQHY8u8LeWViEa6a3k+/w2cfyy70na40pOkAgC2eUgA=
Date:   Wed, 7 Dec 2022 00:19:01 +0000
Message-ID: <20221207001852.GA2414318@bgt-140510-bm03>
In-Reply-To: <63699774d1af_18432294b8@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01719DCE08040547B206BD87863253C0@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djX87rfbvcnG3x7qGdx9/EFNovmyYsZ
        LV7/m85iMX3qBUaL1TfXMFrsf/qcxWLVwmtsFudnnWKxuLxrDpvFrQnHmBy4PFqOvGX1WLzn
        JZPHplWdbB4fn95i8Zg6u97j8ya5ALYoLpuU1JzMstQifbsEroxzl16yFxwQqfjx4whLA+Mm
        gS5GTg4JAROJtc+nMoPYQgIrGSUOn5fuYuQCsluZJE4+X8AOUzT571s2iMRaRom5+/cwQzgf
        GSU2n+tkh3CWMkoc+XKBFaSFTUBRYl/XdjYQW0RAW2LinINgHcwCc1kkLu1aB1YkLGAu8aVz
        EwtEkYXE6SOPoRqsJL4enQu2m0VARWLS10tgNbwCZhLv7jwDq+EU8JDY83YtWJxRQEzi+6k1
        TCA2s4C4xK0n85kg7haUWDR7DzOELSbxb9dDNghbUeL+95fsEPU6Egt2f2KDsO0kzp9ZADVH
        W2LZwtfMEHsFJU7OfMIC0SspcXDFDRaQZyQEvnBI7O6+BbXAReLr9NlQRdISV69PhYpXS5zp
        OccE0dDCKHGpcTNUwlriX+c19gmMKrOQHD4LyVGzkBw1C8lRs5ActYCRdRWjeGlxcW56arFh
        Xmq5XnFibnFpXrpecn7uJkZgKjv973DuDsYdtz7qHWJk4mA8xCjBwawkwvtiY2+yEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd41UzqShQTSE0tSs1NTC1KLYLJMHJxSDUzx13xfrZwqeJs3RsV+
        0z/LWm/D9XPnne8Tm/ggNj9W4NUy1f1ZzCuZ/Be2rXK58ID7eNPWyW399p47TPt/Lmh5Ie/5
        8WLRmUuvb/yVFc7UYGV8sM1vg9+jaerPWjaUvb1+bsFZlS8TFad8i1NY+HDNvQyLzqX7uNPm
        JygvtFKcVOe3mScg9v6UO1dKWFp2zOsL6ZL3nu/w3yxafJWPf/WfRJvzrz8wXMiauMjcsdWO
        Z5XX5Kz+88o91ZwO4Qq7boRk/r3SoKM194j3keaYIF/H169Wdh2YqG9T1npW3bJLo73a/9Os
        n3ImmbblLoZf+x1uHtlaVh+y9ouKkOxlNve5s3kmhyziDRKcf1215bsSS3FGoqEWc1FxIgBU
        DqQB1AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWS2cA0Sffb7f5kgzP/JCzuPr7AZtE8eTGj
        xet/01kspk+9wGix+uYaRov9T5+zWKxaeI3N4vysUywWl3fNYbO4NeEYkwOXR8uRt6wei/e8
        ZPLYtKqTzePj01ssHlNn13t83iQXwBbFZZOSmpNZllqkb5fAlXHu0kv2ggMiFT9+HGFpYNwk
        0MXIySEhYCIx+e9bti5GLg4hgdWMEkvPP2KHcD4ySixccAgqs5RRYtvqWcwgLWwCihL7uraz
        gdgiAtoSE+ccZAYpYhaYyyJxadc6VpCEsIC5xJfOTSwQRRYSp488hmqwkvh6dC47iM0ioCIx
        6eslsBpeATOJd3eeQW07xSix8mY/I0iCU8BDYs/btWBFjAJiEt9PrWECsZkFxCVuPZnPBPGE
        gMSSPeeZIWxRiZeP/7FC2IoS97+/ZIeo15FYsPsTG4RtJ3H+zAKoOdoSyxa+ZoY4QlDi5Mwn
        LBC9khIHV9xgmcAoMQvJullIRs1CMmoWklGzkIxawMi6ilG8tLg4N72i2DAvtVyvODG3uDQv
        XS85P3cTIzANnP53OHIH49FbH/UOMTJxMB5ilOBgVhLhfbGxN1mINyWxsiq1KD++qDQntfgQ
        ozQHi5I4r5DrxHghgfTEktTs1NSC1CKYLBMHp1QDk3pethzXOn5vzRlH7my8//yNiqyfo0uP
        13oDec15RQ8+Gq89kpvHzj7/37UrUS2af+TOKuy8zX17r9E0LZeHml7qZ/5/mFrNY5xqGter
        /PX+GyOT8882eVWLZM8TzHRPyrNISulgWsg/v5PTTP5GdzTjVinLXTdkb+QfPRfyLr10i/fZ
        jbuil9f4W750qGU17vp/9Ar3kZrdb47M2zNHbfkrw+7keQ8ZdY9cDXzM8GmyaflcjXuc0kWn
        QiWklz3a+u7Jhj0mrz/quLtVXFq73+L95ZrU3U1cYQ1s0Vf3iexVkzWe01V72NhY81ZSc6Ll
        ZY7Io/ppb9Ym2i1sTq1ly+z886PxjWaN4dYTnyXfKLEUZyQaajEXFScCAPTcDsxyAwAA
X-CMS-MailID: 20221207001902uscas1p2140599eb4550c13eac9823daf9d8b032
CMS-TYPE: 301P
X-CMS-RootMailID: 20221107212232uscas1p20a000834b76db7a7e459708b06638120
References: <CGME20221107212232uscas1p20a000834b76db7a7e459708b06638120@uscas1p2.samsung.com>
        <20221107212153.745993-1-fan.ni@samsung.com>
        <63699774d1af_18432294b8@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:40:36PM -0800, Dan Williams wrote:

> Fan Ni wrote:
> > Memdev reuse in a region currently does not iterate over all of the
> > interleave targets. Fix this by using existing iterator for memdev reus=
e
> > check.
>=20
> Not enough detail, what does this actually fix in practice? For example,
> if an end user encountered this bug, what would they see as the
> symptoms?  I could probably figure out, but for bugs I should not have
> to, and more importantly downstream OSV kernel maintainers, who do not
> have the same context as CXL developers, also need that information to
> decide if this is a fix they want to backport into their kernel.
>=20

Hi Dan,
Thanks for the feedback. Here are more details about the patch, and
I will refine the patch.

cxlmd_target =3D cxled_to_memdev(cxled_target);
if (cxlmd_target =3D=3D cxlmd) {
	dev_dbg(&cxlr->dev,
			"%s already specified at position %d via: %s\n",
			dev_name(&cxlmd->dev), pos,
			dev_name(&cxled_target->cxld.dev));
	return -EBUSY;
}

Before the patch, the check of whether or not a memdev has already been
used as a target for the region (above code piece) will always be skipped.
Given a memdev with more than one HDM decoder, an interleaved region can be
created that maps multiple HPAs to the same DPA. According to CXL spec 3.0
8.1.3.8.4, "Aliasing (mapping more than one Host Physical Address (HPA) to =
a
single Device Physical Address) is forbidden."

The CXL specification allows a device to have more than one HDM decoder
("The number of decoders implemented by a component are enumerated via the =
CXL
 HDM Decoder Capability register (see Section 8.2.4.19.1"). If a CXL device
 has multiple HDM decoders the current code allows to create memory regions
 that map multiple HPAs to a single DPA.

Fan

> >=20
> > Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  drivers/cxl/core/region.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index f9ae5ad284ff..c7152b4bd9eb 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1226,7 +1226,7 @@ static int cxl_region_attach(struct cxl_region *c=
xlr,
> >  		struct cxl_endpoint_decoder *cxled_target;
> >  		struct cxl_memdev *cxlmd_target;
> > =20
> > -		cxled_target =3D p->targets[pos];
> > +		cxled_target =3D p->targets[i];
> >  		if (!cxled_target)
> >  			continue;
> > =20
> > --=20
> > 2.25.1
>=20
> =
